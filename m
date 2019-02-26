Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103D2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 21:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07EF218A1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 21:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="IOlbWdlr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbfBZVxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 16:53:36 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42538 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728791AbfBZVxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 16:53:36 -0500
Received: from zn.tnic (p200300EC2BCDB200B0CF70802C24D707.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:b200:b0cf:7080:2c24:d707])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 57C131EC0758;
        Tue, 26 Feb 2019 22:53:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1551218014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=I/NHNGVyjIIE83qXlq1IvdhjKdohzuVTDFpeVEiU3Lw=;
        b=IOlbWdlrUeU+9QR243NVbPn3707NI7MvZpGlc/TzlOVzB2R85n4j3O9PE7PUmdNGZVkiwq
        8CBnFkzeAG0hZpBAFimFIn9XpNpCZ+1C/6G+d/QmY4UuZncWjzjp8PlcKihco/HPucBEhr
        qTjhWIbuXzcmbh71XcZYghigKFqj38U=
Date:   Tue, 26 Feb 2019 22:53:27 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/6] EDAC/amd64: Use a macro for iterating over
 Unified Memory Controllers
Message-ID: <20190226215327.GH14836@zn.tnic>
References: <20190226172532.12924-1-Yazen.Ghannam@amd.com>
 <20190226172532.12924-3-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190226172532.12924-3-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 05:25:46PM +0000, Ghannam, Yazen wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Define and use a macro for looping over the number of Unified Memory
> Controllers.
> 
> No functional change.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
> Link:
> https://lkml.kernel.org/r/20190219202536.15462-2-Yazen.Ghannam@amd.com
> 
> v1->v2:
> * New in V2. Please see comment on Patch 2 V1 at link above.
> 
>  drivers/edac/amd64_edac.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 0038fcb0b010..c82aafb7246a 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -449,6 +449,9 @@ static void get_cs_base_and_mask(struct amd64_pvt *pvt, int csrow, u8 dct,
>  #define for_each_chip_select_mask(i, dct, pvt) \
>  	for (i = 0; i < pvt->csels[dct].m_cnt; i++)
>  
> +#define for_each_umc(i) \
> +	for (i = 0; i < num_umcs; i++)
> +
>  /*
>   * @input_addr is an InputAddr associated with the node given by mci. Return the
>   * csrow that input_addr maps to, or -1 on failure (no csrow claims input_addr).
> @@ -722,7 +725,7 @@ static unsigned long determine_edac_cap(struct amd64_pvt *pvt)
>  	if (pvt->umc) {
>  		u8 i, umc_en_mask = 0, dimm_ecc_en_mask = 0;
>  
> -		for (i = 0; i < num_umcs; i++) {
> +		for_each_umc(i) {

Hmm, maybe I didn't express myself as clearly as I should have, before.
Sorry about that.

But if you sort the patches this way:

1. Add for_each_umc() and convert code to use it
2. add num_umcs and convert for_each_umc() to use it

You won't have to touch the loops twice in patches 2 and 3 and your
diffstat will be a lot smaller.

Makes sense?

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
