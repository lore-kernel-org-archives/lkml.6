Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3941C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885D82073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:38:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 885D82073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbeIFAJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:09:41 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:45538 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728161AbeIFAJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:09:40 -0400
Received: by mail-oi0-f65.google.com with SMTP id t68-v6so15895841oie.12;
        Wed, 05 Sep 2018 12:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/iIXmhGiLNPb+oyB0fqAq/cBY95BW9PeH5qSGmIxXL0=;
        b=YNiwLuyQ4RsQYQzjOJXMBpis6UedyGBVq2QEPiHNc/SQC/2D9dgfCyiXaL0+Ogg8Er
         aLbSEa+cVG3eXaoeRsYQ+WJH3j4sx/Qu3eMdyxGbzpahKGMsV7QpYZDEeaZShZAqOVyT
         wCHgUQBmSn6rLDFE+e0cUqiIhtWFWWkzJfaErhhsgC4sIEj3BLZWnBS9Uu/ou4qbfeO/
         Lz2lUZyDbM/Ie4t2Hk+nq/SoQsOqq8M3EKrAwyY6PutUptoOx57+lw4ZPuFwUT13H1bU
         WtVhotDflt6VMFXN2gjQh1ZpjZBT8pJYD2bQeFnnYY6vBqzBsJb1CKno2vWOq2Oh9L6B
         7Yiw==
X-Gm-Message-State: APzg51AEUsc6tUTO7sexfg2HbT7nTZJefwlAho9TunEw8V9M6V5rnEXQ
        GqmtZFqfNPAedj7MMWrUeU2HjFE=
X-Google-Smtp-Source: ANB0VdZKS1V7q7u2y82Cq4cJ/EcgQdvInIUa9iTr/T3xeLQwHWzjclwzJ6AsJ0r9pzC1SDtWYxMzHw==
X-Received: by 2002:aca:af11:: with SMTP id y17-v6mr29485854oie.274.1536176282314;
        Wed, 05 Sep 2018 12:38:02 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u21-v6sm2296053oie.22.2018.09.05.12.38.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 12:38:01 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org
Subject: [PATCH 19/21] iommu: fsl_pamu: use for_each_of_cpu_node iterator
Date:   Wed,  5 Sep 2018 14:37:36 -0500
Message-Id: <20180905193738.19325-20-robh@kernel.org>
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

Cc: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please ack and I will take via the DT tree. This is dependent on the
first 2 patches.

 drivers/iommu/fsl_pamu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index 8540625796a1..1b955aea44dd 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -543,7 +543,7 @@ u32 get_stash_id(u32 stash_dest_hint, u32 vcpu)
 		return ~(u32)0;
 	}

-	for_each_node_by_type(node, "cpu") {
+	for_each_of_cpu_node(node) {
 		prop = of_get_property(node, "reg", &len);
 		for (i = 0; i < len / sizeof(u32); i++) {
 			if (be32_to_cpup(&prop[i]) == vcpu) {
--
2.17.1
