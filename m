Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id qzT1Fd2MHVthPQAAmS7hNA
	; Sun, 10 Jun 2018 20:43:13 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 69436607A4; Sun, 10 Jun 2018 20:43:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EBF5C604D4;
	Sun, 10 Jun 2018 20:43:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EBF5C604D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753734AbeFJUnJ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 16:43:09 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43095 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752133AbeFJUnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 16:43:07 -0400
Received: by mail-wr0-f195.google.com with SMTP id d2-v6so18251120wrm.10
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jun 2018 13:43:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=y8nCAhzIRe1z4xMOT8m6qkIw3nbeHrp4H6C/yuCxzEI=;
        b=jyX9Gf4jbCdtZQ3+N/Bsyqvsq4uii9wlq3lQtVSl/rhajY1xwBAWvrRFtJ+hMTIbtG
         7KeyWAIEbc2ur8JvYqaY96iqyo5dt2+STSdNMwijaht9tcdHZBPxUmjfdexAuQNJF9Ty
         vpzPjNLBx5jbtRrkE4I+cW+h2q/JDxIgAMIzlv/yXykA3/aTc5To/tZdzoe9cqW8OVRk
         ThuMfQu/IRpUytQPUdHVn5bggZylqz9Ske1SamI+1cCQBchLsW5lcl1dGHY2WbTPT6vi
         a9V6UZY5AQNYjYQ+Q9oFRa/L8orAcfLpxSmKRs41C01/CqYNEh4qPdTPH6tju2PegfLd
         XVTg==
X-Gm-Message-State: APt69E0HWMSDga9B1+UCAUpNGO8C8QOQ7eU/AbuQ87KNmp6zUMAu7NFc
        usdTqWq141kBKNuTDgosJhR7fXf9/Ro=
X-Google-Smtp-Source: ADUXVKLr86lg1+zmz/Mm0VUvdxI3A9RDmiH/HCJ+D/GGvRqHhPLgRUuIxdYJzBa6Gqktoy8hlfgLmA==
X-Received: by 2002:adf:f90d:: with SMTP id b13-v6mr921033wrr.38.1528663385986;
        Sun, 10 Jun 2018 13:43:05 -0700 (PDT)
Received: from minerva.home ([90.77.100.34])
        by smtp.gmail.com with ESMTPSA id y186-v6sm10129441wmd.38.2018.06.10.13.43.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Jun 2018 13:43:05 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Brian Warner <brian.warner@samsung.com>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Nasser Afshin <afshin.nasser@gmail.com>,
        linux-media@vger.kernel.org
Subject: [PATCH] Revert "[media] tvp5150: fix pad format frame height"
Date: Sun, 10 Jun 2018 22:43:02 +0200
Message-Id: <20180610204302.1825-1-javierm@redhat.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

---

 drivers/media/i2c/tvp5150.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/tvp5150.c b/drivers/media/i2c/tvp5150.c
index 038e4ae0fe8..3ae543559fe 100644
--- a/drivers/media/i2c/tvp5150.c
+++ b/drivers/media/i2c/tvp5150.c
@@ -872,7 +872,7 @@ static int tvp5150_fill_fmt(struct v4l2_subdev *sd,
 	f = &format->format;
 
 	f->width = decoder->rect.width;
-	f->height = decoder->rect.height;
+	f->height = decoder->rect.height / 2;
 
 	f->code = MEDIA_BUS_FMT_UYVY8_2X8;
 	f->field = V4L2_FIELD_ALTERNATE;
-- 
2.17.1
