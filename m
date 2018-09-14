Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F76FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CFAC206B5
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BTmY+DOv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CFAC206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbeINTiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:38:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44538 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728199AbeINTiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:38:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id v16-v6so10804355wro.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 07:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rd8R49tSHe6GNNdxrka86f7ThsGMCBdbsdSM4u5ch9U=;
        b=BTmY+DOv8DiEIzGEBJX4RYWfTk/ZOXAwxG1eXFr6KPaJviJ3QBqi3DStYle0FMgmrL
         r7Ng47lpJf0ENMgzgGhvvVGCn3wy5zudPNNvoFs9PCymWb340uzsaMV6UN1y2JIakczL
         T7mbwvShfpS27whef0OAcbAhlzy+NF4PCSlJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rd8R49tSHe6GNNdxrka86f7ThsGMCBdbsdSM4u5ch9U=;
        b=ZrmKh1E6Np9Y2EdXtUXc3Tnt6g3P5v3BtUbme/rANsoUtT205b0VCYtoiE5RWVugUt
         MTucwTShw/fslFfY8MXdDerOqOglS6Q2TlPJkOpcblAIEtdMmJqCWnCS+y5s4AM/ZOOn
         KcIUCD9JUvRelt+qVWZXB17SWgU29rRjfvoWwOSMVpwvF3vFFt1IEx+qX8FDPJzh4gib
         23Qu+N7EDtrrSwv7nTXwFwgYRAR5yjCVBYqycoAzniTWre08uEGMXCqnAWX9TQ8KrP0T
         c15l0qWkCTYuLbpS+T2emV8q1E5cUbQKnKLJde2Sy4OkjyczmaObUL6DU0QJXKW0zoPb
         NGvg==
X-Gm-Message-State: APzg51BaDb7Uu5rrvr3WFywUhsK+qrkDRVQSoWsAcgY6UvHO4ITvtJom
        2G3mjYLoY9GP7usKP6M8jjeZow==
X-Google-Smtp-Source: ANB0VdbdvCYfqVSOb/n095syJgDLiAb80BBu3l5VK+nz6XsDsdv+qNW0FGKL0q6HbdONu2+kbhuwFg==
X-Received: by 2002:a5d:448d:: with SMTP id j13-v6mr10052504wrq.236.1536934999666;
        Fri, 14 Sep 2018 07:23:19 -0700 (PDT)
Received: from wifi-122_dhcprange-84.wifi.unimo.it (wifi-122_dhcprange-84.wifi.unimo.it. [155.185.122.84])
        by smtp.gmail.com with ESMTPSA id k35-v6sm17084888wrc.14.2018.09.14.07.23.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 07:23:18 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX/IMPROVEMENT 1/3] block, bfq: correctly charge and reset entity service in all cases
Date:   Fri, 14 Sep 2018 16:23:07 +0200
Message-Id: <20180914142309.6789-2-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180914142309.6789-1-paolo.valente@linaro.org>
References: <20180914142309.6789-1-paolo.valente@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 block/bfq-wf2q.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index ae52bff43ce4..ff7c2d470bb8 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -1181,10 +1181,17 @@ bool __bfq_deactivate_entity(struct bfq_entity *entity, bool ins_into_idle_tree)
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
-- 
2.16.1

