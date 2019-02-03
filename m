Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72F5C282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975B6218D8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbfBCNwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:52:14 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:54318 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728753AbfBCNuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:50:35 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIAL-0003td-RM; Sun, 03 Feb 2019 13:50:34 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9p-0007N1-IZ; Sun, 03 Feb 2019 14:50:01 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Lubomir Rintel" <lkundrak@v3.sk>, "Arnd Bergmann" <arnd@arndb.de>,
        "Olof Johansson" <olof@lixom.net>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.730843877@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 257/305] ARM: mmp/mmp2: fix cpu_is_mmp2() on mmp2-dt
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Lubomir Rintel <lkundrak@v3.sk>

commit 76f4e2c3b6a560cdd7a75b87df543e04d05a9e5f upstream.

cpu_is_mmp2() was equivalent to cpu_is_pj4(), wouldn't be correct for
multiplatform kernels. Fix it by also considering mmp_chip_id, as is
done for cpu_is_pxa168() and cpu_is_pxa910() above.

Moreover, it is only available with CONFIG_CPU_MMP2 and thus doesn't work
on DT-based MMP2 machines. Enable it on CONFIG_MACH_MMP2_DT too.

Note: CONFIG_CPU_MMP2 is only used for machines that use board files
instead of DT. It should perhaps be renamed. I'm not doing it now, because
I don't have a better idea.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Olof Johansson <olof@lixom.net>
[bwh: Backported to 3.16: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/arm/mach-mmp/include/mach/cputype.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/arch/arm/mach-mmp/include/mach/cputype.h
+++ b/arch/arm/mach-mmp/include/mach/cputype.h
@@ -43,10 +43,12 @@ static inline int cpu_is_pxa910(void)
 #define cpu_is_pxa910()	(0)
 #endif
 
-#ifdef CONFIG_CPU_MMP2
+#if defined(CONFIG_CPU_MMP2) || defined(CONFIG_MACH_MMP2_DT)
 static inline int cpu_is_mmp2(void)
 {
-	return (((read_cpuid_id() >> 8) & 0xff) == 0x58);
+	return (((read_cpuid_id() >> 8) & 0xff) == 0x58) &&
+		(((mmp_chip_id & 0xfff) == 0x410) ||
+		 ((mmp_chip_id & 0xfff) == 0x610));
 }
 #else
 #define cpu_is_mmp2()	(0)

