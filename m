Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AFFC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE02220661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:20:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE02220661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbeLIWUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:20:01 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35466 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726558AbeLIVzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:25 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72o-0002iY-3X; Sun, 09 Dec 2018 21:55:22 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72k-0003fz-W3; Sun, 09 Dec 2018 21:55:18 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Mikulas Patocka" <mpatocka@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Ville =?UTF-8?Q?Syrj=C3=A4l=C3=A4?=" <syrjala@sci.fi>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.936389512@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 304/328] mach64: detect the dot clock divider
 correctly on sparc
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit 76ebebd2464c5c8a4453c98b6dbf9c95a599e810 upstream.

On Sun Ultra 5, it happens that the dot clock is not set up properly for
some videomodes. For example, if we set the videomode "r1024x768x60" in
the firmware, Linux would incorrectly set a videomode with refresh rate
180Hz when booting (suprisingly, my LCD monitor can display it, although
display quality is very low).

The reason is this: Older mach64 cards set the divider in the register
VCLK_POST_DIV. The register has four 2-bit fields (the field that is
actually used is specified in the lowest two bits of the register
CLOCK_CNTL). The 2 bits select divider "1, 2, 4, 8". On newer mach64 cards,
there's another bit added - the top four bits of PLL_EXT_CNTL extend the
divider selection, so we have possible dividers "1, 2, 4, 8, 3, 5, 6, 12".
The Linux driver clears the top four bits of PLL_EXT_CNTL and never sets
them, so it can work regardless if the card supports them. However, the
sparc64 firmware may set these extended dividers during boot - and the
mach64 driver detects incorrect dot clock in this case.

This patch makes the driver read the additional divider bit from
PLL_EXT_CNTL and calculate the initial refresh rate properly.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Acked-by: David S. Miller <davem@davemloft.net>
Reviewed-by: Ville Syrjälä <syrjala@sci.fi>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/video/fbdev/aty/atyfb.h      |  3 ++-
 drivers/video/fbdev/aty/atyfb_base.c |  7 ++++---
 drivers/video/fbdev/aty/mach64_ct.c  | 10 +++++-----
 3 files changed, 11 insertions(+), 9 deletions(-)

--- a/drivers/video/fbdev/aty/atyfb.h
+++ b/drivers/video/fbdev/aty/atyfb.h
@@ -335,6 +335,8 @@ extern const struct aty_pll_ops aty_pll_
 extern void aty_set_pll_ct(const struct fb_info *info, const union aty_pll *pll);
 extern u8 aty_ld_pll_ct(int offset, const struct atyfb_par *par);
 
+extern const u8 aty_postdividers[8];
+
 
     /*
      *  Hardware cursor support
@@ -361,7 +363,6 @@ static inline void wait_for_idle(struct
 
 extern void aty_reset_engine(const struct atyfb_par *par);
 extern void aty_init_engine(struct atyfb_par *par, struct fb_info *info);
-extern u8   aty_ld_pll_ct(int offset, const struct atyfb_par *par);
 
 void atyfb_copyarea(struct fb_info *info, const struct fb_copyarea *area);
 void atyfb_fillrect(struct fb_info *info, const struct fb_fillrect *rect);
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -3118,17 +3118,18 @@ static int atyfb_setup_sparc(struct pci_
 		/*
 		 * PLL Reference Divider M:
 		 */
-		M = pll_regs[2];
+		M = pll_regs[PLL_REF_DIV];
 
 		/*
 		 * PLL Feedback Divider N (Dependent on CLOCK_CNTL):
 		 */
-		N = pll_regs[7 + (clock_cntl & 3)];
+		N = pll_regs[VCLK0_FB_DIV + (clock_cntl & 3)];
 
 		/*
 		 * PLL Post Divider P (Dependent on CLOCK_CNTL):
 		 */
-		P = 1 << (pll_regs[6] >> ((clock_cntl & 3) << 1));
+		P = aty_postdividers[((pll_regs[VCLK_POST_DIV] >> ((clock_cntl & 3) << 1)) & 3) |
+		                     ((pll_regs[PLL_EXT_CNTL] >> (2 + (clock_cntl & 3))) & 4)];
 
 		/*
 		 * PLL Divider Q:
--- a/drivers/video/fbdev/aty/mach64_ct.c
+++ b/drivers/video/fbdev/aty/mach64_ct.c
@@ -114,7 +114,7 @@ static void aty_st_pll_ct(int offset, u8
  */
 
 #define Maximum_DSP_PRECISION 7
-static u8 postdividers[] = {1,2,4,8,3};
+const u8 aty_postdividers[8] = {1,2,4,8,3,5,6,12};
 
 static int aty_dsp_gt(const struct fb_info *info, u32 bpp, struct pll_ct *pll)
 {
@@ -221,7 +221,7 @@ static int aty_valid_pll_ct(const struct
 		pll->vclk_post_div += (q <  64*8);
 		pll->vclk_post_div += (q <  32*8);
 	}
-	pll->vclk_post_div_real = postdividers[pll->vclk_post_div];
+	pll->vclk_post_div_real = aty_postdividers[pll->vclk_post_div];
 	//    pll->vclk_post_div <<= 6;
 	pll->vclk_fb_div = q * pll->vclk_post_div_real / 8;
 	pllvclk = (1000000 * 2 * pll->vclk_fb_div) /
@@ -512,7 +512,7 @@ static int aty_init_pll_ct(const struct
 		u8 mclk_fb_div, pll_ext_cntl;
 		pll->ct.pll_ref_div = aty_ld_pll_ct(PLL_REF_DIV, par);
 		pll_ext_cntl = aty_ld_pll_ct(PLL_EXT_CNTL, par);
-		pll->ct.xclk_post_div_real = postdividers[pll_ext_cntl & 0x07];
+		pll->ct.xclk_post_div_real = aty_postdividers[pll_ext_cntl & 0x07];
 		mclk_fb_div = aty_ld_pll_ct(MCLK_FB_DIV, par);
 		if (pll_ext_cntl & PLL_MFB_TIMES_4_2B)
 			mclk_fb_div <<= 1;
@@ -534,7 +534,7 @@ static int aty_init_pll_ct(const struct
 		xpost_div += (q <  64*8);
 		xpost_div += (q <  32*8);
 	}
-	pll->ct.xclk_post_div_real = postdividers[xpost_div];
+	pll->ct.xclk_post_div_real = aty_postdividers[xpost_div];
 	pll->ct.mclk_fb_div = q * pll->ct.xclk_post_div_real / 8;
 
 #ifdef CONFIG_PPC
@@ -583,7 +583,7 @@ static int aty_init_pll_ct(const struct
 			mpost_div += (q <  64*8);
 			mpost_div += (q <  32*8);
 		}
-		sclk_post_div_real = postdividers[mpost_div];
+		sclk_post_div_real = aty_postdividers[mpost_div];
 		pll->ct.sclk_fb_div = q * sclk_post_div_real / 8;
 		pll->ct.spll_cntl2 = mpost_div << 4;
 #ifdef DEBUG

