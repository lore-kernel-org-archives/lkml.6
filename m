Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D92C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8083217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="PQtT1DtF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfBZNR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 08:17:58 -0500
Received: from mail.skyhub.de ([5.9.137.197]:54344 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbfBZNR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 08:17:58 -0500
Received: from zn.tnic (p200300EC2BCDB20004BF6FA0AD9E5D61.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:b200:4bf:6fa0:ad9e:5d61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5C3CC1EC0354;
        Tue, 26 Feb 2019 14:17:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1551187076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2JnbunDZBQpD7g40+XPuyOzLQFdVQIVbt/t2Koka7CU=;
        b=PQtT1DtFcxURLvwLi61JMwTAiJHZ8Thfak3OfuUAHXLCqVf7b6M4RBxaTvvx0Db1zKZDxo
        xPOiWFjlNJe1HgC6FjhKe5CgJsAF5hur5UNds5yXIPNSwvrrEKheB7pb+FpdpERs4kvDK9
        tQvIltPN/gn9UB9dZRyAthiHRdx3lLM=
Date:   Tue, 26 Feb 2019 14:17:47 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] EDAC/amd64: Recognize x16 Symbol Size
Message-ID: <20190226131747.GD14836@zn.tnic>
References: <20190219202536.15462-1-Yazen.Ghannam@amd.com>
 <20190219202536.15462-3-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190219202536.15462-3-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 08:25:54PM +0000, Ghannam, Yazen wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Future AMD systems may support x16 symbol sizes.
> 
> Recognize if a system is using x16 symbol size. Also, simplify the print
> statement.
> 
> Note that a x16 syndrome vector table is not necessary like with x4 or
> x8. This is because systems that support x16 symbol sizes will be SMCA
> systems. In which case, the syndrome can be directly extracted from the
> MCA_SYND[Syndrome] field.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  drivers/edac/amd64_edac.c | 15 +++++++++------
>  drivers/edac/amd64_edac.h |  2 +-
>  2 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 507d824fe45a..bacd2cb22f29 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -897,8 +897,7 @@ static void dump_misc_regs(struct amd64_pvt *pvt)
>  
>  	edac_dbg(1, "  DramHoleValid: %s\n", dhar_valid(pvt) ? "yes" : "no");
>  
> -	amd64_info("using %s syndromes.\n",
> -			((pvt->ecc_sym_sz == 8) ? "x8" : "x4"));
> +	amd64_info("using x%u syndromes.\n", pvt->ecc_sym_sz);
>  }
>  
>  /*
> @@ -2609,10 +2608,14 @@ static void determine_ecc_sym_sz(struct amd64_pvt *pvt)
>  
>  		for_each_umc(i) {
>  			/* Check enabled channels only: */
> -			if ((pvt->umc[i].sdp_ctrl & UMC_SDP_INIT) &&
> -			    (pvt->umc[i].ecc_ctrl & BIT(7))) {
> -				pvt->ecc_sym_sz = 8;
> -				break;
> +			if (pvt->umc[i].sdp_ctrl & UMC_SDP_INIT) {
> +				if (pvt->umc[i].ecc_ctrl & BIT(9)) {
> +					pvt->ecc_sym_sz = 16;
> +					break;
> +				} else if (pvt->umc[i].ecc_ctrl & BIT(7)) {
> +					pvt->ecc_sym_sz = 8;
> +					break;
> +				}
>  			}
>  		}
>  

Let's simplify this function a bit. Diff ontop:

---
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index bacd2cb22f29..df21b00dca08 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2611,18 +2611,14 @@ static void determine_ecc_sym_sz(struct amd64_pvt *pvt)
 			if (pvt->umc[i].sdp_ctrl & UMC_SDP_INIT) {
 				if (pvt->umc[i].ecc_ctrl & BIT(9)) {
 					pvt->ecc_sym_sz = 16;
-					break;
+					return;
 				} else if (pvt->umc[i].ecc_ctrl & BIT(7)) {
 					pvt->ecc_sym_sz = 8;
-					break;
+					return;
 				}
 			}
 		}
-
-		return;
-	}
-
-	if (pvt->fam >= 0x10) {
+	} else if (pvt->fam >= 0x10) {
 		u32 tmp;
 
 		amd64_read_pci_cfg(pvt->F3, EXT_NB_MCA_CFG, &tmp);

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
