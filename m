Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F76C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9905220862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9905220862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405183AbeHATGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:06:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48212 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403884AbeHATGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:06:03 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AF549CC3;
        Wed,  1 Aug 2018 17:19:22 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 113/246] drivers/perf: arm-ccn: dont log to dmesg in event_init
Date:   Wed,  1 Aug 2018 18:50:23 +0200
Message-Id: <20180801165017.112789617@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165011.700991984@linuxfoundation.org>
References: <20180801165011.700991984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit 1898eb61fbc9703efee886d3abec27a388cf28c3 ]

The ARM CCN PMU driver uses dev_warn() to complain about parameters in
the user-provided perf_event_attr. This means that under normal
operation (e.g. a single invocation of the perf tool), a number of
messages warnings may be logged to dmesg.

Tools may issue multiple syscalls to probe for feature support, and
multiple applications (from multiple users) can attempt to open events
simultaneously, so this is not very helpful, even if a user happens to
have access to dmesg. Worse, this can push important information out of
the dmesg ring buffer, and can significantly slow down syscall fuzzers,
vastly increasing the time it takes to find critical bugs.

Demote the dev_warn() instances to dev_dbg(), as is the case for all
other PMU drivers under drivers/perf/. Users who wish to debug PMU event
initialisation can enable dynamic debug to receive these messages.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bus/arm-ccn.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

--- a/drivers/bus/arm-ccn.c
+++ b/drivers/bus/arm-ccn.c
@@ -736,7 +736,7 @@ static int arm_ccn_pmu_event_init(struct
 	ccn = pmu_to_arm_ccn(event->pmu);
 
 	if (hw->sample_period) {
-		dev_warn(ccn->dev, "Sampling not supported!\n");
+		dev_dbg(ccn->dev, "Sampling not supported!\n");
 		return -EOPNOTSUPP;
 	}
 
@@ -744,12 +744,12 @@ static int arm_ccn_pmu_event_init(struct
 			event->attr.exclude_kernel || event->attr.exclude_hv ||
 			event->attr.exclude_idle || event->attr.exclude_host ||
 			event->attr.exclude_guest) {
-		dev_warn(ccn->dev, "Can't exclude execution levels!\n");
+		dev_dbg(ccn->dev, "Can't exclude execution levels!\n");
 		return -EINVAL;
 	}
 
 	if (event->cpu < 0) {
-		dev_warn(ccn->dev, "Can't provide per-task data!\n");
+		dev_dbg(ccn->dev, "Can't provide per-task data!\n");
 		return -EOPNOTSUPP;
 	}
 	/*
@@ -771,13 +771,13 @@ static int arm_ccn_pmu_event_init(struct
 	switch (type) {
 	case CCN_TYPE_MN:
 		if (node_xp != ccn->mn_id) {
-			dev_warn(ccn->dev, "Invalid MN ID %d!\n", node_xp);
+			dev_dbg(ccn->dev, "Invalid MN ID %d!\n", node_xp);
 			return -EINVAL;
 		}
 		break;
 	case CCN_TYPE_XP:
 		if (node_xp >= ccn->num_xps) {
-			dev_warn(ccn->dev, "Invalid XP ID %d!\n", node_xp);
+			dev_dbg(ccn->dev, "Invalid XP ID %d!\n", node_xp);
 			return -EINVAL;
 		}
 		break;
@@ -785,11 +785,11 @@ static int arm_ccn_pmu_event_init(struct
 		break;
 	default:
 		if (node_xp >= ccn->num_nodes) {
-			dev_warn(ccn->dev, "Invalid node ID %d!\n", node_xp);
+			dev_dbg(ccn->dev, "Invalid node ID %d!\n", node_xp);
 			return -EINVAL;
 		}
 		if (!arm_ccn_pmu_type_eq(type, ccn->node[node_xp].type)) {
-			dev_warn(ccn->dev, "Invalid type 0x%x for node %d!\n",
+			dev_dbg(ccn->dev, "Invalid type 0x%x for node %d!\n",
 					type, node_xp);
 			return -EINVAL;
 		}
@@ -808,19 +808,19 @@ static int arm_ccn_pmu_event_init(struct
 		if (event_id != e->event)
 			continue;
 		if (e->num_ports && port >= e->num_ports) {
-			dev_warn(ccn->dev, "Invalid port %d for node/XP %d!\n",
+			dev_dbg(ccn->dev, "Invalid port %d for node/XP %d!\n",
 					port, node_xp);
 			return -EINVAL;
 		}
 		if (e->num_vcs && vc >= e->num_vcs) {
-			dev_warn(ccn->dev, "Invalid vc %d for node/XP %d!\n",
+			dev_dbg(ccn->dev, "Invalid vc %d for node/XP %d!\n",
 					vc, node_xp);
 			return -EINVAL;
 		}
 		valid = 1;
 	}
 	if (!valid) {
-		dev_warn(ccn->dev, "Invalid event 0x%x for node/XP %d!\n",
+		dev_dbg(ccn->dev, "Invalid event 0x%x for node/XP %d!\n",
 				event_id, node_xp);
 		return -EINVAL;
 	}


