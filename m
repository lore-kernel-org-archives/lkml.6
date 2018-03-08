Return-Path: <niklas.cassel@axis.com>
X-Google-Smtp-Source: AG47ELvvzUWz2cX6mh6Imqy3t0KNcfMxj3Sin7dzTKYz+xkAkrJvA4cbxwyDvsHODiF+0UaEtBl0
ARC-Seal: i=1; a=rsa-sha256; t=1520516039; cv=none;
        d=google.com; s=arc-20160816;
        b=kpfYGjWSNbzHYQGCzuXqhtpKWXwWDOL7MSpyeP5PzvuwxDqqGCnwoRODEzJQ8VluOS
         5arLo++2csNAkO9MaIEcqRe8u6tuPZparsxvOOy/IGzl7JjdJWYvT2Vv5kpFIQXoAFoU
         beGL11Ue5DQQVLMmxa9rEx468WFeoRSSCUghpkNwq+RDUVB476I79g1CAjkd0VfYN8ow
         QsfD4k0gLjm1m9KpASMsnAkpB1x9PxaIv8ZSX07vzMTMMi7wHFifUwvdjROGYSgU8pci
         SmTxd2/fob2MJPmElZnlzq7lwgMqdxpORBBnmyxU/RU6dxXFZ8rvxtgZ/TPNecKoM5D9
         aN8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=hMfQNqWElzdhuzXHC50dboGwD8rNKvws0/ocx+KvpRQ=;
        b=svJC11Tq5zAqEADvMNpWElyoZE3j9Fz2JzyiLY8ZGEvtPaEoEXa8mXq7E4Ll9wLWTt
         0swZu5J71wk0+oJUNM6R/P2oYbSLWSqbjdnVjNd6Dhx2fn0HCU5EZyRdcr02x9FYAanP
         0u7bcuZhL2irzpv8V81EhlVeaPIT/k7/b3qW1vqo/aOC8aLxoDbQEU698E0Ingx9bXFp
         x6ORpIm1uhh83VnXJARGm2X/RmP6qJUUZ1p3URrGq6LPZdalEoMJMlIqrYLZauzj/CT2
         469K/09/NJ5W+oFmTHVWup27NR0lPTKsO6AkEwH4iik1rGr+btMa3mqaTGeoyftqZC02
         DLow==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of niklas.cassel@axis.com designates 195.60.68.11 as permitted sender) smtp.mailfrom=niklas.cassel@axis.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of niklas.cassel@axis.com designates 195.60.68.11 as permitted sender) smtp.mailfrom=niklas.cassel@axis.com
From: Niklas Cassel <niklas.cassel@axis.com>
To: kishon@ti.com,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/5] misc: pci_endpoint_test: Handle 64-bit BARs properly
Date: Thu,  8 Mar 2018 14:33:30 +0100
Message-Id: <20180308133331.19464-6-niklas.cassel@axis.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180308133331.19464-1-niklas.cassel@axis.com>
References: <20180308133331.19464-1-niklas.cassel@axis.com>
X-TM-AS-GCONF: 00
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594376627258900258?=
X-GMAIL-MSGID: =?utf-8?q?1594376627258900258?=
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
