Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELvtRj6ahRBwH+R482iPbMax59/gRkFve/zbnyCiooGI8rl/lClyPSwMc/IXUVNtFTN+/YXj
ARC-Seal: i=1; a=rsa-sha256; t=1519831339; cv=none;
        d=google.com; s=arc-20160816;
        b=dL6qax3z56rsg5hN7nAUvBbOj0q/JmoWXziByPAEotEQO9sLGsC0xF+iXnE+kO7LXN
         Aa09ehz3yz5x0id5WruWo00OjhdYKPBaMwR5YosqdL2CfVMHRWUalzcd76fSkcC4DRui
         1cIxB9Jtfm7b3yUA60wJKSdQVzUUK5auTXC4fa3uI5VBGyaxvOx1Co3E41hPexeBU5Fd
         a9WSusF1TbQ5/jNRM3pnzDKERHqyg0D79sulCFXOf5EvCkevAJGD4RCkX2UI5HRkDPPH
         gItgR25zQDRDQAmyCMq+i8YyebV7OZXgtKKb0Jypsdg8UGxPXkO7fFbwL7Wpcg7clkuX
         OZpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=BFDx7kOwTlnYdl/K2bCcF4E0DXAsolOYCq7v0JAl0Dw=;
        b=Vx6OR0CAyys8h0ZCeDfAcROSEdtFkXiWOfr9SZECk8FegwVZr/jjrhT9KEUadi2PL4
         sUmj8dN64Qa6gqAHl+5MctJJl0AcHIEHDhsQLL1fYlmtx0IztBhQKBnFfMhjqu2RjCzW
         OLVPOj8CYwgunKMozsTEFunZf3zvYatlqFXK2ZgvmWdX6rmKk5t/Mog5H8q/fXlrb/ly
         9WawpA0jajlA5U6uBVVD741OHgh+Lm3UHo/RqWVeFNYb6Xq+l0YB7RLGRs99EF/Q7mTr
         73I4YmY6dVodvb8Ixhn71pnjqp5Y11vuQT2n6OSAy9pzxUTEsWSrL2kooHtOvex8ogVw
         ateg==
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
 "Mathias Nyman" <mathias.nyman@linux.intel.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.196117579@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 038/140] xhci: Don't add a virt_dev to the devs array
 before it's fully allocated
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593658666539369196?=
X-GMAIL-MSGID: =?utf-8?q?1593658666539369196?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.2: There is an extra failure path, so we may need to
 free dev->eps[0].ring] 
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -873,10 +873,9 @@ int xhci_alloc_virt_device(struct xhci_h
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
@@ -925,9 +924,19 @@ int xhci_alloc_virt_device(struct xhci_h
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
 
