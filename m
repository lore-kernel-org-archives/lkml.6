Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752714AbeFAPA0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 11:00:26 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:40258 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752487AbeFAPAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 11:00:00 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org,
        tglx@linutronix.de, andrew.cooper3@citrix.com
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Borislav Petkov <bp@suse.de>, David Woodhouse <dwmw@amazon.co.uk>,
        Kees Cook <keescook@chromium.org>,
        KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v1 3/3] x86/bugs: Switch the selection of mitigation from CPU vendor to CPU features
Date: Fri,  1 Jun 2018 10:59:21 -0400
Message-Id: <20180601145921.9500-4-konrad.wilk@oracle.com>
X-Mailer: git-send-email 2.13.4
In-Reply-To: <20180601145921.9500-1-konrad.wilk@oracle.com>
References: <20180601145921.9500-1-konrad.wilk@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8911 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=910
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806010174
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both AMD and Intel can have SPEC CTRL MSR for SSBD.

However AMD also has two more other ways of doing it - which
are !SPEC_CTRL MSR ways.

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

---
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Kees Cook <keescook@chromium.org>
Cc: KarimAllah Ahmed <karahmed@amazon.de>
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
 
-- 
2.13.4
