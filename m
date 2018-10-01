Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C44C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43FBD208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43FBD208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbeJBD6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 23:58:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51272 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeJBD6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 23:58:31 -0400
Received: from static-50-53-48-205.bvtn.or.frontiernet.net ([50.53.48.205] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <john.johansen@canonical.com>)
        id 1g75aW-0007sF-Vg; Mon, 01 Oct 2018 21:18:45 +0000
Subject: Re: [PATCH security-next v3 15/29] LSM: Lift LSM selection out of
 individual LSMs
To:     Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180925001832.18322-1-keescook@chromium.org>
 <20180925001832.18322-16-keescook@chromium.org>
From:   John Johansen <john.johansen@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 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
Organization: Canonical
Message-ID: <42bd09fe-2a24-c376-4f62-a0ea1af953b6@canonical.com>
Date:   Mon, 1 Oct 2018 14:18:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180925001832.18322-16-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/24/2018 05:18 PM, Kees Cook wrote:
> As a prerequisite to adjusting LSM selection logic in the future, this
> moves the selection logic up out of the individual major LSMs, making
> their init functions only run when actually enabled. This considers all
> LSMs enabled by default unless they specified an external "enable"
> variable.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: John Johansen <john.johansen@canonical.com>


> ---
>  include/linux/lsm_hooks.h  |  1 -
>  security/apparmor/lsm.c    |  6 ---
>  security/security.c        | 84 ++++++++++++++++++++++++--------------
>  security/selinux/hooks.c   | 10 -----
>  security/smack/smack_lsm.c |  3 --
>  security/tomoyo/tomoyo.c   |  2 -
>  6 files changed, 53 insertions(+), 53 deletions(-)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 2a41e8e6f6e5..95798f212dbf 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -2091,7 +2091,6 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
>  #define __lsm_ro_after_init	__ro_after_init
>  #endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
>  
> -extern int __init security_module_enable(const char *module);
>  extern void __init capability_add_hooks(void);
>  #ifdef CONFIG_SECURITY_YAMA
>  extern void __init yama_add_hooks(void);
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index d03133a267f2..5399c2f03536 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1542,12 +1542,6 @@ static int __init apparmor_init(void)
>  {
>  	int error;
>  
> -	if (!apparmor_enabled || !security_module_enable("apparmor")) {
> -		aa_info_message("AppArmor disabled by boot time parameter");
> -		apparmor_enabled = false;
> -		return 0;
> -	}
> -
>  	aa_secids_init();
>  
>  	error = aa_setup_dfa_engine();
> diff --git a/security/security.c b/security/security.c
> index a886a978214a..056b36cf6245 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -52,33 +52,78 @@ static bool debug __initdata;
>  			pr_info(__VA_ARGS__);			\
>  	} while (0)
>  
> +static bool __init is_enabled(struct lsm_info *lsm)
> +{
> +	if (!lsm->enabled || *lsm->enabled)
> +		return true;
> +
> +	return false;
> +}
> +
> +/* Mark an LSM's enabled flag, if it exists. */
> +static void __init set_enabled(struct lsm_info *lsm, bool enabled)
> +{
> +	if (lsm->enabled)
> +		*lsm->enabled = enabled;
> +}
> +
> +/* Is an LSM allowed to be initialized? */
> +static bool __init lsm_allowed(struct lsm_info *lsm)
> +{
> +	/* Skip if the LSM is disabled. */
> +	if (!is_enabled(lsm))
> +		return false;
> +
> +	/* Skip major-specific checks if not a major LSM. */
> +	if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0)
> +		return true;
> +
> +	/* Disabled if this LSM isn't the chosen one. */
> +	if (strcmp(lsm->name, chosen_lsm) != 0)
> +		return false;
> +
> +	return true;
> +}
> +
> +/* Check if LSM should be enabled. Mark any that are disabled. */
> +static void __init maybe_initialize_lsm(struct lsm_info *lsm)
> +{
> +	int enabled = lsm_allowed(lsm);
> +
> +	/* Record enablement. */
> +	set_enabled(lsm, enabled);
> +
> +	/* If selected, initialize the LSM. */
> +	if (enabled) {
> +		int ret;
> +
> +		init_debug("initializing %s\n", lsm->name);
> +		ret = lsm->init();
> +		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
> +	}
> +}
> +
>  static void __init ordered_lsm_init(void)
>  {
>  	struct lsm_info *lsm;
> -	int ret;
>  
>  	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
>  		if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) != 0)
>  			continue;
>  
> -		init_debug("initializing %s\n", lsm->name);
> -		ret = lsm->init();
> -		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
> +		maybe_initialize_lsm(lsm);
>  	}
>  }
>  
>  static void __init major_lsm_init(void)
>  {
>  	struct lsm_info *lsm;
> -	int ret;
>  
>  	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
>  		if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0)
>  			continue;
>  
> -		init_debug("initializing %s\n", lsm->name);
> -		ret = lsm->init();
> -		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
> +		maybe_initialize_lsm(lsm);
>  	}
>  }
>  
> @@ -168,29 +213,6 @@ static int lsm_append(char *new, char **result)
>  	return 0;
>  }
>  
> -/**
> - * security_module_enable - Load given security module on boot ?
> - * @module: the name of the module
> - *
> - * Each LSM must pass this method before registering its own operations
> - * to avoid security registration races. This method may also be used
> - * to check if your LSM is currently loaded during kernel initialization.
> - *
> - * Returns:
> - *
> - * true if:
> - *
> - * - The passed LSM is the one chosen by user at boot time,
> - * - or the passed LSM is configured as the default and the user did not
> - *   choose an alternate LSM at boot time.
> - *
> - * Otherwise, return false.
> - */
> -int __init security_module_enable(const char *module)
> -{
> -	return !strcmp(module, chosen_lsm);
> -}
> -
>  /**
>   * security_add_hooks - Add a modules hooks to the hook lists.
>   * @hooks: the hooks to add
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 3f999ed98cfd..409a9252aeb6 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -7133,16 +7133,6 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>  
>  static __init int selinux_init(void)
>  {
> -	if (!security_module_enable("selinux")) {
> -		selinux_enabled = 0;
> -		return 0;
> -	}
> -
> -	if (!selinux_enabled) {
> -		pr_info("SELinux:  Disabled at boot.\n");
> -		return 0;
> -	}
> -
>  	pr_info("SELinux:  Initializing.\n");
>  
>  	memset(&selinux_state, 0, sizeof(selinux_state));
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 4aef844fc0e2..e79fad43a8e3 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -4834,9 +4834,6 @@ static __init int smack_init(void)
>  	struct cred *cred;
>  	struct task_smack *tsp;
>  
> -	if (!security_module_enable("smack"))
> -		return 0;
> -
>  	smack_inode_cache = KMEM_CACHE(inode_smack, 0);
>  	if (!smack_inode_cache)
>  		return -ENOMEM;
> diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
> index 528b6244a648..39bb994ebe09 100644
> --- a/security/tomoyo/tomoyo.c
> +++ b/security/tomoyo/tomoyo.c
> @@ -540,8 +540,6 @@ static int __init tomoyo_init(void)
>  {
>  	struct cred *cred = (struct cred *) current_cred();
>  
> -	if (!security_module_enable("tomoyo"))
> -		return 0;
>  	/* register ourselves with the security framework */
>  	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo");
>  	printk(KERN_INFO "TOMOYO Linux initialized\n");
> 

