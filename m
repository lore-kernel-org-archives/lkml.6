Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92B0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93BA2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545378903;
	bh=hCt/G6i9HInQZTDF08SRWYRHC/T3t2TjiEJX/5MCwLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c1AVyTg+5J8l8n8Rl9GiigIBzLHagmF4CXFh0/NtYP7POzlxEmJnv+afcUh3d03fo
	 KXFYC6Vg2b9tQzfjzQEyL89sSzHo5T9A32H3c/Lo59J1/HXJwL6+fI2TSgGQdvU+2p
	 AVhKE3CdrEhXwzzShwFMYomE2e6/g73miwIQjNj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732795AbeLUHzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:55:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:59218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731366AbeLUHy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 02:54:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4496821906;
        Fri, 21 Dec 2018 07:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545378897;
        bh=hCt/G6i9HInQZTDF08SRWYRHC/T3t2TjiEJX/5MCwLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BRn0fPkMKkPf/c//E6x9o972yAnJhBNfPo5yzOS3Fj2NUm9AvbB3c7w9tFtb3VO3f
         YnBUD0DECcQIhq/1l87LH58Xy5tAlqnBkRVkd7xvwh4vjoIXAagm3pa6pXnsQWozA2
         4Wks21OgMXkVbZ7nWMimRXw0P1lwElPQsDXFmygA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 02/10] PCI: pci-sysfs.c: convert to use BUS_ATTR_WO
Date:   Fri, 21 Dec 2018 08:54:34 +0100
Message-Id: <20181221075442.17109-3-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181221075442.17109-1-gregkh@linuxfoundation.org>
References: <20181221075442.17109-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are trying to get rid of BUS_ATTR() and the usage of that in
pci-sysfs.c can be trivially converted to use BUS_ATTR_WO(), so use that
instead.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/pci-sysfs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 9ecfe13157c0..25794c27c7a4 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -412,8 +412,7 @@ static ssize_t msi_bus_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(msi_bus);
 
-static ssize_t bus_rescan_store(struct bus_type *bus, const char *buf,
-				size_t count)
+static ssize_t rescan_store(struct bus_type *bus, const char *buf, size_t count)
 {
 	unsigned long val;
 	struct pci_bus *b = NULL;
@@ -429,7 +428,7 @@ static ssize_t bus_rescan_store(struct bus_type *bus, const char *buf,
 	}
 	return count;
 }
-static BUS_ATTR(rescan, (S_IWUSR|S_IWGRP), NULL, bus_rescan_store);
+static BUS_ATTR_WO(rescan);
 
 static struct attribute *pci_bus_attrs[] = {
 	&bus_attr_rescan.attr,
-- 
2.20.1

