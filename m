Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B69C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F9320866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="kC4IXgaT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730757AbfAPTZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 14:25:11 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45650 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730165AbfAPTZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 14:25:10 -0500
Received: from zn.tnic (p200300EC2BC98A00CC5DAB5F6CE50A3B.dip0.t-ipconnect.de [IPv6:2003:ec:2bc9:8a00:cc5d:ab5f:6ce5:a3b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 99E471EC0842;
        Wed, 16 Jan 2019 20:25:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547666709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Z8yYcWOc/c1SMKmstndCiEOZ/MoMnAviBAAgC8wNwbU=;
        b=kC4IXgaTd0ObqGUXeM3x8U/gyM4W94xi40Hvby9voFcr0Yt2b+yIGsUHX5AVpXo5d2lVx4
        TKdBGH0AwePOUIiZd4Ex7XVRMaaGyz3ga/H/1xUn3ny2uWioon0MaUVgNl8G83Uu+cCv84
        7hnn2gK62aFqgsSxzZtdOHpv/aKf93s=
Date:   Wed, 16 Jan 2019 20:25:02 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "S, Shirish" <Shirish.S@amd.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "maintainer : X86 ARCHITECTURE" <x86@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "open list : X86 ARCHITECTURE" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/mce/amd: carve out MC4_MISC thresholding quirk
Message-ID: <20190116192502.GJ15409@zn.tnic>
References: <1547651417-23583-1-git-send-email-shirish.s@amd.com>
 <1547651417-23583-3-git-send-email-shirish.s@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1547651417-23583-3-git-send-email-shirish.s@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 03:10:40PM +0000, S, Shirish wrote:
> MC4_MISC thresholding quirk needs to be applied during S5 -> S0 and
> S3 -> S0 state transitions, which follow different code paths, hence
> carve it out and move it mce_amd_feature_init(), which is  the converging
> point of both code paths.
> 
> Changelog[v2]:
>  - move the quirk to mce/amd.c

For future reference: changelog lines ...

> Signed-off-by: Shirish S <shirish.s@amd.com>
> ---

... land below this line so that they are not part of the commit
message.

>  arch/x86/kernel/cpu/mce/amd.c  | 34 ++++++++++++++++++++++++++++++++++
>  arch/x86/kernel/cpu/mce/core.c | 29 -----------------------------
>  2 files changed, 34 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> index 89298c8..f6a5c96 100644
> --- a/arch/x86/kernel/cpu/mce/amd.c
> +++ b/arch/x86/kernel/cpu/mce/amd.c
> @@ -545,6 +545,33 @@ prepare_threshold_block(unsigned int bank, unsigned int block, u32 addr,
>  	return offset;
>  }
>  
> +void mc4_misc_thresholding_quirk(void)

Functions should have a verb in their names.

I've fixed those and other issues now but make sure you take a look at
those nice documents here, for future reference, when preparing other
patches:

https://www.kernel.org/doc/html/latest/process/index.html

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
