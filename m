Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73831C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C7D217C6
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35C7D217C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387701AbeHDLHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:07:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49472 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbeHDLHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:07:53 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E6894BB3;
        Sat,  4 Aug 2018 09:07:54 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 033/124] media: videobuf2-core: dont call memop finish when queueing
Date:   Sat,  4 Aug 2018 11:00:22 +0200
Message-Id: <20180804082703.674631750@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804082702.434482435@linuxfoundation.org>
References: <20180804082702.434482435@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hans.verkuil@cisco.com>

[ Upstream commit 90b2da89a083e1395cb322521a42397c49ae4500 ]

When a buffer is queued or requeued in vb2_buffer_done, then don't
call the finish memop. In this case the buffer is only returned to vb2,
not to userspace.

Calling 'finish' here will cause an unbalance when the queue is
canceled, since the core will call the same memop again.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/v4l2-core/videobuf2-core.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/media/v4l2-core/videobuf2-core.c
+++ b/drivers/media/v4l2-core/videobuf2-core.c
@@ -870,9 +870,12 @@ void vb2_buffer_done(struct vb2_buffer *
 	dprintk(4, "done processing on buffer %d, state: %d\n",
 			vb->index, state);
 
-	/* sync buffers */
-	for (plane = 0; plane < vb->num_planes; ++plane)
-		call_void_memop(vb, finish, vb->planes[plane].mem_priv);
+	if (state != VB2_BUF_STATE_QUEUED &&
+	    state != VB2_BUF_STATE_REQUEUEING) {
+		/* sync buffers */
+		for (plane = 0; plane < vb->num_planes; ++plane)
+			call_void_memop(vb, finish, vb->planes[plane].mem_priv);
+	}
 
 	spin_lock_irqsave(&q->done_lock, flags);
 	if (state == VB2_BUF_STATE_QUEUED ||


