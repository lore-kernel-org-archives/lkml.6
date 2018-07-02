Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1C6C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4055920A8B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4055920A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933674AbeGBIV1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 04:21:27 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:48724 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933544AbeGBIVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 04:21:21 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 43A282939A; Mon,  2 Jul 2018 04:21:18 -0400 (EDT)
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-m68k@lists.linux-m68k.org>,
        <linux-kernel@vger.kernel.org>
Message-Id: <720e9899186bed184fb9b5cce070e2dc519f9665.1530519301.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1530519301.git.fthain@telegraphics.com.au>
References: <cover.1530519301.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v4 01/11] macintosh/via-pmu: Fix section mismatch warning
Date:   Mon,  2 Jul 2018 04:21:18 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pmu_init() function has the __init qualifier, but the ops struct
that holds a pointer to it does not. This causes a build warning.
The driver works fine because the pointer is only dereferenced early.

The function is so small that there's negligible benefit from using
the __init qualifier. Remove it to fix the warning, consistent with
the other ADB drivers.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/macintosh/via-pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index 25c1ce811053..f8a2c917201f 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -378,7 +378,7 @@ static int pmu_probe(void)
 	return vias == NULL? -ENODEV: 0;
 }
 
-static int __init pmu_init(void)
+static int pmu_init(void)
 {
 	if (vias == NULL)
 		return -ENODEV;
-- 
2.16.4

