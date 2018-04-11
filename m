Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48wxTSblQkydeCNnGqd9ws9qHVpkaB5QkYyclntKf/hl/Ybng2LHMTSpS8j8ITOE+BVRqzy
ARC-Seal: i=1; a=rsa-sha256; t=1523472550; cv=none;
        d=google.com; s=arc-20160816;
        b=uPfCVaHpe1nBoVL2Y3J1o66uep57jBaZVmnca76bz7uG93LTSt2uwg82NL339THlzS
         HwhSsc1jO3qJZBl7YGLfazyE/pAQwf1rTp29AdFprp9RGS01dAjLVavxTESdaGbPilSf
         T9qjRUQB0/FoDWgdmBH2E0cH87Twrb0wfMYNXZVMgzn7TJfJNEdCREWxvsyoY6rtegE8
         5mcqlxMRg0dd9NzsgxzoOT0HcVRuEqqRdchU0iVwaUrFqBXsdXJYqZE4S+diA0yqVTVo
         P7XhhMdqJRYHj8zH7a5JRaQYFcfCQu1Kju7OI5x6acTRtOwobljCFfVycw+NrzfDfR/g
         oyww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=njFSbX7YRWKtIlO0CQwTQpojgcVKkvBxHn3VhNjg/U8=;
        b=qN04ZOByyyy+eOd79WlMg1BYYFuPWaSN3vQZKdt8psrVhf0AFcRd+IS/y241VF1OoT
         p8HDNOJCCjtoGnn3ny6E4AUKOXNmLWzMUPyOHwCTY/YOieVo3i4tUkZSIQJUg5pXuxEs
         RwNzQYgQ7E5pfdB9bzacdcbp7HlgC0k8Gq6rJN3Yk3t8UOaekN37lNFPjlZAmsJTPl7K
         7vPKquF3SJOwDIQlxGTKvMi4RVoU2kPdbPEYfM9JPvBjFz9Pl2J/C2E+/VsJRFbh0U3J
         GZjGWD+a45rMpjx14JNhuWmtUx/JGme7nzWCW2MNnS2lnOLThwoI5u3be1a24QyNPMV0
         1JdQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	A Sun <as1033x@comcast.net>,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 126/190] [media] mceusb: sporadic RX truncation corruption fix
Date: Wed, 11 Apr 2018 20:36:12 +0200
Message-Id: <20180411183559.500933813@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476243727187233?=
X-GMAIL-MSGID: =?utf-8?q?1597476752719436722?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: A Sun <as1033x@comcast.net>


[ Upstream commit 8e175b22e8640bf3a58e071af54190b909e4a944 ]

Intermittent RX truncation and loss of IR received data. This resulted
in receive stream synchronization errors where driver attempted to
incorrectly parse IR data (eg 0x90 below) as command response.

[ 3969.139898] mceusb 1-1.2:1.0: processed IR data
[ 3969.151315] mceusb 1-1.2:1.0: rx data: 00 90 (length=2)
[ 3969.151321] mceusb 1-1.2:1.0: Unknown command 0x00 0x90
[ 3969.151336] mceusb 1-1.2:1.0: rx data: 98 0a 8d 0a 8e 0a 8e 0a 8e 0a 8e 0a 9a 0a 8e 0a 0b 3a 8e 00 80 41 59 00 00 (length=25)
[ 3969.151341] mceusb 1-1.2:1.0: Raw IR data, 24 pulse/space samples
[ 3969.151348] mceusb 1-1.2:1.0: Storing space with duration 500000

Bug trigger appears to be normal, but heavy, IR receiver use.

Signed-off-by: A Sun <as1033x@comcast.net>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/rc/mceusb.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/media/rc/mceusb.c
+++ b/drivers/media/rc/mceusb.c
@@ -1370,8 +1370,13 @@ static int mceusb_dev_probe(struct usb_i
 		goto rc_dev_fail;
 
 	/* wire up inbound data handler */
-	usb_fill_int_urb(ir->urb_in, dev, pipe, ir->buf_in, maxp,
-				mceusb_dev_recv, ir, ep_in->bInterval);
+	if (usb_endpoint_xfer_int(ep_in))
+		usb_fill_int_urb(ir->urb_in, dev, pipe, ir->buf_in, maxp,
+				 mceusb_dev_recv, ir, ep_in->bInterval);
+	else
+		usb_fill_bulk_urb(ir->urb_in, dev, pipe, ir->buf_in, maxp,
+				  mceusb_dev_recv, ir);
+
 	ir->urb_in->transfer_dma = ir->dma_in;
 	ir->urb_in->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
 
