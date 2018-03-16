Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuad2BBb7GqhS+oSn64mvHqDdEgxMOabn1d3CNCAw++Oee4pwh3e3SA2RgR5wdiUTSo6h/U
ARC-Seal: i=1; a=rsa-sha256; t=1521214681; cv=none;
        d=google.com; s=arc-20160816;
        b=QhXhtjqwRl6nnBsOHZGmNw4KUQdCCRELmgEO26sXLncZw01IiWo99bFg5glFLcScJf
         tnD8Cd6AhfVCZOfDIzvuEMuwNj5IUDFZsD7jtVlflDXkFD65NQmp1UIwUFaUAB3oY5wi
         fMrRVjTIBFcX87Kzo632kc+JAhCuURasCPf4ehcymEIHLbvik2O0lquJ732Mzpw/YmX6
         fVPyb6PiN9vVbFeJhcB3Sojr6kSNZ/35PvRtQbGU7RUzHLGn5UzUZfe5498EaP7n0G0C
         6cZkgJG/9P5sUsuBubJBwmAicTa6SfQJmByLNaMaxF02CBvi4p+WAMTuEZntdUasFwDE
         RsWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SG9ES3mrPnG1ObuipzjqDUhdE9xh+fSvEpGlvy/aaSw=;
        b=yNMwRe4TOS+8BtIhgaOmwNn0QiGDgDm0B5zDN4iPb5XK1K5STxtslC2Wey4nTUXOd0
         OTZ+izkCHFwyySbHDxq5i6DP3ORnJlKY3M/7GCYEkusATe/83Jqh/Dvd7kKO7lamrQ53
         brioUpj9USu/ZNmVsU4/7GfjphLSYjHBV2jIBthx2gnt+OYlmSzH2IqDl3TXXWVLgz3/
         RS9K5gyshLw0hCQ9Nf46HQX725XuBa5KnNq/mTAOYCZ97qJldBI9dSX5FXAlbvv3Gnoq
         GeOsV7IwO9fkHqdnRpjwTvIQqry/c3mcZJqlPCpL5hUj+P096Etp+OyiNdgTQfuRXlAp
         uSmQ==
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
Subject: [PATCH 4.14 087/109] media: cpia2: Fix a couple off by one bugs
Date: Fri, 16 Mar 2018 16:23:56 +0100
Message-Id: <20180316152334.668116063@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109206068457517?=
X-GMAIL-MSGID: =?utf-8?q?1595109206068457517?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -808,7 +808,7 @@ static int cpia2_querybuf(struct file *f
 	struct camera_data *cam = video_drvdata(file);
 
 	if(buf->type != V4L2_BUF_TYPE_VIDEO_CAPTURE ||
-	   buf->index > cam->num_frames)
+	   buf->index >= cam->num_frames)
 		return -EINVAL;
 
 	buf->m.offset = cam->buffers[buf->index].data - cam->frame_buffer;
@@ -859,7 +859,7 @@ static int cpia2_qbuf(struct file *file,
 
 	if(buf->type != V4L2_BUF_TYPE_VIDEO_CAPTURE ||
 	   buf->memory != V4L2_MEMORY_MMAP ||
-	   buf->index > cam->num_frames)
+	   buf->index >= cam->num_frames)
 		return -EINVAL;
 
 	DBG("QBUF #%d\n", buf->index);
