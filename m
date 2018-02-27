Return-Path: <niklas.cassel@axis.com>
X-Google-Smtp-Source: AG47ELvnr6W/Xitnlqde9VlnZk/QNf9wtsDPzQ6s0HQm+41Qejx8P0DCT7da+c1vMTi/tYzxeLs7
ARC-Seal: i=1; a=rsa-sha256; t=1519732757; cv=none;
        d=google.com; s=arc-20160816;
        b=PXKjK8hVkwqDTyliDZIrHtxe9Kj84RA4jFJ+D60sbDUbtQV2+lYvaANoj8ZQ7t97Q0
         9UADXsTk3lq13k783/i3KoKVKuQEzcB8MXb39OxcC3asA7kO/xZMLby/JY79KepCiG0x
         x65cfFGjVfqndJ/sJXyWs4zUoaCloqKB0U1fLbkhjT6KqB+sC8/nu04gnHFoBQuQb7fU
         utvt++OaYcWzdgZ6h+tdRfHFoyMRcWsyUY+Ku5HuJPJ4RLLoNT6A17rougXEnKsguHd3
         XUdLqJKEHC1YWiXuznSzOuIXiKUKRvFJm/jHnBleG8cGUPvK4nb4T8+wJMw28em8IHyY
         BsQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=sC9jHMQ8OYMLr1jyDqY9b+kyuQOWpXMNQ75RKaA9+hM=;
        b=GyRd/iFuQyvwb+9v1gbXUuxScnNPkQCaA4+ACsMOkN0eIZxObRUJSRozdBlffnAmlW
         bsuwHpHgMQPEil5L16tX0EbIuXGv2AL5x/yzADIO6T/VJRWjgl6SSLeFf5jNKmKkp2Sc
         YZlGTIvQdRj/742cePWpovxx89nLcQ+19CLfPXJ9IbjZd5q1g9E8/0X/LNgDmwXjUz8K
         70tP4CwbL967pbnDVI4HPFtcPyVVysVsfBrDhoG66En26FYWw5I1mZpGpx4Nh/X3Wlif
         PI/Uwg2/z/jCnkg0vxGWXB/AO2TjJLJ2unzqleh0uVpoGjI5ACjB//k4npbO5ftnKfg1
         KB5A==
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
Subject: [PATCH v3 2/3] misc: pci_endpoint_test: Handle 64-bit BARs properly
Date: Tue, 27 Feb 2018 12:59:06 +0100
Message-Id: <20180227115908.14593-3-niklas.cassel@axis.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180227115908.14593-1-niklas.cassel@axis.com>
References: <20180227115908.14593-1-niklas.cassel@axis.com>
X-TM-AS-GCONF: 00
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593555295925166358?=
X-GMAIL-MSGID: =?utf-8?q?1593555295925166358?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

A 64-bit BAR uses the succeeding BAR for the upper bits,
so we cannot simply call pci_ioremap_bar() on every single BAR.

BARs succeding a 64-bit BAR will not have the IORESOURCE_MEM resource
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
Changes since v2:
Check (pci_resource_flags(pdev, bar) & IORESOURCE_MEM)
rather than (pci_resource_len(pdev, bar) == 0), thanks Bjorn.

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
