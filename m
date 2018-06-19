Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CD2C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D9EE20020
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D9EE20020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966953AbeFSPti (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:49:38 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:57773 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966516AbeFSPth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:49:37 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MOXED-1faXXN1Yu5-005r4S; Tue, 19 Jun 2018 17:49:16 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sysvfs: use ktime_get_real_seconds() for superblock stamp
Date:   Tue, 19 Jun 2018 17:48:58 +0200
Message-Id: <20180619154914.3859394-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:Sg7eTiDAzpyigzeqGUXSU8OqqUr67b/yzO/ewNI1FiF3wvSNyas
 yZz2KvobGZd9Tw1fAE3/KiA2yxo6GAgVIcAEAIPh949VSvcdmsKwJRxABsbMQ0nAPkvc34g
 +RiTYATRvEdyXp8Ac1YOfn4dgreXYGbJu6LorJ/YXoV1Vlng2zQaaOFDDLnrd0GzO2GsBEf
 A+1bvJvEPFBBF43NWs8BQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:y7GeZa4+4zA=:71Azyz0qU4AOIrdWH/olHV
 K7t7EcqNdM7AjJ76s1xlzuHRDmTvGRLxW3nWTXlJsGWeacVygI1gW9Kzf2Nfi6fps2yzhNXHn
 Hkyg3qdMQzzr+oFB03lov+Jg/9fMYouj/156XUt+eQEipMtXHUzLiTWzStsVayTZfqCdoVJD7
 +5BqASpBQhOAb7EJq0zdc/zfkyWyQY3/xYntO1WgX3FOKLw7bIxjrOZbNJCtshBQ5VlsPSseO
 c682LpAfniqMplAczB68R6S0SIFf9aTVwqkSTwz73qaqQ5E7RDKL/7RX3AbhhyDv4ozCxfOnd
 /ZHz7MMzXcWVoy2r1TRdUf1zqStoOpsYi9Qs+LrDH5K5nn5E9Fwu5oByrG/61J9JaisPPFBb+
 0i909GP8Pw0cozR6aagBa6TSLupgTHJERwta4C8zRPxMR0x4NpintzfkMFaO6e29/PdbDtxiF
 WzdpSGbzhxtLAQc/vjr0J1pl20U1b0ji+tCyVmlqJId+F3mtuW+CudA5BoUNy1YT4C6kzNM98
 tg+viRv2o4KYl7C5Z79OEVTmtyGT88YtzOGGVKMNXkl5IJW4J3vPQQCrInvAK0+hGbFF4L9mk
 ocO5Mv/GukSbMf7gJXLBGVN9CrhF8cq9AiNRMCDVN8fxMm+xmYTdTewdbKGcSfXOJOASMQH5s
 Vn63j41iuSt55tJ6MSwpZz80ulOFXgBdBqUJC6K04EMmN6yh/Gztyo+TF1F4KO6HqQLI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_seconds() is deprecated in favor of ktime_get_real_seconds(),
which returns a 64-bit timestamp.

In the SYSV file system, the superblock timestamp is only 32 bits
wide, and it is used to check whether a file system is clean, so
the best solution seems to be to force a wraparound and explicitly
convert it to an unsigned 32-bit value.

This is independent of the inode timestamps that are also 32-bit
wide on disk and that come from current_time().

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/sysv/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/sysv/inode.c b/fs/sysv/inode.c
index bec9f79adb25..499a20a5a010 100644
--- a/fs/sysv/inode.c
+++ b/fs/sysv/inode.c
@@ -35,7 +35,7 @@
 static int sysv_sync_fs(struct super_block *sb, int wait)
 {
 	struct sysv_sb_info *sbi = SYSV_SB(sb);
-	unsigned long time = get_seconds(), old_time;
+	u32 time = (u32)ktime_get_real_seconds(), old_time;
 
 	mutex_lock(&sbi->s_lock);
 
@@ -46,8 +46,8 @@ static int sysv_sync_fs(struct super_block *sb, int wait)
 	 */
 	old_time = fs32_to_cpu(sbi, *sbi->s_sb_time);
 	if (sbi->s_type == FSTYPE_SYSV4) {
-		if (*sbi->s_sb_state == cpu_to_fs32(sbi, 0x7c269d38 - old_time))
-			*sbi->s_sb_state = cpu_to_fs32(sbi, 0x7c269d38 - time);
+		if (*sbi->s_sb_state == cpu_to_fs32(sbi, 0x7c269d38u - old_time))
+			*sbi->s_sb_state = cpu_to_fs32(sbi, 0x7c269d38u - time);
 		*sbi->s_sb_time = cpu_to_fs32(sbi, time);
 		mark_buffer_dirty(sbi->s_bh2);
 	}
-- 
2.9.0

