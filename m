Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C676DC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E8120856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E8120856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388332AbeGXKpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 06:45:17 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:40801 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388223AbeGXKpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 06:45:17 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue104 [212.227.15.145]) with ESMTPA (Nemesis) id
 0Ma2zH-1fR4870eqN-00Loxu; Tue, 24 Jul 2018 11:39:28 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        James Puthukattukaran <james.puthukattukaran@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: fix unused variable warning
Date:   Tue, 24 Jul 2018 11:39:03 +0200
Message-Id: <20180724093924.1752416-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:USQGrNY0FLcQHMFs8WFsx4d0jCn3RIOVCCoNW2NBfRr9ho1zjB9
 1/KYFRhQcfp6uTkSFpNU1z70YoM4fXUU7Fn8I6p04JXpW2VMQSsJEBbmhhvXXcDZTGSTr/M
 uyaPvMwXQNkGwwuMmHAGJvcAGcGhjMSo5+2g5XB1ueF5yM1aKoOVlqQzG8SjYLs5yDsuvpa
 laHQ9iqVtQyZ7vs6dpEGw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lLNtJO+WDYE=:jtlbfSvdDp4B4mLUnfpQ18
 f3i5pg+kE1Z/anqcrBE52LtuRt3Cxy3sgIdTfRdmZpSKIH1YY+R954+jDfGs/mtZ1erKNIXB+
 XMPz2ThicN+6V4fvoNoYbx2/2NT/ilHf+q10tP4HLL3C4Go438Olucmba6OXhvdmPry56Vzz7
 LA54pWHcs42VfHElW4oeMajuhigtcqebCoeAzg9uGfVYLW7RXpE1aBoIjAhLlSdOPt5nRxYJs
 2z7iZsOnie8ZdaXdN/hxNYQH5gXgmsdQecIZT4GJbU03s3gMnuPAuwhgeCPrGqeXX9nEXrs7q
 EHS0TLUtbCKCPo+qqFK+oyILrNkqyU5AIFoVcKEcvrFpjqRxQ+Q3z9H/4dQjJUW66MS+Qj8zj
 aDnhKcmd5Vfz9EmSHidI7+39v4osvkkCh9oPEOjl8d1zi00+g4sFScAIVhy3uoI4oskdSStmM
 2Xp6yZIAFrVEWKQsFUqSXxCzkp8ejmNNkwW+5rfhLSDiEoMo6UjI5nQzJ1EPvQKYb1HLm34Ao
 Fo45d1F/5SI16BH0ZBmkuZK1gqIpiGnxvt9L8vUnEpjFoiCIgsOR/0sU49ExJtnDeX1PdeFjI
 0qEHVQCBjnC383wfd8Gyd30jnLrfFhYmL3v25BaifrMUkh8QCFuMGvgBXQhfsItQbejdS2k7Q
 YoSkvHsi144/n3oyrMb/4gHJRDgKIqzFpshdiGWQ6Q5URjFt+exSBhAe67T21B/oF1cQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly introduced function produces a warning without CONFIG_PCI_QUIRKS:

drivers/pci/probe.c: In function 'pci_bus_read_dev_vendor_id':
drivers/pci/probe.c:2221:18: error: unused variable 'bridge' [-Werror=unused-variable]

Move the variable declaration into that #ifdef to avoid the warning.

Fixes: ac5ea104a279 ("PCI: Workaround IDT switch ACS Source Validation erratum")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 1c581346c5b9..7a5323798312 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2218,9 +2218,9 @@ bool pci_bus_generic_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
 bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
 				int timeout)
 {
+#ifdef CONFIG_PCI_QUIRKS
 	struct pci_dev *bridge = bus->self;
 
-#ifdef CONFIG_PCI_QUIRKS
 	/*
 	 * Certain IDT switches have an issue where they improperly trigger
 	 * ACS Source Validation errors on completions for config reads.
-- 
2.18.0

