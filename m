Return-Path: <niklas.cassel@axis.com>
X-Google-Smtp-Source: AH8x227r0ELNuQJJDgLA5inllJzHZ8M6J299IPT0CKUlPX+cWKo/JwZTxx8NawKglT8kAyKZUJKp
ARC-Seal: i=1; a=rsa-sha256; t=1518093236; cv=none;
        d=google.com; s=arc-20160816;
        b=HKVj0Xgp54pKHrxNWrRzpxu0TaJ+RD4h6JUD3/8oZ0HXw1RuMXaNXb5N96TA/ZqQ+I
         0KnwmV3qWGc//qdA3Bp7XCeD2BDTrF8GJcrEvrBmp8NrKusZKvAQWd0KY85rzWcb+MKX
         fCHxKwq8yy+Tci0oC/NQzL6IP5ElU8g0JVOtpyPs6xGzNnzU5wRKIWcA+nx+9btKZt0H
         oPOSDoKij07l9+2+AHIPrFCHpzIMc/psI5k69slzldPPTws8ywQPhWKMBDxw7TBEpJ6N
         IJfVoK0oUPJrgTK7tK5GiKwaD6J4VXU2sEzDdedoGRejma9lb68mS365ePKoYykCC8P9
         freA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=sPNQqtjWVTIiu5lp1Lwlen5Oz5gVFsPFgnq3WfVEE2w=;
        b=hG7HV4wk5m+sBQJdDf/sRChtcjCKr4LyE1MHp8htjOTRRAywdgXwjfgRX5SnRX/4Bi
         uQhaiaE0OJOWilsjq2iGQp6WnsTTV56d6VdE6b9VQg63f8SXFqTl/M+vZs2MdRFB49O1
         FLgAZ5Iej7/zo+qatOAx/i9VhrnFvdOO9IUjvtCBiiaYDHzFq41HanfPdY0fmbjTvO6Y
         aSgszOgVCDmDBrwpLDpeKLopfjhWlZGt44fBdLVa73FCPWFXt5BK3BzdnJTPdcTaPRyW
         shOzbvWvPlUw5BHBJvJASlDr1jMB7X7QrGrYNMBMLX1YFvAe7nTBtl+pQnPEq9ZW4duX
         rgkA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of niklas.cassel@axis.com designates 195.60.68.11 as permitted sender) smtp.mailfrom=niklas.cassel@axis.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of niklas.cassel@axis.com designates 195.60.68.11 as permitted sender) smtp.mailfrom=niklas.cassel@axis.com
From: Niklas Cassel <niklas.cassel@axis.com>
To: kishon@ti.com,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] misc: pci_endpoint_test: Handle 64-bit BARs properly
Date: Thu,  8 Feb 2018 13:33:45 +0100
Message-Id: <20180208123346.20784-3-niklas.cassel@axis.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180208123346.20784-1-niklas.cassel@axis.com>
References: <20180208123346.20784-1-niklas.cassel@axis.com>
X-TM-AS-GCONF: 00
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591836133225578402?=
X-GMAIL-MSGID: =?utf-8?q?1591836133225578402?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

A 64-bit BAR uses the succeeding BAR for the upper bits,
so we cannot simply call pci_ioremap_bar() on every single BAR.

Ignore BARs that does not have a valid resource length.

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
Lorenzo/Bjorn: pci_resource_len() seems to fix my problem,
but is it the correct function to use here?
If BAR[x] is a 64-bit BAR, I'm assuming that pci_resource_len() on BAR[x+1]
will always return 0 (since BAR[x+1] cannot have any prefetchable/type bits
when BAR[x] is 64-bit).

 drivers/misc/pci_endpoint_test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 320276f42653..3af31bfdcfdd 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -534,6 +534,8 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	}
 
 	for (bar = BAR_0; bar <= BAR_5; bar++) {
+		if (pci_resource_len(pdev, bar) == 0)
+			continue;
 		base = pci_ioremap_bar(pdev, bar);
 		if (!base) {
 			dev_err(dev, "failed to read BAR%d\n", bar);
-- 
2.14.2
