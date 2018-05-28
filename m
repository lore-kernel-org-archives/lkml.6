Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425119AbeE1Npf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:45:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932453AbeE1KnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:43:03 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, greg@kroah.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 045/496] powerpc/powernv: Set or clear security feature flags
Date: Mon, 28 May 2018 11:57:10 +0200
Message-Id: <20180528100321.629564433@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

commit 77addf6e95c8689e478d607176b399a6242a777e upstream.

Now that we have feature flags for security related things, set or
clear them based on what we see in the device tree provided by
firmware.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/powernv/setup.c |   56 +++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -37,9 +37,63 @@
 #include <asm/kexec.h>
 #include <asm/smp.h>
 #include <asm/setup.h>
+#include <asm/security_features.h>
 
 #include "powernv.h"
 
+
+static bool fw_feature_is(const char *state, const char *name,
+			  struct device_node *fw_features)
+{
+	struct device_node *np;
+	bool rc = false;
+
+	np = of_get_child_by_name(fw_features, name);
+	if (np) {
+		rc = of_property_read_bool(np, state);
+		of_node_put(np);
+	}
+
+	return rc;
+}
+
+static void init_fw_feat_flags(struct device_node *np)
+{
+	if (fw_feature_is("enabled", "inst-spec-barrier-ori31,31,0", np))
+		security_ftr_set(SEC_FTR_SPEC_BAR_ORI31);
+
+	if (fw_feature_is("enabled", "fw-bcctrl-serialized", np))
+		security_ftr_set(SEC_FTR_BCCTRL_SERIALISED);
+
+	if (fw_feature_is("enabled", "inst-spec-barrier-ori31,31,0", np))
+		security_ftr_set(SEC_FTR_L1D_FLUSH_ORI30);
+
+	if (fw_feature_is("enabled", "inst-l1d-flush-trig2", np))
+		security_ftr_set(SEC_FTR_L1D_FLUSH_TRIG2);
+
+	if (fw_feature_is("enabled", "fw-l1d-thread-split", np))
+		security_ftr_set(SEC_FTR_L1D_THREAD_PRIV);
+
+	if (fw_feature_is("enabled", "fw-count-cache-disabled", np))
+		security_ftr_set(SEC_FTR_COUNT_CACHE_DISABLED);
+
+	/*
+	 * The features below are enabled by default, so we instead look to see
+	 * if firmware has *disabled* them, and clear them if so.
+	 */
+	if (fw_feature_is("disabled", "speculation-policy-favor-security", np))
+		security_ftr_clear(SEC_FTR_FAVOUR_SECURITY);
+
+	if (fw_feature_is("disabled", "needs-l1d-flush-msr-pr-0-to-1", np))
+		security_ftr_clear(SEC_FTR_L1D_FLUSH_PR);
+
+	if (fw_feature_is("disabled", "needs-l1d-flush-msr-hv-1-to-0", np))
+		security_ftr_clear(SEC_FTR_L1D_FLUSH_HV);
+
+	if (fw_feature_is("disabled", "needs-spec-barrier-for-bound-checks", np))
+		security_ftr_clear(SEC_FTR_BNDS_CHK_SPEC_BAR);
+}
+
 static void pnv_setup_rfi_flush(void)
 {
 	struct device_node *np, *fw_features;
@@ -55,6 +109,8 @@ static void pnv_setup_rfi_flush(void)
 	of_node_put(np);
 
 	if (fw_features) {
+		init_fw_feat_flags(fw_features);
+
 		np = of_get_child_by_name(fw_features, "inst-l1d-flush-trig2");
 		if (np && of_property_read_bool(np, "enabled"))
 			type = L1D_FLUSH_MTTRIG;
