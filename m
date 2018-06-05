Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753394AbeFERFr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:05:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:34850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752093AbeFERFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:05:44 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.9 34/61] powerpc/pseries: Set or clear security feature flags
Date: Tue,  5 Jun 2018 19:01:55 +0200
Message-Id: <20180605170119.879523536@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180605170117.643936916@linuxfoundation.org>
References: <20180605170117.643936916@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

commit f636c14790ead6cc22cf62279b1f8d7e11a67116 upstream.

Now that we have feature flags for security related things, set or
clear them based on what we receive from the hypercall.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/pseries/setup.c |   43 +++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -66,6 +66,7 @@
 #include <asm/reg.h>
 #include <asm/plpar_wrappers.h>
 #include <asm/kexec.h>
+#include <asm/security_features.h>
 
 #include "pseries.h"
 
@@ -450,6 +451,40 @@ static void __init find_and_init_phbs(vo
 	of_pci_check_probe_only();
 }
 
+static void init_cpu_char_feature_flags(struct h_cpu_char_result *result)
+{
+	if (result->character & H_CPU_CHAR_SPEC_BAR_ORI31)
+		security_ftr_set(SEC_FTR_SPEC_BAR_ORI31);
+
+	if (result->character & H_CPU_CHAR_BCCTRL_SERIALISED)
+		security_ftr_set(SEC_FTR_BCCTRL_SERIALISED);
+
+	if (result->character & H_CPU_CHAR_L1D_FLUSH_ORI30)
+		security_ftr_set(SEC_FTR_L1D_FLUSH_ORI30);
+
+	if (result->character & H_CPU_CHAR_L1D_FLUSH_TRIG2)
+		security_ftr_set(SEC_FTR_L1D_FLUSH_TRIG2);
+
+	if (result->character & H_CPU_CHAR_L1D_THREAD_PRIV)
+		security_ftr_set(SEC_FTR_L1D_THREAD_PRIV);
+
+	if (result->character & H_CPU_CHAR_COUNT_CACHE_DISABLED)
+		security_ftr_set(SEC_FTR_COUNT_CACHE_DISABLED);
+
+	/*
+	 * The features below are enabled by default, so we instead look to see
+	 * if firmware has *disabled* them, and clear them if so.
+	 */
+	if (!(result->character & H_CPU_BEHAV_FAVOUR_SECURITY))
+		security_ftr_clear(SEC_FTR_FAVOUR_SECURITY);
+
+	if (!(result->character & H_CPU_BEHAV_L1D_FLUSH_PR))
+		security_ftr_clear(SEC_FTR_L1D_FLUSH_PR);
+
+	if (!(result->character & H_CPU_BEHAV_BNDS_CHK_SPEC_BAR))
+		security_ftr_clear(SEC_FTR_BNDS_CHK_SPEC_BAR);
+}
+
 void pseries_setup_rfi_flush(void)
 {
 	struct h_cpu_char_result result;
@@ -463,6 +498,8 @@ void pseries_setup_rfi_flush(void)
 
 	rc = plpar_get_cpu_characteristics(&result);
 	if (rc == H_SUCCESS) {
+		init_cpu_char_feature_flags(&result);
+
 		if (result.character & H_CPU_CHAR_L1D_FLUSH_TRIG2)
 			types |= L1D_FLUSH_MTTRIG;
 		if (result.character & H_CPU_CHAR_L1D_FLUSH_ORI30)
@@ -473,6 +510,12 @@ void pseries_setup_rfi_flush(void)
 			enable = false;
 	}
 
+	/*
+	 * We're the guest so this doesn't apply to us, clear it to simplify
+	 * handling of it elsewhere.
+	 */
+	security_ftr_clear(SEC_FTR_L1D_FLUSH_HV);
+
 	setup_rfi_flush(types, enable);
 }
 
