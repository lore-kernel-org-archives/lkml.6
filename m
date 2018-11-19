Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E67CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F0A214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="w+Yo6O6W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F0A214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406447AbeKTD2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:28:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:42666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405461AbeKTD2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:28:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B96192148E;
        Mon, 19 Nov 2018 17:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542647045;
        bh=It8mrrx7cqd81AfFS4c7QlvoigY5oxZQVzS//ao2v78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w+Yo6O6WnsZQV6ykSZ3mtonfJel1coKh8oKzWarqBZ9B9RtbRaNoPMDr1aN7zy0tE
         /qcW1mAD71EJMMNTEzUNUllFycY4jHhOREFbIckcvw9PHsO/uAA54VPnADhCEQoxX7
         ofsD8PXPj1ZG+HzFFlu45ZSazEu0NLkAwfgS20GM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 07/90] sparc: Throttle perf events properly.
Date:   Mon, 19 Nov 2018 17:28:49 +0100
Message-Id: <20181119162621.950798107@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162620.585061184@linuxfoundation.org>
References: <20181119162620.585061184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "David S. Miller" <davem@davemloft.net>

[ Upstream commit 455adb3174d2c8518cef1a61140c211f6ac224d2 ]

Like x86 and arm, call perf_sample_event_took() in perf event
NMI interrupt handler.

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/sparc/kernel/perf_event.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -23,6 +23,7 @@
 #include <asm/cpudata.h>
 #include <asm/uaccess.h>
 #include <linux/atomic.h>
+#include <linux/sched/clock.h>
 #include <asm/nmi.h>
 #include <asm/pcr.h>
 #include <asm/cacheflush.h>
@@ -1586,6 +1587,8 @@ static int __kprobes perf_event_nmi_hand
 	struct perf_sample_data data;
 	struct cpu_hw_events *cpuc;
 	struct pt_regs *regs;
+	u64 finish_clock;
+	u64 start_clock;
 	int i;
 
 	if (!atomic_read(&active_events))
@@ -1599,6 +1602,8 @@ static int __kprobes perf_event_nmi_hand
 		return NOTIFY_DONE;
 	}
 
+	start_clock = sched_clock();
+
 	regs = args->regs;
 
 	cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -1637,6 +1642,10 @@ static int __kprobes perf_event_nmi_hand
 			sparc_pmu_stop(event, 0);
 	}
 
+	finish_clock = sched_clock();
+
+	perf_sample_event_took(finish_clock - start_clock);
+
 	return NOTIFY_STOP;
 }
 


