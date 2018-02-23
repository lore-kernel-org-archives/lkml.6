Return-Path: <geert@linux-m68k.org>
X-Google-Smtp-Source: AH8x227hif5ZW1OjWmGNH6QP3LzuecYtCT7JvXqkQm8ACYAG2tNAzkh7x/QU7ruXkzPqJZ59z8vn
ARC-Seal: i=1; a=rsa-sha256; t=1519393121; cv=none;
        d=google.com; s=arc-20160816;
        b=zLDGJ7FXHJz7h8RCWPQ6U/bgwPrmE2bkojtXv42nE/aYKotrKSoAqj256QNJrr1DUq
         mGzi3M6Phn/GrEfy/zT58eh8VMatE/BVNBKbBgMSB7D0h5ictLlSOQ77rF/SyingLS0q
         OQn9Mrlu3FTWDqdvymUHfsK2Hc3zeRLMkEUruCBR1ae0sfBR9EZN1xvu6VEuJnWuFRaS
         kz3IemLW5h1zaKQ+7YOKYhQzX/0AhG27C1plHBoju5+/bOgviohqydW/d5IMsVT/Q8C9
         DYsVBn/3dNC2zsGCAMVQZ9aPT88ktUZZNHqEHYRngH3RZ5cGRp3CwI1bDzOviJ5z/CIW
         yADA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=RR4UMlFXwC9+7UdYRdDWais3pNW4unjiOtKUyETeGs4=;
        b=Bt2YH0pa24dEYj5PRR7KG6T3P9HGlt7gbu7DjVcHU10hFt5bA84m56mpDtiG3rn8ah
         skx1CdZQQHeAX4VPZeO+9wOTYKUBmesTtB/yfgjjWf5y+eFrUu2cy5PmtJvLykEKlxH/
         nqs3MoA76gsHOTo5tvkIemI670DDf2+rS3Zlt22APGSKCEYKMVfwhcXoCUG474ma89N4
         Tyap0fC6l0oF6bSxnTIXhqAlNJOlZw+bvqiTXzGYsK9kMgmHa3Q2qolV9gUSr9fA30Lp
         zYj5GvDAJpsL8ZyvTutjSnwvZ+79tHpVA+tNvgQyuPLUcKLbkJR+kLLSfDfOziXgnj06
         HZog==
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
Subject: [PATCH v2 7/9] serial: sh-sci: Fix out-of-bounds access through DT alias
Date: Fri, 23 Feb 2018 14:38:35 +0100
Message-Id: <1519393117-31998-8-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519393117-31998-1-git-send-email-geert+renesas@glider.be>
References: <1519393117-31998-1-git-send-email-geert+renesas@glider.be>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593199161640594851?=
X-GMAIL-MSGID: =?utf-8?q?1593199161640594851?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The sci_ports[] array is indexed using a value derived from the
"serialN" alias in DT, which may lead to an out-of-bounds access.

Fix this by adding a range check.

Note that the array size is defined by a Kconfig symbol
(CONFIG_SERIAL_SH_SCI_NR_UARTS), so this can even be triggered using a
legitimate DTB.

Fixes: 97ed9790c514066b ("serial: sh-sci: Remove unused platform data capabilities field")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Fix Fixes reference,
  - Use ARRAY_SIZE().
---
 drivers/tty/serial/sh-sci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 4d14f321cbec95e0..f6a6610d434efc33 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3096,6 +3096,10 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
 		dev_err(&pdev->dev, "failed to get alias id (%d)\n", id);
 		return NULL;
 	}
+	if (id >= ARRAY_SIZE(sci_ports)) {
+		dev_err(&pdev->dev, "serial%d out of range\n", id);
+		return NULL;
+	}
 
 	sp = &sci_ports[id];
 	*dev_id = id;
-- 
2.7.4
