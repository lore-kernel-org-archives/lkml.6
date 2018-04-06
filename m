Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/OYxfcrM30eGzj9cMKLIwXVHfNOcF9Rv8mJvOjz+0Ec6/ff6GCeYDCRdMCXy/eB/vlXIAs
ARC-Seal: i=1; a=rsa-sha256; t=1523021238; cv=none;
        d=google.com; s=arc-20160816;
        b=PkPpEI8fUaA+NV7L/XRVay504sFcvASK1XYf53c52gytJnApArfHP77FCU36r765FF
         28DDvzFlWlsUfdzZY4CpQr1PPTst5ZtvgrxZ1wglpWFgzimadOUTDeIVOk1XKTyJ6pnY
         m3hb1LZzECVtBJ/3qPlNwVemE22EX8fcELj7taVwkWmrysDmzEyfn4dDSU08mDVoagAd
         NIaYfs/cuRC73EESnBmZxlcmY8oJZWAe1CC8uSBwty422qPhHb2dAY/ZGsZWCDg1cEVf
         YX1L13KDWjAM92BLBBNf+twNMmu66SWQCZao8tPNWbEkkyEfYqRh36i4P6Gka+b8bEPK
         5QHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rUyfsFfSk0oEdorPZM0+QoV8Bg1ZDJTpGt+koPvfPdk=;
        b=X1cUBsHiTyzwa3uUZ0mgA2a7x6j89Jwjp+J1o8mtkpDU/MuFTMXIiaJItZMLu9+rvG
         YvlV4yzqK+B+8Y1xvcH45kcsv32hZRPyeigtwBqOl7w4jNIuucPnI1yfeNJbnbzhPtd0
         bLJPl6v9e1hc6Cquq3hRIB+F/0Y5fggP8UuVmnGCP2EjfbCWampxIMXA0nTEZw0+x657
         EGOM2Dcz/1Benhdf8ENvpRsqbw9rXXErB+2SXk3TyRKvIaErSYJcJ4Xlmn5ybvJFGbTr
         2lsAA5DXRKrnjt5TlPCPjz9k8RNz/48xA9u1PBCUrArYzN9uEKnLyxgqRu4H+8SshWSL
         Jomw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dimitrios Katsaros <patcherwork@gmail.com>,
	Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 58/93] [media] vb2: V4L2_BUF_FLAG_DONE is set after DQBUF
Date: Fri,  6 Apr 2018 15:23:27 +0200
Message-Id: <20180406084227.429700602@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003517450579653?=
X-GMAIL-MSGID: =?utf-8?q?1597003517450579653?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ricardo Ribalda <ricardo.ribalda@gmail.com>

commit 3171cc2b4eb9831ab4df1d80d0410a945b8bc84e upstream.

According to the doc, V4L2_BUF_FLAG_DONE is cleared after DQBUF:

V4L2_BUF_FLAG_DONE 0x00000004  ... After calling the VIDIOC_QBUF or
VIDIOC_DQBUF it is always cleared ...

Unfortunately, it seems that videobuf2 keeps it set after DQBUF. This
can be tested with vivid and dev_debug:

[257604.338082] video1: VIDIOC_DQBUF: 71:33:25.00260479 index=3,
type=vid-cap, flags=0x00002004, field=none, sequence=163,
memory=userptr, bytesused=460800, offset/userptr=0x344b000,
length=460800

This patch forces FLAG_DONE to 0 after calling DQBUF.

Reported-by: Dimitrios Katsaros <patcherwork@gmail.com>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/v4l2-core/videobuf2-core.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/media/v4l2-core/videobuf2-core.c
+++ b/drivers/media/v4l2-core/videobuf2-core.c
@@ -2075,6 +2075,11 @@ static int vb2_internal_dqbuf(struct vb2
 	dprintk(1, "dqbuf of buffer %d, with state %d\n",
 			vb->v4l2_buf.index, vb->state);
 
+	/*
+	 * After calling the VIDIOC_DQBUF V4L2_BUF_FLAG_DONE must be
+	 * cleared.
+	 */
+	b->flags &= ~V4L2_BUF_FLAG_DONE;
 	return 0;
 }
 
