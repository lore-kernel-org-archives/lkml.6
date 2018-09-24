Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DD5ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E9742083A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E9742083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388991AbeIXSpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:45:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59410 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729754AbeIXSpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:45:12 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3AE621099;
        Mon, 24 Sep 2018 12:43:13 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 197/235] lightnvm: pblk: assume that chunks are closed on 1.2 devices
Date:   Mon, 24 Sep 2018 13:53:03 +0200
Message-Id: <20180924113123.963039202@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

[ Upstream commit f6352103d2e0ad2d2066725eb19bfdfb8763239b ]

We can't know if a block is closed or not on 1.2 devices, so assume
closed state to make sure that blocks are erased before writing.

Fixes: 32ef9412c114 ("lightnvm: pblk: implement get log report chunk")
Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/lightnvm/pblk-init.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -716,10 +716,11 @@ static int pblk_setup_line_meta_12(struc
 
 		/*
 		 * In 1.2 spec. chunk state is not persisted by the device. Thus
-		 * some of the values are reset each time pblk is instantiated.
+		 * some of the values are reset each time pblk is instantiated,
+		 * so we have to assume that the block is closed.
 		 */
 		if (lun_bb_meta[line->id] == NVM_BLK_T_FREE)
-			chunk->state =  NVM_CHK_ST_FREE;
+			chunk->state =  NVM_CHK_ST_CLOSED;
 		else
 			chunk->state = NVM_CHK_ST_OFFLINE;
 


