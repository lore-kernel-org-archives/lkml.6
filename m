Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695EAC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 386782146D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 386782146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbeJAWD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:03:59 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39344 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729624AbeJAWD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:03:58 -0400
Received: by mail-ot1-f65.google.com with SMTP id c20-v6so6912589otl.6;
        Mon, 01 Oct 2018 08:25:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=96bgZeDJu8lmzLzGQEjyQG1f1/HFZ+sSY2PjMNDbDoY=;
        b=F3aaTbMOeoc4Khz/PiN9swzdUYVLG1TB+nstWJqqM1VLqP8l9VdKnAILtT5sJUmWcc
         RtE9/xMNtN2XtUhnlRE6QZZVClmW9lQiDR7Uw7/OLQ7RInXq0pnPqqisn7X2z3OlSG+r
         bUZHRyoMmodS0tLi+7b9ZCZQ4u8qSRiiu3RosHOVG8qyMHA6EFZY2qamCZHyLDu4oOYA
         l8okO2wS+q7z5GmPhLgJyCQXUiDbCSAaQWSu9PK1bJ9pTWuA0ljiqswf9+vVL8nQQjFC
         55wsTeXprB8x+1kdbSLyf2rlh4SZkyTX31bKCzrn2RIRAZTzA9L+sCgF6WqGS5SY9i0E
         Kyug==
X-Gm-Message-State: ABuFfogbU5215t9+j4JuZhhMhpWQo/pK1sCWI5QU5TDJDnG91+M/BJi0
        EO3a0t08yZaAOLbZ4/rvpewhvP2ieA==
X-Google-Smtp-Source: ACcGV61gN8sDQ7ZwgxiXNG0uhgpzyr7CRLiPI4AFYaRCsT0e9dKIaehV4clVuU9XfPSCT5gbbC2fdg==
X-Received: by 2002:a9d:32c8:: with SMTP id u66-v6mr6234462otb.156.1538407538647;
        Mon, 01 Oct 2018 08:25:38 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id s203-v6sm2047035oif.33.2018.10.01.08.25.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 08:25:38 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Ley Foon Tan <lftan@altera.com>, nios2-dev@lists.rocketboards.org
Subject: [PATCH v4 4/9] nios2: fix building all dtbs
Date:   Mon,  1 Oct 2018 10:25:26 -0500
Message-Id: <20181001152531.3385-5-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181001152531.3385-1-robh@kernel.org>
References: <20181001152531.3385-1-robh@kernel.org>
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

