Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/oFZ83e8Kco8iMI2kV9/yAMhWVDkp8Mn9I36u1bIF8bKp2rfjvTzrvctkPJyN59yMKBNhD
ARC-Seal: i=1; a=rsa-sha256; t=1523021202; cv=none;
        d=google.com; s=arc-20160816;
        b=Z4hXW2Mg3KW5u0nwSYOyuTpH3ju3x5zMthujUIJ+2ZYkSbIRAzv9Npl3iIMx+yAw2A
         H94kbBAW4MoOT0E3SAhrjeS1cnzRtvlf+h5kyccSQZaObPfJa44+CaAQuc3vo/w5S8ys
         LTi6vt7fgTK1YnETL2eO0JlJ4xJ8TYzQ3+cssWguZ5PFi4KikWUALOJFXw6xAjadw14v
         M0r/iyWK+0TaYyVue+O4QTnn9lrDvf72AgWBgnD+MVqoIaoj3URaZTGqp+qC+JWv8T+6
         3QMqRNO6C0+a+a29jCRx1vqOjXZatLJ1cEYy0HxPLtm7COz/p3woS6WCh2f62ISi1H01
         bNSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=538xN5/lgzMvClT6k91+i13dxKTND2ora+8UG45YKKQ=;
        b=s4gnE6aUI6Wzm/CFuzYI1zgTUNae9f20/6Z5U6Kc3O6j3JhQK76gbdWFDIxOzqk/Oo
         H49UFlKfpd4L1GId+AUnKw2sFElAYi08RcGdvgIode0CRCjZZ/cHE0kx2M5jrCUHuVRg
         gy8tzVn8x2CPRK6o6C2BSk9yWZcf+3E/5hj/n+9yUG4I9tgdjPRZYNaRylW4q0Dho1fs
         5AZigyZlJ/ZvhzCV57FZGxinDUfaq2ApikPYHluCwp+t0It9LP4DRCwnugrmO07B3t9q
         CMX9kFSmBdHXTTA01eI1xgdAx480cXV7uNjyVjxDrcpBUgEhUFQ8kdHvyWM8J40i+YLh
         nabQ==
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
Subject: [PATCH 3.18 43/93] usb: gadget: change len to size_t on alloc_ep_req()
Date: Fri,  6 Apr 2018 15:23:12 +0200
Message-Id: <20180406084226.811970457@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003480390303292?=
X-GMAIL-MSGID: =?utf-8?q?1597003480390303292?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
