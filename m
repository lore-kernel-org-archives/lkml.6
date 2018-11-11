Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B605CC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BEA22241E
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5Z42oH3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BEA22241E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388356AbeKLIUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:20:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:42802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388309AbeKLIUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:03 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7317216FD;
        Sun, 11 Nov 2018 22:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975406;
        bh=doT1MFUeyRQJyESCL8hxSFJCuDSM4o/nsfWhLIzLY2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S5Z42oH3ohKafFyJOPbzz6fbPW+9Mp3zR1dW17D2/7O4KFvPBlRtRSEgpJhfuWHef
         99kLfE2DJ8DkicKsENS5Vwa8hQdXHdGTzW2MdZmt1OektLgjbbCbJxlkT6hyihOn8I
         bSRr4QWlIsRpbc0d8q8knYBZt17rBkYhAgc7i6OI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 111/350] block, bfq: correctly charge and reset entity service in all cases
Date:   Sun, 11 Nov 2018 14:19:35 -0800
Message-Id: <20181111221711.737489186@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
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

From: Paolo Valente <paolo.valente@linaro.org>

[ Upstream commit cbeb869a3d1110450186b738199963c5e68c2a71 ]

BFQ schedules entities (which represent either per-process queues or
groups of queues) as a function of their timestamps. In particular, as
a function of their (virtual) finish times. The finish time of an
entity is computed as a function of the budget assigned to the entity,
assuming, tentatively, that the entity, once in service, will receive
an amount of service equal to its budget. Then, when the entity is
expired because it finishes to be served, this finish time is updated
as a function of the actual service received by the entity. This
allows the entity to be correctly charged with only the service
received, and then to be correctly re-scheduled.

Yet an entity may receive service also while not being the entity in
service (in the scheduling environment of its parent entity), for
several reasons. If the entity remains with no backlog while receiving
this 'unofficial' service, then it is expired. Also on such an
expiration, the finish time of the entity should be updated to account
for only the service actually received by the entity. Unfortunately,
such an update is not performed for an entity expiring without being
the entity in service.

In a similar vein, the service counter of the entity in service is
reset when the entity is expired, to be ready to be used for next
service cycle. This reset too should be performed also in case an
entity is expired because it remains empty after receiving service
while not being the entity in service. But in this case the reset is
not performed.

This commit performs the above update of the finish time and reset of
the service received, also for an entity expiring while not being the
entity in service.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/bfq-wf2q.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -1178,10 +1178,17 @@ bool __bfq_deactivate_entity(struct bfq_
 	st = bfq_entity_service_tree(entity);
 	is_in_service = entity == sd->in_service_entity;
 
-	if (is_in_service) {
-		bfq_calc_finish(entity, entity->service);
+	bfq_calc_finish(entity, entity->service);
+
+	if (is_in_service)
 		sd->in_service_entity = NULL;
-	}
+	else
+		/*
+		 * Non in-service entity: nobody will take care of
+		 * resetting its service counter on expiration. Do it
+		 * now.
+		 */
+		entity->service = 0;
 
 	if (entity->tree == &st->active)
 		bfq_active_extract(st, entity);


