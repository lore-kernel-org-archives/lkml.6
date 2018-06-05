Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751670AbeFELwu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 07:52:50 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:52239 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751502AbeFELwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 07:52:49 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Shanker Donthineni <shankerd@codeaurora.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: cpu_errata: include required headers
Date: Tue,  5 Jun 2018 13:50:07 +0200
Message-Id: <20180605115227.1621618-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:g3wJ6pLnLlG2xO8vlY3O3nRcSQ+Ics8ht1pA1R1IRSHSMlYk5qu
 x1BhL0N+fO6M3HyrRdIWT1XmjX7UxjyqNoO+W/mpza73pPl3tgSClgKD29jphIwFgQMahmI
 HwAhl6TCX3lqiyu/7A4Uu1VM716SKv1fT1EDVWk27XKSurfw/9CwFWhS6ClzfmZV/ykCOiR
 M7UYbBN0klyaGWjZ5pkhg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vqq2hZigar0=:BEiIM0JodeznDqvtBhpapJ
 lwWvUJwmknfokmN7qd8mgjoTJ8pmEQ3nZyhupo4nIeI3hPzzgs8nBwW9bfWmqFd5dF1Xyj2uc
 Lbhvtnai1dAFHjtfDe4zX4RBYH4lrRxnYO1QVo2zPoHVXgnnyFSMCa3dKfzqwd97od6AtRDb2
 tCgrGjpUcZx9EXYcxM7FoiP07p8N1r1LfjOilSK+HA6Xl2gqntZZcQFKhzoh8tlSiIiKUxj6Y
 Poaf07Iybu4unV+40TraRN3yCg3llasmJRngqSpnA0OsnE2VTPMsUuw/3LobAbnEXKtTZHSvT
 U8H/QvpN73hrGbK0ycRB3vscFo37otnXhxLg4n2kDYlDX0T/bwYtHNyUh21nZqXgL/Gq/ZrYc
 NC7qG8uPcJcq3xRE6Mpcv0xmaOySHwWwOWZ1KUxkorDiqs0mUP8El71Ke9bOF1Bdw0zZmB6/z
 7XzHF7Jimb/n4mEGZPoZX08p+wPpLxztzCPMOCncXND6JXdbcpRtTP/CKPSRt/AXzT77wpyPj
 mxGv5/fqNACbochHQrL9J+TR2G/ZKBs+1j9TRg7oOHUBx6w4/2XMuHcxLxdR1nVOJYQNPkN5T
 //2h2iuJU/8gjoxGKo84O1v+F3zpSzJw6+n2GV4yw4M6AyqAtZcrKDSc+NecRwuy5Zal5EdbQ
 ySp0Fq4h1SbP1SIm48wNbhMvtK+faTcQlvWBCPLgI+W5kqFYncYCZwaaN2TiS2u7IpUo=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without including psci.h and arm-smccc.h, we now get a build failure in
some configurations:

arch/arm64/kernel/cpu_errata.c: In function 'arm64_update_smccc_conduit':
arch/arm64/kernel/cpu_errata.c:278:10: error: 'psci_ops' undeclared (first use in this function); did you mean 'sysfs_ops'?

arch/arm64/kernel/cpu_errata.c: In function 'arm64_set_ssbd_mitigation':
arch/arm64/kernel/cpu_errata.c:311:3: error: implicit declaration of function 'arm_smccc_1_1_hvc' [-Werror=implicit-function-declaration]
   arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_WORKAROUND_2, state, NULL);

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This showed up only recently, but I have not bisected what caused it.
---
 arch/arm64/kernel/cpu_errata.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 2b9a31a6a16a..1d2b6d768efe 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -16,6 +16,8 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/arm-smccc.h>
+#include <linux/psci.h>
 #include <linux/types.h>
 #include <asm/cpu.h>
 #include <asm/cputype.h>
-- 
2.9.0
