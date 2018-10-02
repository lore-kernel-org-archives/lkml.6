Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C83C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD2820C0A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pNDXgF8V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CD2820C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbeJBHru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:47:50 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44978 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbeJBHru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 03:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zB1tmEMqzZkwlNpRdcl/gBiISQGCudkT1zkAiuh+hok=; b=pNDXgF8VDxXPzOIEdr6wq8eLM4
        zV/G8Onr6rjUuSP3pfki5iFufAeOcQUgwjApWd3xIVDTDjKThuupRjUcqbBUe10h4nW1x4VKDHwcS
        8Mcit25E+VFu8PpbTySPVUtVrNwpH/HRA1/VW31o8yMtt6b8RjCIz0PBNSDxDQDD4dJBhiGaq6wcN
        rFiRS9cX2y1Xwmxh904qFFus4lj2wHhaQEa7ct89BBfOdGUYZK9F99z8APOMUs9pG1JtWP8Aop/Xk
        he4NaJbh3VJzrpE6KQk7CsbERRihC4q7imOplfHRtGIf5rFf6JAqotWpGJTsn8UrD8A5eyuC2Embc
        CtI1Gh3A==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g799R-00024I-7q; Tue, 02 Oct 2018 01:07:02 +0000
Subject: Re: [PATCH security-next v4 13/32] LoadPin: Rename "enable" to
 "enforce"
To:     Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181002005505.6112-1-keescook@chromium.org>
 <20181002005505.6112-14-keescook@chromium.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0d76adea-93b9-9512-a57b-8605b7928bc2@infradead.org>
Date:   Mon, 1 Oct 2018 18:06:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181002005505.6112-14-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/18 5:54 PM, Kees Cook wrote:
> LoadPin's "enable" setting is really about enforcement, not whether
> or not the LSM is using LSM hooks. Instead, split this out so that LSM
> enabling can be logically distinct from whether enforcement is happening
> (for example, the pinning happens when the LSM is enabled, but the pin
> is only checked when "enforce" is set). This allows LoadPin to continue

ISTB:             when "enforcing" is set).  ??

> to operate sanely in test environments once LSM enable/disable is
> centrally handled (i.e. we want LoadPin to be enabled separately from
> its enforcement).
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> ---
>  security/loadpin/Kconfig   |  4 ++--
>  security/loadpin/loadpin.c | 21 +++++++++++----------
>  2 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/security/loadpin/Kconfig b/security/loadpin/Kconfig
> index dd01aa91e521..8653608a3693 100644
> --- a/security/loadpin/Kconfig
> +++ b/security/loadpin/Kconfig
> @@ -10,10 +10,10 @@ config SECURITY_LOADPIN
>  	  have a root filesystem backed by a read-only device such as
>  	  dm-verity or a CDROM.
>  
> -config SECURITY_LOADPIN_ENABLED
> +config SECURITY_LOADPIN_ENFORCING
>  	bool "Enforce LoadPin at boot"
>  	depends on SECURITY_LOADPIN
>  	help
>  	  If selected, LoadPin will enforce pinning at boot. If not
>  	  selected, it can be enabled at boot with the kernel parameter
> -	  "loadpin.enabled=1".
> +	  "loadpin.enforcing=1".
> diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
> index 0716af28808a..d8a68a6f6fef 100644
> --- a/security/loadpin/loadpin.c
> +++ b/security/loadpin/loadpin.c
> @@ -44,7 +44,7 @@ static void report_load(const char *origin, struct file *file, char *operation)
>  	kfree(pathname);
>  }
>  
> -static int enabled = IS_ENABLED(CONFIG_SECURITY_LOADPIN_ENABLED);
> +static int enforcing = IS_ENABLED(CONFIG_SECURITY_LOADPIN_ENFORCING);
>  static struct super_block *pinned_root;
>  static DEFINE_SPINLOCK(pinned_root_spinlock);
>  
> @@ -60,8 +60,8 @@ static struct ctl_path loadpin_sysctl_path[] = {
>  
>  static struct ctl_table loadpin_sysctl_table[] = {
>  	{
> -		.procname       = "enabled",
> -		.data           = &enabled,
> +		.procname       = "enforcing",
> +		.data           = &enforcing,
>  		.maxlen         = sizeof(int),
>  		.mode           = 0644,
>  		.proc_handler   = proc_dointvec_minmax,
> @@ -97,7 +97,7 @@ static void check_pinning_enforcement(struct super_block *mnt_sb)
>  					   loadpin_sysctl_table))
>  			pr_notice("sysctl registration failed!\n");
>  		else
> -			pr_info("load pinning can be disabled.\n");
> +			pr_info("enforcement can be disabled.\n");
>  	} else
>  		pr_info("load pinning engaged.\n");
>  }
> @@ -128,7 +128,7 @@ static int loadpin_read_file(struct file *file, enum kernel_read_file_id id)
>  
>  	/* This handles the older init_module API that has a NULL file. */
>  	if (!file) {
> -		if (!enabled) {
> +		if (!enforcing) {
>  			report_load(origin, NULL, "old-api-pinning-ignored");
>  			return 0;
>  		}
> @@ -151,7 +151,7 @@ static int loadpin_read_file(struct file *file, enum kernel_read_file_id id)
>  		 * Unlock now since it's only pinned_root we care about.
>  		 * In the worst case, we will (correctly) report pinning
>  		 * failures before we have announced that pinning is
> -		 * enabled. This would be purely cosmetic.
> +		 * enforcing. This would be purely cosmetic.
>  		 */
>  		spin_unlock(&pinned_root_spinlock);
>  		check_pinning_enforcement(pinned_root);
> @@ -161,7 +161,7 @@ static int loadpin_read_file(struct file *file, enum kernel_read_file_id id)
>  	}
>  
>  	if (IS_ERR_OR_NULL(pinned_root) || load_root != pinned_root) {
> -		if (unlikely(!enabled)) {
> +		if (unlikely(!enforcing)) {
>  			report_load(origin, file, "pinning-ignored");
>  			return 0;
>  		}
> @@ -186,10 +186,11 @@ static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
>  
>  void __init loadpin_add_hooks(void)
>  {
> -	pr_info("ready to pin (currently %sabled)", enabled ? "en" : "dis");
> +	pr_info("ready to pin (currently %senforcing)\n",
> +		enforcing ? "" : "not ");
>  	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
>  }
>  
>  /* Should not be mutable after boot, so not listed in sysfs (perm == 0). */
> -module_param(enabled, int, 0);
> -MODULE_PARM_DESC(enabled, "Pin module/firmware loading (default: true)");
> +module_param(enforcing, int, 0);
> +MODULE_PARM_DESC(enforcing, "Enforce module/firmware pinning");
> 


-- 
~Randy
