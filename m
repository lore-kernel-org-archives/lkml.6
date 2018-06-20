Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02A8C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F8D20693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:46:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66F8D20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754388AbeFTJqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:46:30 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:44253 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752392AbeFTI0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:26:16 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue004 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MCMK5-1fN3zl1vDV-009AdF; Wed, 20 Jun 2018 10:26:00 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] shmem: use monotonic time for i_generation
Date:   Wed, 20 Jun 2018 10:25:39 +0200
Message-Id: <20180620082556.581543-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:m52VVL/SbVyYo0XHY4gYT+4xhV/5/hRoisTXVmmwfR9B4xWnaoR
 Oi5feigR2AVITHxFdLHmzHmJQABDqDZ6Ls6lvS3IpIoYSbUGakIOe70OlyercSRBmnAr3OQ
 hniNGPgqI5LJT7uZWNrAZQRNZfsJGg+5uu0Jgxt4IV7hDNlviicbtKDFXCSUjbsu4rOBm7Q
 o4UCV63oSzhc82iTcJ4Pg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qNNG7wysrmc=:feNUcb6fcdKF6/64JwuPZ2
 +Zi+KX85xlbm5KmXLdW7uoI2bMs5M4//IlWhfUtUhkDbtddfAsx9Bk/lcutuFzg8uYj2D1VJe
 3RLQ1KlqMtFI5uXHE8SPNHSO9JVWgARZnCWKqefV6v/n04jbxWSIyHzMnV7Hm3+RTPsnV4eBP
 lMeUqgWDOlyS6waXwuQ6J/Qehs+bJ60aWJTBFHVJKQuJL5ns7EH3JgblW9eAUVLEr2auC+C/g
 hQ9SdwUUp5EWH/1RULw30EtVbf8Nrc252pKSup/uWcG6oZmZqnx+wlXxRK/mb8RtOk502tf1q
 rueTBSos6/qHOrlBuq/CBeKyWOARHQKDEPcFHP0J8Z2+oS/dqZ1/aYU2ofFawPB2MN1561Djj
 lwdq53BnscQOwAVfBdrLkgtyxZ83wjL+C4JrTYCQvf3RayQTnVnae1B7/M4VvsE+TzNVx93nY
 Pg06S5O3FNwbZaqZO0Odjl4uC+7Rs3Zu3PeCDlROvBUS7yuyYAeK3nManfKeOKWZU6/zQ60VU
 tgmp9MqZtWZeValriGQieJAHrJEOWUNN13lRMX9AU1gMtRyUv0L/EHcfSBP7yVtn1tR9Xpudb
 L4075/eicW6EgV23GcDfA1tffVKKMXsp8UNF8wHECD5OYy/pBWWGCdSxPmjPleqAmtISWZTgv
 IcTeoeJCRw5PvbSJRfVkjv+52K8ccaEGvP+H/PVTr8x95tvHY/SpluGRBWqgVPULguOs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_seconds() is deprecated because it will lead to a 32-bit overflow
in 2038 or 2106. We don't need the i_generation to be strictly
monotonic anyway, and other file systems like ext4 and xfs just use
prandom_u32(), so let's use the same one here.

If this is considered too slow, we could also use ktime_get_seconds()
or ktime_get_real_seconds() to keep the previous behavior.
Both of these return a time64_t and are not deprecated, but only
return a unique value once per second, and are predictable.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/shmem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 2cab84403055..387ae5323f56 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -29,6 +29,7 @@
 #include <linux/pagemap.h>
 #include <linux/file.h>
 #include <linux/mm.h>
+#include <linux/random.h>
 #include <linux/sched/signal.h>
 #include <linux/export.h>
 #include <linux/swap.h>
@@ -2187,7 +2188,7 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
 		inode_init_owner(inode, dir, mode);
 		inode->i_blocks = 0;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
-		inode->i_generation = get_seconds();
+		inode->i_generation = prandom_u32();
 		info = SHMEM_I(inode);
 		memset(info, 0, (char *)inode - (char *)info);
 		spin_lock_init(&info->lock);
-- 
2.9.0

