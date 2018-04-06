Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/C05aKJfdgk3C6QV98LQfABBnZyBgki791cTACkwhZLSFTu6nS/YcwiQR8CDZBoZ8eD3Nj
ARC-Seal: i=1; a=rsa-sha256; t=1523021376; cv=none;
        d=google.com; s=arc-20160816;
        b=gDc5tsOEsQCVMraZQvFABJqdvdv2VdrJ3zeCodI//JxtHUeoejyGXYy6R7VVBNGwlW
         /Ap8J4XzQAAvrJSboro0cISjuLnou2ZUaKpevh0cCAUy3194KT8RhdwhukKKCPfomYee
         SqZwOE5lmSEBkOhb4Xq0G47mMarqHPDYmhkK41j+Pt+TmZXNqOrtLiMNV0ThCGMuaesW
         P64NOWrF3DvFCKA8474/E2H1QyPzS5Q30waTmS1VEq10xhAuCXXbMaVBmeOx1gDhLBUS
         z0uXW5MaEhxzNTrgH8m5GseFPI/j5EoM9mshL1OTrTY1S3pn8tvcbosFMjCDj69NOVEj
         zWew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0fML9uzOrC5jkeze+ETlwwf/GWNWsmhwUW9Ggwi6EjE=;
        b=tWVmoC4jaTM1SrwR64/O6OhZJS/xkiSpF2qIUNj1pT3i3g4yV+cNfUGt/BDZN6NRuG
         Eh+e3+8asn9QNhMRGJFmWJYDQBXoXy5cBLtXKD4OrkTAXH8jUk8vR11xwkwg82gEPjp9
         C5cYWsN4olZKEU0db/u0cwVTIdKwGUvmqgaXZgTUIzXxcedDvVYJ+AcgweFZiHjyM8Uh
         x+xCDFcWQKSf6h1704Z/UsO1VOaoULok8SyIcmjt44tQnXYbPLGYZSGBBn4gcG86Y8LR
         C17pPppaWqI74FcLiHIjEbEv5W5DadjZBUZzMukkE+OdEz89WTglIIfqJXAvT2IHz7cP
         xpWg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Robert Baldyga <r.baldyga@samsung.com>,
	"Felipe F. Tonello" <eu@felipetonello.com>,
	Felipe Balbi <balbi@ti.com>
Subject: [PATCH 4.4 06/72] usb: gadget: define free_ep_req as universal function
Date: Fri,  6 Apr 2018 15:23:07 +0200
Message-Id: <20180406084305.661537400@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003477879461290?=
X-GMAIL-MSGID: =?utf-8?q?1597003662802534301?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felipe F. Tonello <eu@felipetonello.com>

commit 079fe5a6da616891cca1a26e803e1df2a87e9ae5 upstream.

This function is shared between gadget functions, so this avoid unnecessary
duplicated code and potentially avoid memory leaks.

Reviewed-by: Robert Baldyga <r.baldyga@samsung.com>
Signed-off-by: Felipe F. Tonello <eu@felipetonello.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/function/f_midi.c       |    6 ------
 drivers/usb/gadget/function/f_sourcesink.c |    6 ------
 drivers/usb/gadget/function/g_zero.h       |    1 -
 drivers/usb/gadget/u_f.c                   |    1 -
 drivers/usb/gadget/u_f.h                   |   10 ++++++++--
 5 files changed, 8 insertions(+), 16 deletions(-)

--- a/drivers/usb/gadget/function/f_midi.c
+++ b/drivers/usb/gadget/function/f_midi.c
@@ -201,12 +201,6 @@ static inline struct usb_request *midi_a
 	return alloc_ep_req(ep, length, length);
 }
 
-static void free_ep_req(struct usb_ep *ep, struct usb_request *req)
-{
-	kfree(req->buf);
-	usb_ep_free_request(ep, req);
-}
-
 static const uint8_t f_midi_cin_length[] = {
 	0, 0, 2, 3, 3, 1, 2, 3, 3, 3, 3, 3, 2, 2, 3, 1
 };
--- a/drivers/usb/gadget/function/f_sourcesink.c
+++ b/drivers/usb/gadget/function/f_sourcesink.c
@@ -303,12 +303,6 @@ static inline struct usb_request *ss_all
 	return alloc_ep_req(ep, len, ss->buflen);
 }
 
-void free_ep_req(struct usb_ep *ep, struct usb_request *req)
-{
-	kfree(req->buf);
-	usb_ep_free_request(ep, req);
-}
-
 static void disable_ep(struct usb_composite_dev *cdev, struct usb_ep *ep)
 {
 	int			value;
--- a/drivers/usb/gadget/function/g_zero.h
+++ b/drivers/usb/gadget/function/g_zero.h
@@ -59,7 +59,6 @@ void lb_modexit(void);
 int lb_modinit(void);
 
 /* common utilities */
-void free_ep_req(struct usb_ep *ep, struct usb_request *req);
 void disable_endpoints(struct usb_composite_dev *cdev,
 		struct usb_ep *in, struct usb_ep *out,
 		struct usb_ep *iso_in, struct usb_ep *iso_out);
--- a/drivers/usb/gadget/u_f.c
+++ b/drivers/usb/gadget/u_f.c
@@ -11,7 +11,6 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/usb/gadget.h>
 #include "u_f.h"
 
 struct usb_request *alloc_ep_req(struct usb_ep *ep, int len, int default_len)
--- a/drivers/usb/gadget/u_f.h
+++ b/drivers/usb/gadget/u_f.h
@@ -16,6 +16,8 @@
 #ifndef __U_F_H__
 #define __U_F_H__
 
+#include <linux/usb/gadget.h>
+
 /* Variable Length Array Macros **********************************************/
 #define vla_group(groupname) size_t groupname##__next = 0
 #define vla_group_size(groupname) groupname##__next
@@ -45,8 +47,12 @@
 struct usb_ep;
 struct usb_request;
 
+/* Requests allocated via alloc_ep_req() must be freed by free_ep_req(). */
 struct usb_request *alloc_ep_req(struct usb_ep *ep, int len, int default_len);
+static inline void free_ep_req(struct usb_ep *ep, struct usb_request *req)
+{
+	kfree(req->buf);
+	usb_ep_free_request(ep, req);
+}
 
 #endif /* __U_F_H__ */
-
-
