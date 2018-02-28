Return-Path: <hdegoede@redhat.com>
X-Google-Smtp-Source: AG47ELvx5G4b1YMmo0iGrfsc6BV6v9fo6JvpcFq1RIZnu0wyUpuxOUujktZhAPeCpzKpZBwqk73G
ARC-Seal: i=1; a=rsa-sha256; t=1519830490; cv=none;
        d=google.com; s=arc-20160816;
        b=eurtup4loDM02M+F7WSZIfwvwF1xANKnRFhIye8nLmVIDGDL7iEOELG5LB0LyE/ziH
         7YE4Rtd6N9rbEpALikFTEZ3t4DcVVufCGRhoUXbD7fY09DmQvKdLdJ6aZJkgENGvTiJE
         OjjaUsFZ4wXXpkOfBAOz/qpMPUIUzmzoSfcZLNaOAo0ZkicvrdiQeQohJDv29u/ecuGP
         02A3uhGucUoHQJXBDL5utRTYEz8szqT7rtngjeAbNWXx8n+tj8V9gNyWuYarG/BCb9Fs
         o+JVAks8HfSL5mfxAGbqxt4qdoKrBTDEgd/+5+lSDjTYsmfGWojvid1CcMc3rzwukv1w
         3NQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=mKozk9X4pi3dFdMPl4RHm1NR4uEle2VSh9rKn+MrywM=;
        b=rAg2+fp8rDZXFXXu2GiT0AbBlr7ps4ODqGrTtiJmFD+drfiXLMkHGx45Asac5bCUxe
         RN0wVQd45aYkGNUYtDghNQdUYV1Rgw/IlJ9/FRTEj+NXvMk7owV58G5AfK4CL4loaPLD
         xIn9b4Mfp16rMmRiYFknMiEUJ2UXrrdCjyNMWCrmIq/lF0Jc9WgG8VSvjdktbaoQEXIt
         eVG2L+R1ZjedcjEDBC1ooC9xoG0EZA0sWWryC64E/K/hB7BwtH2DIWPbAsZS7zLCG3Rl
         92FQtodZnPloDDeTJNFsBsjsCHLTriXqB4G+jnsxKsWYt0pbXyC6b6WGsgNP4TcfCBO2
         /fAQ==
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
Subject: [PATCH v5 07/12] xhci: Add option to get next extended capability in list by passing id = 0
Date: Wed, 28 Feb 2018 16:07:44 +0100
Message-Id: <20180228150749.26831-8-hdegoede@redhat.com>
In-Reply-To: <20180228150749.26831-1-hdegoede@redhat.com>
References: <20180228150749.26831-1-hdegoede@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593657775858829166?=
X-GMAIL-MSGID: =?utf-8?q?1593657775858829166?=
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
