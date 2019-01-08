Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470F9C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 188A220883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546975934;
	bh=ceOvmY4tgRH1XcPLW/C+0eDbqF43d2hThkRggJy4BsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n2qcCJwqUYQLXsVa6LAIbMqFrniYzRjLWMQ7zQx664+/oO8RsViwxUDesU7FJNlfK
	 Z+1KTvN+BtcR+rc1b9EWvmyxVLTOw+Va8EKrUkQlDATYBlQ+u6LtdINdxWnq9mCmsC
	 u2GYdMykRr4KmpVQsnavc0cWfzzkvRTYtaJiG07Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731314AbfAHTcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:32:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:40428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731271AbfAHTcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:32:04 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7059420645;
        Tue,  8 Jan 2019 19:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975924;
        bh=ceOvmY4tgRH1XcPLW/C+0eDbqF43d2hThkRggJy4BsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TsFEWBnkUjhsVzjkXI7tc/2BLoYjHz1OY0P1CbARD4U3JXkCv2tOE1YXGydEsbDQr
         qZ60gnejlXfgt228xF2/vOZxa+oMIuSd6Go3q7//m513+DDHkO1PelhZPWuqYC3FkR
         wBQy41wQNWozzQ9IZRRKlGqvUIl5lDSrwg9Ckd/A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Stephan=20G=C3=BCnther?= <moepi@moepi.net>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 87/97] scsi: mpt3sas: fix memory ordering on 64bit writes
Date:   Tue,  8 Jan 2019 14:29:36 -0500
Message-Id: <20190108192949.122407-87-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192949.122407-1-sashal@kernel.org>
References: <20190108192949.122407-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephan Günther <moepi@moepi.net>

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
index 59d7844ee022..b59bba3e6516 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -3344,8 +3344,9 @@ _base_mpi_ep_writeq(__u64 b, volatile void __iomem *addr,
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

