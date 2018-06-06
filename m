Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DC6AB606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752185AbeFFMRF (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 08:17:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33113 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751849AbeFFMRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 08:17:03 -0400
Date: Wed, 6 Jun 2018 05:16:53 -0700
From: tip-bot for Konrad Rzeszutek Wilk <tipbot@zytor.com>
Message-ID: <tip-108fab4b5c8f12064ef86e02cb0459992affb30f@git.kernel.org>
Cc: konrad.wilk@oracle.com, dwmw@amazon.co.uk, mingo@kernel.org,
        tglx@linutronix.de, hpa@zytor.com, bp@suse.de,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        karahmed@amazon.de
Reply-To: hpa@zytor.com, dwmw@amazon.co.uk, tglx@linutronix.de,
          mingo@kernel.org, konrad.wilk@oracle.com, karahmed@amazon.de,
          linux-kernel@vger.kernel.org, keescook@chromium.org, bp@suse.de
In-Reply-To: <20180601145921.9500-4-konrad.wilk@oracle.com>
References: <20180601145921.9500-4-konrad.wilk@oracle.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/bugs: Switch the selection of mitigation from CPU
 vendor to CPU features
Git-Commit-ID: 108fab4b5c8f12064ef86e02cb0459992affb30f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  108fab4b5c8f12064ef86e02cb0459992affb30f
Gitweb:     https://git.kernel.org/tip/108fab4b5c8f12064ef86e02cb0459992affb30f
Author:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
AuthorDate: Fri, 1 Jun 2018 10:59:21 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 6 Jun 2018 14:13:17 +0200

x86/bugs: Switch the selection of mitigation from CPU vendor to CPU features

Both AMD and Intel can have SPEC_CTRL_MSR for SSBD.

However AMD also has two more other ways of doing it - which
are !SPEC_CTRL MSR ways.

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Kees Cook <keescook@chromium.org>
Cc: kvm@vger.kernel.org
Cc: KarimAllah Ahmed <karahmed@amazon.de>
Cc: andrew.cooper3@citrix.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Link: https://lkml.kernel.org/r/20180601145921.9500-4-konrad.wilk@oracle.com

---
 arch/x86/kernel/cpu/bugs.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 6bea81855cdd..cd0fda1fff6d 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -532,17 +532,12 @@ static enum ssb_mitigation __init __ssb_select_mitigation(void)
 		 * Intel uses the SPEC CTRL MSR Bit(2) for this, while AMD may
 		 * use a completely different MSR and bit dependent on family.
 		 */
-		switch (boot_cpu_data.x86_vendor) {
-		case X86_VENDOR_INTEL:
-		case X86_VENDOR_AMD:
-			if (!static_cpu_has(X86_FEATURE_MSR_SPEC_CTRL)) {
-				x86_amd_ssb_disable();
-				break;
-			}
+		if (!static_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
+			x86_amd_ssb_disable();
+		else {
 			x86_spec_ctrl_base |= SPEC_CTRL_SSBD;
 			x86_spec_ctrl_mask |= SPEC_CTRL_SSBD;
 			wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
-			break;
 		}
 	}
 
