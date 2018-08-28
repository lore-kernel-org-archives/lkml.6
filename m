Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB12C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B1B208B2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28B1B208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbeH1Fm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:42:27 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35484 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeH1FmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:42:24 -0400
Received: by mail-oi0-f67.google.com with SMTP id m11-v6so34075oic.2;
        Mon, 27 Aug 2018 18:53:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y1qHQResAlD2KiXb5xbn3PbqFItIKYsgzg8ghNozEYM=;
        b=U6Ya18GgbJeNi0NNTi9GPKl4ZM7vRNa6F9iG80jOhPbKSo7yUWNzgLJ3XaB3GrjVvj
         JZf0EiwxSu2iOWv40wARcqAneDgoPifIjC4UFsnQBuBkccUdRhPimdeKGThZMj5hKbxD
         GCYLruSlI3DbSfzHo6YzZiwNae1N2ccgvW9lJNfWV1XTd+EoCr2kV7mSZqIveCAW9SJ6
         WL7AV3gex1ykmpXs9jrrFzz4Q+UwAP2jDBYG+RACZGfyyi5r0G5xMANGDLaivWavYwXX
         vx2kL6X4gAomDAwLilIN3Ek03PDCEw6xMFK+yRJFYobzrnzZJLe0qFuvfd/ovDwbnEgr
         HrOQ==
X-Gm-Message-State: APzg51ALBr9qg/c1AKMt9r1nD9IpGDwQ15WV2/w8nL9BEBkXF/2oTj2Z
        dGy0C+q3/pZ1STnZIhFozUVbkRA=
X-Google-Smtp-Source: ANB0Vdai9JyF0AcNqd3FDZ/WH9kXL8uItZ0UOmSL7ZNHMUQ43wsy2wlwldzmyAJrmSTRJ48AdTyGTw==
X-Received: by 2002:aca:b885:: with SMTP id i127-v6mr1122575oif.180.1535421188866;
        Mon, 27 Aug 2018 18:53:08 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n71-v6sm1652696oig.48.2018.08.27.18.53.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 18:53:08 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH] devfreq: Convert to using %pOFn instead of device_node.name
Date:   Mon, 27 Aug 2018 20:52:16 -0500
Message-Id: <20180828015252.28511-15-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/devfreq/event/exynos-ppmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
index a9c64f0d3284..c61de0bdf053 100644
--- a/drivers/devfreq/event/exynos-ppmu.c
+++ b/drivers/devfreq/event/exynos-ppmu.c
@@ -535,8 +535,8 @@ static int of_get_devfreq_events(struct device_node *np,
 
 		if (i == ARRAY_SIZE(ppmu_events)) {
 			dev_warn(dev,
-				"don't know how to configure events : %s\n",
-				node->name);
+				"don't know how to configure events : %pOFn\n",
+				node);
 			continue;
 		}
 
-- 
2.17.1

