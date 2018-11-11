Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736AFC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E262245E
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6+/vbNt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30E262245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390507AbeKLIWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:22:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:51248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387738AbeKLIWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:18 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12ED7216FD;
        Sun, 11 Nov 2018 22:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975541;
        bh=SEUMsag8TDxcxGNBUrgWMvjVdpytKGiqCUuMiiKH/UM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q6+/vbNt2OKOwEAs3UzMhjQv0phNo9cpCismc+Jg0GJyyZ4bpMT7+9DfNitQR47TT
         09ONg5vuIFiVwItVHgVirrkAhfmD/9MEQIbBn8xynFCqKOzXpD5M73dsmb7zcUhhi9
         JpaJPQP6g7JpDi/bNwQMK1eD5aLDFG9vrBn6TxR4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 030/222] sparc: Throttle perf events properly.
Date:   Sun, 11 Nov 2018 14:22:07 -0800
Message-Id: <20181111221650.955207482@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -24,6 +24,7 @@
 #include <asm/cpudata.h>
 #include <linux/uaccess.h>
 #include <linux/atomic.h>
+#include <linux/sched/clock.h>
 #include <asm/nmi.h>
 #include <asm/pcr.h>
 #include <asm/cacheflush.h>
@@ -1612,6 +1613,8 @@ static int __kprobes perf_event_nmi_hand
 	struct perf_sample_data data;
 	struct cpu_hw_events *cpuc;
 	struct pt_regs *regs;
+	u64 finish_clock;
+	u64 start_clock;
 	int i;
 
 	if (!atomic_read(&active_events))
@@ -1625,6 +1628,8 @@ static int __kprobes perf_event_nmi_hand
 		return NOTIFY_DONE;
 	}
 
+	start_clock = sched_clock();
+
 	regs = args->regs;
 
 	cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -1663,6 +1668,10 @@ static int __kprobes perf_event_nmi_hand
 			sparc_pmu_stop(event, 0);
 	}
 
+	finish_clock = sched_clock();
+
+	perf_sample_event_took(finish_clock - start_clock);
+
 	return NOTIFY_STOP;
 }
 


