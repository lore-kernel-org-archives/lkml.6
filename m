Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELs1Os5M0UnhMfomSDS9G+uD++b27H628zd6oNaww5CokshidUu4ejxXGuhI/dIAy0WLfnzL
ARC-Seal: i=1; a=rsa-sha256; t=1519833858; cv=none;
        d=google.com; s=arc-20160816;
        b=F3vz1qrqsZYbumcJAg9sEW7/GjzNvi3VlFnL9Fsgz6ut/jCBI4hhT2oEy2bE85nJyC
         ht69ea7iP+Tfx86EX/Yn3ea6tKOJ59sEKfe/lBXJtEEpznHFvKDKSru1oAAs43D67XSS
         NGfTgTgHKdFob4va4KeaLMSnhfTM4xfGgIJnHUguH3uuLV8v24xRjvfSRbAKxCk6zpsg
         dOopltHRZaGq88yn2PAjMOAanbGvK46UHdYXd7+Id0vcYsBUuOTue7fJ1qk2nhdvRzHt
         8hTI/i3Qk7gMBKUDP4OjU7a/N5C/rYOjLK7isxJOCyr8v5BMRST8deYEvTIepyugsWZV
         lNKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=zpuAxsHtSQJ/XA44kSmDw2BYtMQrGKIqZf932ilgMVM=;
        b=kQrwH4ZnMPEAkHOQRbojgiUaSmkqWJJeLQbH5v/L+GeIgGB9bKNX0Ilkpbprbt7x3m
         A2t1DTWov7ehakAvpcGj5jEw2lUarWIuYP9szMQj92HY4EsMSSZXPDKtB5iW53RNjXmV
         qP5A6QDzjwmjqu0RHb489Lrasw4MJo1EXlwuRjur09uXHm26ON43r2HLWZhBD2QDQt3W
         LLX5nrE9Ygb5PK3D0XP0QLhlE+gTWXbofWVioraa7FCVBaba9OHWNy+v7KFN1YnqEkF1
         OnNQ9ygFFec+YlkV+/uQ4zz3hw0phgmnSvrW/A39WsrSRb+qRF7I2tZ0vUE7K7R4tfuE
         SSJQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Mathias Nyman" <mathias.nyman@linux.intel.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.520216187@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 081/254] xhci: Don't add a virt_dev to the devs array
 before it's fully allocated
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593658666539369196?=
X-GMAIL-MSGID: =?utf-8?q?1593661307013424572?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Mathias Nyman <mathias.nyman@linux.intel.com>

commit 5d9b70f7d52eb14bb37861c663bae44de9521c35 upstream.

Avoid null pointer dereference if some function is walking through the
devs array accessing members of a new virt_dev that is mid allocation.

Add the virt_dev to xhci->devs[i] _after_ the virt_device and all its
members are properly allocated.

issue found by KASAN: null-ptr-deref in xhci_find_slot_id_by_port

"Quick analysis suggests that xhci_alloc_virt_device() is not mutex
protected. If so, there is a time frame where xhci->devs[slot_id] is set
but not fully initialized. Specifically, xhci->devs[i]->udev can be NULL."

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: There is an extra failure path, so we may need to
 free dev->eps[0].ring] 
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -1018,10 +1018,9 @@ int xhci_alloc_virt_device(struct xhci_h
 		return 0;
 	}
 
-	xhci->devs[slot_id] = kzalloc(sizeof(*xhci->devs[slot_id]), flags);
-	if (!xhci->devs[slot_id])
+	dev = kzalloc(sizeof(*dev), flags);
+	if (!dev)
 		return 0;
-	dev = xhci->devs[slot_id];
 
 	/* Allocate the (output) device context that will be used in the HC. */
 	dev->out_ctx = xhci_alloc_container_ctx(xhci, XHCI_CTX_TYPE_DEVICE, flags);
@@ -1069,9 +1068,19 @@ int xhci_alloc_virt_device(struct xhci_h
 		 &xhci->dcbaa->dev_context_ptrs[slot_id],
 		 le64_to_cpu(xhci->dcbaa->dev_context_ptrs[slot_id]));
 
+	xhci->devs[slot_id] = dev;
+
 	return 1;
 fail:
-	xhci_free_virt_device(xhci, slot_id);
+
+	if (dev->eps[0].ring)
+		xhci_ring_free(xhci, dev->eps[0].ring);
+	if (dev->in_ctx)
+		xhci_free_container_ctx(xhci, dev->in_ctx);
+	if (dev->out_ctx)
+		xhci_free_container_ctx(xhci, dev->out_ctx);
+	kfree(dev);
+
 	return 0;
 }
 
