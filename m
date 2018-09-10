Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67F0C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85BAE20880
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:04:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85BAE20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbeIJT6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:58:47 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:43556 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbeIJT6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:58:47 -0400
Received: by mail-oi0-f68.google.com with SMTP id b15-v6so40700776oib.10;
        Mon, 10 Sep 2018 08:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=96bgZeDJu8lmzLzGQEjyQG1f1/HFZ+sSY2PjMNDbDoY=;
        b=NJXqkmoqngjRO+h68JUhVBkwT5wGvz4tnPMIdMUnrz/T/Tl8PMOUfrjKnkhBa8x9S5
         2wOOaCLnvRbQBRrGl85bqemENNk+IM7mXUVpKwZiIHiOeBGkfbdwkx9p7BtSDwJ4Cctf
         cYUIJ9VBw6bTGjcSwlGeMpbHZizWa+XqEVAtApApp5Po7v0aBlrrj5JeVuqS0Yd5DeQW
         YnflYxhD2SJRin+fW51787tBwBq3YcCV1ilTH7J2uiaL8gM+5F3O3mQXjDl1J0MOdL73
         KeMnZYo4BnEr9Dm06OV6nsnDByHMup8fycd54COhVJ4RkL1TEnTli5aQ39LR8LNzjH0a
         16Sw==
X-Gm-Message-State: APzg51DkJAONxTUtQ4aagVToCu8ZXoR5s0QGZNzET6nnJ1yriwUgPWRd
        UwhJ3V2mbyBfy1QynOxp0fGCayA=
X-Google-Smtp-Source: ANB0VdaPDp8+4xSUGBhRa/u7QkzIE8jXUFOH91J12+sv8KOR8gNDnQv6lkPoJajpDbZ4bcDrXULSvw==
X-Received: by 2002:aca:c5d8:: with SMTP id v207-v6mr23101050oif.264.1536591851179;
        Mon, 10 Sep 2018 08:04:11 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id k85-v6sm49465631oiy.2.2018.09.10.08.04.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 08:04:10 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Ley Foon Tan <lftan@altera.com>,
        nios2-dev@lists.rocketboards.org
Subject: [PATCH v3 4/9] nios2: fix building all dtbs
Date:   Mon, 10 Sep 2018 10:03:58 -0500
Message-Id: <20180910150403.19476-5-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180910150403.19476-1-robh@kernel.org>
References: <20180910150403.19476-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nios2 has a 'dtbs' target, but nothing is added to 'dtb-*' targets and
no dtbs were getting built. This enables building all the dts files in
arch/nios2/boot/dts/ when COMPILE_TEST and OF_ALL_DTBS are enabled.

Cc: Ley Foon Tan <lftan@altera.com>
Cc: nios2-dev@lists.rocketboards.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/nios2/boot/dts/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/nios2/boot/dts/Makefile b/arch/nios2/boot/dts/Makefile
index f6358e395b25..a91a0b09be63 100644
--- a/arch/nios2/boot/dts/Makefile
+++ b/arch/nios2/boot/dts/Makefile
@@ -1,3 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-y := $(patsubst "%.dts",%.dtb.o,$(CONFIG_NIOS2_DTB_SOURCE))
+
+dtstree		:= $(srctree)/$(src)
+dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
-- 
2.17.1

