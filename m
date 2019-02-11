Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83192C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530F82081B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896041;
	bh=fVJsEgpP6yg91NLf4cVaN+XZw5PAW+PHWDIUNzaw+9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rsqueXJSmVbZrCw3vdfdhHsLKS0MUn/xy+phnyD7ogOGcjMJQDiXN4ZOUcgfhPvXJ
	 YzN/RwU5n7KEW6ybNXC9DkNW2Z8VtB2i09GqSw8SoBFvwVuxdW4ZFoUkjJmJ+CDhC7
	 /xw5XCCsnAaS+jS8nVWJ2Fg02BfUlGcpDI3ZPmHk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732101AbfBKOkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:40:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:51470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730771AbfBKOkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:40:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39AEF20700;
        Mon, 11 Feb 2019 14:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896035;
        bh=fVJsEgpP6yg91NLf4cVaN+XZw5PAW+PHWDIUNzaw+9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=usC6/xxTE3QL5ANka0J18tYxhR2Sssz4iwUy8u75ITzap6j1MFR+z1kpztM+v2s3c
         vKJQHTQLQ/tWftKWSfQKWrAyvHJaAPYhCKMEES0icpPJ2OBvI5dKclIauHYAsU0vqV
         NZhKmafEVXxnA57dgSay8hsJyxrS+ccVdzpTYDLQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matt Ranostay <matt.ranostay@konsulko.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 051/313] media: video-i2c: avoid accessing released memory area when removing driver
Date:   Mon, 11 Feb 2019 15:15:31 +0100
Message-Id: <20190211141857.146103533@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

[ Upstream commit c764da98a600a4b068d25c77164f092f159cecec ]

The video device release() callback for video-i2c driver frees the whole
struct video_i2c_data.  If there is no user left for the video device
when video_unregister_device() is called, the release callback is executed.

However, in video_i2c_remove() some fields (v4l2_dev, lock, and queue_lock)
in struct video_i2c_data are still accessed after video_unregister_device()
is called.

This fixes the use after free by moving the code from video_i2c_remove()
to the release() callback.

Fixes: 5cebaac60974 ("media: video-i2c: add video-i2c driver")

Reviewed-by: Matt Ranostay <matt.ranostay@konsulko.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/video-i2c.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/media/i2c/video-i2c.c b/drivers/media/i2c/video-i2c.c
index 06d29d8f6be8..f27d294dcbef 100644
--- a/drivers/media/i2c/video-i2c.c
+++ b/drivers/media/i2c/video-i2c.c
@@ -510,7 +510,12 @@ static const struct v4l2_ioctl_ops video_i2c_ioctl_ops = {
 
 static void video_i2c_release(struct video_device *vdev)
 {
-	kfree(video_get_drvdata(vdev));
+	struct video_i2c_data *data = video_get_drvdata(vdev);
+
+	v4l2_device_unregister(&data->v4l2_dev);
+	mutex_destroy(&data->lock);
+	mutex_destroy(&data->queue_lock);
+	kfree(data);
 }
 
 static int video_i2c_probe(struct i2c_client *client,
@@ -608,10 +613,6 @@ static int video_i2c_remove(struct i2c_client *client)
 	struct video_i2c_data *data = i2c_get_clientdata(client);
 
 	video_unregister_device(&data->vdev);
-	v4l2_device_unregister(&data->v4l2_dev);
-
-	mutex_destroy(&data->lock);
-	mutex_destroy(&data->queue_lock);
 
 	return 0;
 }
-- 
2.19.1



