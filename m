Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753E0C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30608208B2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30608208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbeH1Fm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:42:26 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:37538 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbeH1FmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:42:25 -0400
Received: by mail-oi0-f67.google.com with SMTP id p84-v6so21525oic.4;
        Mon, 27 Aug 2018 18:53:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LD5n8vla70O/8QlW/oYQ2vGBTkQH4y8gWqmkkMFpZUk=;
        b=VM+30xpRqcRjc15C+RamDpr0DxH8NzWWT6xCDPCebowz+M1mS93CLqkFOCt6BBvexn
         bhaS2wpLtIILPu9cGZfx/IQamTYuUOjOWRVqpU2arXC7PrD8MvvzQF0589pjX+hlr6o8
         qSQvXnmyW6xz9MHMPwnsb3rAntNdLIwh/7NfUdTDOkj+Q6gHHXrdMtDLWsYoohrjexjn
         qCLIAHkLVVjIfbNTbtDkXtSZNUb2m2RT5ZuSVWSS6OEVhys07Pf1vPzRzsyWMLWcwfi8
         ZyIAQ2PxI2/MwQ6wQSHZ14Svrpe59tA/ggBjcbdKX1LtxIJJlEx/2sBmBokZ9CHuApUf
         rD0g==
X-Gm-Message-State: APzg51AyFXDjINJYLsqyVQc/pSuDIkR9eK6duxMsZ7A9YwckQ+mGWnIy
        e9Lwy7lI369k79ZuiK227zwsJ2E=
X-Google-Smtp-Source: ANB0VdZyYN/g81IBDks6lxim/7+dRpHUpikIGXeL/yzEOl1l/ezwI7dkWO3ms7RtUxcukiic84J7yA==
X-Received: by 2002:aca:5cd4:: with SMTP id q203-v6mr964953oib.217.1535421189706;
        Mon, 27 Aug 2018 18:53:09 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n71-v6sm1652696oig.48.2018.08.27.18.53.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 18:53:09 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Subject: [PATCH] dmaengine: Convert to using %pOFn instead of device_node.name
Date:   Mon, 27 Aug 2018 20:52:17 -0500
Message-Id: <20180828015252.28511-16-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/dma/nbpfaxi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
index 8c7b2e8703da..8d4914cd06f0 100644
--- a/drivers/dma/nbpfaxi.c
+++ b/drivers/dma/nbpfaxi.c
@@ -1095,8 +1095,8 @@ static struct dma_chan *nbpf_of_xlate(struct of_phandle_args *dma_spec,
 	if (!dchan)
 		return NULL;
 
-	dev_dbg(dchan->device->dev, "Entry %s(%s)\n", __func__,
-		dma_spec->np->name);
+	dev_dbg(dchan->device->dev, "Entry %s(%pOFn)\n", __func__,
+		dma_spec->np);
 
 	chan = nbpf_to_chan(dchan);
 
-- 
2.17.1

