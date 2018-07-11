Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8997C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E57920878
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:14:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E57920878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732492AbeGKJSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:18:14 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:34731 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeGKJSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:18:13 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MHpFN-1fe09c0kQ9-003b7L; Wed, 11 Jul 2018 11:14:49 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     adilger.kernel@dilger.ca
Cc:     arnd@arndb.de, jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, sirmy15@gmail.com,
        stable@vger.kernel.org, tgnottingham@gmail.com, tytso@mit.edu,
        y2038@lists.linaro.org
Subject: [PATCH v2 2/6] ext4: use 64-bit timestamps for mmp_time
Date:   Wed, 11 Jul 2018 11:14:10 +0200
Message-Id: <20180711091414.1494843-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180711091414.1494843-1-arnd@arndb.de>
References: <20180711091414.1494843-1-arnd@arndb.de>
X-Provags-ID: V03:K1:9KIdbbQHbE6BmsF9QS6CE0VZGaLOATdivJmOebBq+U+ibEFUsDJ
 Is1BBABZEJivi6E85kYeXu43lgaCw21XcC2NMi5/FdBXwmx7GJEnEnjTOXTRByt9wxear5s
 S7Zg/wb972C3ezH6dFdR3UgL/gdK7rJJqxR0h9ctk4z6yMQm2jgTxM60iDvF9g2Ahj/pbQU
 tFQ+tb+ZBVJjLl4lmYPag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bq64pgaBvEc=:uAfBXobQm2ytQkwu68BoFG
 QZ3nPwDTMoco9xYM7diFqXMlR0NnVfv+5QVSJjlDhrt6Pr0wAzpdAvlwnYmReyMaHj/txRCXK
 pZwMD4/YnYaklMv3eci9bxOgV6IKXMa/ZuJgADCmxc8NHpMqCPFsmIR0lQ/OpRckDVtbxWxd7
 4BAXQCmsgJR/vwc+iTRJ4JzY4Y2F+7hqPQMXu2ud6x/iSbWrGrenLD0ldhLIx/BR+UoaHTTqA
 DynC8/JjT8G4hfhLafCwIwNwznnOEq59g8HOzovA1Cjpu/Bkl/l6NK5k2EIjuzqSBD3w/nYoS
 Xs+EvEfJ6hQxDnT8Hoy4VmLEHacntS2H1ohPv8kjd/kOq9y4wLVXC77b9X+CZUC4cOO0dtFy1
 H8/3ecXG70s/snYXdTT7etChOxTiK8qYqZ408beGQGau0VsM6eFqRV+U2RQsIcmysgduqqcgv
 Q2Y/SsLp7VFq/2f3np6OM6fWoDqZmHCdQW4lamFsqh7h1TmKZnDaYtWJ+5aHID8Gi4zTa1k30
 J0uSF/nhEDPYOhtThMuRrS97kWAKNaS0F3bCj4MhNzOTVJUbX2Ywe+DWsly4mcpY1iphz9Gl+
 dXT6HizkhrPQIcvkrqCTMzcwdLwGS3eY5YzU/Xin5ehI1uwfGqSgdW+epp/BmmSpDpD6pwuYZ
 2w36o4+s195WI3Su2mh35Y3uTaQLJpCGofDxfBhlAcUL8KFg7cGqJD3mxEWwH5B3O5XA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mmp_time field is 64 bits wide, which is good, but calling
get_seconds() results in a 32-bit value on 32-bit architectures. Using
ktime_get_real_seconds() instead returns 64 bits everywhere.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/ext4/mmp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index 27b9a76a0dfa..39da4eb48361 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -147,7 +147,7 @@ static int kmmpd(void *data)
 
 	mmp_block = le64_to_cpu(es->s_mmp_block);
 	mmp = (struct mmp_struct *)(bh->b_data);
-	mmp->mmp_time = cpu_to_le64(get_seconds());
+	mmp->mmp_time = cpu_to_le64(ktime_get_real_seconds());
 	/*
 	 * Start with the higher mmp_check_interval and reduce it if
 	 * the MMP block is being updated on time.
@@ -165,7 +165,7 @@ static int kmmpd(void *data)
 			seq = 1;
 
 		mmp->mmp_seq = cpu_to_le32(seq);
-		mmp->mmp_time = cpu_to_le64(get_seconds());
+		mmp->mmp_time = cpu_to_le64(ktime_get_real_seconds());
 		last_update_time = jiffies;
 
 		retval = write_mmp_block(sb, bh);
@@ -244,7 +244,7 @@ static int kmmpd(void *data)
 	 * Unmount seems to be clean.
 	 */
 	mmp->mmp_seq = cpu_to_le32(EXT4_MMP_SEQ_CLEAN);
-	mmp->mmp_time = cpu_to_le64(get_seconds());
+	mmp->mmp_time = cpu_to_le64(ktime_get_real_seconds());
 
 	retval = write_mmp_block(sb, bh);
 
-- 
2.9.0

