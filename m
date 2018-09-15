Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0807FECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 04:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DFE220881
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 04:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKMqdGm4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DFE220881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbeIOJY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 05:24:28 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38665 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbeIOJY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 05:24:28 -0400
Received: by mail-pf1-f193.google.com with SMTP id x17-v6so5154881pfh.5;
        Fri, 14 Sep 2018 21:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ypZH1fqiIN6FCUM/Eys54o238UT3dDOHuvv9WEvDJoY=;
        b=OKMqdGm4bwq5n1dx8NCZXY5eV/Yw+kgywF1bzUiE70p7hmN/mmTaobAhH5tsFrEQ8H
         ptHl1pttOK9nnfCnegN9nvTZr23+zjSiZ0kwW2vI+svQpydMwUciRPEoepIOthCOIv8z
         MZFYlEOAqLnsgp6D66pSTlJbmfmG+yCXxKp5neAhoSrpPkTXNrKEMDEqw3oiNvQc7hs1
         NLSbOYmxmwYNMa9ML2ek+5gFkQPwm+L3p1XhV31awTaBGwS5FXnn7puluy29+sJ3hcOk
         wM22TIzsjXyc573yBw9g3NgPrV/lfihUodIW6+2r2CscJ0yKgfYhYkTBNmfa8iffdWG8
         EfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ypZH1fqiIN6FCUM/Eys54o238UT3dDOHuvv9WEvDJoY=;
        b=NbfpE6aawo+G0/gBe66VmVsn6jK0UG1/E9VPPCOgSNxI3BBycFr+LCHWXpaM7/gsMG
         EibwZPYg8/lsnmjY7ucTwT3AYFUuTO5j6LXWr0JCcrejiiQxyms2AL5P5TeFqIh+q8SM
         gOKwNCGvvRNUgRyLrJWwcQh4mYPN+Qt+pzxlVLR41mYe0sUs/wwZv7TEa3ZyJyzd/vGP
         MLowv47JuucqRF8jtT6pbtDE1OGW3QmywfuAVn95SxLi6ZWveyZPPIyS8lCfATL9uTru
         4cJ1BD0G1L1CuMEmmZxoJTK8lQlfs02SUy9/XooWIsawtc7jYSaxA3K4PPc5Tq9AwJ39
         RYTg==
X-Gm-Message-State: APzg51AXDT1mZydNwtjX4Tw2qNNqHcuZP3/OW9B6L1jFb104N1OFhGf6
        lh3gMCtYJl/XIezAyRjw6Ys=
X-Google-Smtp-Source: ANB0Vdb+WeiAJ8XBg3QxlcwWLe7lsGpGG30zGbNZhaEpbrBjF6PJxhTYRR8YneMxb3upRt3mC5wT2g==
X-Received: by 2002:a62:205d:: with SMTP id g90-v6mr15567169pfg.253.1536984419499;
        Fri, 14 Sep 2018 21:06:59 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:947c:62c0:a59c:7c99])
        by smtp.gmail.com with ESMTPSA id k126-v6sm11544016pgk.26.2018.09.14.21.06.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 21:06:58 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     davem@davemloft.net, hayashi.kunihiko@socionext.com,
        yamada.masahiro@socionext.com, robh@kernel.org, andrew@lunn.ch
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] net: socionext: Fix two sleep-in-atomic-context bugs in ave_rxfifo_reset()
Date:   Sat, 15 Sep 2018 12:02:46 +0800
Message-Id: <20180915040246.22703-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver may sleep with holding a spinlock.
The function call paths (from bottom to top) in Linux-4.17 are:

[FUNC] usleep_range
drivers/net/ethernet/socionext/sni_ave.c, 892: 
	usleep_range in ave_rxfifo_reset
drivers/net/ethernet/socionext/sni_ave.c, 932: 
	ave_rxfifo_reset in ave_irq_handler

[FUNC] usleep_range
drivers/net/ethernet/socionext/sni_ave.c, 888: 
	usleep_range in ave_rxfifo_reset
drivers/net/ethernet/socionext/sni_ave.c, 932: 
	ave_rxfifo_reset in ave_irq_handler

To fix these bugs, usleep_range() is replaced with udelay().

These bugs are found by my static analysis tool DSAC.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/net/ethernet/socionext/sni_ave.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/socionext/sni_ave.c b/drivers/net/ethernet/socionext/sni_ave.c
index f7ecceeb1e28..3c784a29ce0d 100644
--- a/drivers/net/ethernet/socionext/sni_ave.c
+++ b/drivers/net/ethernet/socionext/sni_ave.c
@@ -904,11 +904,11 @@ static void ave_rxfifo_reset(struct net_device *ndev)
 
 	/* assert reset */
 	writel(AVE_GRR_RXFFR, priv->base + AVE_GRR);
-	usleep_range(40, 50);
+	udelay(50);
 
 	/* negate reset */
 	writel(0, priv->base + AVE_GRR);
-	usleep_range(10, 20);
+	udelay(20);
 
 	/* negate interrupt status */
 	writel(AVE_GI_RXOVF, priv->base + AVE_GISR);
-- 
2.17.0

