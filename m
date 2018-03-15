Return-Path: <kieran.bingham@ideasonboard.com>
X-Google-Smtp-Source: AG47ELtnaiOr+/yexIM64oLFzFFEV5oUn3YMKcZjubbZWo2gGYQPPCaZ5LRTmBXoQkTgOZwQIxSS
ARC-Seal: i=1; a=rsa-sha256; t=1521108064; cv=none;
        d=google.com; s=arc-20160816;
        b=HRw2Vb3bw9MxxUMxuCchBIKeRwhJtQMlEjK3fsQ00/8UAKjADfK8KGafc+VZoDcQZm
         xlvVm5qwVdBO0UZTPumzCxA54v+9KoQcwJdRHdT4+j80L8j0wbG79Wz7iViwkHICc/M6
         k/r95awAWW9gNB+hSoVD0oS9i58OnOqg+/4giW9ImsqnlSBpMU45cv00BTQ2Lz5+zsFS
         dBetszO2Wt4kYoigqoFQZXqc9otqdXNwYsecT4v9qpflOlTqwU8PbRjUzxN9QcWT0BXb
         UwLQa8DzvS2QS22URpfQa7Zw38QKm4WGspS1KIGoq4WAWQv7sidkRpCSScZoh0O5sFeh
         /CgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=+EtMnpE1vNGL5Ga6x5j/y3y/dSlDjerO70oPnRWUjf8=;
        b=sCXu31Kt6P7qn4uZm8SDs5Cjb4LcUiuIW35MEev3rPyXytDcMM26bomswJqKC9nW7y
         Svisv7p70t2WzRwS8sEGkT6wdsJUl/MqgmDHRYYCwuIEn9U93UIVBB85C5dnJGTgzd2C
         Ospl3prAZ+0R1NqE6Q6NzuZ0IGt3A02yPr8Nq+dVNFwxQGvupBwS+l3KgP6iFTNwAoJ3
         iG9thVDWy3SAamJoBSM66imTRc6Qe00Jh19GIYK0Jj6C3P4QAFSLYpKxWKJzhr7lOjBY
         SXyzdfMSlXqkrh5dq8QSrfkokky8BSd5wKa6W7yKk2b71rWTZ5OqMPLW0EzE/stkDA4Y
         P5Pw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@ideasonboard.com header.s=mail header.b=Ljp4vaBs;
       spf=pass (google.com: domain of kieran.bingham@ideasonboard.com designates 2001:4b98:dc2:45:216:3eff:febb:480d as permitted sender) smtp.mailfrom=kieran.bingham@ideasonboard.com
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@ideasonboard.com header.s=mail header.b=Ljp4vaBs;
       spf=pass (google.com: domain of kieran.bingham@ideasonboard.com designates 2001:4b98:dc2:45:216:3eff:febb:480d as permitted sender) smtp.mailfrom=kieran.bingham@ideasonboard.com
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
To: linux-kernel@vger.kernel.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-media@vger.kernel.org,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Kees Cook <keescook@chromium.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH][RFC] kernel.h: provide array iterator
Date: Thu, 15 Mar 2018 11:00:50 +0100
Message-Id: <1521108052-26861-1-git-send-email-kieran.bingham@ideasonboard.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594997409535098266?=
X-GMAIL-MSGID: =?utf-8?q?1594997409535098266?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Simplify array iteration with a helper to iterate each entry in an array.
Utilise the existing ARRAY_SIZE macro to identify the length of the array
and pointer arithmetic to process each item as a for loop.

Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
---
 include/linux/kernel.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

The use of static arrays to store data is a common use case throughout the
kernel. Along with that is the obvious need to iterate that data.

In fact there are just shy of 5000 instances of iterating a static array:
	git grep "for .*ARRAY_SIZE" | wc -l
	4943

When working on the UVC driver - I found that I needed to split one such
iteration into two parts, and at the same time felt that this could be
refactored to be cleaner / easier to read. 

I do however worry that this simple short patch might not be desired or could
also be heavily bikeshedded due to it's potential wide spread use (though
perhaps that would be a good thing to have more users) ...  but here it is,
along with an example usage below which is part of a separate series.

The aim is to simplify iteration on static arrays, in the same way that we have
iterators for lists. The use of the ARRAY_SIZE macro, provides all the
protections given by "__must_be_array(arr)" to this macro too.

Regards

Kieran

=============================================================================
Example Usage from a pending UVC development:

+#define for_each_uvc_urb(uvc_urb, uvc_streaming) \
+       for_each_array_element(uvc_urb, uvc_streaming->uvc_urb)
 
 /*
  * Uninitialize isochronous/bulk URBs and free transfer buffers.
  */
 static void uvc_uninit_video(struct uvc_streaming *stream, int free_buffers)
 {
-       struct urb *urb;
-       unsigned int i;
+       struct uvc_urb *uvc_urb;

        uvc_video_stats_stop(stream);

-       for (i = 0; i < UVC_URBS; ++i) {
-               struct uvc_urb *uvc_urb = &stream->uvc_urb[i];
+       for_each_uvc_urb(uvc_urb, stream)
+               usb_kill_urb(uvc_urb->urb);

-               urb = uvc_urb->urb;
-               if (urb == NULL)
-                       continue;
+       flush_workqueue(stream->async_wq);

-               usb_kill_urb(urb);
-               usb_free_urb(urb);
+       for_each_uvc_urb(uvc_urb, stream) {
+               usb_free_urb(uvc_urb->urb);
                uvc_urb->urb = NULL;
        }

        if (free_buffers)
                uvc_free_urb_buffers(stream);
 }
=============================================================================




diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index ce51455e2adf..95d7dae248b7 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -70,6 +70,16 @@
  */
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
 
+/**
+ * for_each_array_element - Iterate all items in an array
+ * @elem: pointer of array type for iteration cursor
+ * @array: array to be iterated
+ */
+#define for_each_array_element(elem, array) \
+	for (elem = &(array)[0]; \
+	     elem < &(array)[ARRAY_SIZE(array)]; \
+	     ++elem)
+
 #define u64_to_user_ptr(x) (		\
 {					\
 	typecheck(u64, x);		\
-- 
2.7.4
