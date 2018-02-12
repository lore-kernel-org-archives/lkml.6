Return-Path: <joel.stan@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518412592; cv=none;
        d=google.com; s=arc-20160816;
        b=Pn0YzzAvmBa6oRmW8lqVq1p0e5vMGTPukk9gi3rONjfIszV0Y15MkVjcOMdV2XAUOB
         SeRGYhyeOsBHwuDQd70kFLSZeWh39zkfElhGqJbqx10VZTd3nZ2rX2QB+u/Qt492Z1gc
         hbmig3SA02z1k0cSPoBDLlu2vMbSegGyXI+qGB8PjwuQR3SXJn//THjRGgxg276l+SdS
         B6wHtWAIASMGKDMisPstiW4rcALfF/PFMMg8BO/8YnB7ej4rewLnUrB3F2IrHFQccjMI
         i4R2MKi5T10x4ogWDY99RFgJoGO2R3uzH2Wnhd1ZEkQiZ+G4w7i6h+YfNYGgTkg2D3+j
         iRUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :dkim-signature:arc-authentication-results;
        bh=WeHkgg3H/JtN5Wm7yZmgOXs2vSIF2qixWKeOZ1QdahA=;
        b=nPvraGEA55DVPpV1y0pCAg2dHiaSOoysANOKT6ZDJefOzTy6rmqEGIdaH6JeQitZeW
         xW9btVLhZ/Bk5CEdw1oA72YMRn1sS5y+AhNaabJUjUHW2uNJrZRDNW/kkHhLbVxCcZmW
         k4j4dv1GIE9V3NyYmypsLfwP0plGUB3EIIiXwojPXg7e26bIJq3lUzYMi+2CvRu6UyK8
         66/+mOQRdirXh4cSfdsosdX5ay6qGfaX19x8s0RbPJvFPTOHWxTOd4/AX8ZMVVYlWGO+
         +g+IMWov2jT2/+/2WHpmZwD1ge5Q8lG0/NqNd6FI3iXB1amuRopExcTeLTS0DoHP9T63
         JdDQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=N2xsOWQ0;
       spf=pass (google.com: domain of joel.stan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joel.stan@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=N2xsOWQ0;
       spf=pass (google.com: domain of joel.stan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joel.stan@gmail.com
X-Google-Smtp-Source: AH8x227Lhy/pfNt08jFeYXrXjCScTPEAvGn4aCUF9vRtP/veVmq4fQWdHSx8T5FbQcDbs2T0ibB1/Q==
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Jeremy Kerr <jk@ozlabs.org>,
	Christopher Bostic <cbostic@linux.vnet.ibm.com>,
	Brad Bishop <bradleyb@fuzziesquirrel.com>,
	Edward James <eajames@us.ibm.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 02/10] fsi: master-gpio: Add locking during break and link enable
Date: Mon, 12 Feb 2018 15:45:41 +1030
Message-Id: <20180212051549.8575-3-joel@jms.id.au>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180212051549.8575-1-joel@jms.id.au>
References: <20180212051549.8575-1-joel@jms.id.au>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592171001814271170?=
X-GMAIL-MSGID: =?utf-8?q?1592171001814271170?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jeremy Kerr <jk@ozlabs.org>

Currently, we perform GPIO accesses in fsi_master_gpio_break and
fsi_master_link_enable, without holding cmd_lock. This change adds the
appropriate locking.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Christopher Bostic <clbostic@linux.vnet.ibm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/fsi/fsi-master-gpio.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
index ae2618768508..a6d602e89c11 100644
--- a/drivers/fsi/fsi-master-gpio.c
+++ b/drivers/fsi/fsi-master-gpio.c
@@ -461,12 +461,14 @@ static int fsi_master_gpio_term(struct fsi_master *_master,
 static int fsi_master_gpio_break(struct fsi_master *_master, int link)
 {
 	struct fsi_master_gpio *master = to_fsi_master_gpio(_master);
+	unsigned long flags;
 
 	if (link != 0)
 		return -ENODEV;
 
 	trace_fsi_master_gpio_break(master);
 
+	spin_lock_irqsave(&master->cmd_lock, flags);
 	set_sda_output(master, 1);
 	sda_out(master, 1);
 	clock_toggle(master, FSI_PRE_BREAK_CLOCKS);
@@ -475,6 +477,7 @@ static int fsi_master_gpio_break(struct fsi_master *_master, int link)
 	echo_delay(master);
 	sda_out(master, 1);
 	clock_toggle(master, FSI_POST_BREAK_CLOCKS);
+	spin_unlock_irqrestore(&master->cmd_lock, flags);
 
 	/* Wait for logic reset to take effect */
 	udelay(200);
@@ -497,10 +500,14 @@ static void fsi_master_gpio_init(struct fsi_master_gpio *master)
 static int fsi_master_gpio_link_enable(struct fsi_master *_master, int link)
 {
 	struct fsi_master_gpio *master = to_fsi_master_gpio(_master);
+	unsigned long flags;
 
 	if (link != 0)
 		return -ENODEV;
+
+	spin_lock_irqsave(&master->cmd_lock, flags);
 	gpiod_set_value(master->gpio_enable, 1);
+	spin_unlock_irqrestore(&master->cmd_lock, flags);
 
 	return 0;
 }
-- 
2.15.1
