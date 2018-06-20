Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1DCC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2245520836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2245520836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754168AbeFTPdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 11:33:46 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:32781 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753938AbeFTPdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 11:33:44 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.129]) with ESMTPA (Nemesis) id
 0M1vbP-1gK3bv2iPT-00tyr6; Wed, 20 Jun 2018 17:33:36 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>
Cc:     y2038@lists.linaro.org, linux-ext4@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] ext4: use 64-bit timestamps for mmp_time
Date:   Wed, 20 Jun 2018 17:32:59 +0200
Message-Id: <20180620153322.54221-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180620153322.54221-1-arnd@arndb.de>
References: <20180620153322.54221-1-arnd@arndb.de>
X-Provags-ID: V03:K1:7+eRQPh3uEgClCrJVyNQwckvPa3aPLK9+P5+XJvIvWw0DTq8vLY
 wo24erLuYLCFw1Ea5seDddn5qqWUgOkAp51H2uNGVIxmEPfq6WUdf2g+Lrx+5oyG62ZFY0J
 KLwu8FdgnGbHY2xiJeWSkFZlk08yDrI2+8tcXKdmCfQmshb5NYApITAcuCwGN8peoBB932Z
 PZMbGZS9CEcPYb31jnCPw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:itZ639F3zPo=:wFONAgh62chH71J8a74KAY
 +rbOocw/NVovMksxN6AfARGXAGT7KdqqdQeFZKx4FF921tZSph6NvmUt9eWe8qs3hbqukHrO/
 2ICwY1CbGQyM+6pfsN6FwU4mps86uRqzAC2y/MwWifxDqIF2Sdmei/cfYlJULstddsulJTmUl
 +aq+2QIWMbwGScxIUIaABYU0DEAxx0KzfnZQsGtmgR0njYooM3quhsig8bl1yxBpXyiinyHFp
 Hrvhc1NTrfiW/S2EcP9F+Dfp/IuFe1g7AEJ7IsYMtaQMJDaYTdxxnQG5H49TU5chZ8C+QUXqG
 wnc0HrkylGw4bm9olDFRTB8sep4MlTgrO5hgKGYEthg81tsriFHgh1RkXJpkgY7iwg5N/+y0B
 zyTPI8pojhaixcYafPLebUkec3FvMQ/pswEfuzHgaLKU1cduYoLJz90+HXoNdesDI6aWAZiD6
 1Pb4GEZdk815VpuPD8ASEYbLvzOp3B+fBNe8VivMF1c06/7zIw1PuSVn59nM9iyRqLyLlUtN/
 uXNdn11sZ0e1cYaKvImtTwN5YHJmy8Lvkfk6zrXHjHXt5vij51WRtOlNuo20hqyZZAV2i/tnC
 DXNE57JF3N75UBqbJ0kA90KEI80HeN1TEjjmRRaVOQoHRvPNFK3P2d+GfOu8boJz62WGZtysC
 8HylXRAJ+avqkPNYToyndzs4XrzTk2R30PQWbnNUniiR+3+EvodeOqUMqZeo9P+kTEKk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mmp_time field is 64 bits wide, which is good, but calling
get_seconds() results in a 32-bit value on 32-bit architectures. Using
ktime_get_real_seconds() instead returns 64 bits everywhere.

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

