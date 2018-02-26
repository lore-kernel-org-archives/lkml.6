Return-Path: <hdegoede@redhat.com>
X-Google-Smtp-Source: AG47ELtR+Eb+QT1tnNLmiJJd9z8KJwJybIVMp4RfLvrRdYapEvwQOVUpRxgT+nZTawy1An9dvLHi
ARC-Seal: i=1; a=rsa-sha256; t=1519670377; cv=none;
        d=google.com; s=arc-20160816;
        b=CMiLxYNnVGQfV539Ba2y/9/tuOyRL0s5nD8cHzkrYA87M13rIZPGpzLIL6Gv+UamMq
         Ul+OZwxoJVvZyLo4haJ30zO+Kljm25KtFyAwuXJYGm9VsUK4mw43RqviIE2HmroFkg5W
         ZHYvwo7YoE8AP29JpbGXfuknkQGq62kEK2VAqwcKEpvZYxGyedNse60li/hH1ign/TyL
         E2vZ3L5k2zecgcJ0tUQZw93YRejNm04nWSOsZeoDvmNlyi213bwTW+NuaPeiLpmPny/Z
         uCXhGGdA9P0I7IGulfPjQGU5axP7clo6FwAL+RyYGDWfxfH2HcFqvMqyt4FY+BHCyDIV
         Rm3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=mKozk9X4pi3dFdMPl4RHm1NR4uEle2VSh9rKn+MrywM=;
        b=unKRdVuws2wPeGxZXyAvbVaU6AVWbecWUkhFCEc/wLN0dD7guzDj+Pf+i9AKwLEc78
         xSuMfLub0DyygTeLnTkuBf3p3shnLZ2eKuBa2gDJQrzatEZbhoE51nnEk4kbOfZcFssw
         kq0/mmT6qvosVsIHwSbYpnsWciXUqenl027S2Zgm6c3bGfkO9j5d2gy62SoMPfyUvIFX
         +AGi/fFft4imfUwSCwDExUcv3HnYz7jJLLBVM1E1aySZRy6aQpnJvIrhbbtaIodhKmEM
         7uO+KU37napf7/y+1oL/0/Xy4WbWbTknf6uMMro7vQiKUpD+sgdQ+xf5ndd5U950eYco
         3EZA==
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
Subject: [PATCH v4 07/12] xhci: Add option to get next extended capability in list by passing id = 0
Date: Mon, 26 Feb 2018 19:39:14 +0100
Message-Id: <20180226183919.24353-8-hdegoede@redhat.com>
In-Reply-To: <20180226183919.24353-1-hdegoede@redhat.com>
References: <20180226183919.24353-1-hdegoede@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593454030458653630?=
X-GMAIL-MSGID: =?utf-8?q?1593489885315466194?=
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
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v4:
-Add Andy's Reviewed-by

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
