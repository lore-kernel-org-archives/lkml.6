Return-Path: <niklas.cassel@axis.com>
X-Google-Smtp-Source: AH8x226RawP3tt/7QjbazM9u6K0In2ltK+v9An42183Ky8twH5KQWcAKyd29+OM7IYjFfES2plpx
ARC-Seal: i=1; a=rsa-sha256; t=1517501492; cv=none;
        d=google.com; s=arc-20160816;
        b=OWyumJkyqaHC7rpNq8YQMI5UJ3GAtpJeWi/385u/wC81Gw56V/rgV3afcxWE6ZWiHs
         7Wo+iB8QZHG1klKkGRUYlUaaeZh8pR3j5xt9L1DqBJCQ1q2Xq/sI4/sbFIj1eJr45gwf
         eFL3t3oJRsYBAZt7yQMXOf3dqEcv2qwE4NRRO1SGLMWoMUj/qjcLI5z/1u76BLs927Vv
         f6Y5hiGgWx05YZ5OpLVg65hVzjIznNEFMc6s8Tos4VvLUiIV2wG4siDvkm6HTowPPs79
         siNmEX0QhgN0J8OsM3qkWx+vCXIwudV6zUN235d6XJ4aSLDJEL3ZDDr8sGvdCaOQSH6r
         mrmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=sPNQqtjWVTIiu5lp1Lwlen5Oz5gVFsPFgnq3WfVEE2w=;
        b=J2Uq829ROpg1pXFmRtNZfde3EChlA6LPJ5wIuIfc68TMPvY8u7Cxv4JCiEJ6BUaOWp
         qz9/PtIvJSgU3QB3uo/3ktAsEsLnYZ5YOamInImeEFRji0OyUHP3CdxuMvMDFoMFGd+a
         lgWPoePQeSzc00BtcotdElfaVkWicr+fI7/ssCMX7jYbQdN1jjxyQVPRLf4yBipzYyki
         ESUMgqc+Q3lqFxCKcmCFO4r4qOahA5IwMNvb3Fzuroz9xE81R2wQJE8zEpizVn1zQ7BY
         TS8ZjFOSVDrtbe1Zjgmr7iPY+QvcBBJg9ruWHYKOL423T27cXmKaOzgX8QfO+x2hliqz
         LtEA==
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
Subject: [PATCH 2/3] misc: pci_endpoint_test: Handle 64-bit BARs properly
Date: Thu,  1 Feb 2018 17:11:18 +0100
Message-Id: <20180201161119.3852-3-niklas.cassel@axis.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180201161119.3852-1-niklas.cassel@axis.com>
References: <20180201161119.3852-1-niklas.cassel@axis.com>
X-TM-AS-GCONF: 00
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591215644566133735?=
X-GMAIL-MSGID: =?utf-8?q?1591215644566133735?=
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
