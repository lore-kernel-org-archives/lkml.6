Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BEFC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37763206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:40:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37763206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbeLEPju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:39:50 -0500
Received: from xavier.telenet-ops.be ([195.130.132.52]:46378 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727475AbeLEPju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:39:50 -0500
Received: from ramsan ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id 8Ffo1z00K3XaVaC01Ffott; Wed, 05 Dec 2018 16:39:49 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gUZHA-0001yW-7u; Wed, 05 Dec 2018 16:39:48 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gUZHA-0003ay-5y; Wed, 05 Dec 2018 16:39:48 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/4] soc: renesas: rcar-sysc: Merge PM Domain registration and linking
Date:   Wed,  5 Dec 2018 16:39:44 +0100
Message-Id: <20181205153945.13767-4-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205153945.13767-1-geert+renesas@glider.be>
References: <20181205153945.13767-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 977d5ba4507dfe5b ("soc: renesas: rcar-sysc: Make PM domain
initialization more robust") split PM Domain registration and the
linking of children to their parents, to accommodate PM Domain tables
that list child domains before their parents.

However, this failed to realize that parent power domains must be
powered up before their children anyway, and that this thus must be
reflected by the order in the PM Domain tables.

Revert the split, as it did not help anyway.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/soc/renesas/rcar-sysc.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index 73fae6a9728df9ae..123e553510e826f5 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -381,9 +381,6 @@ static int __init rcar_sysc_pd_init(void)
 	pr_debug("%pOF: syscier = 0x%08x\n", np, syscier);
 	iowrite32(syscier, base + SYSCIER);
 
-	/*
-	 * First, create all PM domains
-	 */
 	for (i = 0; i < info->num_areas; i++) {
 		const struct rcar_sysc_area *area = &info->areas[i];
 		struct rcar_sysc_pd *pd;
@@ -411,22 +408,17 @@ static int __init rcar_sysc_pd_init(void)
 			goto out_put;
 
 		domains->domains[area->isr_bit] = &pd->genpd;
-	}
 
-	/*
-	 * Second, link all PM domains to their parents
-	 */
-	for (i = 0; i < info->num_areas; i++) {
-		const struct rcar_sysc_area *area = &info->areas[i];
-
-		if (!area->name || area->parent < 0)
+		if (area->parent < 0)
 			continue;
 
 		error = pm_genpd_add_subdomain(domains->domains[area->parent],
-					       domains->domains[area->isr_bit]);
-		if (error)
+					       &pd->genpd);
+		if (error) {
 			pr_warn("Failed to add PM subdomain %s to parent %u\n",
 				area->name, area->parent);
+			goto out_put;
+		}
 	}
 
 	error = of_genpd_add_provider_onecell(np, &domains->onecell_data);
-- 
2.17.1

