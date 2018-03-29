Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752043AbeC2VhU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 17:37:20 -0400
Received: from sonic307-9.consmr.mail.bf2.yahoo.com ([74.6.134.48]:42399 "EHLO
        sonic307-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751189AbeC2VhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 17:37:18 -0400
X-YMail-OSG: 0_dq0cEVM1mQXHW8Q0umOHPEmR08_0ZUXKrbj6ZQSsYerwkVK9v_Srr1P9CfXIi
 j6oZ4v2igo.EYMZQTtWdqKyiBVzNTqSQkBXcdzI2K28CBmXVsNeBk7qNBt1TvcqQKPp7YbF_G4kz
 erbM3tFqxrieX_cmQXT3I4r4E7vzT96D.Q2O3isTm6ussvUq5FGHVcG5GRUmm1thjGzwHmj22cOl
 S4kZR4qX.3nQu9H6BljmV8a0136gMxtD9LxQz2jsU94LEnm8DwVsBmLtRNqS5E20W1rIwZ4pr8Z7
 ZMya97GKyk54su_QeiD1zNbe7TM7FWfXXZZTLe6qLUSSAg5dWgTmVNRdhHsMBJyFuHiWD2QfxvoV
 xE1RQ1D4Ke.xLcOfMXC9.yolofjBclFNGBklqy.Cr9F2EnhpD_3Y6ii3vfFIXBlIwCWxCns8bKCX
 Rvj3hKAKyQmwb3j2c63Say_Ls7hEO9oACozttR452uvmxkcgacxsamKtct5S2AHiFg3VtZjrhxXZ
 4.UNHh1d7JLbW7z3VxTv0bI08Sf95yfINGHS3tUQIWcyXfLECu0R5pbSnsg5ftig-
Subject: Re: [PATCH v3 1/1] security: Add mechanism to safely (un)load LSMs
 after boot time
To: Sargun Dhillon <sargun@sargun.me>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: penguin-kernel@i-love.sakura.ne.jp, keescook@chromium.org,
        igor.stoppa@huawei.com, jmorris@namei.org, sds@tycho.nsa.gov,
        paul@paul-moore.com, plautrba@redhat.com
References: <cover.1522357211.git.sargun@sargun.me>
 <5240a81494bbe5be5651379cd9828bda34d764e2.1522357211.git.sargun@sargun.me>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <3292bbb3-7c9d-f18d-05f3-9b69b3cac922@schaufler-ca.com>
Date: Thu, 29 Mar 2018 14:37:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <5240a81494bbe5be5651379cd9828bda34d764e2.1522357211.git.sargun@sargun.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/2018 2:14 PM, Sargun Dhillon wrote:
> This patch introduces a mechanism to add mutable hooks and immutable
> hooks to the callback chain. It adds an intermediary item to the
> chain which separates mutable and immutable hooks. Immutable hooks
> are then marked as read-only, as well as the hook heads. This does
> not preclude some hooks being able to be mutated (removed).
>
> It also wraps the hook unloading, and execution with an SRCU. One
> SRCU is used across all hooks, as the SRCU struct can be memory
> intensive, and hook execution time in general should be relatively
> short.
>
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> Signed-off-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> ---
>  include/linux/lsm_hooks.h  |  23 ++---
>  security/Kconfig           |   2 +-
>  security/apparmor/lsm.c    |   2 +-
>  security/commoncap.c       |   2 +-
>  security/security.c        | 210 ++++++++++++++++++++++++++++++++++++++-------
>  security/selinux/hooks.c   |   5 +-
>  security/smack/smack_lsm.c |   3 +-
>  security/tomoyo/tomoyo.c   |   3 +-
>  security/yama/yama_lsm.c   |   2 +-
>  9 files changed, 196 insertions(+), 56 deletions(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 09bc60fb35f1..689e5e72fb38 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1981,9 +1981,12 @@ extern struct security_hook_heads security_hook_heads;
>  extern char *lsm_names;
>  
>  extern void security_add_hooks(struct security_hook_list *hooks, int count,
> -				char *lsm);
> +				char *lsm, bool is_mutable);
>  
> -#ifdef CONFIG_SECURITY_SELINUX_DISABLE
> +#define __lsm_ro_after_init	__ro_after_init
> +/* Currently required to handle SELinux runtime hook disable. */
> +#ifdef CONFIG_SECURITY_WRITABLE_HOOKS
> +#define __lsm_mutable_after_init
>  /*
>   * Assuring the safety of deleting a security module is up to
>   * the security module involved. This may entail ordering the
> @@ -1996,21 +1999,9 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
>   * disabling their module is a good idea needs to be at least as
>   * careful as the SELinux team.
>   */
> -static inline void security_delete_hooks(struct security_hook_list *hooks,
> -						int count)
> -{
> -	int i;
> -
> -	for (i = 0; i < count; i++)
> -		hlist_del_rcu(&hooks[i].list);
> -}
> -#endif /* CONFIG_SECURITY_SELINUX_DISABLE */
> -
> -/* Currently required to handle SELinux runtime hook disable. */
> -#ifdef CONFIG_SECURITY_WRITABLE_HOOKS
> -#define __lsm_ro_after_init
> +extern void security_delete_hooks(struct security_hook_list *hooks, int count);
>  #else
> -#define __lsm_ro_after_init	__ro_after_init
> +#define __lsm_mutable_after_init __ro_after_init
>  #endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
>  
>  extern int __init security_module_enable(const char *module);
> diff --git a/security/Kconfig b/security/Kconfig
> index c4302067a3ad..a3b8b1142e6f 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -32,7 +32,7 @@ config SECURITY
>  	  If you are unsure how to answer this question, answer N.
>  
>  config SECURITY_WRITABLE_HOOKS
> -	depends on SECURITY
> +	depends on SECURITY && SRCU
>  	bool
>  	default n
>  
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 9a65eeaf7dfa..d6cca8169df0 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1155,7 +1155,7 @@ static int __init apparmor_init(void)
>  		goto buffers_out;
>  	}
>  	security_add_hooks(apparmor_hooks, ARRAY_SIZE(apparmor_hooks),
> -				"apparmor");
> +				"apparmor", false);
>  
>  	/* Report that AppArmor successfully initialized */
>  	apparmor_initialized = 1;
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 48620c93d697..fe4b0d9d44ce 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -1363,7 +1363,7 @@ struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
>  void __init capability_add_hooks(void)
>  {
>  	security_add_hooks(capability_hooks, ARRAY_SIZE(capability_hooks),
> -				"capability");
> +				"capability", false);
>  }
>  
>  #endif /* CONFIG_SECURITY */
> diff --git a/security/security.c b/security/security.c
> index 3cafff61b049..2ddb64864e3e 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -29,6 +29,11 @@
>  #include <linux/backing-dev.h>
>  #include <linux/string.h>
>  #include <net/flow.h>
> +#include <linux/srcu.h>
> +#include <linux/mutex.h>
> +
> +#define SECURITY_HOOK_COUNT \
> +	(sizeof(security_hook_heads) / sizeof(struct hlist_head))
>  
>  #define MAX_LSM_EVM_XATTR	2
>  
> @@ -36,7 +41,10 @@
>  #define SECURITY_NAME_MAX	10
>  
>  struct security_hook_heads security_hook_heads __lsm_ro_after_init;
> +EXPORT_SYMBOL_GPL(security_hook_heads);
> +
>  static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
> +static DEFINE_MUTEX(security_hook_mutex);
>  
>  char *lsm_names;
>  /* Boot-time LSM user choice */
> @@ -53,6 +61,103 @@ static void __init do_security_initcalls(void)
>  	}
>  }
>  
> +#ifdef CONFIG_SECURITY_WRITABLE_HOOKS
> +DEFINE_STATIC_SRCU(security_hook_srcu);
> +static struct security_hook_list	null_hooks[SECURITY_HOOK_COUNT];
> +#define HAS_FUNC(SHL, FUNC)	(SHL->hook.FUNC)

The HAS_FUNC() macro will work, but it's awkward outside of the
call_..._hook() macros. I think you should document how to use it
properly somewhere in here. There are enough cases where the
call_..._hook() macros aren't used that someone could have trouble
figuring out how to use it.
