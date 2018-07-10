Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE904C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AAE320BF2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AAE320BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388920AbeGJSdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:33:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47756 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387961AbeGJSdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:33:23 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 38299E3D;
        Tue, 10 Jul 2018 18:33:10 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Devin Heitmueller <dheitmueller@kernellabs.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 36/53] media: vb2: core: Finish buffers at the end of the stream
Date:   Tue, 10 Jul 2018 20:25:12 +0200
Message-Id: <20180710182500.874667405@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182458.736721865@linuxfoundation.org>
References: <20180710182458.736721865@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sakari Ailus <sakari.ailus@linux.intel.com>

commit 03703ed1debf777ea845aa9b50ba2e80a5e7dd3c upstream.

If buffers were prepared or queued and the buffers were released without
starting the queue, the finish mem op (corresponding to the prepare mem
op) was never called to the buffers.

Before commit a136f59c0a1f there was no need to do this as in such a case
the prepare mem op had not been called yet. Address the problem by
explicitly calling finish mem op when the queue is stopped if the buffer
is in either prepared or queued state.

Fixes: a136f59c0a1f ("[media] vb2: Move buffer cache synchronisation to prepare from queue")

Cc: stable@vger.kernel.org # for v4.13 and up
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Tested-by: Devin Heitmueller <dheitmueller@kernellabs.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/v4l2-core/videobuf2-core.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/media/v4l2-core/videobuf2-core.c
+++ b/drivers/media/v4l2-core/videobuf2-core.c
@@ -1689,6 +1689,15 @@ static void __vb2_queue_cancel(struct vb
 	for (i = 0; i < q->num_buffers; ++i) {
 		struct vb2_buffer *vb = q->bufs[i];
 
+		if (vb->state == VB2_BUF_STATE_PREPARED ||
+		    vb->state == VB2_BUF_STATE_QUEUED) {
+			unsigned int plane;
+
+			for (plane = 0; plane < vb->num_planes; ++plane)
+				call_void_memop(vb, finish,
+						vb->planes[plane].mem_priv);
+		}
+
 		if (vb->state != VB2_BUF_STATE_DEQUEUED) {
 			vb->state = VB2_BUF_STATE_PREPARED;
 			call_void_vb_qop(vb, buf_finish, vb);


