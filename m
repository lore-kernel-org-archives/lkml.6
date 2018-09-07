Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58029C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B44120645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B44120645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbeIHCIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:08:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46996 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727869AbeIHCIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:08:43 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1EC41EF6;
        Fri,  7 Sep 2018 21:25:52 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.14 14/89] media: Revert "[media] tvp5150: fix pad format frame height"
Date:   Fri,  7 Sep 2018 23:09:08 +0200
Message-Id: <20180907210854.455819653@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210852.341064285@linuxfoundation.org>
References: <20180907210852.341064285@linuxfoundation.org>
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

From: Javier Martinez Canillas <javierm@redhat.com>

commit 1831af092308aa5a59ae61e47494e441c8be6b93 upstream.

This reverts commit 0866df8dffd514185bfab0d205db76e4c02cf1e4.

The v4l uAPI documentation [0] makes clear that in the case of interlaced
video (i.e: field is V4L2_FIELD_ALTERNATE) the height refers to the number
of lines in the field and not the number of lines in the full frame (which
is twice the field height for interlaced formats).

So the original height calculation was correct, and it shouldn't had been
changed by the mentioned commit.

[0]:https://linuxtv.org/downloads/v4l-dvb-apis/uapi/v4l/subdev-formats.html

Fixes: 0866df8dffd5 ("[media] tvp5150: fix pad format frame height")

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Cc: <stable@vger.kernel.org>      # for v4.12 and up
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/i2c/tvp5150.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/i2c/tvp5150.c
+++ b/drivers/media/i2c/tvp5150.c
@@ -871,7 +871,7 @@ static int tvp5150_fill_fmt(struct v4l2_
 	f = &format->format;
 
 	f->width = decoder->rect.width;
-	f->height = decoder->rect.height;
+	f->height = decoder->rect.height / 2;
 
 	f->code = MEDIA_BUS_FMT_UYVY8_2X8;
 	f->field = V4L2_FIELD_ALTERNATE;


