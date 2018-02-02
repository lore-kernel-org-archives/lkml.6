Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224SwjnRhlBaC2Vnr1Zm+D5VDRi1hWc3PLtQaZwnGUD/fuuD1A2GnHbhAQz0NxxKEkAUeQmE
ARC-Seal: i=1; a=rsa-sha256; t=1517590905; cv=none;
        d=google.com; s=arc-20160816;
        b=DhoiianDL56O4b8rNoUDHD+mT3QeVjqA0dJaqYIgMt6ZEa/uqfQIjS4JV/ztiLZFvF
         srhfchnCff0iVY3+6yTfACdft0fmSnSFbM7XbVSNzWQCvjEysadJiSwSQfarjp0QxhKo
         WSVMPGwEtcnGMrPt1OBQ1Jy+1l516SiQkByjxKgK4Fp1WDLqZRQtajSDQft8a3LBM53p
         oMFJboY5iRBm4A8v/IZARpsssl0KUAj6A7ByLHeu5u76SvBGfdQeuc53VJfZaHT2KgDk
         MiizlWjCk8t1cJbJsDXbqGmCVyx1JYWUumQij/1vM8xHuFPaQtfv8m2QeorocaZfar6L
         fJ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FKfzfKF4bBLTh4jcIqvSYpGBjHSpjghS4cJVJD6QB+M=;
        b=FK7wGeP9bLOtWLJbRTmKQHvpmOZv01ezjgO5JikMdcKXxrc3EY0uaLOlga2W5K6Eet
         aAvUO37nU1j66SgHks3qgjz9XZj/BIiKBKHcbLKIJpayPQm1FfE9IWliqPW7D3MML/l/
         C5cv5i2dK1mD9zqzm99kopEQPuxj9Ovo+k//pCDcpn5FiG/W/yxEYoq7JUReEQfLobmn
         aoZK3H5vNyNBUQr5EgpHtcbNhwDbTmhTsz7jzK+rnFMws/FVLtamRRMOBtFsEI4e2fge
         hqCSra7U39pgdzsh15fiz2MXbXyUTXLSYgm664otTKMC1aSZQZ1eaz9xGkEhNNi5p6+R
         w1iw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Colin Ian King <colin.king@canonical.com>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 53/67] usb: gadget: dont dereference g until after it has been null checked
Date: Fri,  2 Feb 2018 17:58:22 +0100
Message-Id: <20180202140821.185771025@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309400693081740?=
X-GMAIL-MSGID: =?utf-8?q?1591309400693081740?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>


[ Upstream commit b2fc059fa549fe6881d4c1f8d698b0f50bcd16ec ]

Avoid dereferencing pointer g until after g has been sanity null checked;
move the assignment of cdev much later when it is required into a more
local scope.

Detected by CoverityScan, CID#1222135 ("Dereference before null check")

Fixes: b785ea7ce662 ("usb: gadget: composite: fix ep->maxburst initialization")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/composite.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -104,7 +104,6 @@ int config_ep_by_speed(struct usb_gadget
 			struct usb_function *f,
 			struct usb_ep *_ep)
 {
-	struct usb_composite_dev	*cdev = get_gadget_data(g);
 	struct usb_endpoint_descriptor *chosen_desc = NULL;
 	struct usb_descriptor_header **speed_desc = NULL;
 
@@ -176,8 +175,12 @@ ep_found:
 			_ep->maxburst = comp_desc->bMaxBurst + 1;
 			break;
 		default:
-			if (comp_desc->bMaxBurst != 0)
+			if (comp_desc->bMaxBurst != 0) {
+				struct usb_composite_dev *cdev;
+
+				cdev = get_gadget_data(g);
 				ERROR(cdev, "ep0 bMaxBurst must be 0\n");
+			}
 			_ep->maxburst = 1;
 			break;
 		}
