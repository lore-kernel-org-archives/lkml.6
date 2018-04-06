Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+S0Jdgj7RTGGWqfV6MuaOKb7OV537BgBgGl4eu624HBupppl3U6dU4qN8/9BcK8SuaHWM2
ARC-Seal: i=1; a=rsa-sha256; t=1523021381; cv=none;
        d=google.com; s=arc-20160816;
        b=tT/3GXX+FCQ08/KnYFj0fQ6jjMn5bzummsYAkIDZsr7K8rxNDRzoy4nd/K3ML97ct4
         aVoUbaIGbLL+fUnN9ZTTqj1PJzMzV3le0XR5DxQORawN2IZFXCJw5guFgWF02CmswXWz
         gK2OJa7gAs9cCkd3tsStEUu1gn9tWhcBFVHVNxjnIJ6LTv3oyr9kpRD4Wx5g/MMb4qxz
         nyVGrfWzaKt/6AZ0wjYu5mo2tgMqg6/clx7EgReJW9qqlU5DBu9GISxJ8ABqk6d0G/we
         DWd9n4MEeg+23ltQ196am2QYwCmNQgtqTjcHonZkqfJrrUiqZ4/lBJZCbQs7OhihAlBU
         qmjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=e3uWem1aX0dHq4m4dRAIU+CxEYHmLbCQ8wXzJOK3euM=;
        b=u5LJyMGAY6m5U83R11Pm/h152ukRW1NmUfhQniFaPZhqCGXyVGKpKsO6q7pR8dahWK
         PYwocRKa8Ypwo+tEsp/8AnYWvFIyndXmP6hjtfFCmHogGCYyroE42l/0/yfJxDgcDIVz
         H1ipCyrmAVo29iYVqMLzrneJVh27RcG7O3Da0Z6xQ6+dVjew3pw5/a/LrvlJKRrOcLht
         uicYErU7GjGLPZ1mw2GtVBv0W/qDwOFKIlRGoHDj9SxejA9GZnft9lHs7HHMjh2Igmnl
         kSJddMFusD08QplVgBpBk1Bpx9iMOA9thyzV0xkheXgZ1mr0uxZy8E3vVHCAffNPcfU5
         LKSA==
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
Subject: [PATCH 4.4 08/72] usb: gadget: fix usb_ep_align_maybe endianness and new usb_ep_align
Date: Fri,  6 Apr 2018 15:23:09 +0200
Message-Id: <20180406084305.796067391@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003483960260193?=
X-GMAIL-MSGID: =?utf-8?q?1597003668168975541?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -663,8 +663,20 @@ static inline struct usb_gadget *dev_to_
 	list_for_each_entry(tmp, &(gadget)->ep_list, ep_list)
 
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
@@ -675,8 +687,7 @@ static inline struct usb_gadget *dev_to_
 static inline size_t
 usb_ep_align_maybe(struct usb_gadget *g, struct usb_ep *ep, size_t len)
 {
-	return !g->quirk_ep_out_aligned_size ? len :
-			round_up(len, (size_t)ep->desc->wMaxPacketSize);
+	return g->quirk_ep_out_aligned_size ? usb_ep_align(ep, len) : len;
 }
 
 /**
