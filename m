Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D9CC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D91E120850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544037421;
	bh=pV0q+5bPX4IZNDLBU1ft9Yw/2ADgxLU26NMIhukjKSg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=1FU5LCMIeEnrCM+e3qHHf909qq0SKtY4ZvfxOHJKclaDa+Q1QgyBTEsZbbiMGLvJg
	 79MWNbWPA7lbcbbWke67S9lrkhLKgpMtCtBg7PMR7DHYjyAZ6kwd+0pUDc37AWwPt/
	 rWklJF+vjY7iCvNpWtnr+yfwV2odD8edH4i7olNM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D91E120850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbeLETQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:16:59 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34488 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbeLETQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:16:58 -0500
Received: by mail-oi1-f193.google.com with SMTP id h25so18576996oig.1;
        Wed, 05 Dec 2018 11:16:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vJ4tevbNbxREqSgsxj5/TEpmpw/iqRFq5WUY9yVtSgM=;
        b=iaMa3vmmt4XWnABo5ZwJWnrRg5SY9CRUXDnNM95Xi+73GB7o0pDAZPr+y+yMumwjbD
         zYtq8J8zTksjUDTrQOIQWdq5DAxyxMIRfPCokr6z+s/q7iknh8L4/4PC0PozTsQPZi0Y
         o6nStqSiDaJOxpvZCam6T/UGl8i1s5L1iZdGhUbjou75/BTOEtmCrBCBI1RAyvvA3+b2
         X0Ceuta1BHr6g5oLnCyOBRelUzMnGt9Z+WGajaO1p/ZEHupE88COPJ18/bz+hMlgZmkB
         tfVU6iQ9CtEynLH2VUZNc5GiSQBI/8KLgyzxnK7fkdStGIBePAJUSdthstlN2MP7Gjhl
         Pgag==
X-Gm-Message-State: AA+aEWYrYXeg6vNAqZ/Ie7DLd5z+VzyUNMSwBdI+hCxIY5yR2tbkQNhG
        w4zN5pII8cKuSdbYo1sOLw==
X-Google-Smtp-Source: AFSGD/VKQ0mBEaCbGjELAaEHiAqQP6TYFXXAQ7F/F9rdi7OdwKKaDgDGEljwM50VJ2K5lSyGKgBKfA==
X-Received: by 2002:aca:88a:: with SMTP id 132mr568804oii.224.1544037417673;
        Wed, 05 Dec 2018 11:16:57 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id f18sm7355241otl.18.2018.12.05.11.16.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 11:16:56 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: [PATCH v2] misc: cxl: Use device_type helpers to access the node type
Date:   Wed,  5 Dec 2018 13:16:55 -0600
Message-Id: <20181205191655.14612-1-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove directly accessing device_type property and use the
of_node_is_type accessor instead. While not using it here, this is
part of eventually removing the struct device_node.type pointer.

Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linuxppc-dev@lists.ozlabs.org
Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
- Reword commit message as this change was using the .type ptr.

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

