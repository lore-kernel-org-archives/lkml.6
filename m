Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831ABC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A403206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="H9LnA4gl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfAIWIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 17:08:53 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43856 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbfAIWIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 17:08:52 -0500
Received: from zn.tnic (p200300EC2BEA10006802B5941DDA3DDE.dip0.t-ipconnect.de [IPv6:2003:ec:2bea:1000:6802:b594:1dda:3dde])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6DD361EC027A;
        Wed,  9 Jan 2019 23:08:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547071731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Q6DP2BmRrr4pfYlYlCnGunrzad5k8+WLSO7ADjQQvbY=;
        b=H9LnA4glwBvAp8RP+VuP92TlAJ8hEbxfCQ9clKW5ZYFFIFLVR48+4RwFmGrheEkplVMVpW
        NNnBmbOUCOlDKqIGmB4zRBk85o41hVxME2GexyYhCixtUyNPvuwi9wqwLgdFc2/tVnJdOx
        GCHL1X3TL+GMRyDIzqM1gMEyrC26lgs=
Date:   Wed, 9 Jan 2019 23:08:43 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "S, Shirish" <Shirish.S@amd.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "maintainer : X86 ARCHITECTURE" <x86@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "open list : X86 ARCHITECTURE" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/mce/amd: Ensure quirks are applied in resume
 path as well
Message-ID: <20190109220843.GK15665@zn.tnic>
References: <1546857399-2926-1-git-send-email-shirish.s@amd.com>
 <1546857399-2926-3-git-send-email-shirish.s@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1546857399-2926-3-git-send-email-shirish.s@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 10:37:24AM +0000, S, Shirish wrote:
> This patch adds threshold quirk applicable for family 15

Same issue with "This patch" here.

> in resume path as well, since mce_amd_feature_init()
> does not have quirks applied when originating from mce_syscore_resume(),
> resulting in the below message at every successful resume:
> 
> "[Firmware Bug]: cpu 0, invalid threshold interrupt offset ..."
> 
> Signed-off-by: Shirish S <shirish.s@amd.com>
> ---
>  arch/x86/kernel/cpu/mce/amd.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> index 89298c8..27cbf66 100644
> --- a/arch/x86/kernel/cpu/mce/amd.c
> +++ b/arch/x86/kernel/cpu/mce/amd.c
> @@ -545,6 +545,34 @@ prepare_threshold_block(unsigned int bank, unsigned int block, u32 addr,
>  	return offset;
>  }
>  
> +void disable_err_thresholding(struct cpuinfo_x86 *c)
> +{
> +	int i;
> +	u64 hwcr;
> +	bool need_toggle;
> +	u32 msrs[] = {
> +		0x00000413, /* MC4_MISC0 */
> +		0xc0000408, /* MC4_MISC1 */
> +	};
> +
> +	if (c->x86_model >= 0x10 && c->x86_model <= 0x7f) {

You can save yourself an indentation level by reversing the logic here:

	if (c->x86 != 0x15)
		return;

Also, I'm wondering if you simply can't do

	if (c->x86_model < 0x10)
		return;

The assumption being that all the models - even after 0x7f - are highly
unlikely to get MC4_MISC thresholding supported, all of a sudden. Might
wanna run it by HW guys first though.

> +		rdmsrl(MSR_K7_HWCR, hwcr);
> +
> +		/* McStatusWrEn has to be set */
> +		need_toggle = !(hwcr & BIT(18));
> +
> +		if (need_toggle)
> +			wrmsrl(MSR_K7_HWCR, hwcr | BIT(18));
> +
> +		/* Clear CntP bit safely */
> +		for (i = 0; i < ARRAY_SIZE(msrs); i++)
> +			msr_clear_bit(msrs[i], 62);
> +
> +		/* restore old settings */
> +		if (need_toggle)
> +			wrmsrl(MSR_K7_HWCR, hwcr);
> +	}

So you copied the same code from __mcheck_cpu_apply_quirks().

No.

In a first patch, you carve that CntP clearing code in a separate
function disable_err_thresholding() like you've done before.

Then, in a second patch, you call it from mce/amd.c and you move all the
family/model checks inside the function so that you have a sole

	disable_err_thresholding();

calls where you need them.

You don't have to pass in struct cpuinfo_x86 *c - you can use
boot_cpu_data in the function.

> +}
>  /* cpu init entry point, called from mce.c with preempt off */
>  void mce_amd_feature_init(struct cpuinfo_x86 *c)
>  {
> @@ -552,6 +580,12 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
>  	unsigned int bank, block, cpu = smp_processor_id();
>  	int offset = -1;
>  
> +	/* Disable error thresholding bank in S3 resume path as well,

What S3 resume path? That's the CPU init path.

Also, kernel comments style is:

	/*
	 * A sentence ending with a full-stop.
	 * Another sentence. ...
	 * More sentences. ...
	 */


Good luck!

:-)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
