Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80866C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4936D2145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2pTCa4i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4936D2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728805AbeKOI1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:27:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:34392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728719AbeKOI1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:27:21 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1206922528;
        Wed, 14 Nov 2018 22:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234138;
        bh=F39rnfOVUoYN9/DL7o7+gxFsFk/S3E9pAO88Ys/rau0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O2pTCa4iflaaYuNXK2q0L91N5KYieVa1/YaY5XwueMByuQRFHNvDgj4PeWfCekWWM
         0WiyOPOdNoukSB9U0OtNnsI7OYSYrG9IfKWLJtoqxfqbqEC52dGcKa/lOB0tLVNRsc
         JSL8QDJ538DD3vDEvO13FfbNNl2j0pWXkl04nJsg=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 41/73] block: Clear kernel memory before copying to user
Date:   Wed, 14 Nov 2018 17:21:35 -0500
Message-Id: <20181114222207.98701-41-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222207.98701-1-sashal@kernel.org>
References: <20181114222207.98701-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keith Busch <keith.busch@intel.com>

[ Upstream commit f3587d76da05f68098ddb1cb3c98cc6a9e8a402c ]

If the kernel allocates a bounce buffer for user read data, this memory
needs to be cleared before copying it to the user, otherwise it may leak
kernel memory to user space.

Laurence Oberman <loberman@redhat.com>
Signed-off-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bio.c b/block/bio.c
index 0093bed81c0e..41173710430c 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1261,6 +1261,7 @@ struct bio *bio_copy_user_iov(struct request_queue *q,
 		if (ret)
 			goto cleanup;
 	} else {
+		zero_fill_bio(bio);
 		iov_iter_advance(iter, bio->bi_iter.bi_size);
 	}
 
-- 
2.17.1

