Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuj6pb9BoQBTCjAkoapSkvJnliEoOLwsdxT9MmKyxO5+/EJJ2U8ICLEGcmusZoWjP6pekrQ
ARC-Seal: i=1; a=rsa-sha256; t=1521483061; cv=none;
        d=google.com; s=arc-20160816;
        b=IH1Dhhz2E0tYTgbf5DNZvL2j3WeyXhBC85qy8TkxEklnwFZzgqbF3/zk36jMA0Ffx1
         Anq/Arf4KPVVTQmh2hNfj8IJdjvqn2tswE/imaW2tSk3z/Q4RWBykOSVzVRyhpfBt6vP
         ElDe9d3hkhBXuNEGJE5m9FO1KBneATvAXotAJkooGvy829tOORQExkeVrQXeoNKa3iRR
         UgptrENbIf/89B9dvnT3GLGR9qJu3TwWe5xXm5+MYNcYpaPfbdZJZM/Yxrxn22Y9OaLt
         ZLECR92aZre9kMdOc4KOEJzSxKDDlIea/4lyEwNJGMUxb9gbjpJQl11qQShdfEoZS268
         MKfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Ydrup8WiDvD4UL3s8Mp6zcfhht5FP9lgb5ue8nPE3cw=;
        b=IONvVl3VPttMERG/BzfR7GzaOjEFbB3ol3Myo/4vQTwSwrMPBWbYl9oesicwW5syXD
         z83Teemnd0g6Bq5JvXfxA0ZfADRNuYvjUSkHPJg7yUiqKjNQZ0Z6NoPzwEGcxnbrai78
         +J3P6GGKecd8lEBFVUwEfzbD8sZpFhDY2NQbI8SrM/m1GrJKvXPn/+WFysVmrq2wdKii
         EoObwdMfb592YY2y1aNyNoVFDI3jgOOiJRa3ZJFh6Wu/fFFOm+/Fu5uwlSeharpgaA1c
         I6ot89I5+aKfU7s26ot8ukSYGGT095AXIAPXY7kP0XCM88UPh65fb76424xug0NqfjlJ
         04tA==
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
Subject: [PATCH 3.18 54/68] media: cpia2: Fix a couple off by one bugs
Date: Mon, 19 Mar 2018 19:06:32 +0100
Message-Id: <20180319171835.467820557@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390622995940501?=
X-GMAIL-MSGID: =?utf-8?q?1595390622995940501?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
