Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605E8C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB46A2088E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NJxgFelP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB46A2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbeH1VPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:15:50 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:44071 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbeH1VPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:15:49 -0400
Received: by mail-qt0-f194.google.com with SMTP id k38-v6so2581624qtk.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 10:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=8/9S4oNIuaIwN4/KHGrMqpYUYY2ShYnEoEe1dn+7sXs=;
        b=NJxgFelPJNY0tZo6wVPeuqONacOX5cS2PYkHNmJJn/XeJmRJD6qcdy9ebXIn9fpAqS
         mpehpWrdd7O4YddZvdefdFksAKB8nWNnvwh6kZmZYkmeI6/TDWcCWI7fZ5AtN61Z05ks
         InrJVXa6BoVyQz0xqtLVqdlna42SXMpafeJuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8/9S4oNIuaIwN4/KHGrMqpYUYY2ShYnEoEe1dn+7sXs=;
        b=s7vVGTqYm/WwsVJoeR7FoJ1VVL00T587sOQDbrnZhfGGFkH2AO1DXRH0BZKBYB6pxd
         SeNcxtnqrCc9V+jcMeSwcxCRK3qRCqBjx1XUL5yOENoYR+S0oLSDoBXqSeR7jjvVmi5X
         cqQaQdRPYdPkI80bhyPy3Mh8lXpZgZlEw5vK90x4QSA6ZwWn4PmfuCat6Bc1pxIisKPJ
         mRM0IiagGyhUubKnvO4BHRwmy9e1XzBKFZMWGfZLQzEj4vr9xgYdkYQTtlALDZi9HlE6
         aetFUBlxZ55LxL8/e84foF7g8YgbhdY0EtTTf9zLKRxgU5vZZ0NzCFYOFvvzV6YAQMmB
         27dg==
X-Gm-Message-State: APzg51DZ1pNpDHB2ZczMX2iGnVrdzFhF8Fs0FAEvfFuTHguUq/GPEa/W
        24HqWa37Gci/CpHdr3tXzfYmEA==
X-Google-Smtp-Source: ANB0Vda/lxGhzT9eNlrKVfZis0C0qodZcSwdUyc4HihLJ3/n9UgkukV3Gjunmk0kSz0KlkGrwjzNOQ==
X-Received: by 2002:aed:21ac:: with SMTP id l41-v6mr2710899qtc.293.1535476990000;
        Tue, 28 Aug 2018 10:23:10 -0700 (PDT)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id o18-v6sm981868qki.38.2018.08.28.10.23.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 10:23:08 -0700 (PDT)
From:   Ray Jui <ray.jui@broadcom.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        Jitendra Bhivare <jitendra.bhivare@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH] PCI: iproc: Remove PAXC slot check to allow VF support
Date:   Tue, 28 Aug 2018 10:22:58 -0700
Message-Id: <20180828172258.76629-1-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jitendra Bhivare <jitendra.bhivare@broadcom.com>

Fix previous incorrect logic that limits PAXC slot number to zero only.
In order for SRIOV/VF to work, we need to allow the slot number to be
greater than zero.

Fixes: 46560388c476c ("PCI: iproc: Allow multiple devices except on PAXC")
Signed-off-by: Jitendra Bhivare <jitendra.bhivare@broadcom.com>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
---
 drivers/pci/controller/pcie-iproc.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index 3160e9342a2f..c20fd6bd68fd 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -630,14 +630,6 @@ static void __iomem *iproc_pcie_map_cfg_bus(struct iproc_pcie *pcie,
 			return (pcie->base + offset);
 	}
 
-	/*
-	 * PAXC is connected to an internally emulated EP within the SoC.  It
-	 * allows only one device.
-	 */
-	if (pcie->ep_is_internal)
-		if (slot > 0)
-			return NULL;
-
 	return iproc_pcie_map_ep_cfg_reg(pcie, busno, slot, fn, where);
 }
 
-- 
2.17.1

