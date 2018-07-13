Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B95ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA2420873
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DA2420873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731280AbeGMPDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 11:03:20 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:42531 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729726AbeGMPDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 11:03:19 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0Lecog-1gPdih0E2A-00qQL9; Fri, 13 Jul 2018 16:47:53 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     y2038@lists.linaro.org, linux-fsdevel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] [RESEND] jffs2: use unsigned 32-bit timstamps consistently
Date:   Fri, 13 Jul 2018 16:47:17 +0200
Message-Id: <20180713144739.3150217-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180713144739.3150217-1-arnd@arndb.de>
References: <20180713144739.3150217-1-arnd@arndb.de>
X-Provags-ID: V03:K1:/io4Z9LvC9PS8hE8ttxo0Nqb0WWyAlsTbMMvof4RvXGCkWzM/Uy
 4OoVeFPdI9rdfCsYno5WZKpnd+Tm/fPl6JJj8wNDZ/7Zax04Wj228ifBlVxkAIMjagUSZXr
 JiSr/uELFvv1wRDF6/8vi4/PgNHwI8BfcxifwyEwLLKhxfetiVOPJl58y0sX/cmso8Du7Dh
 p4VjEuU8oCqWI8P5ZiyYQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MFniaDVfd1Q=:qSUkUQk2mQxt45m2kdcCxa
 6u3Y+FTXV06+0HErp75R/ZhdU3ZJL5yxiqEoO4aZJe51RoChZtFkJjSc2fXs/aN7CMRT4/sd0
 6Qau3Vu3WFnTk4fmZJ6RligHtx7kcKWE9xRgzp3SyTjWID0xadrpp9gdA+1unPd3Lj0Z7RFRy
 HNVxdF5y6kDY1D3945IsAb01emyLsZ1rlhN9UEF043Pi33baF18cyrc0YX0yT//V3S6shxHiB
 Eep2GjBlLCffy4AP3ISrFISFL08XYc9MsS/uv+1eog7qelLCCASd3ePlNxE3w4SdeclER71//
 r5tZEVS4rpZIbRW6rDGTgybCs1pkL9iJHQnfj3BzQTOQL40uWmiirQesC3AbME1KoLGqmZT8l
 6zfV47NxrCknNQb3WGV1UcLLCOQQUw9BJUT2VgN++kfqdYz1C9TpXOyDQj6HnH5tLmVg4dfXM
 6waIum2/DhnsfubtYkHt7DZ+f52LqpA9TZZTZu/4dhWN0dmO/atF7ryHrnrIEe7YXbERkMqfF
 N2mxkEfuxGetu4Jsl2ds1zpAFojm4akacZtmprUFn0IuRjmHO/cWzDvlWB7HohkqYitmpK53h
 qO76tY/UtlYTYpQy7a/fjBXAkj2WMar/Plqb/eIWIsGIion9aWO0FD9ozYlvwEMdmtFXAe1CR
 npjR5Po0wk4DeFiO1ZJJ4vv19qYIyxPNtQ0a2BLRu1Zkl1FudW3EuhwJ583vDvSD/RNM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most users of jffs2 are 32-bit systems that traditionally only support
timestamps using a 32-bit signed time_t, in the range from years 1902 to
2038. On 64-bit systems, jffs2 however interpreted the same timestamps
as unsigned values, reading back negative times (before 1970) as times
between 2038 and 2106.

Now that Linux supports 64-bit inode timestamps even on 32-bit systems,
let's use the second interpretation everywhere to allow jffs2 to be
used on 32-bit systems beyond 2038 without a fundamental change to the
inode format.

This has a slight risk of regressions, when existing files with timestamps
before 1970 are present in file system images and are now interpreted
as future time stamps. I considered moving the wraparound point a bit,
e.g. to 1960, in order to deal with timestamps that ended up on Dec 31,
1969 due to incorrect timezone handling. However, this would complicate
the implementation unnecessarily, so I went with the simplest possible
method of extending the timestamps.

Writing files with timestamps before 1970 or after 2106 now results
in those times being clamped in the file system.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/jffs2/os-linux.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/jffs2/os-linux.h b/fs/jffs2/os-linux.h
index acbe1f722f2d..a2dbbb3f4c74 100644
--- a/fs/jffs2/os-linux.h
+++ b/fs/jffs2/os-linux.h
@@ -31,13 +31,13 @@ struct kvec;
 #define JFFS2_F_I_GID(f) (i_gid_read(OFNI_EDONI_2SFFJ(f)))
 #define JFFS2_F_I_RDEV(f) (OFNI_EDONI_2SFFJ(f)->i_rdev)
 
-#define ITIME(sec) ((struct timespec64){(int32_t)sec, 0})
-#define JFFS2_NOW() (ktime_get_real_seconds())
-#define I_SEC(tv) ((tv).tv_sec)
-#define JFFS2_F_I_CTIME(f) (OFNI_EDONI_2SFFJ(f)->i_ctime.tv_sec)
-#define JFFS2_F_I_MTIME(f) (OFNI_EDONI_2SFFJ(f)->i_mtime.tv_sec)
-#define JFFS2_F_I_ATIME(f) (OFNI_EDONI_2SFFJ(f)->i_atime.tv_sec)
-
+#define JFFS2_CLAMP_TIME(t) ((uint32_t)clamp_t(time64_t, (t), 0, U32_MAX))
+#define ITIME(sec) ((struct timespec64){sec, 0})
+#define JFFS2_NOW() JFFS2_CLAMP_TIME(ktime_get_real_seconds())
+#define I_SEC(tv) JFFS2_CLAMP_TIME((tv).tv_sec)
+#define JFFS2_F_I_CTIME(f) I_SEC(OFNI_EDONI_2SFFJ(f)->i_ctime)
+#define JFFS2_F_I_MTIME(f) I_SEC(OFNI_EDONI_2SFFJ(f)->i_mtime)
+#define JFFS2_F_I_ATIME(f) I_SEC(OFNI_EDONI_2SFFJ(f)->i_atime)
 #define sleep_on_spinunlock(wq, s)				\
 	do {							\
 		DECLARE_WAITQUEUE(__wait, current);		\
-- 
2.9.0

