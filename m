Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753927AbeEaEgh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 00:36:37 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43427 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751989AbeEaEga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 00:36:30 -0400
From: Dongjiu Geng <gengdongjiu@huawei.com>
To: <catalin.marinas@arm.com>, <will.deacon@arm.com>, <rjw@rjwysocki.net>,
        <lenb@kernel.org>, <tony.luck@intel.com>, <bp@alien8.de>,
        <robert.moore@intel.com>, <erik.schmauss@intel.com>,
        <mark.rutland@arm.com>, <dave.martin@arm.com>,
        <ard.biesheuvel@linaro.org>, <james.morse@arm.com>,
        <gengdongjiu@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH v1 2/2] arm64: handle NOTIFY_SEI notification by the APEI driver
Date: Thu, 31 May 2018 20:41:46 +0800
Message-ID: <1527770506-8076-3-git-send-email-gengdongjiu@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527770506-8076-1-git-send-email-gengdongjiu@huawei.com>
References: <1527770506-8076-1-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.143.28.90]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kernel or KVM gets the NOTIFY_SEI notification, it firstly
calls the APEI driver to handle this notification.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
 arch/arm64/kernel/traps.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
---
change since https://www.spinics.net/lists/kvm/msg168919.html

1. Remove the handle_guest_sei() helper


diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 8bbdc17..676e40c 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -50,6 +50,7 @@
 #include <asm/exception.h>
 #include <asm/system_misc.h>
 #include <asm/sysreg.h>
+#include <acpi/ghes.h>
 
 static const char *handler[]= {
 	"Synchronous Abort",
@@ -701,6 +702,20 @@ void __noreturn arm64_serror_panic(struct pt_regs *regs, u32 esr)
 bool arm64_is_fatal_ras_serror(struct pt_regs *regs, unsigned int esr)
 {
 	u32 aet = arm64_ras_serror_get_severity(esr);
+	int ret = -ENOENT;
+
+	if (IS_ENABLED(CONFIG_ACPI_APEI_SEI)) {
+		if (interrupts_enabled(regs))
+			nmi_enter();
+
+		ret = ghes_notify_sei();
+
+		if (interrupts_enabled(regs))
+			nmi_exit();
+
+		if (!ret)
+			return false;
+	}
 
 	switch (aet) {
 	case ESR_ELx_AET_CE:	/* corrected error */
-- 
1.9.1
