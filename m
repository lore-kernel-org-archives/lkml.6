Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48TvvjA84PKkPU4CoN8SjsSHTqM40VVKJd8zk6d6cdpCiOjIG9xnQvMThHYLLzdf1INHVbg
ARC-Seal: i=1; a=rsa-sha256; t=1523021208; cv=none;
        d=google.com; s=arc-20160816;
        b=SxAnBojoBNqDAT0poZml+iRyOk1pLVbVDI4AY4WrTa+adgODZhytomfGN4IMqKpOxR
         DvH8IqcAVJY8hTgtYeNoZmbJBubssvYMsKjJx9tyC2D+cucr/2a3uMhIo63AaxHwRFyV
         YCN8dgQX/OwO23KNkG8f6+2jFPkAckIUB+QG9kiPq7IS0lWGOCLN2fZQvgFKGqDmoNkX
         cGo6O/Fjff6LeUsYA4xCKunOmLwcXYonV0LXbbjcBmc5wLuD1IBE26+D2MEi6hLOCkS5
         uu+27+F5Omjn9xQk39yFbvFP6jOgfQfuEz0baKEp4ev2h9FlIx3EQ1W/lXhOAmZCePk9
         ui4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1i1Mm1c+CfehsBw0bEMr41AvqpjZ8Bv89PiSKXowqJM=;
        b=z1knBOKwzZtQ1QQfPEZrBjR8FFW66w5q6ZXM0gnPCjpQgACVHYwVJddzVEoeKe3K76
         boBlUNIyUk8HrR39+oxrsLALqyQM57lrJiAGVkRZHVKUtx64e+0JUeYJShObFljQqtjG
         E6OfTRhXAVH/81WU8z90bRdZGGdIppnDIWrKUm47bkUWku6T1iWsnDPWouIUn71qqrwb
         wWlj233uqcISBXqEMC+3vUQ8jmmdCifDV6tg2s6ovH8azE+lpO0r0bCarSL8BWSJcGGf
         O5haR/3BRTcMQSD4XmO3AkBrQOCoFV/fy6zwS4WZ3XlBlxNIOfRMCBB7Z2qb/j4f1Tgt
         W4PA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Felipe F. Tonello" <eu@felipetonello.com>,
	Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 3.18 45/93] usb: gadget: align buffer size when allocating for OUT endpoint
Date: Fri,  6 Apr 2018 15:23:14 +0200
Message-Id: <20180406084226.893151758@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003487278830693?=
X-GMAIL-MSGID: =?utf-8?q?1597003487278830693?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felipe F. Tonello <eu@felipetonello.com>

commit e0466156ee2e944fb47a3fa00932c3698a6d2c67 upstream.

Using usb_ep_align() makes sure that the buffer size for OUT endpoints is
always aligned with wMaxPacketSize (512 usually). This makes sure
that no buffer has the wrong size, which can cause nasty bugs.

Signed-off-by: Felipe F. Tonello <eu@felipetonello.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/u_f.c |    3 +++
 drivers/usb/gadget/u_f.h |   16 +++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

--- a/drivers/usb/gadget/u_f.c
+++ b/drivers/usb/gadget/u_f.c
@@ -12,6 +12,7 @@
  */
 
 #include "u_f.h"
+#include <linux/usb/ch9.h>
 
 struct usb_request *alloc_ep_req(struct usb_ep *ep, size_t len, int default_len)
 {
@@ -20,6 +21,8 @@ struct usb_request *alloc_ep_req(struct
 	req = usb_ep_alloc_request(ep, GFP_ATOMIC);
 	if (req) {
 		req->length = len ?: default_len;
+		if (usb_endpoint_dir_out(ep->desc))
+			req->length = usb_ep_align(ep, req->length);
 		req->buf = kmalloc(req->length, GFP_ATOMIC);
 		if (!req->buf) {
 			usb_ep_free_request(ep, req);
--- a/drivers/usb/gadget/u_f.h
+++ b/drivers/usb/gadget/u_f.h
@@ -47,8 +47,22 @@
 struct usb_ep;
 struct usb_request;
 
-/* Requests allocated via alloc_ep_req() must be freed by free_ep_req(). */
+/**
+ * alloc_ep_req - returns a usb_request allocated by the gadget driver and
+ * allocates the request's buffer.
+ *
+ * @ep: the endpoint to allocate a usb_request
+ * @len: usb_requests's buffer suggested size
+ * @default_len: used if @len is not provided, ie, is 0
+ *
+ * In case @ep direction is OUT, the @len will be aligned to ep's
+ * wMaxPacketSize. In order to avoid memory leaks or drops, *always* use
+ * usb_requests's length (req->length) to refer to the allocated buffer size.
+ * Requests allocated via alloc_ep_req() *must* be freed by free_ep_req().
+ */
 struct usb_request *alloc_ep_req(struct usb_ep *ep, size_t len, int default_len);
+
+/* Frees a usb_request previously allocated by alloc_ep_req() */
 static inline void free_ep_req(struct usb_ep *ep, struct usb_request *req)
 {
 	kfree(req->buf);
