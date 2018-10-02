Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEA0C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D3FC206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:32:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D3FC206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731252AbeJBUPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:15:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34368 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729480AbeJBUPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:15:21 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 247635AA;
        Tue,  2 Oct 2018 13:31:58 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Seiderer <ps.report@gmx.net>,
        Steve Longerbeam <steve_longerbeam@mentor.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 027/137] media: staging/imx: fill vb2_v4l2_buffer field entry
Date:   Tue,  2 Oct 2018 06:23:48 -0700
Message-Id: <20181002132500.386329922@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132458.446916963@linuxfoundation.org>
References: <20181002132458.446916963@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Seiderer <ps.report@gmx.net>

[ Upstream commit a38d4b71cb7a12b65317f4e3d59883a918957719 ]

- fixes gstreamer v4l2src warning:

  0:00:00.716640334  349  0x164f720 WARN  v4l2bufferpool gstv4l2bufferpool.c:1195:gst_v4l2_buffer_pool_dqbuf:<v4l2src0:pool:src> Driver should never set v4l2_buffer.field to ANY

- fixes v4l2-compliance test failure:

  Streaming ioctls:
          test read/write: OK (Not Supported)
              Video Capture:
                  Buffer: 0 Sequence: 0 Field: Any Timestamp: 58.383658s
                  fail: v4l2-test-buffers.cpp(297): g_field() == V4L2_FIELD_ANY

Signed-off-by: Peter Seiderer <ps.report@gmx.net>
Reviewed-by: Steve Longerbeam <steve_longerbeam@mentor.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/media/imx/imx-ic-prpencvf.c |    1 +
 drivers/staging/media/imx/imx-media-csi.c   |    1 +
 2 files changed, 2 insertions(+)

--- a/drivers/staging/media/imx/imx-ic-prpencvf.c
+++ b/drivers/staging/media/imx/imx-ic-prpencvf.c
@@ -210,6 +210,7 @@ static void prp_vb2_buf_done(struct prp_
 
 	done = priv->active_vb2_buf[priv->ipu_buf_num];
 	if (done) {
+		done->vbuf.field = vdev->fmt.fmt.pix.field;
 		vb = &done->vbuf.vb2_buf;
 		vb->timestamp = ktime_get_ns();
 		vb2_buffer_done(vb, priv->nfb4eof ?
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -171,6 +171,7 @@ static void csi_vb2_buf_done(struct csi_
 
 	done = priv->active_vb2_buf[priv->ipu_buf_num];
 	if (done) {
+		done->vbuf.field = vdev->fmt.fmt.pix.field;
 		vb = &done->vbuf.vb2_buf;
 		vb->timestamp = ktime_get_ns();
 		vb2_buffer_done(vb, priv->nfb4eof ?


