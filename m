Return-Path: <hdegoede@redhat.com>
X-Google-Smtp-Source: AH8x225AbsiR8CS+CbdG11JBTxGV+Aev9qegmA+8dWzEz5Q9wEqKXYm0iigmr28l7fN3pLH+ZjJa
ARC-Seal: i=1; a=rsa-sha256; t=1518778086; cv=none;
        d=google.com; s=arc-20160816;
        b=MsydpM4yNjDsWRBOKSztg+mBcb4fxRssCV0hLK3aDZ0s0ss6BFzRDPK1eXvkZDJ9Nz
         rG19Thj4uzSN99S/3z7hRw+gMZNGkBruHdGUM5lD7Qd3pgkGLDKoQQ/1c96g37dJKagW
         NMK62XQxJOOnRZyd3Rr+0wxxh2D/abPH+mUnE1er4CEa0hNrAYPahUD9DWFYLyGsiqrQ
         RWgC+sgGjrjdX1fROQ0nElYlvs3dpaKTPkszbUQrVePDX1/Spu6laBepJU/Vkkq7p6Bt
         RSqfsZ6CLtM2pMCK5ZapLrEvrY+q+KchBf9LO7ur7eBiOCNWqLRHAzMQepnh+Awf9cyQ
         gxAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=IEs9/fFvSvy639G8ZbpnuPVQlg0YllpmBQqXY7km3i8=;
        b=shdhN2xd5x0IfFi6mPKzSEfFB2HwXwqIfc3DvtKn4+0dwe1yJI2S3goWp7OYGSDYem
         qdXZJoIE48qHrR1xjvgVJ2Cf4YaFnhicJcbAj3DUcjcNZ3U3YteUVqYSYN6Vuiow6I6d
         OEefD7xVU3fsgAO5zgTxx6RM6zg7DqFUDamPn48ni8RB7XYFxxSKG6wkl9Qlm6VQrY7h
         v4ZCe/p+oeVDvdkz9x/MU3W4ugQ5+uZ8Ra+C1Z7RWj85Zwc4UzdrP+zMveo4ECgW6vJo
         TdDCQ1//xve2zNty+HVKWzipNx3gdbR5IjKM6ugOJIYzsnFLXebdRZ1Ni9LCZPFRnxSJ
         iTtg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
From: Hans de Goede <hdegoede@redhat.com>
To: Darren Hart <dvhart@infradead.org>,
	Andy Shevchenko <andy@infradead.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 07/12] xhci: Add option to get next extended capability in list by passing id = 0
Date: Fri, 16 Feb 2018 11:47:46 +0100
Message-Id: <20180216104751.8371-8-hdegoede@redhat.com>
In-Reply-To: <20180216104751.8371-1-hdegoede@redhat.com>
References: <20180216104751.8371-1-hdegoede@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592554250822701794?=
X-GMAIL-MSGID: =?utf-8?q?1592554250822701794?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mathias Nyman <mathias.nyman@linux.intel.com>

Modify xhci_find_next_ext_cap(base, offset, id) to return the next
capability offset if 0 is passed for id. Otherwise it will behave as
previously and return the offset of the next capability with matching id

capability id 0 is not used by xhci (reserved)

This is useful when we want to loop through all capabilities.

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/usb/host/xhci-ext-caps.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-ext-caps.h b/drivers/usb/host/xhci-ext-caps.h
index bf7316e130d3..631e7cc62604 100644
--- a/drivers/usb/host/xhci-ext-caps.h
+++ b/drivers/usb/host/xhci-ext-caps.h
@@ -84,7 +84,8 @@
  * @base	PCI MMIO registers base address.
  * @start	address at which to start looking, (0 or HCC_PARAMS to start at
  *		beginning of list)
- * @id		Extended capability ID to search for.
+ * @id		Extended capability ID to search for, or 0 for the next
+ *		capability
  *
  * Returns the offset of the next matching extended capability structure.
  * Some capabilities can occur several times, e.g., the XHCI_EXT_CAPS_PROTOCOL,
@@ -110,7 +111,7 @@ static inline int xhci_find_next_ext_cap(void __iomem *base, u32 start, int id)
 		val = readl(base + offset);
 		if (val == ~0)
 			return 0;
-		if (XHCI_EXT_CAPS_ID(val) == id && offset != start)
+		if (offset != start && (id == 0 || XHCI_EXT_CAPS_ID(val) == id))
 			return offset;
 
 		next = XHCI_EXT_CAPS_NEXT(val);
-- 
2.14.3
