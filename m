Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6506C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A77D32148E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762614;
	bh=MuWyFUYymivztUZ8odu7W1lKbkOpPMlFKL64fhrTizM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xMbaBCbkbHiNRC5OcBKns5Ni9hfGhN7EmYVU5K1rPqGROTVi8O2gR3tuntpiwEGh4
	 gBCF/LkREvWVxX9JJCrL6QYKqC0rCONl7kYIBFhnHkQ/cm6CTnDGfwDRQXUBQ+IJ9r
	 k39zxAihSZLQ0sy5R86ti/x8jIXm86QZEh79t56I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731389AbfA2LuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:50:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:41358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731378AbfA2LuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:50:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 705C82086C;
        Tue, 29 Jan 2019 11:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762610;
        bh=MuWyFUYymivztUZ8odu7W1lKbkOpPMlFKL64fhrTizM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j5ZvaIYHc0k3Jm07n2UXL3H99b58puY6uR67qhWB8yUhFbIZeNOYpkp6hyxMYFzCf
         Ow40V/XpLqrqzbX75lUhqHhTltp9TOGeOZGPQF3JijHoTVS//u1DI/A9RAdQEPFLXQ
         nadGQazlHZ6HiZlFROdLW+KKAcEphP3SNRSmR3o8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Tatashin <pasha.tatashin@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, hpa@zytor.com, douly.fnst@cn.fujitsu.com,
        peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com,
        pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, pbonzini@redhat.com
Subject: [PATCH 4.14 64/68] x86/xen/time: Output xen sched_clock time from 0
Date:   Tue, 29 Jan 2019 12:36:26 +0100
Message-Id: <20190129113137.917364608@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113131.751891514@linuxfoundation.org>
References: <20190129113131.751891514@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Tatashin <pasha.tatashin@oracle.com>

commit 38669ba205d178d2d38bfd194a196d65a44d5af2 upstream.

It is expected for sched_clock() to output data from 0, when system boots.

Add an offset xen_sched_clock_offset (similarly how it is done in other
hypervisors i.e. kvm_sched_clock_offset) to count sched_clock() from 0,
when time is first initialized.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: steven.sistare@oracle.com
Cc: daniel.m.jordan@oracle.com
Cc: linux@armlinux.org.uk
Cc: schwidefsky@de.ibm.com
Cc: heiko.carstens@de.ibm.com
Cc: john.stultz@linaro.org
Cc: sboyd@codeaurora.org
Cc: hpa@zytor.com
Cc: douly.fnst@cn.fujitsu.com
Cc: peterz@infradead.org
Cc: prarit@redhat.com
Cc: feng.tang@intel.com
Cc: pmladek@suse.com
Cc: gnomes@lxorguk.ukuu.org.uk
Cc: linux-s390@vger.kernel.org
Cc: boris.ostrovsky@oracle.com
Cc: jgross@suse.com
Cc: pbonzini@redhat.com
Link: https://lkml.kernel.org/r/20180719205545.16512-14-pasha.tatashin@oracle.com
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/xen/time.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -31,6 +31,8 @@
 /* Xen may fire a timer up to this many ns early */
 #define TIMER_SLOP	100000
 
+static u64 xen_sched_clock_offset __read_mostly;
+
 /* Get the TSC speed from Xen */
 static unsigned long xen_tsc_khz(void)
 {
@@ -57,6 +59,11 @@ static u64 xen_clocksource_get_cycles(st
 	return xen_clocksource_read();
 }
 
+static u64 xen_sched_clock(void)
+{
+	return xen_clocksource_read() - xen_sched_clock_offset;
+}
+
 static void xen_read_wallclock(struct timespec *ts)
 {
 	struct shared_info *s = HYPERVISOR_shared_info;
@@ -367,7 +374,7 @@ void xen_timer_resume(void)
 }
 
 static const struct pv_time_ops xen_time_ops __initconst = {
-	.sched_clock = xen_clocksource_read,
+	.sched_clock = xen_sched_clock,
 	.steal_clock = xen_steal_clock,
 };
 
@@ -505,6 +512,7 @@ static void __init xen_time_init(void)
 
 void __ref xen_init_time_ops(void)
 {
+	xen_sched_clock_offset = xen_clocksource_read();
 	pv_time_ops = xen_time_ops;
 
 	x86_init.timers.timer_init = xen_time_init;
@@ -547,6 +555,7 @@ void __init xen_hvm_init_time_ops(void)
 		return;
 	}
 
+	xen_sched_clock_offset = xen_clocksource_read();
 	pv_time_ops = xen_time_ops;
 	x86_init.timers.setup_percpu_clockev = xen_time_init;
 	x86_cpuinit.setup_percpu_clockev = xen_hvm_setup_cpu_clockevents;


