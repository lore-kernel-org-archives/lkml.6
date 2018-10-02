Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E80CC00449
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F7822083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ql6Xco9D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F7822083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbeJBH7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:59:12 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45160 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeJBH7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 03:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2+6QRyaExpmbMF1OBAJxYq0QCbbA9YE2015ccebeU44=; b=ql6Xco9DTNdBdtEXxiMYfDeh0s
        5cNkCkiol8eatfF57PTyqPKWsON3d5iRF4qd0G9KzNxgHNVk9GrUKLn3EWZftTBhFK6wBtvCPXxpb
        gHCm92zbjWxNeXrZmYHHOe/QmZ/n8UdSAJ1s5kFaUCdLbN6IAQ9EHxbHagiG9a9rHPlHpo9YU/rKy
        Y9fcDgxTgvmq14aEuTjhUpxe7idlKJSf2vQFLljp3+8eeGeeHuY68G8XHSKKUCtOwncUtWOtIH50E
        ErZj3/yc3lCKW1OKNwOFW8JLis4Kdxx6T1aFmnBDuxn6svNhs7bXFdRN9lGFq5+He0B2ldSovotHK
        chqDUzQg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g79Kb-00028Y-HK; Tue, 02 Oct 2018 01:18:34 +0000
Subject: Re: [PATCH security-next v4 21/32] LSM: Finalize centralized LSM
 enabling logic
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
 <20181002005505.6112-22-keescook@chromium.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ccfbe049-392d-4df5-5eb5-ea18576d4afd@infradead.org>
Date:   Mon, 1 Oct 2018 18:18:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181002005505.6112-22-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/18 5:54 PM, Kees Cook wrote:
> Prior to this patch, default "enable" behavior was unchanged: SELinux
> and AppArmor were controlled separately from the centralized control
> defined by CONFIG_LSM_ENABLE and "lsm.enable=...". This changes the
> logic to give all control over to the central logic.
> 
> Instead of allowing SELinux and AppArmor to override the central LSM
> enabling logic, by having separate CONFIG and boot parameters, this
> forces all "enable" variables to disabled, then enables any listed in
> the CONFIG_LSM_ENABLE and "lsm.enable=..." settings, and finally disables
> any listed in "lsm.disable=...".
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  .../admin-guide/kernel-parameters.txt         |  6 ++--
>  include/linux/lsm_hooks.h                     |  2 +-
>  security/security.c                           | 32 +++++++------------
>  3 files changed, 15 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 67c90985d2b8..f646cfab5613 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2279,14 +2279,12 @@
>  	lsm.disable=lsm1,...,lsmN
>  			[SECURITY] Comma-separated list of LSMs to disable
>  			at boot time. This overrides "lsm.enable=",

better:			              This overrides "lsm.enable=" and

> -			CONFIG_LSM_ENABLE, and any per-LSM CONFIGs and boot
> -			parameters.
> +			CONFIG_LSM_ENABLE.
>  
>  	lsm.enable=lsm1,...,lsmN
>  			[SECURITY] Comma-separated list of LSMs to enable
>  			at boot time. This overrides any omissions from
> -			CONFIG_LSM_ENABLE, and any per-LSM CONFIGs and
> -			boot parameters.
> +			CONFIG_LSM_ENABLE.
>  
>  	machvec=	[IA-64] Force the use of a particular machine-vector
>  			(machvec) in a generic kernel.


-- 
~Randy
