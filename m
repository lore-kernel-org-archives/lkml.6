Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D19C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38032218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545378899;
	bh=47S8YJipzUMBfrOzpB93E4MJioF9T1iRgreKTFl+cqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uA25WLkC8N7FMmFcNpP56fY1enTE3QG+sSbz88M1EbNfPtuMDq2AxEVfPJdmkqcQu
	 7A0jq9c4gkBztxH9NZ00P1xI8s1woGAwh46kz9ZQ3bGT8mtHaYqLuDrIQdlUzO8+Un
	 vQykzVNWJhTzdZe+DLzL2/NYkU9W3UydHh2gV2Jo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732619AbeLUHy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:54:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:59184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731366AbeLUHyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 02:54:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5064218F0;
        Fri, 21 Dec 2018 07:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545378895;
        bh=47S8YJipzUMBfrOzpB93E4MJioF9T1iRgreKTFl+cqc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fZI+770d5Y29JgTm41cokVGArX9Eb6srlSgGac7yoD+NCgSQXtLIVuTmWLLiSZ7NH
         1UFYMGmwFLIns2WPYaPMg4CugKlGJ/5msisw51tPxoqozu/OOzWhlbIb/iVE2phTwz
         Q37cbrjzfu9LoPNfLPdaPmEMuy637LNMcl8+UdCs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 01/10] PCI: pci.c: convert to use BUS_ATTR_RW
Date:   Fri, 21 Dec 2018 08:54:33 +0100
Message-Id: <20181221075442.17109-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181221075442.17109-1-gregkh@linuxfoundation.org>
References: <20181221075442.17109-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are trying to get rid of BUS_ATTR() and the usage of that in pci.c
can be trivially converted to use BUS_ATTR_RW(), so use that instead.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/pci.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c9d8e3c837de..fda84538de79 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6034,19 +6034,18 @@ static ssize_t pci_get_resource_alignment_param(char *buf, size_t size)
 	return count;
 }
 
-static ssize_t pci_resource_alignment_show(struct bus_type *bus, char *buf)
+static ssize_t resource_alignment_show(struct bus_type *bus, char *buf)
 {
 	return pci_get_resource_alignment_param(buf, PAGE_SIZE);
 }
 
-static ssize_t pci_resource_alignment_store(struct bus_type *bus,
+static ssize_t resource_alignment_store(struct bus_type *bus,
 					const char *buf, size_t count)
 {
 	return pci_set_resource_alignment_param(buf, count);
 }
 
-static BUS_ATTR(resource_alignment, 0644, pci_resource_alignment_show,
-					pci_resource_alignment_store);
+static BUS_ATTR_RW(resource_alignment);
 
 static int __init pci_resource_alignment_sysfs_init(void)
 {
-- 
2.20.1

