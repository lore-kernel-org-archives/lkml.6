Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308F1C64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0187206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0187206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbeJCEgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:36:42 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:52962 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbeJCEgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:36:40 -0400
Received: from 79.184.253.194.ipv4.supernova.orange.pl (79.184.253.194) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id d44d2490e9807d22; Tue, 2 Oct 2018 23:51:11 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 4/6] cpuidle: menu: Do not update last_state_idx in menu_select()
Date:   Tue, 02 Oct 2018 23:45:07 +0200
Message-ID: <1940908.mNKd7HXT40@aspire.rjw.lan>
In-Reply-To: <3510260.hvypppS8Bs@aspire.rjw.lan>
References: <3510260.hvypppS8Bs@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It is not necessary to update data->last_state_idx in menu_select()
as it only is used in menu_update() which only runs when
data->needs_update is set and that is set only when updating
data->last_state_idx in menu_reflect().

Accordingly, drop the update of data->last_state_idx from
menu_select() and get rid of the (now redundant) "out" label
from it.

No intentional behavior changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/menu.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -398,7 +398,7 @@ static int menu_select(struct cpuidle_dr
 			    s->target_residency <= ktime_to_us(delta_next))
 				idx = i;
 
-			goto out;
+			return idx;
 		}
 		if (s->exit_latency > latency_req) {
 			/*
@@ -445,10 +445,7 @@ static int menu_select(struct cpuidle_dr
 		}
 	}
 
-out:
-	data->last_state_idx = idx;
-
-	return data->last_state_idx;
+	return idx;
 }
 
 /**

