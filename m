Return-Path: <joel.stan@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518419364; cv=none;
        d=google.com; s=arc-20160816;
        b=J1zhLIlAqOlHFjh+u8ZJ1SQAHXTanczZjNscFNhyO+1CNXIYOLaQYDChqzxI/fZgcl
         XAASBHdRAMD2QGmvGYkvnmBLEaiotycyk+eSl1VJks2YiR+HvHOMX1VrArhbASxdsRaY
         cYDBBsaTABMb1rGf50W6ZFjoq3yFS/ahLGOlyDcT5LOTmebBYFJPC0tqDjw4mtXz6d1c
         34e8cVMiGG2Uh37DdPxi20d4C0iyuqERcNfYEgtWu1gU+ELFVwWM+mcaES9uSS0U2Z3T
         xQUM3pBcebEuf25/qrQ/Lx41QWn2O7AT2zkDhuRh4Y5CBINuU4WM8FxD8tBkMzD4JfkN
         YGxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :dkim-signature:arc-authentication-results;
        bh=+UnUovVBeP3OPX99eGGjysHXPyKEeVfZbA2KOoeGXvQ=;
        b=aUVfiapdQwxZq4vFKFkvSY3onk0M5eDVkGeIf4GbNCTllrvYFC4UwFGlPb7JZP5hnJ
         V5R2MRkQxfke1/vMM8BFPs7/Te7J0ZxRbYukUUmzF4VKMHItFMRJWWueHZjfImqL/oHQ
         ccIjxi+OFZEw8zXdHJ04vH+GUeLE9lweIO3BOY5qwx7HAh/sQP7l/UiwInJk+zuOJ8Zb
         n7LV65xus9LCx/nc1aCTva+G6SvzQx0UUJ12LQ+atgkw1OHoZXftCoFWtnS6xKsIbxdM
         GM+PtEIA3wQWR0TJgAblaZex7711q++NU9C4g4ho3zJnevf7cfOh3Oi6XsVo+mPsUkfb
         BkrA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=bWwEXbfD;
       spf=pass (google.com: domain of joel.stan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joel.stan@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=bWwEXbfD;
       spf=pass (google.com: domain of joel.stan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joel.stan@gmail.com
X-Google-Smtp-Source: AH8x2247EviiIxGJtH6jnzqSXv3tVa4zIDwLE/OPx59C2tEWapwIfyvsGtNAc0Hyx+DwZYkxZC4XMQ==
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
To: Lee Jones <lee.jones@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Jeffery <andrew@aj.id.au>,
	Cyril Bur <cyrilbur@gmail.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Lei YU <mine260309@gmail.com>
Subject: [PATCH 3/3] misc: aspeed-lpc-ctrl: Enable FWH and A2H bridge cycles
Date: Mon, 12 Feb 2018 17:38:47 +1030
Message-Id: <20180212070847.32387-4-joel@jms.id.au>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180212070847.32387-1-joel@jms.id.au>
References: <20180212070847.32387-1-joel@jms.id.au>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592178104146690344?=
X-GMAIL-MSGID: =?utf-8?q?1592178104146690344?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

To date this driver has relied on prevous state from out of tree hacks
and vendor u-boot trees in order to have the host be able to access
data over the LPC bus.

Now we explicitly enable the AHB to LPC bridge and FWH cycles from when
the user first configures the address to map. We chose to do this then,
as before that time there is no way for the kernel to know where it is
safe to point the LPC window.

Tested-by: Lei YU <mine260309@gmail.com>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/misc/aspeed-lpc-ctrl.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/aspeed-lpc-ctrl.c b/drivers/misc/aspeed-lpc-ctrl.c
index 1827b7aa6674..a024f8042259 100644
--- a/drivers/misc/aspeed-lpc-ctrl.c
+++ b/drivers/misc/aspeed-lpc-ctrl.c
@@ -21,6 +21,10 @@
 
 #define DEVICE_NAME	"aspeed-lpc-ctrl"
 
+#define HICR5 0x0
+#define HICR5_ENL2H	BIT(8)
+#define HICR5_ENFWH	BIT(10)
+
 #define HICR7 0x8
 #define HICR8 0xc
 
@@ -155,8 +159,18 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, unsigned int cmd,
 		if (rc)
 			return rc;
 
-		return regmap_write(lpc_ctrl->regmap, HICR8,
-			(~(map.size - 1)) | ((map.size >> 16) - 1));
+		rc = regmap_write(lpc_ctrl->regmap, HICR8,
+				(~(map.size - 1)) | ((map.size >> 16) - 1));
+		if (rc)
+			return rc;
+
+		/*
+		 * Enable LPC FHW cycles. This is required for the host to
+		 * access the regions specified.
+		 */
+		return regmap_update_bits(lpc_ctrl->regmap, HICR5,
+				HICR5_ENFWH | HICR5_ENL2H,
+				HICR5_ENFWH | HICR5_ENL2H);
 	}
 
 	return -EINVAL;
-- 
2.15.1
