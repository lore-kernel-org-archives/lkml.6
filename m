Return-Path: <heikki.krogerus@linux.intel.com>
X-Google-Smtp-Source: AG47ELtgj7hlq+a03vE4Kx9HINi+f5DvX8l8w37kGR9cK+0ZuU4DvfBryG3QIdhvvUc0iqdLl+4z
ARC-Seal: i=1; a=rsa-sha256; t=1520865300; cv=none;
        d=google.com; s=arc-20160816;
        b=V0VvwbL2I2MWjTIauF7igJc1p9pqm+MUsHWW+REr+M7LEXUTgdcLyhSD3rK/5sGNhZ
         1jpW1jdi4kpyNnvL3mgWGGmNXzriVQ1km4bdL4QtctegLx5FGvwfTfAn7xdJJuzZirC4
         ucGGb8Ts+e0AsGeO4Ln5T7bwcBCXuShpO9Yt/2Oz3Xk+DuDRfNKbdY22nkX4EXbrrELx
         PExVzVtsRMIKAEZCACXnpF1miilIrSs85xkby4vqv6D6PIGChSK7k/zUXp+P7NwxGNMW
         jqDteNPprc4yUtfttWZ9XZ/CO4kxMXQOl4mC9B/GkukJyYWFABQqSgOsikNLX7pUthQt
         cbpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=BQXu4PO5OSZSChgfTGjodjx43dT8usLASxkUwoDGIR8=;
        b=c20P8BeDdHURMxneleOxeBJ5r/3ugwr2+AW9Ffaoanh0tCee0c2Eqcxcyl3+XrkZGs
         2/tG0+l5mat43hudE/5He+96BI+SNaivRRRU5P0s+mvLddLKwL93Pm39gAyZPpLmnTsF
         g5OG86IezOF7zOYu5u2CqW4wKEgcP8a4DqtZXUXxtKi17Achv+pRXoKreUqp9ToObP+A
         K3h7V+LbI+D3Oo54fwoJyr3TR/HxDdidBv+r9BdcQe9C2ckRNspaI1rxbfIZWcnVTppk
         6tOjky9IR9okqWGh5lrVjzOdNuxSeTR2Wibzkh2sRYd6wcH765Zh7XDfwedAi5yj1D5W
         7Qjg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,461,1515484800";
   d="scan'208";a="37470897"
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>,
	Andy Shevchenko <andy@infradead.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jun Li <jun.li@nxp.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH v7 07/12] xhci: Add option to get next extended capability in list by passing id = 0
Date: Mon, 12 Mar 2018 17:34:26 +0300
Message-Id: <20180312143431.82396-8-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180312143431.82396-1-heikki.krogerus@linux.intel.com>
References: <20180312143431.82396-1-heikki.krogerus@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594742853185184818?=
X-GMAIL-MSGID: =?utf-8?q?1594742853185184818?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mathias Nyman <mathias.nyman@linux.intel.com>

Modify xhci_find_next_ext_cap(base, offset, id) to return the next
capability offset if 0 is passed for id. Otherwise it will behave as
previously and return the offset of the next capability with matching id

capability id 0 is not used by xHCI (reserved)

This is useful when we want to loop through all capabilities.

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Revieved-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
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
2.16.1
