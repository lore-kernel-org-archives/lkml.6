Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F91BC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E78952073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:38:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E78952073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbeIFAKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:10:01 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:45535 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728206AbeIFAJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:09:39 -0400
Received: by mail-oi0-f67.google.com with SMTP id t68-v6so15895746oie.12;
        Wed, 05 Sep 2018 12:38:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UaR34K7qLbNcCLw0wKWUg6RGN//yoBhDn2ndX1R0DnQ=;
        b=uCc9e/72u13+Mi94FibBBdLF3DytcFlN1y3nLtM7QKYgtLfA/teWYV2ZN/5FJ+9v9C
         /BMLJ1CndE69cDhmIQhM+S455XWkxrmVZXAY486satQ4MmrFPw2z1axz9LrOw3W4sf0J
         G47LkECAniA1hu+qHWv4et31e3fJDdzlJ3DazVcGv9HU6B6KvB4KWCFQ+Lj/FIzzAIsZ
         hXqZUdG+1FpMq3EwXZ2cOBLKmMQNEnM76B6YNBzIrUNgVtadsE8rIr+2QBjXpp2rXHgm
         IM8Xpr+2ze6UA559lKdP18BXkw0PdJSkMips47BmSJJkhzVpPj4xhs8NGuziuO5saj8B
         mb3A==
X-Gm-Message-State: APzg51ABOynwt3nI7uQNGXBr3UoouIxCBZAkH3YWBxoZFqRcNn8rTx86
        wkGa17aiBM8h1pKuBH0CO1ni8Q0=
X-Google-Smtp-Source: ANB0VdZHqKWOZDKa0UV7MbWNqJADWpVVtrn0uic03OQLi5QJwDUEjQ1xZ3fDezG5mHEjgvdWZ8cCsQ==
X-Received: by 2002:aca:4455:: with SMTP id r82-v6mr33048297oia.260.1536176280833;
        Wed, 05 Sep 2018 12:38:00 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u21-v6sm2296053oie.22.2018.09.05.12.37.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 12:38:00 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org
Subject: [PATCH 18/21] edac: cpc925: use for_each_of_cpu_node iterator
Date:   Wed,  5 Sep 2018 14:37:35 -0500
Message-Id: <20180905193738.19325-19-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180905193738.19325-1-robh@kernel.org>
References: <20180905193738.19325-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the for_each_of_cpu_node iterator to iterate over cpu nodes. This
has the side effect of defaulting to iterating using "cpu" node names in
preference to the deprecated (for FDT) device_type == "cpu".

Cc: Borislav Petkov <bp@alien8.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-edac@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please ack and I will take via the DT tree. This is dependent on the
first 2 patches.

 drivers/edac/cpc925_edac.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/edac/cpc925_edac.c b/drivers/edac/cpc925_edac.c
index 2c98e020df05..3c0881ac9880 100644
--- a/drivers/edac/cpc925_edac.c
+++ b/drivers/edac/cpc925_edac.c
@@ -593,8 +593,7 @@ static void cpc925_mc_check(struct mem_ctl_info *mci)
 /******************** CPU err device********************************/
 static u32 cpc925_cpu_mask_disabled(void)
 {
-	struct device_node *cpus;
-	struct device_node *cpunode = NULL;
+	struct device_node *cpunode;
 	static u32 mask = 0;

 	/* use cached value if available */
@@ -603,20 +602,8 @@ static u32 cpc925_cpu_mask_disabled(void)

 	mask = APIMASK_ADI0 | APIMASK_ADI1;

-	cpus = of_find_node_by_path("/cpus");
-	if (cpus == NULL) {
-		cpc925_printk(KERN_DEBUG, "No /cpus node !\n");
-		return 0;
-	}
-
-	while ((cpunode = of_get_next_child(cpus, cpunode)) != NULL) {
+	for_each_of_cpu_node(cpunode) {
 		const u32 *reg = of_get_property(cpunode, "reg", NULL);
-
-		if (strcmp(cpunode->type, "cpu")) {
-			cpc925_printk(KERN_ERR, "Not a cpu node in /cpus: %s\n", cpunode->name);
-			continue;
-		}
-
 		if (reg == NULL || *reg > 2) {
 			cpc925_printk(KERN_ERR, "Bad reg value at %pOF\n", cpunode);
 			continue;
@@ -633,9 +620,6 @@ static u32 cpc925_cpu_mask_disabled(void)
 				"Assuming PI id is equal to CPU MPIC id!\n");
 	}

-	of_node_put(cpunode);
-	of_node_put(cpus);
-
 	return mask;
 }

--
2.17.1
