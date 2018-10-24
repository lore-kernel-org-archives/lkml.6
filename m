Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9C5ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A6A20824
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ccR8E2Ca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A6A20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbeJYBmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 21:42:35 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36238 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbeJYBmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 21:42:35 -0400
Received: by mail-wm1-f66.google.com with SMTP id a8-v6so6198810wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 10:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=a61AxcMEEoOMby5wnEQKj4zTJW6/YYCLTZm/LR69Eak=;
        b=ccR8E2CaWIxow2gsguoihgieQq3o5wiDx3hFraj6Bc2Wt+UeoEzieHKCoPiJaZhDxx
         PnoJF/ZfveXvtnp/nYMbUsJ6dwmw1P4UHH1u9W2j62A0DaNdgXEt0KszX/lsIHMgdrit
         zTSnRM+WvD9fXKr176H5+ekicoCZkZAfTgm1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=a61AxcMEEoOMby5wnEQKj4zTJW6/YYCLTZm/LR69Eak=;
        b=CIf03086P/HKlwdwu+uAFE0A6mJr2r4wakSo7Qyc79dhm8JIeZOh7+okTsY8SOCH/F
         TzV5mMEN+n9ZF3DY+A/wE0MH1TGgXVbZMJxEZWr24+rl78FV827QBSWVFHM3aua7xL65
         BEFmiujyNqcNqduqZY0217kpM5jJOVhOdU/OwE9TLjD+DCotiNojEpk1IqBZjKghP2fV
         IQGH6LG1/KMN9cj7QD1iRmeDlbBeKn6cIEit5UcwAtcBw2g/CDtvpYJdIiMn0KWkN5Aa
         h8MS9fwIoC3np2yL+Ple1SPqcUI8icREMKiqCGuSpnhbAcfsVIQjCJUYLR/T5eH1AWn1
         EqsQ==
X-Gm-Message-State: AGRZ1gI+HbxgEkFV/ioFtl6GcPoAIdBTlnFxQtFw7DEC3CSx6n4+sC7f
        8kZyUBq/RGP5gX0dG0vZOPRb/w==
X-Google-Smtp-Source: AJdET5dPN19u9l5CCBA5r/4WxzLox0LT77bCcfq4cmEJuA4HoP9F5jQoA04TWzR4tG5wywRE1Mtqdw==
X-Received: by 2002:a1c:6c09:: with SMTP id h9-v6mr3454230wmc.95.1540401221962;
        Wed, 24 Oct 2018 10:13:41 -0700 (PDT)
Received: from localhost.localdomain ([2.43.217.248])
        by smtp.gmail.com with ESMTPSA id 64-v6sm6449041wrr.64.2018.10.24.10.13.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 10:13:40 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, Federico Motta <federico@willer.it>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX] block, bfq: fix asymmetric scenarios detection
Date:   Wed, 24 Oct 2018 19:13:25 +0200
Message-Id: <20181024171325.7154-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Federico Motta <federico@willer.it>

Since commit 2d29c9f89fcd ("block, bfq: improve asymmetric scenarios
detection"), a scenario is defined asymmetric when one of the
following conditions holds:
- active bfq_queues have different weights
- one or more group of entities (bfq_queue or other groups of entities)
  are active
bfq grants fairness and low latency also in such asymmetric scenarios,
by plugging the dispatching of I/O if the bfq_queue in service happens
to be temporarily idle. This plugging may lower throughput, so it is
important to do it only when strictly needed.

By mystake, in commit '2d29c9f89fcd' ("block, bfq: improve asymmetric
scenarios detection") the num_active_groups counter was firstly
incremented and subsequently decremented at any entity (group or
bfq_queue) weight change.

This is useless, because only transitions from active to inactive and
vice versa matter for that counter. Unfortunately this is also
incorrect in the following case: the entity at issue is a bfq_queue
and it is under weight raising. In fact in this case there is a
spurious increment of the num_active_groups counter.

This spurious increment may cause scenarios to be wrongly detected as
asymmetric, thus causing useless plugging and loss of throughput.

This commit fixes this issue by simply removing the above useless and
wrong increments and decrements.

Fixes: 2d29c9f89fcd ("block, bfq: improve asymmetric scenarios detection")
Signed-off-by: Federico Motta <federico@willer.it>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-wf2q.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 476b5a90a5a4..4b0d5fb69160 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -792,24 +792,18 @@ __bfq_entity_update_weight_prio(struct bfq_service_tree *old_st,
 		 * queue, remove the entity from its old weight counter (if
 		 * there is a counter associated with the entity).
 		 */
-		if (prev_weight != new_weight) {
-			if (bfqq) {
-				root = &bfqd->queue_weights_tree;
-				__bfq_weights_tree_remove(bfqd, bfqq, root);
-			} else
-				bfqd->num_active_groups--;
+		if (prev_weight != new_weight && bfqq) {
+			root = &bfqd->queue_weights_tree;
+			__bfq_weights_tree_remove(bfqd, bfqq, root);
 		}
 		entity->weight = new_weight;
 		/*
 		 * Add the entity, if it is not a weight-raised queue,
 		 * to the counter associated with its new weight.
 		 */
-		if (prev_weight != new_weight) {
-			if (bfqq && bfqq->wr_coeff == 1) {
-				/* If we get here, root has been initialized. */
-				bfq_weights_tree_add(bfqd, bfqq, root);
-			} else
-				bfqd->num_active_groups++;
+		if (prev_weight != new_weight && bfqq && bfqq->wr_coeff == 1) {
+			/* If we get here, root has been initialized. */
+			bfq_weights_tree_add(bfqd, bfqq, root);
 		}
 
 		new_st->wsum += entity->weight;
-- 
2.19.1

