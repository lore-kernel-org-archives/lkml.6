Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id bWjfF01OGVtGdwAAmS7hNA
	; Thu, 07 Jun 2018 15:27:26 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 49CF66089E; Thu,  7 Jun 2018 15:27:26 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RcEPVec9"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CD65E60115;
	Thu,  7 Jun 2018 15:27:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CD65E60115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935660AbeFGP1Y (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:27:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60228 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932889AbeFGO51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ddaQmGfdRo8pmT21eJd+HFHksxfrWFcXQbUE0j4Hyz0=; b=RcEPVec9nSkmZukf5BftLiGCO
        rAqU67RUxazRuJZAK2jIdf7fBM8mtpCiCuGWRBgcK0kza1gaohoBFuaAFnJtgw2tnO83+dS8nOlNN
        EjKQ4KBC1xRGcnyNUupBp0yLqc/pXKym4/czkJ3ioZIhaNNbeAnFeh1ve8TRyW3yyiU1+F4Qxc/b7
        7MQtpRGGAQPFWVftkmIp5snVIPSjTNLkf2cv59jNtwHVa71AiTateomSDcbei7LB/gUYMskSdUN1L
        av9SNUZ6LZmWyZYoC4bmluYU8vfu8Zprf5sp6OZj9JvART86uzcGOnSKgZTFTXcYmM2ccCsuTp5AO
        nCgxzVLTw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fQwLt-0005uD-RG; Thu, 07 Jun 2018 14:57:25 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kees Cook <keescook@chromium.org>
Cc: Matthew Wilcox <mawilcox@microsoft.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: [PATCH 6/6] Convert intel uncore to struct_size
Date: Thu,  7 Jun 2018 07:57:20 -0700
Message-Id: <20180607145720.22590-7-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180607145720.22590-1-willy@infradead.org>
References: <20180607145720.22590-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

Need to do a bit of rearranging to make this work.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 arch/x86/events/intel/uncore.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 15b07379e72d..e15cfad4f89b 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -865,8 +865,6 @@ static void uncore_types_exit(struct intel_uncore_type **types)
 static int __init uncore_type_init(struct intel_uncore_type *type, bool setid)
 {
 	struct intel_uncore_pmu *pmus;
-	struct attribute_group *attr_group;
-	struct attribute **attrs;
 	size_t size;
 	int i, j;
 
@@ -891,21 +889,24 @@ static int __init uncore_type_init(struct intel_uncore_type *type, bool setid)
 				0, type->num_counters, 0, 0);
 
 	if (type->event_descs) {
+		struct {
+			struct attribute_group group;
+			struct attribute *attrs[];
+		} *attr_group;
 		for (i = 0; type->event_descs[i].attr.attr.name; i++);
 
-		attr_group = kzalloc(sizeof(struct attribute *) * (i + 1) +
-					sizeof(*attr_group), GFP_KERNEL);
+		attr_group = kzalloc(struct_size(attr_group, attrs, i + 1),
+								GFP_KERNEL);
 		if (!attr_group)
 			goto err;
 
-		attrs = (struct attribute **)(attr_group + 1);
-		attr_group->name = "events";
-		attr_group->attrs = attrs;
+		attr_group->group.name = "events";
+		attr_group->group.attrs = attr_group->attrs;
 
 		for (j = 0; j < i; j++)
-			attrs[j] = &type->event_descs[j].attr.attr;
+			attr_group->attrs[j] = &type->event_descs[j].attr.attr;
 
-		type->events_group = attr_group;
+		type->events_group = &attr_group->group;
 	}
 
 	type->pmu_group = &uncore_pmu_attr_group;
-- 
2.17.0
