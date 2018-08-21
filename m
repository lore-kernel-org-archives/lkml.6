Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A80DC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 21:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48987217FF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 21:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48987217FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbeHVBRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 21:17:55 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34992 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbeHVBRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 21:17:25 -0400
Received: by mail-oi0-f67.google.com with SMTP id m11-v6so34828685oic.2;
        Tue, 21 Aug 2018 14:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=96bgZeDJu8lmzLzGQEjyQG1f1/HFZ+sSY2PjMNDbDoY=;
        b=YtJpnrICImw/anir2wNfaUrYGmyEvWecitpkr5EGNFQDirwwjHHprEimeAjbc5RE9D
         NxRkRX7RrOXhl7I37IK9jppFnQ/35s+8EnG0U7Dbrr1BPlG3Q93uRIap66zbuKGETi+E
         HNdXuzSEJGNWisbdjsmhG+3ecFiiJ3IlRtCeguOsdv4xJpgOoeHUrtVXHFV4vzuBsfdo
         8+i5p06Cv5ofNDxNlQ7BR1FTWIuwjhAjv18/gJzlieiYbKDq7zqn7O5AawqUxLOMckI/
         HPa/85z5U1FqfnCCmzWv25kRcByJGQWm8ei5xNv9KnU5FyF7ANnCeU5ifAq8/oEaq+km
         Hltw==
X-Gm-Message-State: APzg51DE7dZN3eYa0bmnrNI+opJrAwYtEKkgtt3MY+kggseXG73dfXgM
        RCEW6DwH6FBRRnC6CFSBoj53IPM=
X-Google-Smtp-Source: ANB0VdZjUG/J+LrGaaDkqqe3YpufRpyPA49c/FbjUcMgYxSAlVOsWYx3FFHDbnR0cDbbRZa4JWmr4Q==
X-Received: by 2002:aca:401:: with SMTP id 1-v6mr1152011oie.28.1534888530309;
        Tue, 21 Aug 2018 14:55:30 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id x126-v6sm18785332oig.15.2018.08.21.14.55.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 14:55:29 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Ley Foon Tan <lftan@altera.com>,
        nios2-dev@lists.rocketboards.org
Subject: [PATCH 4/8] nios2: fix building all dtbs
Date:   Tue, 21 Aug 2018 16:55:20 -0500
Message-Id: <20180821215524.23040-5-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180821215524.23040-1-robh@kernel.org>
References: <20180821215524.23040-1-robh@kernel.org>
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

