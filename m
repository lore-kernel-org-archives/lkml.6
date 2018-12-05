Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,TVD_SUBJ_WIPE_DEBT,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69076C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3791E206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:39:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3791E206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbeLEPj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:39:58 -0500
Received: from laurent.telenet-ops.be ([195.130.137.89]:54422 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbeLEPjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:39:51 -0500
Received: from ramsan ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id 8Ffo1z00P3XaVaC01FfoB9; Wed, 05 Dec 2018 16:39:49 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gUZHA-0001yU-6K; Wed, 05 Dec 2018 16:39:48 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gUZHA-0003au-5K; Wed, 05 Dec 2018 16:39:48 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/4] soc: renesas: rcar-sysc: Remove rcar_sysc_power_{down,up}() helpers
Date:   Wed,  5 Dec 2018 16:39:43 +0100
Message-Id: <20181205153945.13767-3-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205153945.13767-1-geert+renesas@glider.be>
References: <20181205153945.13767-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until commit 7e8a50df26f4e700 ("soc: renesas: rcar-sysc: Drop legacy
handling"), the rcar_sysc_power_{down,up}() helpers were public, as they
were called by the legacy (pre-DT) CPU power management code on R-Car H1
and R-Car Gen2 before.

As they are just one-line wrappers around rcar_sysc_power(), it makes
sense to just remove them.

This also avoids a bool/helper/bool conversion in rcar_sysc_power_cpu(),
where a bool is checked to call one of two helper functions, which
just call rcar_sysc_power() with hardcoded boolean values again.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/soc/renesas/rcar-sysc.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index af53363eda0374ce..73fae6a9728df9ae 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -146,16 +146,6 @@ static int rcar_sysc_power(const struct rcar_sysc_ch *sysc_ch, bool on)
 	return ret;
 }
 
-static int rcar_sysc_power_down(const struct rcar_sysc_ch *sysc_ch)
-{
-	return rcar_sysc_power(sysc_ch, false);
-}
-
-static int rcar_sysc_power_up(const struct rcar_sysc_ch *sysc_ch)
-{
-	return rcar_sysc_power(sysc_ch, true);
-}
-
 static bool rcar_sysc_power_is_off(const struct rcar_sysc_ch *sysc_ch)
 {
 	unsigned int st;
@@ -184,7 +174,7 @@ static int rcar_sysc_pd_power_off(struct generic_pm_domain *genpd)
 	struct rcar_sysc_pd *pd = to_rcar_pd(genpd);
 
 	pr_debug("%s: %s\n", __func__, genpd->name);
-	return rcar_sysc_power_down(&pd->ch);
+	return rcar_sysc_power(&pd->ch, false);
 }
 
 static int rcar_sysc_pd_power_on(struct generic_pm_domain *genpd)
@@ -192,7 +182,7 @@ static int rcar_sysc_pd_power_on(struct generic_pm_domain *genpd)
 	struct rcar_sysc_pd *pd = to_rcar_pd(genpd);
 
 	pr_debug("%s: %s\n", __func__, genpd->name);
-	return rcar_sysc_power_up(&pd->ch);
+	return rcar_sysc_power(&pd->ch, true);
 }
 
 static bool has_cpg_mstp;
@@ -252,7 +242,7 @@ static int __init rcar_sysc_pd_setup(struct rcar_sysc_pd *pd)
 		goto finalize;
 	}
 
-	rcar_sysc_power_up(&pd->ch);
+	rcar_sysc_power(&pd->ch, true);
 
 finalize:
 	error = pm_genpd_init(genpd, gov, false);
@@ -478,8 +468,7 @@ static int rcar_sysc_power_cpu(unsigned int idx, bool on)
 		if (!(pd->flags & PD_CPU) || pd->ch.chan_bit != idx)
 			continue;
 
-		return on ? rcar_sysc_power_up(&pd->ch)
-			  : rcar_sysc_power_down(&pd->ch);
+		return rcar_sysc_power(&pd->ch, on);
 	}
 
 	return -ENOENT;
-- 
2.17.1

