Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC65C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62BB425026
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:38:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62BB425026
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755684AbeFXPiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:38:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59712 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751366AbeFXPiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:38:06 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5E1152C;
        Sun, 24 Jun 2018 15:38:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josef Bacik <jbacik@fb.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.16 36/64] nbd: update size when connected
Date:   Sun, 24 Jun 2018 23:22:17 +0800
Message-Id: <20180624142746.063479589@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624142743.613370789@linuxfoundation.org>
References: <20180624142743.613370789@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josef Bacik <jbacik@fb.com>

commit c3f7c9397609705ef848cc98a5fb429b3e90c3c4 upstream.

I messed up changing the size of an NBD device while it was connected by
not actually updating the device or doing the uevent.  Fix this by
updating everything if we're connected and we change the size.

cc: stable@vger.kernel.org
Fixes: 639812a ("nbd: don't set the device size until we're connected")
Signed-off-by: Josef Bacik <jbacik@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/nbd.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -246,6 +246,8 @@ static void nbd_size_set(struct nbd_devi
 	struct nbd_config *config = nbd->config;
 	config->blksize = blocksize;
 	config->bytesize = blocksize * nr_blocks;
+	if (nbd->task_recv != NULL)
+		nbd_size_update(nbd);
 }
 
 static void nbd_complete_rq(struct request *req)


