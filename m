Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx498E4Y4UDB3WsFSvSROayoUTYw/3jn8+1nORKcYOViBM1k6tsT2f2rdllI+kXj0onK4WVuA
ARC-Seal: i=1; a=rsa-sha256; t=1523021378; cv=none;
        d=google.com; s=arc-20160816;
        b=kuyf4O4kg0KH8aM7ahKaxOmdfCN633kgZt/HX9ZVwNq/zURSAkOP0eMToL7XAEI8kC
         uTs1MinAnN6ysy3mdkrzehodPdVqzp8y8DJiI08ge1XEqknUd804w8GkMNeEwNTMcMMU
         Gta7tq0as/9j5VyNfE74+qdSQoBrApYQjsuRH+R9zif/QJDCujluuWPPOHk8Tfy5wbhg
         seXhOA/voRc4893RIKfK1lqqea6xP11WEdcGWOpsbFR4QRgnRiCfQzupMfMAfNtngQQ3
         H3qgbyRMiKwwM99ozW8lvzuqVQLjZdCL6m56D2jlNaRpcHAk1t4tbYJ8vDrDT9kXbWo3
         GF+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FuThynM6YPYjhcQ+LC1crviUH0mi90TrP+bQQZquA/8=;
        b=EMkhJY0qa4D8sX51wFB2cEOjswZhwMkEOo9zU4N3km+NHXq0DrOXpO9IZ5vSNrC/oH
         fpDAGkQJXQb3f0UN1hn1S5Hdz6EeW39/+OJkPZMD6tc5l8bk9KQ/lDc3MarK4X6Z9Xjs
         ZrWD4IPt3TCeI4lscad6DAIvz+oqy7RHSJemMN5gY+uufjNONAWcsOO7XLgXlZ+o0tsa
         BXW96/jrHekK78jtoJA5HYHRmZnxLneJvJCcCofa8lPCrZGlWpPeMG7RK6JHJPe6K3aB
         KA/BweA01GuaRtS7mloB8l4vJaM8b2dg+Hx+DybHCMC9djmY8J65RGGIo7pEJbSyGA0i
         Q6cw==
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
Subject: [PATCH 4.4 07/72] usb: gadget: change len to size_t on alloc_ep_req()
Date: Fri,  6 Apr 2018 15:23:08 +0200
Message-Id: <20180406084305.735685835@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003480390303292?=
X-GMAIL-MSGID: =?utf-8?q?1597003665414048399?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felipe F. Tonello <eu@felipetonello.com>

commit 69bb99738b5c6d56d2b1a75db9cbb4d187453c1a upstream.

Length of buffers should be of type size_t whenever possible. Altough
recommended, this change has no real practical change, unless a driver has a
uses a huge or negative buffer size - it might help find these bugs.

Signed-off-by: Felipe F. Tonello <eu@felipetonello.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/u_f.c |    2 +-
 drivers/usb/gadget/u_f.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/usb/gadget/u_f.c
+++ b/drivers/usb/gadget/u_f.c
@@ -13,7 +13,7 @@
 
 #include "u_f.h"
 
-struct usb_request *alloc_ep_req(struct usb_ep *ep, int len, int default_len)
+struct usb_request *alloc_ep_req(struct usb_ep *ep, size_t len, int default_len)
 {
 	struct usb_request      *req;
 
--- a/drivers/usb/gadget/u_f.h
+++ b/drivers/usb/gadget/u_f.h
@@ -48,7 +48,7 @@ struct usb_ep;
 struct usb_request;
 
 /* Requests allocated via alloc_ep_req() must be freed by free_ep_req(). */
-struct usb_request *alloc_ep_req(struct usb_ep *ep, int len, int default_len);
+struct usb_request *alloc_ep_req(struct usb_ep *ep, size_t len, int default_len);
 static inline void free_ep_req(struct usb_ep *ep, struct usb_request *req)
 {
 	kfree(req->buf);
