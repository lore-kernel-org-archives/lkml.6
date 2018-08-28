Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8F0C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6180420645
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6180420645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbeH1FoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:44:19 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:44266 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbeH1FoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:44:18 -0400
Received: by mail-oi0-f68.google.com with SMTP id l82-v6so1713325oih.11;
        Mon, 27 Aug 2018 18:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R/zzWRmdkz+/e+qsAXR3rufuCezNemtFvvshUfI3oCs=;
        b=C/Tt/9jAvuuDF74LY8c3PSiW7z2abqcJjUvYIptp1qK9gO6mQKHqYw9Wd1DvfpQcmC
         I4dXYNklFkyGjciaLtquTj24nILroaWwqL9z0W2F3hi0PWAo/4JOaPKKB7L6+mHVry+d
         DVmZ/XrgVFPEjfb++V9G0G6+ILlJsdhyuZoHeH9FgN2QlENJaYX29nQC/9ytjl2NDp6q
         n7cZLtNXWlyqlpGMFI8/G2/XeHP/70GkqQ0YqED2OQf+Rjq43TtiEwyRkq2yFgKyXihx
         HiuQAMrTJ5r0zhIi1zFqP+83ECt8J8SYNLY4KD0oQlO1DFR1dWxpqxAjua2oHWT93LJM
         i4JQ==
X-Gm-Message-State: APzg51BhR8PG9rVPrVSnEtuA/rJxkWGlLgwNIEj5eRv3fNXRp5z77RFm
        dg1U9aWfEd9ywKFO0yqdJ89C+fI=
X-Google-Smtp-Source: ANB0VdbonGIAfFvj9SpkklnAVuNdTGPUYyokLV4GPv+LcZ8ZMVcszaiQGsTwSllkkDAeBAvUmsSn8A==
X-Received: by 2002:a54:448b:: with SMTP id v11-v6mr1173427oiv.208.1535421302005;
        Mon, 27 Aug 2018 18:55:02 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n71-v6sm1652696oig.48.2018.08.27.18.55.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 18:55:01 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: [PATCH] net: phy: Convert to using %pOFn instead of device_node.name
Date:   Mon, 27 Aug 2018 20:52:36 -0500
Message-Id: <20180828015252.28511-35-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/net/phy/mdio-thunder.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/mdio-thunder.c b/drivers/net/phy/mdio-thunder.c
index 564616968cad..1546f6398831 100644
--- a/drivers/net/phy/mdio-thunder.c
+++ b/drivers/net/phy/mdio-thunder.c
@@ -73,8 +73,8 @@ static int thunder_mdiobus_pci_probe(struct pci_dev *pdev,
 		err = of_address_to_resource(node, 0, &r);
 		if (err) {
 			dev_err(&pdev->dev,
-				"Couldn't translate address for \"%s\"\n",
-				node->name);
+				"Couldn't translate address for \"%pOFn\"\n",
+				node);
 			break;
 		}
 
-- 
2.17.1

