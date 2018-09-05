Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13F6C4321E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715792073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 715792073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbeIFAJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:09:21 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:38140 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbeIFAJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:09:21 -0400
Received: by mail-oi0-f67.google.com with SMTP id x197-v6so15932064oix.5;
        Wed, 05 Sep 2018 12:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MKDQ1pakY0QZK7RcLSpB+cr/rJf9FazHt+NA8s09ORI=;
        b=HKXYtaOuSwZHe5/Ps0odrODp8uKTj1roVC8lbilcCfJIfXqkQxX1KcirBQfcB/WILH
         roSZrDz9cUEatE8xd2XxaSOn39KF7T5Wt0DPZiHD3Fdfb3HVKwGFVeyLa+fmikMVgH6t
         9V0aj15n30jdJzg11a1l9+iL4z5GmHbY9JD5WJeTb/BA4J4HxnB1hLtgOgKQP4p+8z4b
         oKstuFutMrz2n4KoUapsQNdMDXcr8vXKu/QOXaQznfP/JUJM3AkrV0or55ywYi8q2+Zy
         soUBA81oK3x9el+/4qZj1kp+p5q5yekot5KQlKAFM8JGUtNK9F+MutKC1mKfN0ZEDrwm
         HZiw==
X-Gm-Message-State: APzg51AAdC7NCyBuB/+TlsMG7DcjUdxfUMGVdz/xwT96JJHiXiwcSc7/
        YYugAc+5ltgrnqkv4yQZG1Udcj0=
X-Google-Smtp-Source: ANB0VdYQbjTbL1MYa7cmWE9KmKwbuVxG0FCa1tMJIw+DhcNYv4Ts40Oatd3spdRxcisnfsTETWOtrg==
X-Received: by 2002:aca:3d4:: with SMTP id 203-v6mr29749127oid.321.1536176262805;
        Wed, 05 Sep 2018 12:37:42 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u21-v6sm2296053oie.22.2018.09.05.12.37.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 12:37:42 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH 02/21] of: Support matching cpu nodes with no 'reg' property
Date:   Wed,  5 Sep 2018 14:37:19 -0500
Message-Id: <20180905193738.19325-3-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180905193738.19325-1-robh@kernel.org>
References: <20180905193738.19325-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some single core ARM systems, the DTs can have a single cpu node
without a reg property and #address-cells == 0. This case is valid and
should match on cpu #0.

Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/base.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 70609d5a2506..6389aeb2f48c 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -327,6 +327,8 @@ static bool __of_find_n_match_cpu_property(struct device_node *cpun,
 
 	ac = of_n_addr_cells(cpun);
 	cell = of_get_property(cpun, prop_name, &prop_len);
+	if (!cell && !ac && arch_match_cpu_phys_id(cpu, 0))
+		return true;
 	if (!cell || !ac)
 		return false;
 	prop_len /= sizeof(*cell) * ac;
-- 
2.17.1

