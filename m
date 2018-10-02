Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F233C64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E436320652
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E436320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbeJCEGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:06:02 -0400
Received: from namei.org ([65.99.196.166]:35230 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727040AbeJCEGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:06:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w92LKWUj024580;
        Tue, 2 Oct 2018 21:20:33 GMT
Date:   Wed, 3 Oct 2018 07:20:32 +1000 (AEST)
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
Subject: Re: [PATCH security-next v4 10/32] LSM: Don't ignore initialization
 failures
In-Reply-To: <20181002005505.6112-11-keescook@chromium.org>
Message-ID: <alpine.LRH.2.21.1810030719040.23596@namei.org>
References: <20181002005505.6112-1-keescook@chromium.org> <20181002005505.6112-11-keescook@chromium.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Oct 2018, Kees Cook wrote:

> LSM initialization failures have traditionally been ignored. We should
> at least WARN when something goes wrong.

I guess we could have a boot param which specifies what to do if any LSM 
fails to init, as I think some folks will want to stop execution at that 
point.

Thoughts?


> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> ---
>  security/security.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/security/security.c b/security/security.c
> index 395f804f6a91..2055af907eba 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -55,10 +55,12 @@ static __initdata bool debug;
>  static void __init major_lsm_init(void)
>  {
>  	struct lsm_info *lsm;
> +	int ret;
>  
>  	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
>  		init_debug("initializing %s\n", lsm->name);
> -		lsm->init();
> +		ret = lsm->init();
> +		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
>  	}
>  }
>  
> 

-- 
James Morris
<jmorris@namei.org>

