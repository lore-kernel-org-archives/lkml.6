Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD4DC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A42721903
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550499842;
	bh=fr6cLjHdbLMxd3XI+oLfNpBtB5NBvpRBNr4CzyK+Hds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sZf3qxX710YJq3gmhlh34KWU11cTZyQL0NLqGxXuRt0tQBHGt0QBy5aVcsO6R6cVe
	 lQjqGUw0ghc3oupE2u5tltk6wXJtLm6e0VlTONBMdrT6Id1hTXBD5mKsIxcI0sI7Fp
	 L72qhwUZhgH0zyetK/Czh9ZWwGAl2jFO0O610YKA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390279AbfBROYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:24:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:46534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389878AbfBROEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:04:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 700A42070B;
        Mon, 18 Feb 2019 14:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498646;
        bh=fr6cLjHdbLMxd3XI+oLfNpBtB5NBvpRBNr4CzyK+Hds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tcTecG8vQ5eiUUQIWPubTM/cl70NA+L70csuXdwmeH0ntuaiCbmBgfoZzTfsYUR3f
         /2N5ATiw3ls7lnICmCz/Q926rsggcUqAtGFbNUwzdRXNT23JG5yMYEmjYeysp1Nf5M
         V57jzaZBgkzG+8ZpSUz8dAma+CschHI29GRzg5Iw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Finn Thain <fthain@telegraphics.com.au>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        Stan Johnson <userm57@yahoo.com>
Subject: [PATCH 4.4 068/143] block/swim3: Fix -EBUSY error when re-opening device after unmount
Date:   Mon, 18 Feb 2019 14:43:16 +0100
Message-Id: <20190218133531.584709330@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 296dcc40f2f2e402facf7cd26cf3f2c8f4b17d47 ]

When the block device is opened with FMODE_EXCL, ref_count is set to -1.
This value doesn't get reset when the device is closed which means the
device cannot be opened again. Fix this by checking for refcount <= 0
in the release method.

Reported-and-tested-by: Stan Johnson <userm57@yahoo.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/swim3.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
index c264f2d284a7..2e0a9e2531cb 100644
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -1027,7 +1027,11 @@ static void floppy_release(struct gendisk *disk, fmode_t mode)
 	struct swim3 __iomem *sw = fs->swim3;
 
 	mutex_lock(&swim3_mutex);
-	if (fs->ref_count > 0 && --fs->ref_count == 0) {
+	if (fs->ref_count > 0)
+		--fs->ref_count;
+	else if (fs->ref_count == -1)
+		fs->ref_count = 0;
+	if (fs->ref_count == 0) {
 		swim3_action(fs, MOTOR_OFF);
 		out_8(&sw->control_bic, 0xff);
 		swim3_select(fs, RELAX);
-- 
2.19.1



