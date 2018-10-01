Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA6EC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79CEA20666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79CEA20666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbeJBE1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 00:27:49 -0400
Received: from namei.org ([65.99.196.166]:34810 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbeJBE1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 00:27:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w91LliaK022175;
        Mon, 1 Oct 2018 21:47:44 GMT
Date:   Tue, 2 Oct 2018 07:47:44 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Kees Cook <keescook@chromium.org>
cc:     Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH security-next v3 14/29] LSM: Plumb visibility into optional
 "enabled" state
In-Reply-To: <20180925001832.18322-15-keescook@chromium.org>
Message-ID: <alpine.LRH.2.21.1810020747380.20364@namei.org>
References: <20180925001832.18322-1-keescook@chromium.org> <20180925001832.18322-15-keescook@chromium.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Sep 2018, Kees Cook wrote:

> In preparation for lifting the "is this LSM enabled?" logic out of the
> individual LSMs, pass in any special enabled state tracking (as needed
> for SELinux, AppArmor, and LoadPin). This should be an "int" to include
> handling any future cases where "enabled" is exposed via sysctl which
> has no "bool" type.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/lsm_hooks.h | 1 +
>  security/apparmor/lsm.c   | 5 +++--
>  security/selinux/hooks.c  | 1 +
>  3 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 5056f7374b3d..2a41e8e6f6e5 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -2044,6 +2044,7 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
>  struct lsm_info {
>  	const char *name;	/* Populated automatically. */
>  	unsigned long flags;	/* Optional: flags describing LSM */
> +	int *enabled;		/* Optional: NULL means enabled. */

This seems potentially confusing.

Perhaps initialize 'enabled' to a default int pointer, like:

	static int lsm_default_enabled = 1;

Then,

	DEFINE_LSM(foobar)
	flags = LSM_FLAG_LEGACY_MAJOR,
	.enabled = &lsm_default_enabled,
	.init = foobar_init,
	END_LSM;



>  	int (*init)(void);
>  };
>  
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 4c5f63e9aeba..d03133a267f2 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1303,8 +1303,8 @@ bool aa_g_paranoid_load = true;
>  module_param_named(paranoid_load, aa_g_paranoid_load, aabool, S_IRUGO);
>  
>  /* Boot time disable flag */
> -static bool apparmor_enabled = CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE;
> -module_param_named(enabled, apparmor_enabled, bool, S_IRUGO);
> +static int apparmor_enabled = CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE;
> +module_param_named(enabled, apparmor_enabled, int, 0444);
>  
>  static int __init apparmor_enabled_setup(char *str)
>  {
> @@ -1608,5 +1608,6 @@ static int __init apparmor_init(void)
>  
>  DEFINE_LSM(apparmor)
>  	.flags = LSM_FLAG_LEGACY_MAJOR,
> +	.enabled = &apparmor_enabled,
>  	.init = apparmor_init,
>  END_LSM;
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 615cf6498c0f..3f999ed98cfd 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -7204,6 +7204,7 @@ void selinux_complete_init(void)
>     all processes and objects when they are created. */
>  DEFINE_LSM(selinux)
>  	.flags = LSM_FLAG_LEGACY_MAJOR,
> +	.enabled = &selinux_enabled,
>  	.init = selinux_init,
>  END_LSM;
>  
> 

-- 
James Morris
<jmorris@namei.org>

