Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753481AbeFERF6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:05:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752976AbeFERFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:05:55 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.9 37/61] powerpc/64s: Enhance the information in cpu_show_meltdown()
Date: Tue,  5 Jun 2018 19:01:58 +0200
Message-Id: <20180605170120.052252607@linuxfoundation.org>
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

commit ff348355e9c72493947be337bb4fae4fc1a41eba upstream.

Now that we have the security feature flags we can make the
information displayed in the "meltdown" file more informative.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/security.c |   30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -6,6 +6,7 @@
 
 #include <linux/kernel.h>
 #include <linux/device.h>
+#include <linux/seq_buf.h>
 
 #include <asm/security_features.h>
 
@@ -19,8 +20,33 @@ unsigned long powerpc_security_features
 
 ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	if (rfi_flush)
-		return sprintf(buf, "Mitigation: RFI Flush\n");
+	bool thread_priv;
+
+	thread_priv = security_ftr_enabled(SEC_FTR_L1D_THREAD_PRIV);
+
+	if (rfi_flush || thread_priv) {
+		struct seq_buf s;
+		seq_buf_init(&s, buf, PAGE_SIZE - 1);
+
+		seq_buf_printf(&s, "Mitigation: ");
+
+		if (rfi_flush)
+			seq_buf_printf(&s, "RFI Flush");
+
+		if (rfi_flush && thread_priv)
+			seq_buf_printf(&s, ", ");
+
+		if (thread_priv)
+			seq_buf_printf(&s, "L1D private per thread");
+
+		seq_buf_printf(&s, "\n");
+
+		return s.len;
+	}
+
+	if (!security_ftr_enabled(SEC_FTR_L1D_FLUSH_HV) &&
+	    !security_ftr_enabled(SEC_FTR_L1D_FLUSH_PR))
+		return sprintf(buf, "Not affected\n");
 
 	return sprintf(buf, "Vulnerable\n");
 }
