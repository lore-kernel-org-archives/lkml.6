Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/1Cul1DL1EEsebF+A1Di7aVDSBAV1bHD5I3XS7dp8mov++77MjQmvRSftgHe0jmTr5x8qk
ARC-Seal: i=1; a=rsa-sha256; t=1523473335; cv=none;
        d=google.com; s=arc-20160816;
        b=XZwag9IJBiRULVxsta2h1vNsn0ma+VmdsS98r+BR+JfCRqkkzBSJkVcL2cah/RIxYo
         rn0jU2mys7WNjmdDvatC5peI0svC2CJjHPhzadSQeK1W5L1c0wOhUS6yWgH+NDIQ3D2i
         CE5Eg/CA+PCwYZktHlhdsY3oZLZRK2IkZHaX500PI+MiOFPPKClKfelKm5AEbepvEB0i
         mUYI7K8dsVFOFK7JYOtpxt9nKbUN2pGlhiN9x/C4uFFazFCg55ACWPHOmseTru1q/7J8
         u48IdLAFp2gVHpx7oGjSSOjs2XL6hyTTf0ye6IwTN+D8vAwoZ++yiVBdRg26QobaUvF8
         b0Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Ljnk4gec1UgNJAOMF5NSX/ehofgQAjsSLa8AJqd60P8=;
        b=jRTNOGs+o4t1HcnBCWBiArp16DDTprjrYPmdAw98AVSG1OvAao8ZoLXFc2vZ2StsIG
         39uWQqjkgdMWtdZyUoz9b9cKkqEze9d92SOvJyf9kymTgXkGf6FWINw5IcbFqFjBikYf
         78Y/GPcyUr8E876jeJcHjpFIu2oy6ABUU27PLXpQlvrnsMBrkW1lpYyAgbPulQuXG6KS
         qMGyk63RDpR30/kcUuKlFw4c9ffmgTGlgm8ec+COy9V7JNU5rjzOxmJ4VhjTfQgbbSeC
         K9346T5POgBHFlmKy8RbO/rm9WDnQBu9+8bWwzPiDALvIQoykqw0YqJWmYUGQo+oLWV+
         ZEAQ==
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
Subject: [PATCH 4.9 209/310] [media] mceusb: sporadic RX truncation corruption fix
Date: Wed, 11 Apr 2018 20:35:48 +0200
Message-Id: <20180411183631.559421963@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476243727187233?=
X-GMAIL-MSGID: =?utf-8?q?1597477576315138631?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1381,8 +1381,13 @@ static int mceusb_dev_probe(struct usb_i
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
 
