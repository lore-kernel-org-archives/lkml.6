Return-Path: <jhogan@kernel.org>
X-Google-Smtp-Source: AH8x226zdHdE6wCm01v1JyxDqIhvXPut8yhYnZRsh3HSWoQ+i4xzPSyiIIw385L3PdBNg98nb13Z
ARC-Seal: i=1; a=rsa-sha256; t=1519256468; cv=none;
        d=google.com; s=arc-20160816;
        b=T5VNHRxVMAzQlzerhaFHj7eRRi4Y9/wD45ChOXJTu1HYt8cYGC2CIqR2YyTMehEmew
         L2HOLqVxJL47BJqnWxQ+OnMUw1zw7EtPItDnFJ1GCH56ygGsPeHqyhNV8XjYcb02jLFh
         R04xbYPt1Vs3nQeeCOimhwFwtzdgRvG+uwLl+UaDTvGp4cU3MqHbMlBMQFOBKmfnv0OF
         4UqmbfS1Gu+6UP2cU+x73xo/tkH6aowskXFwo/tjypxaBe1E429hK6aNDuZ9xzNRwBin
         Vcl7gwwPz+lPRcx2j9tcsIHnIsO5tOrzqJc5oJYPe7TgCN3yF/zerXn+efqwuYIKoWlc
         B8Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:arc-authentication-results;
        bh=2+TYxW6+QAkyb95bya+7u5gBoEr1/oF7UeFAPN/DPoI=;
        b=SS6hY5rDciEBZUSOlcy6njByOF596fh0fP/jLzYUGug0Hvau4iagOFkroyzwvDmiL5
         ewkSe5RWtyXjllvplT3jAxc2c9nRuAvKR5WsXdDlGAD5KHevnUIc5ZVVgFAYHV/44NXf
         +ND/X0B2/egY7Ocx6MQiO9B0FPsRr49NwMsd3UL3paGckMrgZQEtSihaIYQxxypO5S3A
         5aTZalOSGb8qw4ExZMgax2VgZ82epcyJIOLjS8SOee8ehxdcyX9BVfKM7coO+G6WZEUx
         1F6q4sSMJC6I5q7T39Njlr705zOHtOpr2JsWoaht13YI3377wtY2fSqRKWZOkybLF8ag
         Jptg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jhogan@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jhogan@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jhogan@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jhogan@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA4C6217A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
From: James Hogan <jhogan@kernel.org>
To: linux-metag@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	James Hogan <jhogan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 07/13] tty: Remove metag DA TTY and console driver
Date: Wed, 21 Feb 2018 23:38:19 +0000
Message-Id: <20180221233825.10024-8-jhogan@kernel.org>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180221233825.10024-1-jhogan@kernel.org>
References: <20180221233825.10024-1-jhogan@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593055870586278296?=
X-GMAIL-MSGID: =?utf-8?q?1593055870586278296?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Now that arch/metag/ has been removed, remove the metag DA TTY and
console driver. It is of no value without the architecture code.

Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-metag@vger.kernel.org
---
 drivers/tty/Kconfig    |  13 -
 drivers/tty/Makefile   |   1 -
 drivers/tty/metag_da.c | 665 -------------------------------------------------
 3 files changed, 679 deletions(-)
 delete mode 100644 drivers/tty/metag_da.c

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index b811442c5ce6..75a71ebcb369 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -402,19 +402,6 @@ config GOLDFISH_TTY_EARLY_CONSOLE
 	default y if GOLDFISH_TTY=y
 	select SERIAL_EARLYCON
 
-config DA_TTY
-	bool "DA TTY"
-	depends on METAG_DA
-	select SERIAL_NONSTANDARD
-	help
-	  This enables a TTY on a Dash channel.
-
-config DA_CONSOLE
-	bool "DA Console"
-	depends on DA_TTY
-	help
-	  This enables a console on a Dash channel.
-
 config MIPS_EJTAG_FDC_TTY
 	bool "MIPS EJTAG Fast Debug Channel TTY"
 	depends on MIPS_CDMM
diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
index 8ce3a8661b31..47c71f43a397 100644
--- a/drivers/tty/Makefile
+++ b/drivers/tty/Makefile
@@ -32,7 +32,6 @@ obj-$(CONFIG_SYNCLINKMP)	+= synclinkmp.o
 obj-$(CONFIG_SYNCLINK)		+= synclink.o
 obj-$(CONFIG_PPC_EPAPR_HV_BYTECHAN) += ehv_bytechan.o
 obj-$(CONFIG_GOLDFISH_TTY)	+= goldfish.o
-obj-$(CONFIG_DA_TTY)		+= metag_da.o
 obj-$(CONFIG_MIPS_EJTAG_FDC_TTY) += mips_ejtag_fdc.o
 obj-$(CONFIG_VCC)		+= vcc.o
 
diff --git a/drivers/tty/metag_da.c b/drivers/tty/metag_da.c
deleted file mode 100644
index 99eaed4b2dbc..000000000000
-- 
2.13.6
