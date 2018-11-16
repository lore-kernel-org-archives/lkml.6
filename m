Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CF4C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CCFA2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:11:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CCFA2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbeKQIZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 03:25:28 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43601 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeKQIZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 03:25:27 -0500
Received: by mail-ot1-f68.google.com with SMTP id a11so19077103otr.10;
        Fri, 16 Nov 2018 14:11:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/G7/uyz7QXf7tbLsILQzDHnS++eVzTBhhnns0VhMoTU=;
        b=i2BfIrzE3LCLUWGdBxBXe0o3Rh2p1OLGcVKifqyipq0LGzJv+Le7X6NrfTSLwEwzuB
         Mhu4j+5h3zrcv7K1F3dkw++Xl9CRs7EIsuoDUGdoD6O5gLxZqxfDmsTkLFZPM6dKDjsC
         O6X+JzZwNohwKpTmTv7GuQNjVOK21lWdPVFl53IFgJNKHGNLATttONBwGoqdfVVUfgPE
         lgRCWw/zq0Ehg6LiDmHSXmXLa9G7knBxZM5LitCJYUVRO24vHipIoXz37TbZs6fCMs9d
         efqYOa9egqfGA36NOQG3cQ4gr3B7I8DqsgBp0u9GACJA4P7ho0wXHOEHuVSOklPrXxfb
         GT7A==
X-Gm-Message-State: AGRZ1gIf+cKUucH+cnJ9fdrsYu9e99S/z47ihY/XrTULHwlLNfp5X/cQ
        ffI+a9dQiFhH7NU7pPIgbQ==
X-Google-Smtp-Source: AJdET5cWuhY2KdZgilsbDi9ELt6Qu3qVpFGjMszfurOkQ2/mGAYfFrz93y19BKkVbvz8nyiLfYcfyA==
X-Received: by 2002:a9d:75da:: with SMTP id c26mr7966790otl.39.1542406276903;
        Fri, 16 Nov 2018 14:11:16 -0800 (PST)
Received: from localhost.localdomain (mobile-166-173-57-127.mycingular.net. [166.173.57.127])
        by smtp.googlemail.com with ESMTPSA id p204-v6sm12142631oib.25.2018.11.16.14.11.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 14:11:16 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] misc: cxl: Use device_type helpers to access the node type
Date:   Fri, 16 Nov 2018 16:11:02 -0600
Message-Id: <20181116221104.23024-6-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove directly accessing device_node.type pointer and use the accessors
instead. This will eventually allow removing the type pointer.

Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/misc/cxl/pci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index b66d832d3233..c79ba1c699ad 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -1718,7 +1718,6 @@ int cxl_slot_is_switched(struct pci_dev *dev)
 {
 	struct device_node *np;
 	int depth = 0;
-	const __be32 *prop;
 
 	if (!(np = pci_device_to_OF_node(dev))) {
 		pr_err("cxl: np = NULL\n");
@@ -1727,8 +1726,7 @@ int cxl_slot_is_switched(struct pci_dev *dev)
 	of_node_get(np);
 	while (np) {
 		np = of_get_next_parent(np);
-		prop = of_get_property(np, "device_type", NULL);
-		if (!prop || strcmp((char *)prop, "pciex"))
+		if (!of_node_is_type(np, "pciex"))
 			break;
 		depth++;
 	}
-- 
2.19.1

