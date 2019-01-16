Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F4FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA3B20868
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbfAPVOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:14:53 -0500
Received: from namei.org ([65.99.196.166]:56382 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726924AbfAPVOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:14:53 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x0GLEjAL007529;
        Wed, 16 Jan 2019 21:14:45 GMT
Date:   Thu, 17 Jan 2019 08:14:45 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
cc:     John Johansen <john.johansen@canonical.com>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com
Subject: Re: WARNING in apparmor_cred_free
In-Reply-To: <99cd1f6b-682e-7d1f-35ad-b9092d46323f@schaufler-ca.com>
Message-ID: <alpine.LRH.2.21.1901170814170.7422@namei.org>
References: <0000000000007f604f057f2b8509@google.com> <6213e783-4377-489d-cdfb-1a83f4497076@schaufler-ca.com> <b0d2811e-87e4-21d4-c33a-2d2012a906cc@canonical.com> <2ccf6281-3f4b-a94a-ed71-31905e583fa6@schaufler-ca.com> <234c868b-4521-0707-a135-d8c24bc179bd@schaufler-ca.com>
 <99cd1f6b-682e-7d1f-35ad-b9092d46323f@schaufler-ca.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2019, Casey Schaufler wrote:

> >From 47134986133c822e1d88860fa2b108f92c97a7ff Mon Sep 17 00:00:00 2001
> From: Casey Schaufler <casey@schaufler-ca.com>
> Date: Fri, 11 Jan 2019 17:31:50 -0800
> Subject: [PATCH 1/2] LSM: Check for NULL cred-security on free
> 
> Check that the cred security blob has been set before trying
> to clean it up. There is a case during credential initialization
> that could result in this.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

JJ: does this fix the problem?

> ---
>  security/security.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/security/security.c b/security/security.c
> index a618e22df5c6..7bffc86d4e87 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1477,6 +1477,13 @@ int security_cred_alloc_blank(struct cred *cred, gfp_t gfp)
>  
>  void security_cred_free(struct cred *cred)
>  {
> +	/*
> +	 * There is a failure case in prepare_creds() that
> +	 * may result in a call here with ->security being NULL.
> +	 */
> +	if (unlikely(cred->security == NULL))
> +		return;
> +
>  	call_void_hook(cred_free, cred);
>  
>  	kfree(cred->security);
> 

-- 
James Morris
<jmorris@namei.org>

