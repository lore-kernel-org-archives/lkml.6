Return-Path: <hdegoede@redhat.com>
X-Google-Smtp-Source: AG47ELvTGouVoq3tfwk0y0ouKqZODWmt2uD5rxetu4zOXWGl1lLuWRJNGp6smxyBaXNA8tP6OF3s
ARC-Seal: i=1; a=rsa-sha256; t=1519986074; cv=none;
        d=google.com; s=arc-20160816;
        b=UTqS8RhWI+fRUdmC1L/zJS3KqvUHVRBh9DP8HljAOCC25ZFhUwKQmGakA2y1r6KbJF
         Aw7rrc9EeN/o2F+U5VHBp7laF1BV+V5YpFFjZjVWJeYGCpOq+t/pDVTdI4/shF/2m43R
         RlKhVDt1EBhm48pZ7xRdsKmpenIht+IqQwSIkTlYES/RNqCdEU7PenxdpFDK8rFBCgv3
         VBLAtdQLx+u8yGCAiJljG2/ueQ1pfwFbZcymOACNHT26yj9X32FG+bet81U3jJJ+Zy58
         RPuOEIIcKxNCM3HLIK9/4SA2aAeOGER3CU7xx5E33zXgpy8moMkeYiOU2b7qzcvhuWTb
         tn8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=mKozk9X4pi3dFdMPl4RHm1NR4uEle2VSh9rKn+MrywM=;
        b=J4H1Z6MP+u0PkPE7Ia8Zfew34m5D8SXlmit3Gzypio/u3gtjFCSkdKSTwkG3LG1pKi
         y3F+QU+0XET2loz9cFS9NLZlQCn/nok/07gKX6O/I7nXsqlJOABzQBw1pDN3Q9pVnTr6
         pQradaItWTmbiG2y2o6/PU8whQEanzsOrcjKX6Iz7qRxbWCY2gh75yz74hw/7CEIAHKO
         fWBfUsDa2cYvBkP9KsBlcNNphc+i1Jj/CPYhBAy+PynuKdlwzZxby9U1zvsSRPIAp1Ij
         TFEtskmOVtHGSVTfkqWIrmvfJLyy+653535CNUDW9VTimUnoeGX4IhD3ZOCOiUT3VtvJ
         OhTw==
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH v6 07/12] xhci: Add option to get next extended capability in list by passing id = 0
Date: Fri,  2 Mar 2018 11:20:52 +0100
Message-Id: <20180302102057.8917-8-hdegoede@redhat.com>
In-Reply-To: <20180302102057.8917-1-hdegoede@redhat.com>
References: <20180302102057.8917-1-hdegoede@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593820918091686911?=
X-GMAIL-MSGID: =?utf-8?q?1593820918091686911?=
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
