Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FCBC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 13:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF0A20665
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 13:56:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDF0A20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbeJZWdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 18:33:37 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59533 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726014AbeJZWdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 18:33:37 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 378C7C40EAC34;
        Fri, 26 Oct 2018 21:56:21 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Fri, 26 Oct 2018 21:56:14 +0800
From:   John Garry <john.garry@huawei.com>
To:     <catalin.marinas@arm.com>, <will.deacon@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH] arm64/numa: Add more vetting in numa_set_distance()
Date:   Fri, 26 Oct 2018 21:57:47 +0800
Message-ID: <1540562267-101152-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently it is acceptable to set the distance between 2 separate nodes to
LOCAL_DISTANCE.

Reject this as it is invalid.

This change avoids a crash reported in [1].

[1] https://www.spinics.net/lists/arm-kernel/msg683304.html

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
index 146c04c..6092e3d 100644
--- a/arch/arm64/mm/numa.c
+++ b/arch/arm64/mm/numa.c
@@ -335,7 +335,8 @@ void __init numa_set_distance(int from, int to, int distance)
 	}
 
 	if ((u8)distance != distance ||
-	    (from == to && distance != LOCAL_DISTANCE)) {
+	    (from == to && distance != LOCAL_DISTANCE) ||
+	    (from != to && distance == LOCAL_DISTANCE)) {
 		pr_warn_once("Warning: invalid distance parameter, from=%d to=%d distance=%d\n",
 			     from, to, distance);
 		return;
-- 
1.9.1

