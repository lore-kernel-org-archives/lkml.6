Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/cLXLcuko/1C6qNV/yR580qN1e6mD9NKQ5a2EBeKbSFKIOksTKMvL/iMWuI7y+T+EyZEKG
ARC-Seal: i=1; a=rsa-sha256; t=1523021199; cv=none;
        d=google.com; s=arc-20160816;
        b=k0eJPvgncBqDlMmxNJx6biaZLwEYqBdmMCfqRpVSRxpCpzr6fAMiOhuT53d+iGyYtT
         rnXvsYIQaSN0rpleUtYZ0CTSOwdQYqsNw8REBd2qIw4sEMaV3wn+rFTI4qp7vO0795dj
         Fd5UIBExMbkoB9JeGWleUF0O3aoi9Yre2dp47Rb3vjp8x8IhNmz48rUy2quc5/3B/HCf
         6oqvrbzl0qtBY/+qYS5dP8PBZsF/tp9gijjWyOKEnrto7yxeGIu/lsa4zLkELw8Wf1fe
         aLA2AQYxFpU1XPzd+VXeU4ZGUjYIyh2O8vfvtI4QdJdV/KJIgSP4+oDjlFqI4n+GpCXd
         aEwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=oGB/jKJuPnNM5cQ1BgefkmjKSXywtIpovrZX5te2T+c=;
        b=Xz4yCPJ5PliS85O1hTZXRMSEdNt4rgJEHBeooRFwuc4zvcBYYSO6nz7kYDe46WjSJs
         O6bqq+vcuRV3WqxQpxADZHWjkMvT/wu8EjAkeg3OvPNIeQ9ndnqm7dUcDJyXMIBu9QYC
         R9vz/87NzkO02+lgJ/rvaR50tYbWC2092mVNXX1SuRfi6Zg0FoddMpHiIQZghreH0iaP
         3MWuq0+cPwVXOjE8hQeyn32aP2wtOKRMa+YwOJF9dLc6RNoIsv1pOUeA9yExzWA0u8kl
         RXyzQfFH3E+jSDHitzl04N4s2uamR6UcGOoHh42gFv4TWCOCHsoZ4d0m3EHTRNvs90HS
         DtHw==
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
Subject: [PATCH 3.18 42/93] usb: gadget: define free_ep_req as universal function
Date: Fri,  6 Apr 2018 15:23:11 +0200
Message-Id: <20180406084226.775718254@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003477879461290?=
X-GMAIL-MSGID: =?utf-8?q?1597003477879461290?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -199,12 +199,6 @@ static inline struct usb_request *midi_a
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
@@ -435,12 +435,6 @@ static inline struct usb_request *ss_all
 	return alloc_ep_req(ep, len, buflen);
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
@@ -69,7 +69,6 @@ void lb_modexit(void);
 int lb_modinit(void);
 
 /* common utilities */
-void free_ep_req(struct usb_ep *ep, struct usb_request *req);
 void disable_endpoints(struct usb_composite_dev *cdev,
 		struct usb_ep *in, struct usb_ep *out,
 		struct usb_ep *iso_in, struct usb_ep *iso_out,
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
