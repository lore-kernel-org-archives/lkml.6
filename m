Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtvK/01TzRxJM4PyUCTV1iDuIlqddpbUrwwLt/POQ1eHrZfxJnT/xgz0GUhfIYzKPNx+4sB
ARC-Seal: i=1; a=rsa-sha256; t=1521484009; cv=none;
        d=google.com; s=arc-20160816;
        b=ulo3WAjTH+y/kkJgYCE5x1oUajRnKfdshyOs76EHZkjYnYbOFXav+MOsjXBV68gFfp
         4v9wTPm/gIiEDXGw31IMKzVUl4Evj9aemmG4o406z1z1h2/VIMwTkX+kTCWmpaLILV9+
         KZj4L80PTeCyiwlRW4yTgrXUTXVY6SBYENTTh4258cnJeuBSj+9wsllB+ft5SCBmNEpR
         hHCjBPsYeOJuWIA5YYZkVx+63+1e//HHynMnWYPYog0qiXZB0+0Ilo9KA5sd/np6bxZo
         GbH/O9rX8vPUTWp1m/zE7BDhxQeuwPfF881swXu6mOeLsv0xkNmQLjLSy8QvTmxqhj8+
         E5GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QovJBloNsRJYfvXsQnDYGeTTOUinUrc0f5CHxxKvQ5E=;
        b=UuzuOejN5MICVU3p5okLSsHhOWvQ4bTDA1a/eXIxaBXzV2ytV809ZXR74EUsJM2vjs
         Ec9RZSwSeUqaH79/I1HHFaW5i+nApswmP1D3UsUwgRIvDWlA4LW8YykRpf13GCYm0cQG
         r8q7zanPJmdwLlRNOWzJip5zSudgan5XLXMYLDZM5lkO/0pq1wcj3O5n4FS7gHJoKRIa
         gmdH1K1yusTa82m/h5qwhmtmnWY7mtTYjGLBscZSCDcMOLdUaErsDlRw/FY2ODR5x5Yw
         atb8jFCqztg2PLDRL0q9RC4JPRbkfdaDNMq/e7USU8cedEWGhIg7LPQUjOQH9AYI3ezs
         m+1Q==
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
Subject: [PATCH 4.9 198/241] media: cpia2: Fix a couple off by one bugs
Date: Mon, 19 Mar 2018 19:07:43 +0100
Message-Id: <20180319180759.393591393@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390622995940501?=
X-GMAIL-MSGID: =?utf-8?q?1595391617129316997?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
