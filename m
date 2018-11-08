Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035B3C46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81B920825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C81B920825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbeKHTuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 14:50:04 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:14615 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726955AbeKHTuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 14:50:04 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3DADD162ADF3F;
        Thu,  8 Nov 2018 18:15:16 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.408.0; Thu, 8 Nov 2018 18:15:10 +0800
From:   John Garry <john.garry@huawei.com>
To:     <robh+dt@kernel.org>, <frowand.list@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <will.deacon@arm.com>,
        <anshuman.khandual@arm.com>, <peterz@infradead.org>
Subject: [PATCH v2] of, numa: Validate some distance map rules
Date:   Thu, 8 Nov 2018 18:17:03 +0800
Message-ID: <1541672223-131326-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the NUMA distance map parsing does not validate the distance
table for the distance-matrix rules 1-2 in [1].

However the arch NUMA code may enforce some of these rules, but not all.
Such is the case for the arm64 port, which does not enforce the rule that
the distance between separates nodes cannot equal LOCAL_DISTANCE.

The patch adds the following rules validation:
- distance of node to self equals LOCAL_DISTANCE
- distance of separate nodes > LOCAL_DISTANCE

This change avoids a yet-unresolved crash reported in [2].

A note on dealing with symmetrical distances between nodes:

Validating symmetrical distances between nodes is difficult. If it were
mandated in the bindings that every distance must be recorded in the
table, then it would be easy. However, it isn't.

In addition to this, it is also possible to record [b, a] distance only
(and not [a, b]). So, when processing the table for [b, a], we cannot
assert that current distance of [a, b] != [b, a] as invalid, as [a, b]
distance may not be present in the table and current distance would be
default at REMOTE_DISTANCE.

As such, we maintain the policy that we overwrite distance [a, b] = [b, a]
for b > a. This policy is different to kernel ACPI SLIT validation, which
allows non-symmetrical distances (ACPI spec SLIT rules allow it). However,
the distance debug message is dropped as it may be misleading (for a distance
which is later overwritten).

Some final notes on semantics:

- It is implied that it is the responsibility of the arch NUMA code to
  reset the NUMA distance map for an error in distance map parsing.

- It is the responsibility of the FW NUMA topology parsing (whether OF or
  ACPI) to enforce NUMA distance rules, and not arch NUMA code.

[1] Documents/devicetree/bindings/numa.txt
[2] https://www.spinics.net/lists/arm-kernel/msg683304.html

Cc: stable@vger.kernel.org # 4.7
Signed-off-by: John Garry <john.garry@huawei.com>
Acked-by: Will Deacon <will.deacon@arm.com>
---
Changes from v1:
- Add note on masking crash reported
- Add Will's tag
- Add cc stable

diff --git a/drivers/of/of_numa.c b/drivers/of/of_numa.c
index 35c64a4295e0..fe6b13608e51 100644
--- a/drivers/of/of_numa.c
+++ b/drivers/of/of_numa.c
@@ -104,9 +104,14 @@ static int __init of_numa_parse_distance_map_v1(struct device_node *map)
 		distance = of_read_number(matrix, 1);
 		matrix++;
 
+		if ((nodea == nodeb && distance != LOCAL_DISTANCE) ||
+		    (nodea != nodeb && distance <= LOCAL_DISTANCE)) {
+			pr_err("Invalid distance[node%d -> node%d] = %d\n",
+			       nodea, nodeb, distance);
+			return -EINVAL;
+		}
+
 		numa_set_distance(nodea, nodeb, distance);
-		pr_debug("distance[node%d -> node%d] = %d\n",
-			 nodea, nodeb, distance);
 
 		/* Set default distance of node B->A same as A->B */
 		if (nodeb > nodea)
-- 
1.9.1

