Return-Path: <hdegoede@redhat.com>
X-Google-Smtp-Source: AG47ELsMjz20XdXg9/0Rg59ohRAHW3EM8FbGYcxhj4xcH19D6bBRI+Usr/xf2Nkdp4ZYcnkv4weo
ARC-Seal: i=1; a=rsa-sha256; t=1519636183; cv=none;
        d=google.com; s=arc-20160816;
        b=nqs9sy9F1Q88WpEurDyzWb2wb9l2RGe7sO7BaMzFpu7qgERy74iwc2UkzEvj0Nl5Tx
         TJFV6P3dWwiABZrG1qgKyN7RTFq7ZQuiRIOY3xN4D0eWasptyW2fMKAkTFz5xBEF9K13
         pCRoV8svGbEm+Ja5cNs08i6szTh+N4myhf5CDM2gR9q6OgGLb3QqwPU2BBaBPwvf86eE
         5rwdl1NUElz7xENtNmzJvW+2njg9A24ZipXJcwISisVCjy42dGwZt091Tn+RooMiP06h
         XHlRZjGuqaydJS3+zeJrGECk/lrV/Kbj49703rUueNfOD1TQ5t73+NyPb/kZk/w4Yytk
         YOag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=EYSwN5e+Z7nb8ug1n57YFQMu2U/rRVopiK9ddZbDKvE=;
        b=Nx/aaf1n7uuj3HHNFgi1bCW+qxsKHhWmixKLBjEk19UDDxATNuw6cgbkqztxVLYfCr
         H6LCdJFckvxJJd/ngsq/+myxtk00FgeCCTxox+dbyagI+BKuBSWKf4FDx5lX1SzBp940
         3CBmoMMSNyUVABP6tYnE5fgCHmMxbFfyn+rnxTOZy7/3vphvzvu6C8Ye+5HJfXiFkCE/
         EFHhbrwmFnGrmrxB18ki9dPeh3dWcEqPUXVG3vBvNv0MPrHbVFu5TVjrHpXoNl/t0InP
         vuFF8GRf1VTfw9IeK568DMesUcaNHO8tg/+XK2QMW7SRutyTv7wpdDQcjjdrDx+44Bh0
         Aj7g==
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH v3 07/12] xhci: Add option to get next extended capability in list by passing id = 0
Date: Mon, 26 Feb 2018 10:09:20 +0100
Message-Id: <20180226090925.29436-8-hdegoede@redhat.com>
In-Reply-To: <20180226090925.29436-1-hdegoede@redhat.com>
References: <20180226090925.29436-1-hdegoede@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593454030458653630?=
X-GMAIL-MSGID: =?utf-8?q?1593454030458653630?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mathias Nyman <mathias.nyman@linux.intel.com>

Modify xhci_find_next_ext_cap(base, offset, id) to return the next
capability offset if 0 is passed for id. Otherwise it will behave as
previously and return the offset of the next capability with matching id

capability id 0 is not used by xHCI (reserved)

This is useful when we want to loop through all capabilities.

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Added Heikki's Reviewed-by
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
