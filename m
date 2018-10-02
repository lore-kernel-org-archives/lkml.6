Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26E4C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B8D2083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92B8D2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbeJBUMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:12:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33110 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729802AbeJBUMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:12:48 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 62284A67;
        Tue,  2 Oct 2018 13:29:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.18 147/228] regulator: Fix do-nothing value for regulators without suspend state
Date:   Tue,  2 Oct 2018 06:24:04 -0700
Message-Id: <20181002132509.101211388@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
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

From: Marek Szyprowski <m.szyprowski@samsung.com>

commit 3edd79cf5a44b12dbb13bc320f5788aed6562b36 upstream.

Some regulators don't have all states defined and in such cases regulator
core should not assume anything. However in current implementation
of of_get_regulation_constraints() DO_NOTHING_IN_SUSPEND enable value was
set only for regulators which had suspend node defined, otherwise the
default 0 value was used, what means DISABLE_IN_SUSPEND. This lead to
broken system suspend/resume on boards, which had simple regulator
constraints definition (without suspend state nodes).

To avoid further mismatches between the default and uninitialized values
of the suspend enabled/disabled states, change the values of the them,
so default '0' means DO_NOTHING_IN_SUSPEND.

Fixes: 72069f9957a1: regulator: leave one item to record whether regulator is enabled
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/regulator/core.c          |    2 +-
 drivers/regulator/of_regulator.c  |    2 --
 include/linux/regulator/machine.h |    6 +++---
 3 files changed, 4 insertions(+), 6 deletions(-)

--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3147,7 +3147,7 @@ static inline int regulator_suspend_togg
 	if (!rstate->changeable)
 		return -EPERM;
 
-	rstate->enabled = en;
+	rstate->enabled = (en) ? ENABLE_IN_SUSPEND : DISABLE_IN_SUSPEND;
 
 	return 0;
 }
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -213,8 +213,6 @@ static void of_get_regulation_constraint
 		else if (of_property_read_bool(suspend_np,
 					"regulator-off-in-suspend"))
 			suspend_state->enabled = DISABLE_IN_SUSPEND;
-		else
-			suspend_state->enabled = DO_NOTHING_IN_SUSPEND;
 
 		if (!of_property_read_u32(np, "regulator-suspend-min-microvolt",
 					  &pval))
--- a/include/linux/regulator/machine.h
+++ b/include/linux/regulator/machine.h
@@ -48,9 +48,9 @@ struct regulator;
  * DISABLE_IN_SUSPEND	- turn off regulator in suspend states
  * ENABLE_IN_SUSPEND	- keep regulator on in suspend states
  */
-#define DO_NOTHING_IN_SUSPEND	(-1)
-#define DISABLE_IN_SUSPEND	0
-#define ENABLE_IN_SUSPEND	1
+#define DO_NOTHING_IN_SUSPEND	0
+#define DISABLE_IN_SUSPEND	1
+#define ENABLE_IN_SUSPEND	2
 
 /* Regulator active discharge flags */
 enum regulator_active_discharge {


