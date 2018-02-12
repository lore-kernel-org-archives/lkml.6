Return-Path: <joel.stan@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518412631; cv=none;
        d=google.com; s=arc-20160816;
        b=jOIobPnfLyVueK0/jztATUDT8J1kpmLluDpuoipUyAr/BdJaPPPk8imzcV7+KzEp53
         brq7zivs9UnbMDn6ShoIKrjlhwTay4kBRL/Hwn/xyAndGx4KqoiufpDjrwI4h3nv7OdI
         9PXtkjZxAh4qSRjaR5Of6lp9ob/MQHbQqc4/Wig5poggVa6G4MWIywdUWZMvtUzUOxFh
         wpFPPuYOtZXx3jv6l8deGMzaCTsa2tK2bi+H7/kr0daF9w4B1HavGlrMXHYy8PssIpG+
         CwK3aO/dFCfhTzTz+7AYoZaR+i8vUd+WTyO8uDgj1CZ97r79XKRUF+DPejYr3jGM8cL6
         x/Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :dkim-signature:arc-authentication-results;
        bh=/pe7gC4457snTkdizIdjllMLQxQZAy76GlQWszn3i6Q=;
        b=TY9avGZr08fNyUgYfUlknCNDEBRiLujq62kbSIv+ACzs104mJho3BltAVzjJQ8857r
         kC2HTE0oYQxAWEs3el43ZtbvCOIstcBfWMoXvVXu/rPpTo4+rygolaM32na2RDhov/oW
         TUxzAkLgf6eCqG1lqq4bNGWS1tDWqQBxz6aUyrwWn1d3uFJ3ft7W5BOaY5NefxSmqz3h
         wdZec2jUSA6NUcIBgFeUb3sakTkfQwz44TGVWyAgbgGlXKlBceWwW17Ja9SOFcuPjBif
         i8bT8b5ExuvKMmzwY8eJ8KO9a5qzMNWMH8vcVW0uSP8ECVnwj1xGi+WG3MSF5yRmvm88
         FgEQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=vIwOvjHb;
       spf=pass (google.com: domain of joel.stan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joel.stan@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=vIwOvjHb;
       spf=pass (google.com: domain of joel.stan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joel.stan@gmail.com
X-Google-Smtp-Source: AH8x225IwVNEqkB1vJjOE8cHLj/vf1OYdK1XevNbrjtXlRqAbgrzYFciKc6O66M0UESUnIynfIrNtg==
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Christopher Bostic <cbostic@linux.vnet.ibm.com>,
	Jeremy Kerr <jk@ozlabs.org>,
	Brad Bishop <bradleyb@fuzziesquirrel.com>,
	Edward James <eajames@us.ibm.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 07/10] fsi: core: Reduce console output during normal scan
Date: Mon, 12 Feb 2018 15:45:46 +1030
Message-Id: <20180212051549.8575-8-joel@jms.id.au>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180212051549.8575-1-joel@jms.id.au>
References: <20180212051549.8575-1-joel@jms.id.au>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592171043563710176?=
X-GMAIL-MSGID: =?utf-8?q?1592171043563710176?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Christopher Bostic <cbostic@linux.vnet.ibm.com>

To reduce amount of console output during boot / power up make
all normal path scan related messages debug type.

Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
Acked-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/fsi/fsi-core.c       | 4 ++--
 drivers/fsi/fsi-master-hub.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 1069cb402bd3..8d8b25809452 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -207,7 +207,7 @@ static int fsi_slave_report_and_clear_errors(struct fsi_slave *slave)
 	if (rc)
 		return rc;
 
-	dev_info(&slave->dev, "status: 0x%08x, sisc: 0x%08x\n",
+	dev_dbg(&slave->dev, "status: 0x%08x, sisc: 0x%08x\n",
 			be32_to_cpu(stat), be32_to_cpu(irq));
 
 	/* clear interrupts */
@@ -687,7 +687,7 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 		return -EIO;
 	}
 
-	dev_info(&master->dev, "fsi: found chip %08x at %02x:%02x:%02x\n",
+	dev_dbg(&master->dev, "fsi: found chip %08x at %02x:%02x:%02x\n",
 			chip_id, master->idx, link, id);
 
 	rc = fsi_slave_set_smode(master, link, id);
diff --git a/drivers/fsi/fsi-master-hub.c b/drivers/fsi/fsi-master-hub.c
index 3223a671a0ef..5e4cd3134bc0 100644
--- a/drivers/fsi/fsi-master-hub.c
+++ b/drivers/fsi/fsi-master-hub.c
@@ -254,7 +254,7 @@ static int hub_master_probe(struct device *dev)
 
 	reg = be32_to_cpu(__reg);
 	links = (reg >> 8) & 0xff;
-	dev_info(dev, "hub version %08x (%d links)\n", reg, links);
+	dev_dbg(dev, "hub version %08x (%d links)\n", reg, links);
 
 	rc = fsi_slave_claim_range(fsi_dev->slave, FSI_HUB_LINK_OFFSET,
 			FSI_HUB_LINK_SIZE * links);
-- 
2.15.1
