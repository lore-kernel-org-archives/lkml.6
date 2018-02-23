Return-Path: <geert@linux-m68k.org>
X-Google-Smtp-Source: AH8x224ssAashbAicHvJUmDGN3yb4rb5/MaME+01KmIyrVL907Y/ONUjcMfgsHpssiDpc1z/akDd
ARC-Seal: i=1; a=rsa-sha256; t=1519393121; cv=none;
        d=google.com; s=arc-20160816;
        b=DtnOaHdhmr+gSOuQyy2VSmcqVG7IB7Fdu5dYiNbij9eDvJouXABSXhIvy2Q1hEDa7h
         FS6ZCtjZCcMAGc03RWP62OZoxgFaf9wUXH+pk5k27gN4TN+LvaFgGnRiEKjRVj9IHgBV
         8TkNJJOmAr9F1MUXzrb+d9ESfPnUPmyx4SBszaSxqnGt8HzhcWeHJMOR41MkbAN5+ncL
         GwERkEYf7LZtlolrFxX+oVvMjstDgMduyTIh/xxlClzWCDIIvxSv5hRWfkWmcOVOom85
         tdDb/1fnqTltCXqu3ZjKSR8Oo8fg+6tnTCzbsqYaAbnoOfjQAtJsofZYpzsotwK6XEaT
         bpWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=GL1IiAKboj0ubCF5Cs0c+3UxaTIf4d+x0Kye2291EGo=;
        b=siHA9BedgTXs158EPtWWzdwqqvLozOOd8+Hn4sC2YQgjqXEsXI4YGzLc9ifYrj3fZA
         ZB4Meg0vH1Rbqa9yZMrA6uPwGd3YYqOpt9xiTCaZrBwkOMbowtq282NmiY0l9Ou/q3MF
         zpyfiybtGI5UbBV5rM7dJLlVJuUceo1021LLIDPJfImmbk7AMn/QNtlMZFeGmc7upSNt
         4nNDHl/0GooOBwInDPsEf2S/WsouEli7vCXKH3NanwqZ7K9oEv1/fA+aE8s6iR/gJWKA
         ue/k9iuwC/9HkCIibBv4C9tQoa2aDIz/ENJq5EKKfxGriqxW8Xm60DOGG4JroX1BGQGR
         7IZg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 2a02:1800:110:4::f00:18 is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 2a02:1800:110:4::f00:18 is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Barry Song <baohua@kernel.org>,
	Vineet Gupta <vgupta@synopsys.com>,
	Jiri Slaby <jslaby@suse.com>,
	Michal Simek <michal.simek@xilinx.com>,
	linux-serial@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 4/9] serial: mxs-auart: Fix out-of-bounds access through serial port index
Date: Fri, 23 Feb 2018 14:38:32 +0100
Message-Id: <1519393117-31998-5-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519393117-31998-1-git-send-email-geert+renesas@glider.be>
References: <1519393117-31998-1-git-send-email-geert+renesas@glider.be>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593199161582698407?=
X-GMAIL-MSGID: =?utf-8?q?1593199161582698407?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The auart_port[] array is indexed using a value derived from the
"serialN" alias in DT, or from platform data, which may lead to an
out-of-bounds access.

Fix this by adding a range check.

Fixes: 1ea6607d4cdc9179 ("serial: mxs-auart: Allow device tree probing")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Fix Fixes reference,
  - Use ARRAY_SIZE(),
  - Update patch description for platform data.
---
 drivers/tty/serial/mxs-auart.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 079dc47aa142d8e1..caa8a41b6e71df9e 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1663,6 +1663,10 @@ static int mxs_auart_probe(struct platform_device *pdev)
 		s->port.line = pdev->id < 0 ? 0 : pdev->id;
 	else if (ret < 0)
 		return ret;
+	if (s->port.line >= ARRAY_SIZE(auart_port)) {
+		dev_err(&pdev->dev, "serial%d out of range\n", s->port.line);
+		return -EINVAL;
+	}
 
 	if (of_id) {
 		pdev->id_entry = of_id->data;
-- 
2.7.4
