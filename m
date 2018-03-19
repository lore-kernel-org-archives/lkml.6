Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvyiWM17brp40pJ3FOcQ6kU/ptHcSnsSin63fLx5WoOH3A/BgqWJX+KWzykQ6srK6546P9J
ARC-Seal: i=1; a=rsa-sha256; t=1521483374; cv=none;
        d=google.com; s=arc-20160816;
        b=xO8YMhivtIq3iifPWLbk5NeLYv+dwKmtzIXhs1gp7WWuV3dI5SVfOKqnb9agJCRUXK
         PGtMuztuNEB+u1wMX3Bezd3CO2oDlMWSgTIWdK6BCxabTnZFsYU7VQnFk0WG7rThjccI
         731xOz1Pbd9S0pjgqXW2DpRbGEss0aNFk7jkhIC/MOcJ1yXg3va6PpKd0TozKnUq/CMl
         ePShAna4t8lXRb/hGeQUTGSpRZIi7PYPzEMV0uGy6xc6GVSEwGsC4kv8qXmXZf+3+txv
         MKMQ9dyDJ7Bm6928imnwnGqRhQDk9tl232BP7qcdJ84JZSUcRUe85avIFUuwqK+eql2i
         u7Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=VI4BUmhRemTmhDgj9ci9ntgrE1OSsc4S/f1v6GZiyKM=;
        b=tFdKCXl1hz1inM0rL1EpC0tLV1gT5F9+SGr15iWss+d/g8cBWyLCfOr67rDc+62IYV
         tTXNJh2SINAizGUHrCsqQ14o0a6oEW8jVR7c+M2XYGlMLXm7Kmh5v4FVhd+GE9HOUXCS
         bgFaERNGQDn+zxTWl34yZf5E7TQBw0yPIfIQxXYC3Oi/sV3udm17J2KcZAkuWybdfML9
         AE2dpqaTEU5V27IQt1nlruxP9oXHHncS0vNXnnUW3Ss152uc9TFscR3C1LCCvmigik49
         nyR9mXfjBZBaJMqAB08z5Voawh/k7y9kd0FL9rqVii9nQhYFiLGoxT6Tzpdom7gOq/At
         E++A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 100/134] media: cpia2: Fix a couple off by one bugs
Date: Mon, 19 Mar 2018 19:06:23 +0100
Message-Id: <20180319171903.684047783@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390622995940501?=
X-GMAIL-MSGID: =?utf-8?q?1595390950867110706?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>


[ Upstream commit d5ac225c7d64c9c3ef821239edc035634e594ec9 ]

The cam->buffers[] array has cam->num_frames elements so the > needs to
be changed to >= to avoid going beyond the end of the array.  The
->buffers[] array is allocated in cpia2_allocate_buffers() if you want
to confirm.

Fixes: ab33d5071de7 ("V4L/DVB (3376): Add cpia2 camera support")

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/usb/cpia2/cpia2_v4l.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/media/usb/cpia2/cpia2_v4l.c
+++ b/drivers/media/usb/cpia2/cpia2_v4l.c
@@ -812,7 +812,7 @@ static int cpia2_querybuf(struct file *f
 	struct camera_data *cam = video_drvdata(file);
 
 	if(buf->type != V4L2_BUF_TYPE_VIDEO_CAPTURE ||
-	   buf->index > cam->num_frames)
+	   buf->index >= cam->num_frames)
 		return -EINVAL;
 
 	buf->m.offset = cam->buffers[buf->index].data - cam->frame_buffer;
@@ -863,7 +863,7 @@ static int cpia2_qbuf(struct file *file,
 
 	if(buf->type != V4L2_BUF_TYPE_VIDEO_CAPTURE ||
 	   buf->memory != V4L2_MEMORY_MMAP ||
-	   buf->index > cam->num_frames)
+	   buf->index >= cam->num_frames)
 		return -EINVAL;
 
 	DBG("QBUF #%d\n", buf->index);
