Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC386C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D3A2150B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:42:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D3A2150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390463AbeHNUbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:31:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59712 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728642AbeHNUbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:31:01 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0BEA040B;
        Tue, 14 Aug 2018 17:42:49 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 068/107] cpu/hotplug: Online siblings when SMT control is turned on
Date:   Tue, 14 Aug 2018 19:17:31 +0200
Message-Id: <20180814171525.038026212@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171520.883143803@linuxfoundation.org>
References: <20180814171520.883143803@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 215af5499d9e2b55f111d2431ea20218115f29b3 upstream

Writing 'off' to /sys/devices/system/cpu/smt/control offlines all SMT
siblings. Writing 'on' merily enables the abilify to online them, but does
not online them automatically.

Make 'on' more useful by onlining all offline siblings.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/cpu.c |   26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1917,6 +1917,15 @@ static void cpuhp_offline_cpu_device(uns
 	kobject_uevent(&dev->kobj, KOBJ_OFFLINE);
 }
 
+static void cpuhp_online_cpu_device(unsigned int cpu)
+{
+	struct device *dev = get_cpu_device(cpu);
+
+	dev->offline = false;
+	/* Tell user space about the state change */
+	kobject_uevent(&dev->kobj, KOBJ_ONLINE);
+}
+
 static int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
 {
 	int cpu, ret = 0;
@@ -1949,11 +1958,24 @@ static int cpuhp_smt_disable(enum cpuhp_
 	return ret;
 }
 
-static void cpuhp_smt_enable(void)
+static int cpuhp_smt_enable(void)
 {
+	int cpu, ret = 0;
+
 	cpu_maps_update_begin();
 	cpu_smt_control = CPU_SMT_ENABLED;
+	for_each_present_cpu(cpu) {
+		/* Skip online CPUs and CPUs on offline nodes */
+		if (cpu_online(cpu) || !node_online(cpu_to_node(cpu)))
+			continue;
+		ret = _cpu_up(cpu, 0, CPUHP_ONLINE);
+		if (ret)
+			break;
+		/* See comment in cpuhp_smt_disable() */
+		cpuhp_online_cpu_device(cpu);
+	}
 	cpu_maps_update_done();
+	return ret;
 }
 
 static ssize_t
@@ -1984,7 +2006,7 @@ store_smt_control(struct device *dev, st
 	if (ctrlval != cpu_smt_control) {
 		switch (ctrlval) {
 		case CPU_SMT_ENABLED:
-			cpuhp_smt_enable();
+			ret = cpuhp_smt_enable();
 			break;
 		case CPU_SMT_DISABLED:
 		case CPU_SMT_FORCE_DISABLED:


