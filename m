Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 34LaJqY8GlsgOwAAmS7hNA
	; Fri, 08 Jun 2018 08:22:48 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8E0C3607DC; Fri,  8 Jun 2018 08:22:48 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gPqsD3Y5"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C4BE0606FA;
	Fri,  8 Jun 2018 08:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C4BE0606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932463AbeFHIWp (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 04:22:45 -0400
Received: from smtprelay.synopsys.com ([198.182.37.59]:47739 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932190AbeFHITl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 04:19:41 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 8A8EF1E14A2;
        Fri,  8 Jun 2018 10:19:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1528445974; bh=uV0N/SWn0gFsPITGXKqTFxYsKOeYNCFelcmSlIfNu3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=gPqsD3Y5yHbMxiWPgqlJV62haHX/liCqBpy02cG2eg6yMpWDSFn7IVZlqXPIRDxVL
         9R4HtES2gYyYtzQ1G/Y1FEHeibFaX6n4dysHO0KD0/VwbFF+7dKbuTlnXLGYTpXAwa
         VXTF5IozGCGkGkdTjywfiuKJvYx49fZiygHB9hjPzEeQxnTMV2YjRXuP5GjT6RmaXw
         5d7e3ej9xSzKfHSj+Jt5OMQ4/orQI2afaGwMqTDGkYFO4h3fyNG1dBM6tdQ4tuT+p4
         rRWeIq8PhC1v8x6NVYj+8PJx7pcPB5ynqVyXdQ8j48k/e0orR9PffVkMcXRCXSBq70
         qa/MEjiseXSIg==
Received: from pt02.synopsys.com (pt02.synopsys.com [10.107.23.240])
        by mailhost.synopsys.com (Postfix) with ESMTP id BCEB959DC;
        Fri,  8 Jun 2018 01:19:33 -0700 (PDT)
Received: from UbuntuMate-64Bits.internal.synopsys.com (gustavo-e7480.internal.synopsys.com [10.107.25.102])
        by pt02.synopsys.com (Postfix) with ESMTP id 585323E941;
        Fri,  8 Jun 2018 09:19:32 +0100 (WEST)
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, jesper.nilsson@axis.com
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v3 10/10] tools: PCI: Add MSI-X support
Date: Fri,  8 Jun 2018 09:19:26 +0100
Message-Id:
 <f01e56d31b9f7a9b924f146cea007218bb081f5f.1527862777.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1527862777.git.gustavo.pimentel@synopsys.com>
References: <cover.1527862777.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1527862777.git.gustavo.pimentel@synopsys.com>
References: <cover.1527862777.git.gustavo.pimentel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20180608081926.5fvb8Sj_iQAmD1_PtHt5mVF5xXYmwRd31uxM0caD9t8@z>

Add MSI-X support to pcitest tool.

Add 2 new IOCTL commands:
 - Allow to reconfigure driver IRQ type in runtime.
 - Allow to retrieve current driver IRQ type configured.

Modify pcitest.sh script to accommodate MSI-X interrupt tests.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
Change v1->v2:
 - Allow IRQ type driver reconfiguring in runtime, follwing Kishon's
suggestion.
Change v2->v3:
 - Nothing changed, just to follow the patch set version.

 include/uapi/linux/pcitest.h |  3 +++
 tools/pci/pcitest.c          | 51 +++++++++++++++++++++++++++++++++++++++++++-
 tools/pci/pcitest.sh         | 15 +++++++++++++
 3 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/pcitest.h b/include/uapi/linux/pcitest.h
index 953cf03..cbf422e 100644
--- a/include/uapi/linux/pcitest.h
+++ b/include/uapi/linux/pcitest.h
@@ -16,5 +16,8 @@
 #define PCITEST_WRITE		_IOW('P', 0x4, unsigned long)
 #define PCITEST_READ		_IOW('P', 0x5, unsigned long)
 #define PCITEST_COPY		_IOW('P', 0x6, unsigned long)
+#define PCITEST_MSIX		_IOW('P', 0x7, int)
+#define PCITEST_SET_IRQTYPE	_IOW('P', 0x8, int)
+#define PCITEST_GET_IRQTYPE	_IO('P', 0x9)
 
 #endif /* __UAPI_LINUX_PCITEST_H */
diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index 9074b47..af146bb 100644
--- a/tools/pci/pcitest.c
+++ b/tools/pci/pcitest.c
@@ -31,12 +31,17 @@
 #define BILLION 1E9
 
 static char *result[] = { "NOT OKAY", "OKAY" };
+static char *irq[] = { "LEGACY", "MSI", "MSI-X" };
 
 struct pci_test {
 	char		*device;
 	char		barnum;
 	bool		legacyirq;
 	unsigned int	msinum;
+	unsigned int	msixnum;
+	int		irqtype;
+	bool		set_irqtype;
+	bool		get_irqtype;
 	bool		read;
 	bool		write;
 	bool		copy;
@@ -65,6 +70,24 @@ static int run_test(struct pci_test *test)
 			fprintf(stdout, "%s\n", result[ret]);
 	}
 
+	if (test->set_irqtype) {
+		ret = ioctl(fd, PCITEST_SET_IRQTYPE, test->irqtype);
+		fprintf(stdout, "SET IRQ TYPE TO %s:\t\t", irq[test->irqtype]);
+		if (ret < 0)
+			fprintf(stdout, "FAILED\n");
+		else
+			fprintf(stdout, "%s\n", result[ret]);
+	}
+
+	if (test->get_irqtype) {
+		ret = ioctl(fd, PCITEST_GET_IRQTYPE);
+		fprintf(stdout, "GET IRQ TYPE:\t\t");
+		if (ret < 0)
+			fprintf(stdout, "FAILED\n");
+		else
+			fprintf(stdout, "%s\n", irq[ret]);
+	}
+
 	if (test->legacyirq) {
 		ret = ioctl(fd, PCITEST_LEGACY_IRQ, 0);
 		fprintf(stdout, "LEGACY IRQ:\t");
@@ -83,6 +106,15 @@ static int run_test(struct pci_test *test)
 			fprintf(stdout, "%s\n", result[ret]);
 	}
 
+	if (test->msixnum > 0 && test->msixnum <= 2048) {
+		ret = ioctl(fd, PCITEST_MSIX, test->msixnum);
+		fprintf(stdout, "MSI-X%d:\t\t", test->msixnum);
+		if (ret < 0)
+			fprintf(stdout, "TEST FAILED\n");
+		else
+			fprintf(stdout, "%s\n", result[ret]);
+	}
+
 	if (test->write) {
 		ret = ioctl(fd, PCITEST_WRITE, test->size);
 		fprintf(stdout, "WRITE (%7ld bytes):\t\t", test->size);
@@ -133,7 +165,7 @@ int main(int argc, char **argv)
 	/* set default endpoint device */
 	test->device = "/dev/pci-endpoint-test.0";
 
-	while ((c = getopt(argc, argv, "D:b:m:lrwcs:")) != EOF)
+	while ((c = getopt(argc, argv, "D:b:m:x:i:Ilrwcs:")) != EOF)
 	switch (c) {
 	case 'D':
 		test->device = optarg;
@@ -151,6 +183,20 @@ int main(int argc, char **argv)
 		if (test->msinum < 1 || test->msinum > 32)
 			goto usage;
 		continue;
+	case 'x':
+		test->msixnum = atoi(optarg);
+		if (test->msixnum < 1 || test->msixnum > 2048)
+			goto usage;
+		continue;
+	case 'i':
+		test->irqtype = atoi(optarg);
+		if (test->irqtype < 0 || test->irqtype > 2)
+			goto usage;
+		test->set_irqtype = true;
+		continue;
+	case 'I':
+		test->get_irqtype = true;
+		continue;
 	case 'r':
 		test->read = true;
 		continue;
@@ -173,6 +219,9 @@ int main(int argc, char **argv)
 			"\t-D <dev>		PCI endpoint test device {default: /dev/pci-endpoint-test.0}\n"
 			"\t-b <bar num>		BAR test (bar number between 0..5)\n"
 			"\t-m <msi num>		MSI test (msi number between 1..32)\n"
+			"\t-x <msix num>	\tMSI-X test (msix number between 1..2048)\n"
+			"\t-i <irq type>	\tSet IRQ type (0 - Legacy, 1 - MSI, 2 - MSI-X)\n"
+			"\t-I			Get current IRQ type configured\n"
 			"\t-l			Legacy IRQ test\n"
 			"\t-r			Read buffer test\n"
 			"\t-w			Write buffer test\n"
diff --git a/tools/pci/pcitest.sh b/tools/pci/pcitest.sh
index 77e8c85..75ed48f 100644
--- a/tools/pci/pcitest.sh
+++ b/tools/pci/pcitest.sh
@@ -16,7 +16,10 @@ echo
 echo "Interrupt tests"
 echo
 
+pcitest -i 0
 pcitest -l
+
+pcitest -i 1
 msi=1
 
 while [ $msi -lt 33 ]
@@ -26,9 +29,21 @@ do
 done
 echo
 
+pcitest -i 2
+msix=1
+
+while [ $msix -lt 2049 ]
+do
+        pcitest -x $msix
+        msix=`expr $msix + 1`
+done
+echo
+
 echo "Read Tests"
 echo
 
+pcitest -i 1
+
 pcitest -r -s 1
 pcitest -r -s 1024
 pcitest -r -s 1025
-- 
2.7.4
