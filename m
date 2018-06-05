Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753140AbeFERE5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:04:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:33866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753100AbeFEREx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:04:53 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Neuling <mikey@neuling.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.9 02/61] powerpc/64s: Clear PCR on boot
Date: Tue,  5 Jun 2018 19:01:23 +0200
Message-Id: <20180605170117.775646752@linuxfoundation.org>
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

From: Michael Neuling <mikey@neuling.org>

commit faf37c44a105f3608115785f17cbbf3500f8bc71 upstream.

Clear the PCR (Processor Compatibility Register) on boot to ensure we
are not running in a compatibility mode.

We've seen this cause problems when a crash (and kdump) occurs while
running compat mode guests. The kdump kernel then runs with the PCR
set and causes problems. The symptom in the kdump kernel (also seen in
petitboot after fast-reboot) is early userspace programs taking
sigills on newer instructions (seen in libc).

Signed-off-by: Michael Neuling <mikey@neuling.org>
Cc: stable@vger.kernel.org
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/cpu_setup_power.S |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/arch/powerpc/kernel/cpu_setup_power.S
+++ b/arch/powerpc/kernel/cpu_setup_power.S
@@ -28,6 +28,7 @@ _GLOBAL(__setup_cpu_power7)
 	beqlr
 	li	r0,0
 	mtspr	SPRN_LPID,r0
+	mtspr	SPRN_PCR,r0
 	mfspr	r3,SPRN_LPCR
 	bl	__init_LPCR
 	bl	__init_tlb_power7
@@ -41,6 +42,7 @@ _GLOBAL(__restore_cpu_power7)
 	beqlr
 	li	r0,0
 	mtspr	SPRN_LPID,r0
+	mtspr	SPRN_PCR,r0
 	mfspr	r3,SPRN_LPCR
 	bl	__init_LPCR
 	bl	__init_tlb_power7
@@ -57,6 +59,7 @@ _GLOBAL(__setup_cpu_power8)
 	beqlr
 	li	r0,0
 	mtspr	SPRN_LPID,r0
+	mtspr	SPRN_PCR,r0
 	mfspr	r3,SPRN_LPCR
 	ori	r3, r3, LPCR_PECEDH
 	bl	__init_LPCR
@@ -78,6 +81,7 @@ _GLOBAL(__restore_cpu_power8)
 	beqlr
 	li	r0,0
 	mtspr	SPRN_LPID,r0
+	mtspr	SPRN_PCR,r0
 	mfspr   r3,SPRN_LPCR
 	ori	r3, r3, LPCR_PECEDH
 	bl	__init_LPCR
@@ -98,6 +102,7 @@ _GLOBAL(__setup_cpu_power9)
 	li	r0,0
 	mtspr	SPRN_LPID,r0
 	mtspr	SPRN_PID,r0
+	mtspr	SPRN_PCR,r0
 	mfspr	r3,SPRN_LPCR
 	LOAD_REG_IMMEDIATE(r4, LPCR_PECEDH | LPCR_PECE_HVEE | LPCR_HVICE)
 	or	r3, r3, r4
@@ -121,6 +126,7 @@ _GLOBAL(__restore_cpu_power9)
 	li	r0,0
 	mtspr	SPRN_LPID,r0
 	mtspr	SPRN_PID,r0
+	mtspr	SPRN_PCR,r0
 	mfspr   r3,SPRN_LPCR
 	LOAD_REG_IMMEDIATE(r4, LPCR_PECEDH | LPCR_PECE_HVEE | LPCR_HVICE)
 	or	r3, r3, r4
