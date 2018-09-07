Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18B9C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80AEE20645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80AEE20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbeIHB71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:59:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42750 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728418AbeIHB70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:59:26 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C67C8FA4;
        Fri,  7 Sep 2018 21:16:39 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.18 085/145] sched: idle: Avoid retaining the tick when it has been stopped
Date:   Fri,  7 Sep 2018 23:09:11 +0200
Message-Id: <20180907210911.159590509@linuxfoundation.org>
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

commit 7059b36636beab57c3c43c62104483e5449bee95 upstream.

If the tick has been stopped already, but the governor has not asked to
stop it (which it can do sometimes), the idle loop should invoke
tick_nohz_idle_stop_tick(), to let tick_nohz_stop_tick() take care
of this case properly.

Fixes: 554c8aa8ecad (sched: idle: Select idle state before stopping the tick)
Cc: 4.17+ <stable@vger.kernel.org> # 4.17+
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/sched/idle.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -190,7 +190,7 @@ static void cpuidle_idle_call(void)
 		 */
 		next_state = cpuidle_select(drv, dev, &stop_tick);
 
-		if (stop_tick)
+		if (stop_tick || tick_nohz_tick_stopped())
 			tick_nohz_idle_stop_tick();
 		else
 			tick_nohz_idle_retain_tick();


