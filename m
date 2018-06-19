Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C42C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF34820661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:00:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF34820661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966929AbeFSQAP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:00:15 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:42101 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966263AbeFSQAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:00:00 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MPrBi-1faH7m1TJC-0052b7; Tue, 19 Jun 2018 17:59:32 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] jffs2: use unsigned 32-bit timstamps consistently
Date:   Tue, 19 Jun 2018 17:59:04 +0200
Message-Id: <20180619155925.4107498-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180619155925.4107498-1-arnd@arndb.de>
References: <20180619155925.4107498-1-arnd@arndb.de>
X-Provags-ID: V03:K1:In2LSs2gpZ6AWdNNz8wswR1amcrtt1fvcMaLH4XrQYVXOTjCte5
 W0zgt3tCHO2KTSW6qtCP6bZXGM9gX1a2EKA8ViknC2A3TZSf+90vpg3slG9PLATLCN8ZNSN
 VRA54wjzBWp+fAY7OExnsjqXlVymv55BhjQ3nTHxhWj4fyH50jOTIjZGOC8RFtIqfeisk60
 BAlQQKHVATAM4wECPv0bg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qB1l/bvs9X0=:nFq66kTEoAr7Pv3OGwTMGc
 AtJzjyBkBLLG6qTI/vPrhC+0odb82wOdT65HJ2gsJ+PqoD8WJF7WRXyRsPmDDK+l3UYXYFyB9
 X6sJgPvfLdvzLgbjudavfxeBb1MFniBAWqz53ePxTX7Fd1tJI186+wZTmychcIlAo9mwzEwUJ
 PqNwOiW+FfFPjwmeAXnD2OepGfXXHKK4I9J3k1c/T+fxoUGbqJ8qbMdbsON3UFiDUusyZD6Qg
 o9Ua1ot96uKncvI0994XVU9bsbuhNRVHh4J/N6AFRER/w5E6dANWp4FqgGUmt5QEZKikMfBTr
 /aQS/bIBcnS/UN0v7E7dmYsvd7Ozal4E7Xhmb7sRSJHHrsJTyM9uJeFmBM2URvm1UEfhxgsWY
 naLUf0vPRwtPcEypwjBOhAqmMC5D+bUeVS42DVxAPlnXDxdLyjN1PTMrG7QOcp1wWFOf10szf
 k2/9kB3BIkn/s/zGJ/m4F6tBTGg78ssTaLeLa79g8lm410J67wOjDmzIwiBWsi+xaDwZAEHg0
 6tvBBRg8w+vLgCPmkPB8ElxV/Qg/Cc25SQ4TmQODQyuWOdrMp4G27mYyUiu3FEkC1SLaA40gj
 XoxAIfKJ5cZFsB8GMqZHsi3CifqvEqLQziP8etMZwbxz7O7XkDeIoboj7NcUu1/UJ1RFk8YnV
 2Db1UDFkzCpumh3+pSEV6ablVQC+ChNil26U77DWt7aaRo0A+HiwJL2kuI4qxCbgcq6Q=
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

