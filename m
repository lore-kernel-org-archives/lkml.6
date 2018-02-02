Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751809AbeBBG4T (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 01:56:19 -0500
Received: from smtpbg298.qq.com ([184.105.67.102]:42660 "EHLO smtpbg298.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751460AbeBBGzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 01:55:39 -0500
X-QQ-mid: Xesmtp11t1517554081t2i3s4io1
X-QQ-SSF: C1000000000000F0FF621300000000W
X-QQ-FEAT: IgOyAJXnK6EZKTN0wGtHSS3GLH9xE9hCwUUxH9eCS/BKFwvLzNVJ40jJ3QNI2
        t+VAsHsIsxO64Awh3Y6ynbt/kZOJV3m1uljwhj2mkoDTcgPK3qw/rDkMRC4rawYWuG+BHlW
        EiYFxX70o3K3gWw51wwFokg/MxNBxOOc9Om5i08fYLRKUrh8aCpyOcYZSAWJp5/sjpWmP/C
        XSYPp8t6sE8edp++vRL2AuHmvryhrB1Xn/p0o6Wovyqcn8DCkNsA4wTx4Q32hGISr/j8oVx
        SorntA+iRrcTGgZk6ZmCwP6Y4=
X-QQ-GoodBg: 0
From: Chen Baozi <cbz@baozis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
        linux-kernel@vger.kernel.org, Chen Baozi <cbz@baozis.org>
Subject: [PATCH] x86/retpoline: check CONFIG_RETPOLINE option when SPECTRE_V2_CMD_AUTO
Date: Fri,  2 Feb 2018 14:47:44 +0800
Message-Id: <20180202064744.29331-1-cbz@baozis.org>
X-Mailer: git-send-email 2.16.1
X-QQ-SENDSIZE: 520
X-QQ-FName: DB53A4D9FB764512AAC9BCB0D68CF43E
X-QQ-LocalIP: 10.208.130.95
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, if there is no spectre_v2= or nospectre_v2 specified in the boot
parameter, the kernel will automatically choose mitigation by default.
However, when selecting the auto mode, it doesn't check whether the
retpoline has been built in the kernel. Thus, if someone built a kernel
without CONFIG_RETPOLINE and booted the system without specifying any
spectre_v2 kernel parameters, the kernel would still report that it has
enabled a minimal retpoline mitigation which is not the case. This patch
adds the checking of CONFIG_RETPOLINE option under the 'auto' mode to fix
it.

Signed-off-by: Chen Baozi <cbz@baozis.org>
---
 arch/x86/kernel/cpu/bugs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 390b3dc3d438..70b7d17426eb 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -193,7 +193,9 @@ static void __init spectre_v2_select_mitigation(void)
 	case SPECTRE_V2_CMD_FORCE:
 		/* FALLTRHU */
 	case SPECTRE_V2_CMD_AUTO:
-		goto retpoline_auto;
+		if (IS_ENABLED(CONFIG_RETPOLINE))
+			goto retpoline_auto;
+		break;
 
 	case SPECTRE_V2_CMD_RETPOLINE_AMD:
 		if (IS_ENABLED(CONFIG_RETPOLINE))
-- 
2.13.5 (Apple Git-94)
