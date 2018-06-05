Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753533AbeFERGE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:06:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753383AbeFERGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:06:01 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.9 39/61] powerpc/pseries: Use the security flags in pseries_setup_rfi_flush()
Date: Tue,  5 Jun 2018 19:02:00 +0200
Message-Id: <20180605170120.159520145@linuxfoundation.org>
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

commit 2e4a16161fcd324b1f9bf6cb6856529f7eaf0689 upstream.

Now that we have the security flags we can simplify the code in
pseries_setup_rfi_flush() because the security flags have pessimistic
defaults.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/pseries/setup.c |   27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -492,30 +492,27 @@ void pseries_setup_rfi_flush(void)
 	bool enable;
 	long rc;
 
-	/* Enable by default */
-	enable = true;
-	types = L1D_FLUSH_FALLBACK;
-
 	rc = plpar_get_cpu_characteristics(&result);
-	if (rc == H_SUCCESS) {
+	if (rc == H_SUCCESS)
 		init_cpu_char_feature_flags(&result);
 
-		if (result.character & H_CPU_CHAR_L1D_FLUSH_TRIG2)
-			types |= L1D_FLUSH_MTTRIG;
-		if (result.character & H_CPU_CHAR_L1D_FLUSH_ORI30)
-			types |= L1D_FLUSH_ORI;
-
-		if ((!(result.behaviour & H_CPU_BEHAV_L1D_FLUSH_PR)) ||
-		    (!(result.behaviour & H_CPU_BEHAV_FAVOUR_SECURITY)))
-			enable = false;
-	}
-
 	/*
 	 * We're the guest so this doesn't apply to us, clear it to simplify
 	 * handling of it elsewhere.
 	 */
 	security_ftr_clear(SEC_FTR_L1D_FLUSH_HV);
 
+	types = L1D_FLUSH_FALLBACK;
+
+	if (security_ftr_enabled(SEC_FTR_L1D_FLUSH_TRIG2))
+		types |= L1D_FLUSH_MTTRIG;
+
+	if (security_ftr_enabled(SEC_FTR_L1D_FLUSH_ORI30))
+		types |= L1D_FLUSH_ORI;
+
+	enable = security_ftr_enabled(SEC_FTR_FAVOUR_SECURITY) && \
+		 security_ftr_enabled(SEC_FTR_L1D_FLUSH_PR);
+
 	setup_rfi_flush(types, enable);
 }
 
