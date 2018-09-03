Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4DAC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A4120658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A4120658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731397AbeICVzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:55:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47776 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728335AbeICVzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:55:38 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 93BDED18;
        Mon,  3 Sep 2018 17:34:27 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Paulo Zanoni <paulo.r.zanoni@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 4.18 047/123] x86/gpu: reserve ICLs graphics stolen memory
Date:   Mon,  3 Sep 2018 18:56:31 +0200
Message-Id: <20180903165721.453010260@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165719.499675257@linuxfoundation.org>
References: <20180903165719.499675257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paulo Zanoni <paulo.r.zanoni@intel.com>

commit db0c8d8b031d2b5960f6407f7f2ca20e97e00605 upstream.

ICL changes the registers and addresses to 64 bits.

I also briefly looked at implementing an u64 version of the PCI config
read functions, but I concluded this wouldn't be trivial, so it's not
worth doing it for a single user that can't have any racing problems
while reading the register in two separate operations.

v2:
 - Scrub the development (non-public) changelog (Joonas).
 - Remove the i915.ko bits so this can be easily backported in order
   to properly avoid stolen memory even on machines without i915.ko
   (Joonas).
 - CC stable for the reasons above.

Issue: VIZ-9250
CC: stable@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Paulo Zanoni <paulo.r.zanoni@intel.com>
Fixes: 412310019a20 ("drm/i915/icl: Add initial Icelake definitions.")
Reviewed-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180504203252.28048-1-paulo.r.zanoni@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/early-quirks.c |   18 ++++++++++++++++++
 include/drm/i915_drm.h         |    4 +++-
 2 files changed, 21 insertions(+), 1 deletion(-)

--- a/arch/x86/kernel/early-quirks.c
+++ b/arch/x86/kernel/early-quirks.c
@@ -338,6 +338,18 @@ static resource_size_t __init gen3_stole
 	return bsm & INTEL_BSM_MASK;
 }
 
+static resource_size_t __init gen11_stolen_base(int num, int slot, int func,
+						resource_size_t stolen_size)
+{
+	u64 bsm;
+
+	bsm = read_pci_config(num, slot, func, INTEL_GEN11_BSM_DW0);
+	bsm &= INTEL_BSM_MASK;
+	bsm |= (u64)read_pci_config(num, slot, func, INTEL_GEN11_BSM_DW1) << 32;
+
+	return bsm;
+}
+
 static resource_size_t __init i830_stolen_size(int num, int slot, int func)
 {
 	u16 gmch_ctrl;
@@ -498,6 +510,11 @@ static const struct intel_early_ops chv_
 	.stolen_size = chv_stolen_size,
 };
 
+static const struct intel_early_ops gen11_early_ops __initconst = {
+	.stolen_base = gen11_stolen_base,
+	.stolen_size = gen9_stolen_size,
+};
+
 static const struct pci_device_id intel_early_ids[] __initconst = {
 	INTEL_I830_IDS(&i830_early_ops),
 	INTEL_I845G_IDS(&i845_early_ops),
@@ -529,6 +546,7 @@ static const struct pci_device_id intel_
 	INTEL_CFL_IDS(&gen9_early_ops),
 	INTEL_GLK_IDS(&gen9_early_ops),
 	INTEL_CNL_IDS(&gen9_early_ops),
+	INTEL_ICL_11_IDS(&gen11_early_ops),
 };
 
 struct resource intel_graphics_stolen_res __ro_after_init = DEFINE_RES_MEM(0, 0);
--- a/include/drm/i915_drm.h
+++ b/include/drm/i915_drm.h
@@ -95,7 +95,9 @@ extern struct resource intel_graphics_st
 #define    I845_TSEG_SIZE_512K	(2 << 1)
 #define    I845_TSEG_SIZE_1M	(3 << 1)
 
-#define INTEL_BSM 0x5c
+#define INTEL_BSM		0x5c
+#define INTEL_GEN11_BSM_DW0	0xc0
+#define INTEL_GEN11_BSM_DW1	0xc4
 #define   INTEL_BSM_MASK	(-(1u << 20))
 
 #endif				/* _I915_DRM_H_ */


