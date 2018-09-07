Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE188C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BBC02075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BBC02075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbeIHCHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:07:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46818 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbeIHCHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:07:31 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 48745EF6;
        Fri,  7 Sep 2018 21:24:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.18 144/145] cpuidle: menu: Retain tick when shallow state is selected
Date:   Fri,  7 Sep 2018 23:10:10 +0200
Message-Id: <20180907210914.266185643@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit 757ab15c3f4968b5a29caf3fe8b67660ce84c3cd upstream.

The case addressed by commit 5ef499cd571c (cpuidle: menu: Handle
stopped tick more aggressively) in the stopped tick case is present
when the tick has not been stopped yet too.  Namely, if only two CPU
idle states, shallow state A with target residency significantly
below the tick boundary and deep state B with target residency
significantly above it, are available and the predicted idle
duration is above the tick boundary, but below the target residency
of state B, state A will be selected and the CPU may spend indefinite
amount of time in it, which is not quite energy-efficient.

However, if the tick has not been stopped yet and the governor is
about to select a shallow idle state for the CPU even though the idle
duration predicted by it is above the tick boundary, it should be
fine to wake up the CPU early, so the tick can be retained then and
the governor will have a chance to select a deeper state when it runs
next time.

[Note that when this really happens, it will make the idle duration
 predictor believe that the CPU might be idle longer than predicted,
 which will make it more likely to predict longer idle durations going
 forward, but that will also cause deeper idle states to be selected
 going forward, on average, which is what's needed here.]

Fixes: 87c9fe6ee495 (cpuidle: menu: Avoid selecting shallow states with stopped tick)
Reported-by: Leo Yan <leo.yan@linaro.org>
Cc: 4.17+ <stable@vger.kernel.org> # 4.17+: 5ef499cd571c (cpuidle: menu: Handle ...)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/cpuidle/governors/menu.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -380,9 +380,20 @@ static int menu_select(struct cpuidle_dr
 		if (idx == -1)
 			idx = i; /* first enabled state */
 		if (s->target_residency > data->predicted_us) {
-			if (!tick_nohz_tick_stopped())
+			if (data->predicted_us < TICK_USEC)
 				break;
 
+			if (!tick_nohz_tick_stopped()) {
+				/*
+				 * If the state selected so far is shallow,
+				 * waking up early won't hurt, so retain the
+				 * tick in that case and let the governor run
+				 * again in the next iteration of the loop.
+				 */
+				expected_interval = drv->states[idx].target_residency;
+				break;
+			}
+
 			/*
 			 * If the state selected so far is shallow and this
 			 * state's target residency matches the time till the


