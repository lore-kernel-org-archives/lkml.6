Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07411C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B2F20663
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548359204;
	bh=7CLx201FXot8WPX2wRnO5k/NX3TLsxnzf15j46Yn5ms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rbvXCAdf94ioNJdd6PwCJwmFAEjvHDUXhUU68UyqRElgQtCfwcv4+8HsGG7fvPlk0
	 1jXFMSS5BhuLWUhUIKObXLaQT1uKp8A6qeA2oL5kkOdn7eIg8pddM7vA9dhrXnTv9x
	 uAGo2t+i3IczIs/7K6TRVy6knltSga/zF8Qbtiz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387886AbfAXTqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:46:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:44354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733262AbfAXTnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:43:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF4A3218D9;
        Thu, 24 Jan 2019 19:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548359021;
        bh=7CLx201FXot8WPX2wRnO5k/NX3TLsxnzf15j46Yn5ms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C8+PlOA5AG1T7wRrvg/BpPCWd4Sl6lIuJe2j6c3rHPoDIhGzG5pngxz1y8d2Bz5MR
         IfRWdwZ0lw7vYkchEYxwbJwKIkCXPiitq4YTuFU4uldlAGD7i8u1hlJheMKAxlblut
         G4kIqE7WNxf+8z6egVaZ4whJPOxZAeC2dN4nWiAQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Stephan=20G=C3=BCnther?= <moepi@moepi.net>,
        Matt Corallo <linux@bluematt.me>,
        Sreekanth Reddy <Sreekanth.Reddy@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 107/127] scsi: mpt3sas: fix memory ordering on 64bit writes
Date:   Thu, 24 Jan 2019 20:20:53 +0100
Message-Id: <20190124190216.540220850@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190211.984305387@linuxfoundation.org>
References: <20190124190211.984305387@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 23c3828aa2f84edec7020c7397a22931e7a879e1 ]

With commit 09c2f95ad404 ("scsi: mpt3sas: Swap I/O memory read value back
to cpu endianness"), 64bit writes in _base_writeq() were rewritten to use
__raw_writeq() instad of writeq().

This introduced a bug apparent on powerpc64 systems such as the Raptor
Talos II that causes the HBA to drop from the PCIe bus under heavy load and
being reinitialized after a couple of seconds.

It can easily be triggered on affacted systems by using something like

  fio --name=random-write --iodepth=4 --rw=randwrite --bs=4k --direct=0 \
    --size=128M --numjobs=64 --end_fsync=1
  fio --name=random-write --iodepth=4 --rw=randwrite --bs=64k --direct=0 \
    --size=128M --numjobs=64 --end_fsync=1

a couple of times. In my case I tested it on both a ZFS raidz2 and a btrfs
raid6 using LSI 9300-8i and 9400-8i controllers.

The fix consists in resembling the write ordering of writeq() by adding a
mandatory write memory barrier before device access and a compiler barrier
afterwards. The additional MMIO barrier is superfluous.

Signed-off-by: Stephan Günther <moepi@moepi.net>
Reported-by: Matt Corallo <linux@bluematt.me>
Acked-by: Sreekanth Reddy <Sreekanth.Reddy@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 2500377d0723..bfd826deabbe 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -3319,8 +3319,9 @@ _base_mpi_ep_writeq(__u64 b, volatile void __iomem *addr,
 static inline void
 _base_writeq(__u64 b, volatile void __iomem *addr, spinlock_t *writeq_lock)
 {
+	wmb();
 	__raw_writeq(b, addr);
-	mmiowb();
+	barrier();
 }
 #else
 static inline void
-- 
2.19.1



