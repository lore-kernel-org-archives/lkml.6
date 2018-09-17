Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B971ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3322146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:58:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E3322146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbeIRE14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:27:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47680 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728660AbeIRE1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:27:55 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E10F6CB2;
        Mon, 17 Sep 2018 22:58:27 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 55/70] media: s5p-mfc: Fix buffer look up in s5p_mfc_handle_frame_{new, copy_time} functions
Date:   Tue, 18 Sep 2018 00:42:28 +0200
Message-Id: <20180917211653.490722825@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211649.099135838@linuxfoundation.org>
References: <20180917211649.099135838@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sylwester Nawrocki <s.nawrocki@samsung.com>

[ Upstream commit 4faeaf9c0f4581667ce5826f9c90c4fd463ef086 ]

Look up of buffers in s5p_mfc_handle_frame_new, s5p_mfc_handle_frame_copy_time
functions is not working properly for DMA addresses above 2 GiB. As a result
flags and timestamp of returned buffers are not set correctly and it breaks
operation of GStreamer/OMX plugins which rely on the CAPTURE buffer queue
flags.

Due to improper return type of the get_dec_y_adr, get_dspl_y_adr callbacks
and sign bit extension these callbacks return incorrect address values,
e.g. 0xfffffffffefc0000 instead of 0x00000000fefc0000. Then the statement:

"if (vb2_dma_contig_plane_dma_addr(&dst_buf->b->vb2_buf, 0) == dec_y_addr)"

is always false, which breaks looking up capture queue buffers.

To ensure proper matching by address u32 type is used for the DMA
addresses. This should work on all related SoCs, since the MFC DMA
address width is not larger than 32-bit.

Changes done in this patch are minimal as there is a larger patch series
pending refactoring the whole driver.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/s5p-mfc/s5p_mfc.c |   23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

--- a/drivers/media/platform/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc.c
@@ -249,24 +249,24 @@ static void s5p_mfc_handle_frame_all_ext
 static void s5p_mfc_handle_frame_copy_time(struct s5p_mfc_ctx *ctx)
 {
 	struct s5p_mfc_dev *dev = ctx->dev;
-	struct s5p_mfc_buf  *dst_buf, *src_buf;
-	size_t dec_y_addr;
+	struct s5p_mfc_buf *dst_buf, *src_buf;
+	u32 dec_y_addr;
 	unsigned int frame_type;
 
 	/* Make sure we actually have a new frame before continuing. */
 	frame_type = s5p_mfc_hw_call(dev->mfc_ops, get_dec_frame_type, dev);
 	if (frame_type == S5P_FIMV_DECODE_FRAME_SKIPPED)
 		return;
-	dec_y_addr = s5p_mfc_hw_call(dev->mfc_ops, get_dec_y_adr, dev);
+	dec_y_addr = (u32)s5p_mfc_hw_call(dev->mfc_ops, get_dec_y_adr, dev);
 
 	/* Copy timestamp / timecode from decoded src to dst and set
 	   appropriate flags. */
 	src_buf = list_entry(ctx->src_queue.next, struct s5p_mfc_buf, list);
 	list_for_each_entry(dst_buf, &ctx->dst_queue, list) {
-		if (vb2_dma_contig_plane_dma_addr(&dst_buf->b->vb2_buf, 0)
-				== dec_y_addr) {
-			dst_buf->b->timecode =
-						src_buf->b->timecode;
+		u32 addr = (u32)vb2_dma_contig_plane_dma_addr(&dst_buf->b->vb2_buf, 0);
+
+		if (addr == dec_y_addr) {
+			dst_buf->b->timecode = src_buf->b->timecode;
 			dst_buf->b->vb2_buf.timestamp =
 						src_buf->b->vb2_buf.timestamp;
 			dst_buf->b->flags &=
@@ -302,10 +302,10 @@ static void s5p_mfc_handle_frame_new(str
 {
 	struct s5p_mfc_dev *dev = ctx->dev;
 	struct s5p_mfc_buf  *dst_buf;
-	size_t dspl_y_addr;
+	u32 dspl_y_addr;
 	unsigned int frame_type;
 
-	dspl_y_addr = s5p_mfc_hw_call(dev->mfc_ops, get_dspl_y_adr, dev);
+	dspl_y_addr = (u32)s5p_mfc_hw_call(dev->mfc_ops, get_dspl_y_adr, dev);
 	if (IS_MFCV6_PLUS(dev))
 		frame_type = s5p_mfc_hw_call(dev->mfc_ops,
 			get_disp_frame_type, ctx);
@@ -324,9 +324,10 @@ static void s5p_mfc_handle_frame_new(str
 	/* The MFC returns address of the buffer, now we have to
 	 * check which videobuf does it correspond to */
 	list_for_each_entry(dst_buf, &ctx->dst_queue, list) {
+		u32 addr = (u32)vb2_dma_contig_plane_dma_addr(&dst_buf->b->vb2_buf, 0);
+
 		/* Check if this is the buffer we're looking for */
-		if (vb2_dma_contig_plane_dma_addr(&dst_buf->b->vb2_buf, 0)
-				== dspl_y_addr) {
+		if (addr == dspl_y_addr) {
 			list_del(&dst_buf->list);
 			ctx->dst_queue_cnt--;
 			dst_buf->b->sequence = ctx->sequence;


