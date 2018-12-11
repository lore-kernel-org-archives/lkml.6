Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A453C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F25620855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544170;
	bh=rZL1l33+ONbVdmj271/gue21RB2yhpPTuRbNGiu8cac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mSGhNnhHrQgGKjIILtxOTz0pKtZtlBLh1hYuJhk2CRPebOvkYmQrpUWYxnMDllnpS
	 w60c0kyKZqzjdBtcyksOKGP49IJh0KqdZzB64Ie+JQGC4wKWoQkDtUHUvXlddSWqgg
	 +B23eWkZH6fDc3+WE34+l5tyV+LCMEcH/vW9s7oE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F25620855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731163AbeLKQCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:02:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:45636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730663AbeLKP4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:56:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D8C1205C9;
        Tue, 11 Dec 2018 15:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543808;
        bh=rZL1l33+ONbVdmj271/gue21RB2yhpPTuRbNGiu8cac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IzT58bp4t9EZbiT9ZySQUL9Iz8hdr0R8qfwRfci0hZw1djR5IxkMU4j7+MEaz29h0
         Irl4q1XU961PxUvpqBXAZAU3PDr8sylaH3KuZYFHNm/dnk2eIlayxXILJidpcofXns
         a9PRBEpElYz2JgpIeAVl7xscFJFb9vvUxRkLyZ2I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>,
        softwarebugs <softwarebugs@protonmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.19 071/118] media: gspca: fix frame overflow error
Date:   Tue, 11 Dec 2018 16:41:30 +0100
Message-Id: <20181211151647.115849635@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hverkuil@xs4all.nl>

commit f96d84488f7d5f9123428c700cea82a292bca53e upstream.

When converting gspca to vb2 I missed that fact that the buffer sizes
were rounded up to the next page size. As a result some gspca drivers
(spca561 being one of them) reported frame overflows.

Modify the code to align the buffer sizes to the next page size, just
as the original code did.

Fixes: 1f5965c4dfd7 ("media: gspca: convert to vb2")
Tested-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Reported-by: softwarebugs <softwarebugs@protonmail.com>
Cc: <stable@vger.kernel.org>      # for v4.18 and up
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/gspca/gspca.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/drivers/media/usb/gspca/gspca.c
+++ b/drivers/media/usb/gspca/gspca.c
@@ -426,10 +426,10 @@ void gspca_frame_add(struct gspca_dev *g
 
 	/* append the packet to the frame buffer */
 	if (len > 0) {
-		if (gspca_dev->image_len + len > gspca_dev->pixfmt.sizeimage) {
+		if (gspca_dev->image_len + len > PAGE_ALIGN(gspca_dev->pixfmt.sizeimage)) {
 			gspca_err(gspca_dev, "frame overflow %d > %d\n",
 				  gspca_dev->image_len + len,
-				  gspca_dev->pixfmt.sizeimage);
+				  PAGE_ALIGN(gspca_dev->pixfmt.sizeimage));
 			packet_type = DISCARD_PACKET;
 		} else {
 /* !! image is NULL only when last pkt is LAST or DISCARD
@@ -1297,18 +1297,19 @@ static int gspca_queue_setup(struct vb2_
 			     unsigned int sizes[], struct device *alloc_devs[])
 {
 	struct gspca_dev *gspca_dev = vb2_get_drv_priv(vq);
+	unsigned int size = PAGE_ALIGN(gspca_dev->pixfmt.sizeimage);
 
 	if (*nplanes)
-		return sizes[0] < gspca_dev->pixfmt.sizeimage ? -EINVAL : 0;
+		return sizes[0] < size ? -EINVAL : 0;
 	*nplanes = 1;
-	sizes[0] = gspca_dev->pixfmt.sizeimage;
+	sizes[0] = size;
 	return 0;
 }
 
 static int gspca_buffer_prepare(struct vb2_buffer *vb)
 {
 	struct gspca_dev *gspca_dev = vb2_get_drv_priv(vb->vb2_queue);
-	unsigned long size = gspca_dev->pixfmt.sizeimage;
+	unsigned long size = PAGE_ALIGN(gspca_dev->pixfmt.sizeimage);
 
 	if (vb2_plane_size(vb, 0) < size) {
 		gspca_err(gspca_dev, "buffer too small (%lu < %lu)\n",


