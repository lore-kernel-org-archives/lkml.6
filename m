Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEECC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 118472168D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 118472168D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732134AbeHNUZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:25:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58080 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbeHNUZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:25:26 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4162CD4A;
        Tue, 14 Aug 2018 17:37:17 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 038/104] cpu/hotplug: Make bringup/teardown of smp threads symmetric
Date:   Tue, 14 Aug 2018 19:16:52 +0200
Message-Id: <20180814171517.748129166@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171515.270692185@linuxfoundation.org>
References: <20180814171515.270692185@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit c4de65696d865c225fda3b9913b31284ea65ea96 upstream

The asymmetry caused a warning to trigger if the bootup was stopped in state
CPUHP_AP_ONLINE_IDLE. The warning no longer triggers as kthread_park() can
now be invoked on already or still parked threads. But there is still no
reason to have this be asymmetric.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/cpu.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -758,7 +758,6 @@ static int takedown_cpu(unsigned int cpu
 
 	/* Park the smpboot threads */
 	kthread_park(per_cpu_ptr(&cpuhp_state, cpu)->thread);
-	smpboot_park_threads(cpu);
 
 	/*
 	 * Prevent irq alloc/free while the dying cpu reorganizes the
@@ -1344,7 +1343,7 @@ static struct cpuhp_step cpuhp_ap_states
 	[CPUHP_AP_SMPBOOT_THREADS] = {
 		.name			= "smpboot/threads:online",
 		.startup.single		= smpboot_unpark_threads,
-		.teardown.single	= NULL,
+		.teardown.single	= smpboot_park_threads,
 	},
 	[CPUHP_AP_IRQ_AFFINITY_ONLINE] = {
 		.name			= "irq/affinity:online",


