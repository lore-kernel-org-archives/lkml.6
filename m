Return-Path: <niklas.cassel@axis.com>
X-Google-Smtp-Source: AIpwx4/FVSSZ4vmXtF6yRQDEFj+ukpLDP3ZBCK5Rl6AOMlLNdFxbwZI22x3gKgIAp3fn5+B1HQ1A
ARC-Seal: i=1; a=rsa-sha256; t=1522237898; cv=none;
        d=google.com; s=arc-20160816;
        b=GZpYXVO5cFg9M+C1sgKe9QWiTYpNvZLs+aQ33Us/w+sJwIO5CaovN5Ok2p9U5+oBTS
         6g1SLuBxGw96AXK5+fF2LQqiuiJEzppnbNuhn20309tKLDjqofnjFlU8+/qPHAIg9g0S
         ZjZoMzO8IjzXT8wEwXNzlIzKjC0e6+P79300U+LMcvEyUcazsOxUk7Lt0UymqQf6Z48T
         lcO8hItAP6QPr7GLbQUeV7WPJb9+88LrTqoUzavZP8n9ZHtIf90VNYhTbZEtc4sNq0Sb
         RT0CzPXlEjMgYZfnOxi3XoD0BlXTEV6C9FJzNRGo3Qqil/Cooswou8Tglr7rQYARseVn
         r/yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=2GplgQroBnLZ4aDfrnxYBtb9/0DsRKI9bT4hRapO3TY=;
        b=X9dCEFrgCXT6ivZZOwyZLxMV9T0jdamXcJZAuuylLCMJrecA4mhwSb5FuHlU3A/AWK
         yWhIsDpprdnQYHB3jKt8iqxVK3UcpDgia7CXXo3eEUGB0aJFBZSDbp3wmSkQhKUI5xwM
         MbYg/uV6sUX8QHobdECwupy94Y7I0zrfpdrraubYdKtIVcJvzoweSk3d7x/dU8WUv+ua
         +HtXQGJj7EpRFm3gj1bpGpfPpIz+ySmjPsivQXwO9SVrf85+R++Q0xxwz+El84Sf5Rfm
         jWHn2mVqFGU0zXmD1KBitvocO6+zMHzb/b5O1Pq35bFtFWNh68iOlgPBnQ27Swm2Ub61
         DPcw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of niklas.cassel@axis.com designates 195.60.68.11 as permitted sender) smtp.mailfrom=niklas.cassel@axis.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of niklas.cassel@axis.com designates 195.60.68.11 as permitted sender) smtp.mailfrom=niklas.cassel@axis.com
From: Niklas Cassel <niklas.cassel@axis.com>
To: kishon@ti.com,
	cyrille.pitchen@free-electrons.com,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 12/12] misc: pci_endpoint_test: Handle 64-bit BARs properly
Date: Wed, 28 Mar 2018 13:50:17 +0200
Message-Id: <20180328115018.31921-13-niklas.cassel@axis.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180328115018.31921-1-niklas.cassel@axis.com>
References: <20180328115018.31921-1-niklas.cassel@axis.com>
X-TM-AS-GCONF: 00
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596182125919667723?=
X-GMAIL-MSGID: =?utf-8?q?1596182125919667723?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

A 64-bit BAR consists of a BAR pair, where the second BAR has the
upper bits, so we cannot simply call pci_ioremap_bar() on every single
BAR index.

The second BAR in a BAR pair will not have the IORESOURCE_MEM resource
flag set. Only call ioremap on BARs that have the IORESOURCE_MEM
resource flag set.

pci 0000:01:00.0: BAR 4: assigned [mem 0xc0300000-0xc031ffff 64bit]
pci 0000:01:00.0: BAR 2: assigned [mem 0xc0320000-0xc03203ff 64bit]
pci 0000:01:00.0: BAR 0: assigned [mem 0xc0320400-0xc03204ff 64bit]
pci-endpoint-test 0000:01:00.0: can't ioremap BAR 1: [??? 0x00000000 flags 0x0]
pci-endpoint-test 0000:01:00.0: failed to read BAR1
pci-endpoint-test 0000:01:00.0: can't ioremap BAR 3: [??? 0x00000000 flags 0x0]
pci-endpoint-test 0000:01:00.0: failed to read BAR3
pci-endpoint-test 0000:01:00.0: can't ioremap BAR 5: [??? 0x00000000 flags 0x0]
pci-endpoint-test 0000:01:00.0: failed to read BAR5

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/misc/pci_endpoint_test.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 320276f42653..fe8897e64635 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -534,12 +534,14 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	}
 
 	for (bar = BAR_0; bar <= BAR_5; bar++) {
-		base = pci_ioremap_bar(pdev, bar);
-		if (!base) {
-			dev_err(dev, "failed to read BAR%d\n", bar);
-			WARN_ON(bar == test_reg_bar);
+		if (pci_resource_flags(pdev, bar) & IORESOURCE_MEM) {
+			base = pci_ioremap_bar(pdev, bar);
+			if (!base) {
+				dev_err(dev, "failed to read BAR%d\n", bar);
+				WARN_ON(bar == test_reg_bar);
+			}
+			test->bar[bar] = base;
 		}
-		test->bar[bar] = base;
 	}
 
 	test->base = test->bar[test_reg_bar];
-- 
2.14.2
