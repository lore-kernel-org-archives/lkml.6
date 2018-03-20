Return-Path: <heikki.krogerus@linux.intel.com>
X-Google-Smtp-Source: AG47ELuHAfS+4azWO43WQ9UmPTvq+dTm/iN4HFRurZmXQl+JQomWVZOW08SZwTcUwpcG7MUdHEn0
ARC-Seal: i=1; a=rsa-sha256; t=1521550662; cv=none;
        d=google.com; s=arc-20160816;
        b=cJGbGd6kmpUEFHQnpQJsw3N/BTizavKKUrjLEBynFK7nJkboUyVRAcNJUzcrXEnC54
         W8ZHmP8+IbEfLcO2dN6/looiGgQTaJRxNawrSTk0WW/7OxLp2VfFyHrlcaPoOqvxsOrc
         dVJ7oVlDMpL39MzCRb7kU5fdCb2e5WdQZ/UGYKXeLJfQGofWAb7AkiMNn0elk7sG9znc
         7OTrDEaSq4Twaed9HkDcquEk9YO1rRBEJhTOAHPWxcI2m9bR9x1Sx85jy8OjRPfmV+v+
         vLYyV518CajvfeJFFXeK7VmTYaoX/CraYQOifQrne47pcoBbHp0AyFcjkp+NCJILX60X
         m3Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=PyI8vAxpnnlKC0yu5aIxWpjeuz3Q+CDu8S+ZmsP4qko=;
        b=PxtyRK+4ntAMHLZYyZkpHXEZu0l/lGgnstmiNVMCEeyeehsgn7ufhxl9clWWQ9b+ey
         wO5Iv2gsFUGeZQaT/YIVwJRQnKPA+UeNFr+1dIzUP3oGPoq8clSA21tJbmeLnR8QssIv
         NSnhek9vW1+121Vb2prAEZscFnfeyxYc0AtSTcJVPFcK9o348jzute3LdNKzJLGaMpu/
         K0hTZtx+dUX1HBriMKKWTTUV/lOyIDLtsq3FUlKocrRjL8v4Gazw9IGtr2qtOO6FBJ74
         SyxAt1W4FxN0Y1rWTX3EA9bBhvIFJRAUGvgAiz2zd/g7TXf0nsHVExAbDKcLFBuWHHPX
         bkUw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,335,1517904000";
   d="scan'208";a="39592561"
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
Subject: [PATCH v9 07/12] xhci: Add option to get next extended capability in list by passing id = 0
Date: Tue, 20 Mar 2018 15:57:08 +0300
Message-Id: <20180320125713.85465-8-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180320125713.85465-1-heikki.krogerus@linux.intel.com>
References: <20180320125713.85465-1-heikki.krogerus@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595461507272547974?=
X-GMAIL-MSGID: =?utf-8?q?1595461507272547974?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mathias Nyman <mathias.nyman@linux.intel.com>

Modify xhci_find_next_ext_cap(base, offset, id) to return the next
capability offset if 0 is passed for id. Otherwise it will behave as
previously and return the offset of the next capability with matching id

capability id 0 is not used by xHCI (reserved)

This is useful when we want to loop through all capabilities.

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
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
2.16.2
