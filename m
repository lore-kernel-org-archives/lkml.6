Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227eTLe9z1H/1uPMV6y2VoTSt9WYh9VcRGailxKALU9AxY+opMds/Of3KScu0M6p8R2fxjBd
ARC-Seal: i=1; a=rsa-sha256; t=1518707952; cv=none;
        d=google.com; s=arc-20160816;
        b=yjDvrLOmJdZNn8JOgLZkQ9G6ZBqqXnhbFfHXhLAu4mn1aKNvxTZNoEz9hToqLLHfPs
         ALv7Elp3tq+/D/qbRUYFAJb718vgxzvLLeDrPjIJEP8XhkUJeuGg/iFHwCN01NlNrr/P
         LZGn66pLtlxMr9JKRv3FnFg9o44raPZefOHIrYXCe4KaN4/VKnykW9aYZySDayh651+4
         e+K4qC/bDz5DwbN5p6Hp3WoamaCrS2DnTZ8NSb9dfdULEuJly1UMegcoHB7Ws2NqIZTf
         OkHNheul6YTrbCJneTsg1I1WOumNF8Bl495e3i69bD/eOHYb07DyHnO7g03p8T+HJAXG
         KWhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=51O9SJxOVii3exK99cjzc+BIxuKW9RcHMzShk7ur29o=;
        b=0wAQfHEkj1sOulbMweXgci6f+HnvPUVnJjnxpRimSs1bNg+K+TLDIRDo0loENwiWpc
         uYIvLSQne9X8CCZKuaO5fphqpuhfbLCcbIfIFPRUHVwomCGRNR1VkeIe8zKuX2FYD07a
         QL8GWWVQ5NxMpUQNNPqGlv1calS573oi82fxLnEToELHalSqBGpI96kN5bX6LMNBlXIk
         5zIjnhNTvOBG5WNyPo1pZ7IxLR5wFQpT0WdQtZo289FpP5yOjtQYj97wUR6UPb11K8wc
         nlDv0YBB6Lv7BUH6EYJvCbzu68DOiJ4/RIrx+ZuI9OJtFNM7guxS3i0HrTbmRdSB5N4k
         Af2g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 3.18 22/45] usbip: stub: stop printing kernel pointer addresses in messages
Date: Thu, 15 Feb 2018 16:17:13 +0100
Message-Id: <20180215144120.598182835@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215144115.863307741@linuxfoundation.org>
References: <20180215144115.863307741@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480710125829893?=
X-GMAIL-MSGID: =?utf-8?q?1592480710125829893?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuah Khan <shuahkh@osg.samsung.com>

commit 248a22044366f588d46754c54dfe29ffe4f8b4df upstream.

Remove and/or change debug, info. and error messages to not print
kernel pointer addresses.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/usbip/stub_main.c |    5 +++--
 drivers/usb/usbip/stub_rx.c   |    7 ++-----
 drivers/usb/usbip/stub_tx.c   |    4 ++--
 3 files changed, 7 insertions(+), 9 deletions(-)

--- a/drivers/usb/usbip/stub_main.c
+++ b/drivers/usb/usbip/stub_main.c
@@ -252,11 +252,12 @@ void stub_device_cleanup_urbs(struct stu
 	struct stub_priv *priv;
 	struct urb *urb;
 
-	dev_dbg(&sdev->udev->dev, "free sdev %p\n", sdev);
+	dev_dbg(&sdev->udev->dev, "Stub device cleaning up urbs\n");
 
 	while ((priv = stub_priv_pop(sdev))) {
 		urb = priv->urb;
-		dev_dbg(&sdev->udev->dev, "free urb %p\n", urb);
+		dev_dbg(&sdev->udev->dev, "free urb seqnum %lu\n",
+			priv->seqnum);
 		usb_kill_urb(urb);
 
 		kmem_cache_free(stub_priv_cache, priv);
--- a/drivers/usb/usbip/stub_rx.c
+++ b/drivers/usb/usbip/stub_rx.c
@@ -230,9 +230,6 @@ static int stub_recv_cmd_unlink(struct s
 		if (priv->seqnum != pdu->u.cmd_unlink.seqnum)
 			continue;
 
-		dev_info(&priv->urb->dev->dev, "unlink urb %p\n",
-			 priv->urb);
-
 		/*
 		 * This matched urb is not completed yet (i.e., be in
 		 * flight in usb hcd hardware/driver). Now we are
@@ -271,8 +268,8 @@ static int stub_recv_cmd_unlink(struct s
 		ret = usb_unlink_urb(priv->urb);
 		if (ret != -EINPROGRESS)
 			dev_err(&priv->urb->dev->dev,
-				"failed to unlink a urb %p, ret %d\n",
-				priv->urb, ret);
+				"failed to unlink a urb # %lu, ret %d\n",
+				priv->seqnum, ret);
 
 		return 0;
 	}
--- a/drivers/usb/usbip/stub_tx.c
+++ b/drivers/usb/usbip/stub_tx.c
@@ -201,8 +201,8 @@ static int stub_send_ret_submit(struct s
 
 		/* 1. setup usbip_header */
 		setup_ret_submit_pdu(&pdu_header, urb);
-		usbip_dbg_stub_tx("setup txdata seqnum: %d urb: %p\n",
-				  pdu_header.base.seqnum, urb);
+		usbip_dbg_stub_tx("setup txdata seqnum: %d\n",
+				  pdu_header.base.seqnum);
 		usbip_header_correct_endian(&pdu_header, 1);
 
 		iov[iovnum].iov_base = &pdu_header;
