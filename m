Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2279Hao0tEQ9FyxYoC5omDZVCSvIKi/hdbSS4MkFBh+abqrNReu6i8GBBcuj0IoK3uyYQVzH
ARC-Seal: i=1; a=rsa-sha256; t=1517591572; cv=none;
        d=google.com; s=arc-20160816;
        b=nPrMLr2lFrpV7uk6Yh1JV+OYv6WBgv+lcz6EtK/4Qnhd4XIg87rzSo1McEwHXBkqYm
         HDAQSBTChyLcEsmiMuQ2l3Q1WKIgOzh4dnXyueVr6zMuRTz2HU9rQEiJvDWQWbufHCVb
         b+5r+CqpY0AKE9R7FPlt6kcvxu1jcO8MOmb6N/dBc53sGptw+94/Q52LS6giQR56Pn9n
         iz9jwNIjtImjuraTwihvjp63VfmxTzzWvwDknUEZa5T+landrgAQT7Fe63hpk7BZya2k
         xAC73fQS9hhNvdD6u6FP2V2P7mIcZmy4zoyqnjrqHWhdop1oV7+B7eIYX9H3NOEFxFQs
         gZJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=JOqKCXtePEpv7/DuG4GE0cq/habkACRNuvmaOqT9N8M=;
        b=Ntn5d+StogK5wJ748Vo5+qgYgN4bl/eM494MdQAli6g48E9IeuJlxYoOVRgo9sRYWM
         MmlxE0+AW9ChF0nzSxCwvyxz8pTn3oI8LcMTU0BCS7rhC14XAZgWnjw8T6qqj5T0PPGd
         zQlAeQxNgoweISV6lE78Dms8xGcmRbVV1iOJpthsA3fV2pY8B1S3f5988pn5xBiQxGdj
         Ss/IDVOHSiCTy25h0fcBciShxXAX/p5IbVHXhKOHYQ0K/rCNiypPMg/2d3hak7KbmbhA
         pup8QdvbBubRvO6d9lzNM2lW/YC/4R82ZECNLOIY6rBKcyajv223rANvf/M5Lz3uD+sp
         DTQg==
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
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 125/156] usb: gadget: dont dereference g until after it has been null checked
Date: Fri,  2 Feb 2018 17:58:26 +0100
Message-Id: <20180202140846.036004738@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309400693081740?=
X-GMAIL-MSGID: =?utf-8?q?1591310100348807555?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/composite.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -150,7 +150,6 @@ int config_ep_by_speed(struct usb_gadget
 			struct usb_function *f,
 			struct usb_ep *_ep)
 {
-	struct usb_composite_dev	*cdev = get_gadget_data(g);
 	struct usb_endpoint_descriptor *chosen_desc = NULL;
 	struct usb_descriptor_header **speed_desc = NULL;
 
@@ -229,8 +228,12 @@ ep_found:
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
