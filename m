Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97942C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DFF12086A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:44:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DFF12086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbeH1Tgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:36:50 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:32894 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeH1Tgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:36:50 -0400
Received: by mail-oi0-f65.google.com with SMTP id 8-v6so3696544oip.0;
        Tue, 28 Aug 2018 08:44:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:content-transfer-encoding;
        bh=QDIFD17YEn+kqfLMMb6i4R6ZHoL97FcQhi7EfT6umuo=;
        b=ZQAeQYpAAWEIuQ64ujisB5HdqA1Fp7dZs+N2n209ENUwOfJNDwdEFLHL+qfUlrt7pE
         8BjWm8hYGfu/IO4njxPr3ASH1kNBUipvo086atMf3UhuEtxXN4irpo6FGgGPpdjRom1L
         Zrz6czdGNJtZvcHlA2YV7DXnRvXZJfWgsw5sdp8d+FH5R4Wnizvsk1cSnZZCYKt0Be0V
         OFuR36AUPD4eklgS63eHRAK/SloVOjXcnqK8uM0P7qkRAFaccjog3GKKxKeUCPhJo/IK
         d0jukelYJNxwWpWJw7PbVw6TXbJs6NWxyIxj0GCra+WR8RGLDi6sxh24q3n+AEURUCNu
         UGsg==
X-Gm-Message-State: APzg51Bnqpcc9wJKsmWKD5NpPgE04ruavTvA1owkhafImsf0BAETNo/3
        a9B5p+PalDyWctb9mGT/8OuAWMM=
X-Google-Smtp-Source: ANB0VdaYOm5KUmtvVSO2o6ugpDveQrFuk5Zk6OOmlUtf0Kp8+kDzhuba2MxX9wWKZfeOopY4OMsbMQ==
X-Received: by 2002:aca:6044:: with SMTP id u65-v6mr1745651oib.323.1535471075119;
        Tue, 28 Aug 2018 08:44:35 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id f4-v6sm1808331oic.52.2018.08.28.08.44.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 08:44:34 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Joe Perches <joe@perches.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Paul Walmsley <paul@pwsan.com>,
        Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] ARM: omap: Convert to using %pOFn instead of device_node.name
Date:   Tue, 28 Aug 2018 10:44:27 -0500
Message-Id: <20180828154433.5693-1-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: "Benoît Cousson" <bcousson@baylibre.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
- fix error in format specifier position

 arch/arm/mach-omap2/omap_hwmod.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 2ceffd85dd3d..9cc339048173 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -738,7 +738,7 @@ static int __init _setup_clkctrl_provider(struct device_node *np)
 	provider->size = size | 0xff;
 	provider->node = np;

-	pr_debug("%s: %s: %x...%x [+%x]\n", __func__, np->parent->name,
+	pr_debug("%s: %pOFn: %x...%x [+%x]\n", __func__, np->parent,
 		 provider->addr, provider->addr + provider->size,
 		 provider->offset);

@@ -799,9 +799,9 @@ static struct clk *_lookup_clkctrl_clk(struct omap_hwmod *oh)

 			clk = of_clk_get_from_provider(&clkspec);

-			pr_debug("%s: %s got %p (offset=%x, provider=%s)\n",
+			pr_debug("%s: %s got %p (offset=%x, provider=%pOFn)\n",
 				 __func__, oh->name, clk, clkspec.args[0],
-				 provider->node->parent->name);
+				 provider->node->parent);

 			return clk;
 		}
@@ -2107,8 +2107,8 @@ static int of_dev_find_hwmod(struct device_node *np,
 		if (res)
 			continue;
 		if (!strcmp(p, oh->name)) {
-			pr_debug("omap_hwmod: dt %s[%i] uses hwmod %s\n",
-				 np->name, i, oh->name);
+			pr_debug("omap_hwmod: dt %pOFn[%i] uses hwmod %s\n",
+				 np, i, oh->name);
 			return i;
 		}
 	}
@@ -2210,8 +2210,8 @@ int omap_hwmod_parse_module_range(struct omap_hwmod *oh,
 		return -ENOENT;

 	if (nr_addr != 1 || nr_size != 1) {
-		pr_err("%s: invalid range for %s->%s\n", __func__,
-		       oh->name, np->name);
+		pr_err("%s: invalid range for %s->%pOFn\n", __func__,
+		       oh->name, np);
 		return -EINVAL;
 	}

@@ -2219,8 +2219,8 @@ int omap_hwmod_parse_module_range(struct omap_hwmod *oh,
 	base = of_translate_address(np, ranges++);
 	size = be32_to_cpup(ranges);

-	pr_debug("omap_hwmod: %s %s at 0x%llx size 0x%llx\n",
-		 oh->name, np->name, base, size);
+	pr_debug("omap_hwmod: %s %pOFn at 0x%llx size 0x%llx\n",
+		 oh->name, np, base, size);

 	res->start = base;
 	res->end = base + size - 1;
@@ -2322,8 +2322,8 @@ static int __init _init(struct omap_hwmod *oh, void *data)
 	if (r)
 		pr_debug("omap_hwmod: %s missing dt data\n", oh->name);
 	else if (np && index)
-		pr_warn("omap_hwmod: %s using broken dt data from %s\n",
-			oh->name, np->name);
+		pr_warn("omap_hwmod: %s using broken dt data from %pOFn\n",
+			oh->name, np);

 	r = _init_mpu_rt_base(oh, NULL, index, np);
 	if (r < 0) {
--
2.17.1
