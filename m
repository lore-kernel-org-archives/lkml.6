Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41B1ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2AE120873
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:53:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2AE120873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbeGMPIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 11:08:01 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:47837 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729643AbeGMPIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 11:08:01 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue005 [212.227.15.129]) with ESMTPA (Nemesis) id
 0LmgTP-1gDsU72V4V-00aER4; Fri, 13 Jul 2018 16:52:40 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     y2038@lists.linaro.org, linux-fsdevel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [RESEND] sysvfs: use ktime_get_real_seconds() for superblock stamp
Date:   Fri, 13 Jul 2018 16:52:28 +0200
Message-Id: <20180713145236.3152513-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:8QINVex3AWD2tY5LEde/lFs8zkoO0W2hEG9DAyg+KkREZHSlSoW
 g9FYPRJ4bM8pgpvwFax4yP6sG0V8XBWddb6psPFw5mwg6CsLHOf85JmvwtM9yKye+v/takQ
 Rtjeiss7lQwL7qbrAUTNHO23zzgCEBVNCMHUiPITWkHCQbbXy4gSRzHDPAH6ksvwKm2C3ja
 whMMqNckVf+qd8I2zuE0Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:28Z+V08+WLI=:40xTgqTwaqtqYsow1eaVc3
 /dEzt8QZmoLkhi+O0A9E07CTX1k+GeF4UVX/No6blsrrWwZebp0M/NNRXCS4kXzybQOyv6F5X
 sskinArmgr24MBfIcVLkjB0WyxKTcfjaQxEqqKW0x8B2GaMc/NwnjR8mY3J8SpyF9NYktDZfc
 oh2OMv9PqgEHUNGzsxBrxOlfXQ/AXPe/n0YXz81nIHRCwCctKko1RhULroKXSMMJLTjzxrp9J
 mvVgo2JwdS7yvfLjbpW73X3Yx8gNTX0wx759m/nEs1fRnjm8WX1yPKyMyPZR7gv/r+x7T0j+w
 IMqiZZsixQhfRoAOCLPpGCtLRQWpUxiFVUJ0HFwg1MXz/pPZ05mxFJKwA3s0aoPeBo05zcxFK
 egV/8Guq43ytn0NQODx/pVkQtGQjQvjmPi7WWiPU5ZqnuFoqN/56L2AXl3ULzgyHuzfJtUS4A
 mVdO2TJLX3j3ZKXlG2kVLCf1zsOiK8JxbCqqJr/86kZcwZmffuPCakljNPWrf1nL7bugfiFcY
 S6yosq7kJd4cyhqndq/DS4TYaTBv6KAKWFn3B5H7qQbEbyYMmbwJtyoqUzHYq73deFKglnuDO
 5MNq+PgluwHrtZKvAgdFnUXSCNbUNRKip/Q/QTSYkInLnhTqg4nlrKA1sY8+z0eAuINfDQnB3
 4ND0dFpXbODheSqMY5ClVYJA4au/ZcTzjl5qDuXMl6jEBrVlKVzzsvDUDRpSa+PI7B4Q=
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

Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Originally sent on Jun 19, got an Ack but no other reply.

Christoph apparently hasn't applied any sysvfs patches in many years,
so I'd like someone else to take this one.

Al or Andrew, could you take this patch for 4.19 as well?
---
 fs/sysv/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/sysv/inode.c b/fs/sysv/inode.c
index 47f66bbc4578..e8927ea70d12 100644
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

