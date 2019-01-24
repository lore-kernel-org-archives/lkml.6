Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C88C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1E621855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbfAXP5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 10:57:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59836 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728040AbfAXP5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 10:57:16 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 57E39ED27C;
        Thu, 24 Jan 2019 15:57:16 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E7111001F4A;
        Thu, 24 Jan 2019 15:57:15 +0000 (UTC)
Date:   Thu, 24 Jan 2019 16:57:13 +0100
From:   Igor Mammedov <imammedo@redhat.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Joe Mario <jmario@redhat.com>, Jiri Kosina <jkosina@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: cpu/hotplug: broken sibling thread hotplug
Message-ID: <20190124165713.2b0b37ed@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 24 Jan 2019 15:57:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case guest is booted with one CPU present and then later
a sibling CPU is hotplugged [1], it stays offline since SMT
is disabled.

Bisects to
 73d5e2b47264 ("cpu/hotplug: detect SMT disabled by BIOS")
which used __max_smt_threads to decide disabling SMT and in
case [1] only primary CPU thread is present hence SMT
is disabled.

Later bc2d8d262cba (cpu/hotplug: Fix SMT supported evaluation),
rewrites code path but evaluation criteria still depends on
sibling thread being present at boot time, so problem persist.

1) QEMU -smp 1,sockets=2,cores=1,threads=2 -monitor stdio ...
   # hotplug sibling thread
   (qemu) device_add qemu64-x86_64-cpu,socket-id=0,core-id=0,thread-id=1

I've failed to find reasoning behind statement:
  "
  cpu/hotplug: detect SMT disabled by BIOS

    If SMT is disabled in BIOS, the CPU code doesn't properly detect it.
  "

Question is 
 1: why cpu_smt_check_topology_early() at check_bugs()
wasn't sufficient to detect SMT disabled in BIOS and
 2: why side-effect of present at boot siblings were used
    to keep SMT enabled?

Following quick hack fixes the sibling issue but that's
effectively means reverting both above mentioned so we are
back to the original issue "If SMT is disabled in BIOS, ..."
which roots I weren't able to locate.

---
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 91d5c38..44df8cd 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -415,7 +415,7 @@ void __init cpu_smt_check_topology_early(void)
  */
 void __init cpu_smt_check_topology(void)
 {
-       if (!cpu_smt_available)
+       if (!topology_smt_supported())
                cpu_smt_control = CPU_SMT_NOT_SUPPORTED;
 }
---
