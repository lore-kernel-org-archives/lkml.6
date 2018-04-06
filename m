Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx485jizsRduc/PsiibtOSp8CalVkdpr+vFRdnwfRCYEOhnrUEiJwI1VD3cq8C/lYDQmb33gP
ARC-Seal: i=1; a=rsa-sha256; t=1523021384; cv=none;
        d=google.com; s=arc-20160816;
        b=VMJygBY0bvcbDPmLJ5qilg146YzL0UST4z5zqJcPNVc7gsDPOsTaisbYmHNGecRJcL
         nVkSTVnqEbOZeGKxEn0QBG5x2yQdIrQN6yr6xS3qQ4/MkZaNj3qfS7UWL8XrHwZmRvFi
         jjyLvvjNTNH+AhOq/i+bFA3e9GLKkS1imtb/kDdUOVOUS/nuVQak3TizMNVqoNZUX/A2
         I+MS+dUx35cugHrx4ljeLGUZ31zu9K26LmmNJsw6RmCmAuduEJRo1iy3MA6+P4BRgHlW
         PVNmXqgtJdahnp3kZ2ToIpPG0xIQYE7UCkkUPZED7hxOwAmsCq+tON0ZSmysQXCBrK5Q
         kMSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4+3DSx9HahILDVAV0v8NccW4ujY7rQz6J/0d0pqauoA=;
        b=PGkSAVzG64PHGQG1A7kgigB1RD9iSO36YO4GHP21o3mjGJiJUBV/j8rysGuUqgks2s
         mSZC/gopkFFfVxbuyXMncM8CznQvVhIUnKL//3og+RZQYArL/EEQRSGsyxn+jCmiqnBF
         ihgmY+BH3fjwekaQieMvPrGHiUHfXLZw0ec832CPvZI1iEdwucoNF5g7OeawPmVSdtHf
         zleqVfqr6BMNQCBZVKjmnBiPb3Iyp01r08OdG94ErcazeqpFHy224S5hkqJURLEQjCkQ
         WlFDst0Xeap3ZUkNlujRyb6mRGrzCxxo1rkxBvh4fYmU4OpffL0w5NN66nQUqtlPJK7Y
         IAnw==
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
Subject: [PATCH 4.4 09/72] usb: gadget: align buffer size when allocating for OUT endpoint
Date: Fri,  6 Apr 2018 15:23:10 +0200
Message-Id: <20180406084305.868157370@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003487278830693?=
X-GMAIL-MSGID: =?utf-8?q?1597003670547837757?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
