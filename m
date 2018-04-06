Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/P0Wqh5U1lYCjiyNIyaCW3fJTaA35n7TWCCp9N9lqoFenXIaCuDvnqM+799dc81o9MLTbg
ARC-Seal: i=1; a=rsa-sha256; t=1523021205; cv=none;
        d=google.com; s=arc-20160816;
        b=KIzcJ2rnSy/n6LCJafkFtBLzCQ6lBD1Gfii4IfEChF8NtN/vBJ0OzyrNq7whLDOZXc
         V7J4jiUAOIBJUMuLcQIa+Z7fvz9WBVTGWiUP+ZxED1YA2L+r4+Q823nDangqkmpmDrYs
         WjHSHovS1GfNTytVeEBx1AhVWupyIWx57nZDj9/EC/p3gmBI8V8oSTso9Lc5+b8YjoxB
         ln8/RsBGdVrGHIuwzAXkV1RFPxGk7R0YDBR+okWkRMRZSJGGmk7hkakZmrfbsshPPDCK
         70TwatRY8k24ycDrgKqwiinAgLHPVlIkK2/tU8uWY76Vu9qLJiMlKnrlSyc/rT+AmZ03
         L7mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tJ3TGUCsJTAsFYZx716Zj2WBnVO18xgE8LBiw1NUIzM=;
        b=Xdd6QO0wHRpC310r6a0X6XDsG164tHxyxVY5Jx5Mgqa1+jFcXjWMZLPeIkl83IGT5a
         CBNPUgTyHOyq/xZanCVi/dG/rmf0xpmDm8S2nLJcY7u1yVxKBneNrUohxv+VeqfSKtfq
         5S6cKH1RPFPBNKWa9YR5q9+o3e3W5m27/LQKxqISYjyGOppzSMvKc14XjBP5b96Okhyn
         HPevTmuFemDPTAXUtgZuionIbn83Q1BVdi82kQ0yfb0mW9z7o0ODiCkM+4ACBMaNuv5L
         j/e2fApjJgh0jIXMAObTDrFSSIMZRnAtcpHTyX9Fi716Ho+cItDYzmjiVt2T1Wd/+IB2
         /jng==
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
Subject: [PATCH 3.18 44/93] usb: gadget: fix usb_ep_align_maybe endianness and new usb_ep_align
Date: Fri,  6 Apr 2018 15:23:13 +0200
Message-Id: <20180406084226.848881058@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003483960260193?=
X-GMAIL-MSGID: =?utf-8?q?1597003483960260193?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felipe F. Tonello <eu@felipetonello.com>

commit 16b114a6d7973cf027e4c2b23eae1076eaf98c25 upstream.

USB spec specifies wMaxPacketSize to be little endian (as other properties),
so when using this variable in the driver we should convert to the current
CPU endianness if necessary.

This patch also introduces usb_ep_align() which does always returns the
aligned buffer size for an endpoint. This is useful to be used by USB requests
allocator functions.

Signed-off-by: Felipe F. Tonello <eu@felipetonello.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/usb/gadget.h |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -582,8 +582,20 @@ static inline struct usb_gadget *dev_to_
 
 
 /**
+ * usb_ep_align - returns @len aligned to ep's maxpacketsize.
+ * @ep: the endpoint whose maxpacketsize is used to align @len
+ * @len: buffer size's length to align to @ep's maxpacketsize
+ *
+ * This helper is used to align buffer's size to an ep's maxpacketsize.
+ */
+static inline size_t usb_ep_align(struct usb_ep *ep, size_t len)
+{
+	return round_up(len, (size_t)le16_to_cpu(ep->desc->wMaxPacketSize));
+}
+
+/**
  * usb_ep_align_maybe - returns @len aligned to ep's maxpacketsize if gadget
- *	requires quirk_ep_out_aligned_size, otherwise reguens len.
+ *	requires quirk_ep_out_aligned_size, otherwise returns len.
  * @g: controller to check for quirk
  * @ep: the endpoint whose maxpacketsize is used to align @len
  * @len: buffer size's length to align to @ep's maxpacketsize
@@ -594,8 +606,7 @@ static inline struct usb_gadget *dev_to_
 static inline size_t
 usb_ep_align_maybe(struct usb_gadget *g, struct usb_ep *ep, size_t len)
 {
-	return !g->quirk_ep_out_aligned_size ? len :
-			round_up(len, (size_t)ep->desc->wMaxPacketSize);
+	return g->quirk_ep_out_aligned_size ? usb_ep_align(ep, len) : len;
 }
 
 /**
