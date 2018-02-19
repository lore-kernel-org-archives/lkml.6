Return-Path: <joel.stan@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519025107; cv=none;
        d=google.com; s=arc-20160816;
        b=oY66Tti8s5ZFv9r8b44rtGMQ7UItKru12wlY9wPWNyqJV0sZ1LFaiQMMh7Wd9lGuoi
         GuAegplDm/eyWBABstWExy+DCe9wusLAxGXEWKVjsYSGfpTFMhovl5DhfxxOXdbG6TBs
         V9XmFyDDTSq0MF5oBovLh8RDq9LYyVVvAAVqplNQTa1DpOdpXEdeY8Gq3c/27oidGOl9
         blzz2UxvY78nnG/+sTXI+IyFF90srBCXtTH35snfEgPO5dLesSAu2wmtAHF9X2pNFEvG
         bGilVnkEs70jAXInvFn1m3BzMzFrm0SaIVe8PxR5F5VvF4ndGIF5SnpcJjwVFku28FYi
         EkzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :dkim-signature:arc-authentication-results;
        bh=0+y23RNN9DiEUUahCXyZcFMFudK8X0KhRebf3LNpKXs=;
        b=GaiGXYFj/etRbo03DZzqoYYNUZhpRIOKuOiyh+zgfXx5FUDjzCtZNGWCyUItYibfAT
         +Q83O8yzgb8CZwGVY4xEwMK5KoNZ3BFjCpzNar5DXgn2Qd2wXI6wH7YtwpODhXHhF879
         Zd9/3m9UeWuqZpF7typS69ydyVtfRBndL9oEOuI7dAFUvBORTsIQuGMo4r3jmzMjrdgu
         AQRUcBrzDV1Ktj+2V3KhMXLwGpbZYer4NdRpg4tqYhGZ8LMq9eWkg8p/qoYGi0kQwVqZ
         SXVa4KzXEXqyL7LoPI+cejJU2tW9tlEzPYLjOKdSR6yKcPlgMfYzF8Q62OgTMR9zaf0e
         vzng==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=mhAxtisp;
       spf=pass (google.com: domain of joel.stan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joel.stan@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=mhAxtisp;
       spf=pass (google.com: domain of joel.stan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joel.stan@gmail.com
X-Google-Smtp-Source: AH8x227sO62QOTxQVr7DmAVxCilT1blfaa9YGaqNsaNFF8Rf372StQvFvBdSBbP6HZ0sW2139agDQA==
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
To: Lee Jones <lee.jones@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Jeffery <andrew@aj.id.au>,
	Cyril Bur <cyrilbur@gmail.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Lei YU <mine260309@gmail.com>
Subject: [PATCH v2 3/3] misc: aspeed-lpc-ctrl: Enable FWH and A2H bridge cycles
Date: Mon, 19 Feb 2018 17:54:22 +1030
Message-Id: <20180219072422.22733-4-joel@jms.id.au>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180219072422.22733-1-joel@jms.id.au>
References: <20180219072422.22733-1-joel@jms.id.au>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592813270854938491?=
X-GMAIL-MSGID: =?utf-8?q?1592813270854938491?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

To date this driver has relied on prevous state from out of tree hacks
and vendor u-boot trees in order to have the host be able to access
data over the LPC bus.

Now we explicitly enable the AHB to LPC bridge and FWH cycles from when
the user first configures the address to map. We chose to do this then
as before that time there is no way for the kernel to know where it is
safe to point the LPC window.

Tested-by: Lei YU <mine260309@gmail.com>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Cyril Bur <cyrilbur@gmail.com>
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
