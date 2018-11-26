Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2146C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 02:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2D320855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 02:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nsHYni7l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C2D320855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbeKZNOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 08:14:19 -0500
Received: from m12-18.163.com ([220.181.12.18]:57548 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbeKZNOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 08:14:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=qorekFGeooYOSgfSgV
        0sCGZtcgWAK/QZ2nDNBp2VjMk=; b=nsHYni7leTFetOE3BA48JM8STyDwG7DHBj
        5mSWjPMomOVS5XAJmhqjAkwgvUdkFVPMktAty7TNqnv94JOhuI6+27tB4AqWum2y
        ACRkKBcx5CsjUUbiJWTi5oIqUuzKC45AJdfRT9hmNVXM9GMPiW2MaRbZgbpFYpoh
        GBRLniw1U=
Received: from bp.localdomain (unknown [106.120.213.96])
        by smtp14 (Coremail) with SMTP id EsCowACHKUCpWPtbbVFABw--.2604S3;
        Mon, 26 Nov 2018 10:21:31 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kai Bankett <chaosman@ontika.net>, Pan Bian <bianpan2016@163.com>
Subject: [PATCH] fs/qnx6: set and bh1 and bh2 to NULL after dropping references
Date:   Mon, 26 Nov 2018 10:21:28 +0800
Message-Id: <1543198888-36464-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: EsCowACHKUCpWPtbbVFABw--.2604S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF1UuF4kGFWUJw1kuw17Wrg_yoWDurX_KF
        yxJr48Gw45t3Za9F45A3yjy3Wvgrnakay8Ar17Kr13u34DtF1Utan7GF90grs3W3yUXa90
        yr1v9FySy3yfujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU173v5UUUUU==
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/xtbBUQwLclaD0T4n3AAAsl
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function qnx6_fill_super drops the reference to bh2 when superblock
1 is activated via brelse, otherwise it drops the reference to bh1 when
superblock 2 is activated. If error occurs after that, it will try to
drop the references to bh1 and bh2 again. This may result in
use-after-free bugs. The patch sets bh1 and bh2 to NULL after their
reference counts are decreased.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 fs/qnx6/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 4aeb26b..e8a8536 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -405,12 +405,14 @@ static int qnx6_fill_super(struct super_block *s, void *data, int silent)
 		sbi->sb_buf = bh1;
 		sbi->sb = (struct qnx6_super_block *)bh1->b_data;
 		brelse(bh2);
+		bh2 = NULL;
 		pr_info("superblock #1 active\n");
 	} else {
 		/* superblock #2 active */
 		sbi->sb_buf = bh2;
 		sbi->sb = (struct qnx6_super_block *)bh2->b_data;
 		brelse(bh1);
+		bh1 = NULL;
 		pr_info("superblock #2 active\n");
 	}
 mmi_success:
-- 
2.7.4


