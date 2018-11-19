Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C35C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 927C62086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Be2R+0MR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 927C62086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387938AbeKTDHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:07:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:41628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732866AbeKTDHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:07:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E1BF21104;
        Mon, 19 Nov 2018 16:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645799;
        bh=ZC7yS2R/050ANxy5B7edJsI0NpOr2jM5wBcCPtBsEOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Be2R+0MRzJYq5zyGd+rGGiCqAIYuBQqCFJeS3+ERoN5icsC9s279VYXYrPfaglgjt
         34MJWHzFaImap46j+fsCIT0H3K9+jNzCfZRkh7vx6Y7MVHal7nnJRuIkJa1cL2pV1f
         yYpopLOzVdyS3e84/CeKqrbFU9wyTSMW6bjuxldc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 4.18 094/171] of, numa: Validate some distance map rules
Date:   Mon, 19 Nov 2018 17:28:10 +0100
Message-Id: <20181119162634.094403970@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Garry <john.garry@huawei.com>

commit 89c38422e072bb453e3045b8f1b962a344c3edea upstream.

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
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/of/of_numa.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/of/of_numa.c
+++ b/drivers/of/of_numa.c
@@ -115,9 +115,14 @@ static int __init of_numa_parse_distance
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


