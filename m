Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB333C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E6A2086B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:11:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8E6A2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbeKQIZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 03:25:19 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34337 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeKQIZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 03:25:18 -0500
Received: by mail-ot1-f66.google.com with SMTP id t5so22780341otk.1;
        Fri, 16 Nov 2018 14:11:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z20+2CzOTLX/2B946rI2J1ZHpCgM0oKasDbqmx4HY5Y=;
        b=M2NdLCHxbYtrPKCw/dgm5o+x1MCWpb/U+p/Dx/jDee4E7hxzPxq6dfHYxhf/1vHOGL
         9E9SE9ZL40EQvZFqfDBUqh86bDQvJJnvCrp65vYviIM9rjFSlLQke+zEuSKk5hFKLhXd
         EmUUY5a8/XawVDa/CKmGXV1TluAysMpyRVhXs7hbLEGoCiUNk6ltHOcjsDP2KEpJFNAO
         9+xXCqMZH+UZ4aMUHLyRUGBlAPUa1k5ytC9eYYuyBff9kk0GSBDR+GQ0LiSxemNU4lME
         2wcue1yFDQh/fDurBJP9Au8L1Zn+X+SKgwRz1mNbMf0jwal/Ury70d6IqRyYxBN09Xi7
         NCeg==
X-Gm-Message-State: AGRZ1gLqCl2xVoBnd295kbZVU+SuTTjk9bV9ADl3AS6RG9Ez/hpRauNk
        nQWKYYLRS2k/QVJYwiTXYT/uGwb5IA==
X-Google-Smtp-Source: AJdET5eaxUPAckeT83rduY/9RFbvb2md1aAZb9TQgnWgNI3PhP1aqsTovP09yU1ErJeR+3XGal+APA==
X-Received: by 2002:a9d:118a:: with SMTP id v10mr7014258otf.281.1542406267698;
        Fri, 16 Nov 2018 14:11:07 -0800 (PST)
Received: from localhost.localdomain (mobile-166-173-57-127.mycingular.net. [166.173.57.127])
        by smtp.googlemail.com with ESMTPSA id p204-v6sm12142631oib.25.2018.11.16.14.11.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 14:11:07 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     James Hogan <jhogan@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>, linux-mips@linux-mips.org
Subject: [PATCH] MIPS: Use device_type helpers to access the node type
Date:   Fri, 16 Nov 2018 16:10:58 -0600
Message-Id: <20181116221104.23024-2-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove directly accessing device_node.type pointer and use the accessors
instead. This will eventually allow removing the type pointer.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/mips/pci/pci-rt3883.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/mips/pci/pci-rt3883.c b/arch/mips/pci/pci-rt3883.c
index 958899ffe99c..bafbf69e7dc4 100644
--- a/arch/mips/pci/pci-rt3883.c
+++ b/arch/mips/pci/pci-rt3883.c
@@ -445,8 +445,7 @@ static int rt3883_pci_probe(struct platform_device *pdev)
 
 	/* find the PCI host bridge child node */
 	for_each_child_of_node(np, child) {
-		if (child->type &&
-		    of_node_cmp(child->type, "pci") == 0) {
+		if (of_node_is_type(child, "pci")) {
 			rpc->pci_controller.of_node = child;
 			break;
 		}
@@ -464,8 +463,7 @@ static int rt3883_pci_probe(struct platform_device *pdev)
 	for_each_available_child_of_node(rpc->pci_controller.of_node, child) {
 		int devfn;
 
-		if (!child->type ||
-		    of_node_cmp(child->type, "pci") != 0)
+		if (!of_node_is_type(child, "pci"))
 			continue;
 
 		devfn = of_pci_get_devfn(child);
-- 
2.19.1

