Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEAFC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 11:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 067472082F
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 11:12:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 067472082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbeLBLMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 06:12:36 -0500
Received: from shell.v3.sk ([90.176.6.54]:60575 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbeLBLMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 06:12:36 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id F2853C7E34;
        Sun,  2 Dec 2018 12:12:30 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 2K7_tONg8Rcx; Sun,  2 Dec 2018 12:12:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 429D7C7E35;
        Sun,  2 Dec 2018 12:12:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mCZKP6n99bWm; Sun,  2 Dec 2018 12:12:27 +0100 (CET)
Received: from odvarok.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 5D627C7E34;
        Sun,  2 Dec 2018 12:12:27 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     arm-soc <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Cc:     Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, James Cameron <quozl@laptop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] ARM: mmp/mmp2: fix cpu_is_mmp2() on mmp2-dt
Date:   Sun,  2 Dec 2018 12:12:24 +0100
Message-Id: <20181202111224.1450-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpu_is_mmp2() was equivalent to cpu_is_pj4(), wouldn't be correct for
multiplatform kernels. Fix it by also considering mmp_chip_id, as is
done for cpu_is_pxa168() and cpu_is_pxa910() above.

Moreover, it is only available with CONFIG_CPU_MMP2 and thus doesn't work
on DT-based MMP2 machines. Enable it on CONFIG_MACH_MMP2_DT too.

Note: CONFIG_CPU_MMP2 is only used for machines that use board files
instead of DT. It should perhaps be renamed. I'm not doing it now, becaus=
e
I don't have a better idea.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/mach-mmp/cputype.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mmp/cputype.h b/arch/arm/mach-mmp/cputype.h
index 446edaeb78a7..a96abcf521b4 100644
--- a/arch/arm/mach-mmp/cputype.h
+++ b/arch/arm/mach-mmp/cputype.h
@@ -44,10 +44,12 @@ static inline int cpu_is_pxa910(void)
 #define cpu_is_pxa910()	(0)
 #endif
=20
-#ifdef CONFIG_CPU_MMP2
+#if defined(CONFIG_CPU_MMP2) || defined(CONFIG_MACH_MMP2_DT)
 static inline int cpu_is_mmp2(void)
 {
-	return (((read_cpuid_id() >> 8) & 0xff) =3D=3D 0x58);
+	return (((read_cpuid_id() >> 8) & 0xff) =3D=3D 0x58) &&
+		(((mmp_chip_id & 0xfff) =3D=3D 0x410) ||
+		 ((mmp_chip_id & 0xfff) =3D=3D 0x610));
 }
 #else
 #define cpu_is_mmp2()	(0)
--=20
2.19.1

