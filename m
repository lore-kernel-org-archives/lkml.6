Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CFDC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C91D217D9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvCJeV/g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730854AbfACOZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 09:25:30 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35181 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbfACOZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 09:25:30 -0500
Received: by mail-pg1-f193.google.com with SMTP id s198so16079765pgs.2;
        Thu, 03 Jan 2019 06:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iLTZ0cgTG91z7S9lSIj8BQKMB7ZsyNxPQ7QHvLRKSb0=;
        b=PvCJeV/gh3OKnFiUMA+1t5W0R5uPwOVrHRtKa/5/2wppCyB1IAk1BBmFpwUdTIn44+
         LpCj6EiZetisq7GljryF/1UdjQTbiE9xq3tuELkJVdR2SkKEQCkzpxLo7aNowDCq5fR2
         uLpJQsYthkyYT1979uJQibSCh3iADnxDQZSRytdN0Te7qkXe2HV2eirG/jew3W2JZgP4
         hg8/+f514lPx/3z2+NspopUS4mhwnmmIMlhmi54C5falub5DSju8keFLGKxa2n3ku6qN
         HN7j8Z33OG9lVL9DkAgLAwVEPGS/bO+ErpCsZiTRK4HNa31FGkz8D6K5yUn8n4A8B2Yp
         zK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iLTZ0cgTG91z7S9lSIj8BQKMB7ZsyNxPQ7QHvLRKSb0=;
        b=GCFW3GUYvmXbT02mnEyvaab6hGkMoK/c+WxEAyz2970ypHv9pPobZsafPYaXkugyVj
         xwDnU6QFoXtXSDm3SDuOe36rE1OFqOgYaEntbmJTU1/SyGjVEuCAQxtTxk1bawa9SEaB
         gsd36aLhMJvabaSlxnsUWI8Pjim+bybmFX1cd/yr0L52N25ZQwYfD+BOSEG9V3IKl/9d
         IiaWaTrMoIxFE20BdwK0Wlg60yVRiJH8UYDtdp9EQ5xQiH1orsEy+YjfpJhMCtbKL75e
         OelJmTx4I1kNKC6TPEhkMAMQWPubzfy2C4lS5gToEtZKpk0mHXNbMj41MvVntOCTtunG
         Z1lA==
X-Gm-Message-State: AJcUukdliPYcOOOtCzar4kK4Z3VFMnpdogBBcE1lM49JuozsJTUUMGJE
        P6MuWCjJllwC+OBwFTEoxA==
X-Google-Smtp-Source: ALg8bN5gJFhaVNoSRbxaTG3Q15UUzOOPszm1XhNQKwvai9Zjgws1M9+8fJxxxsJg98nApdYPH1EwOA==
X-Received: by 2002:a63:2109:: with SMTP id h9mr17207318pgh.277.1546525529084;
        Thu, 03 Jan 2019 06:25:29 -0800 (PST)
Received: from localhost.localdomain (li1566-229.members.linode.com. [139.162.86.229])
        by smtp.gmail.com with ESMTPSA id v12sm80201432pgg.41.2019.01.03.06.25.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Jan 2019 06:25:28 -0800 (PST)
From:   Junchang Wang <junchangwang@gmail.com>
To:     dave@stgolabs.net, paulmck@linux.ibm.com, josh@joshtriplett.org,
        corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Junchang Wang <junchangwang@gmail.com>
Subject: [PATCH] RCU/torture.txt: remove section MODULE PARAMETERS
Date:   Thu,  3 Jan 2019 22:24:51 +0800
Message-Id: <1546525491-5724-1-git-send-email-junchangwang@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The supported module parameters are detailed in both RCU/torture.txt and 
admin-guide/kernel-parameters.txt, and the latter is actively maintained.
So this patch removes section MODULE PARAMETERS in torture.txt and
adds a reference to the information in kernel-parameters.txt.

Signed-off-by: Junchang Wang <junchangwang@gmail.com>
---
 Documentation/RCU/torture.txt | 169 +-----------------------------------------
 1 file changed, 2 insertions(+), 167 deletions(-)

diff --git a/Documentation/RCU/torture.txt b/Documentation/RCU/torture.txt
index 55918b5..c12d4cc 100644
--- a/Documentation/RCU/torture.txt
+++ b/Documentation/RCU/torture.txt
@@ -10,173 +10,8 @@ status messages via printk(), which can be examined via the dmesg
 command (perhaps grepping for "torture").  The test is started
 when the module is loaded, and stops when the module is unloaded.
 
-
-MODULE PARAMETERS
-
-This module has the following parameters:
-
-fqs_duration	Duration (in microseconds) of artificially induced bursts
-		of force_quiescent_state() invocations.  In RCU
-		implementations having force_quiescent_state(), these
-		bursts help force races between forcing a given grace
-		period and that grace period ending on its own.
-
-fqs_holdoff	Holdoff time (in microseconds) between consecutive calls
-		to force_quiescent_state() within a burst.
-
-fqs_stutter	Wait time (in seconds) between consecutive bursts
-		of calls to force_quiescent_state().
-
-gp_normal	Make the fake writers use normal synchronous grace-period
-		primitives.
-
-gp_exp		Make the fake writers use expedited synchronous grace-period
-		primitives.  If both gp_normal and gp_exp are set, or
-		if neither gp_normal nor gp_exp are set, then randomly
-		choose the primitive so that about 50% are normal and
-		50% expedited.  By default, neither are set, which
-		gives best overall test coverage.
-
-irqreader	Says to invoke RCU readers from irq level.  This is currently
-		done via timers.  Defaults to "1" for variants of RCU that
-		permit this.  (Or, more accurately, variants of RCU that do
-		-not- permit this know to ignore this variable.)
-
-n_barrier_cbs	If this is nonzero, RCU barrier testing will be conducted,
-		in which case n_barrier_cbs specifies the number of
-		RCU callbacks (and corresponding kthreads) to use for
-		this testing.  The value cannot be negative.  If you
-		specify this to be non-zero when torture_type indicates a
-		synchronous RCU implementation (one for which a member of
-		the synchronize_rcu() rather than the call_rcu() family is
-		used -- see the documentation for torture_type below), an
-		error will be reported and no testing will be carried out.
-
-nfakewriters	This is the number of RCU fake writer threads to run.  Fake
-		writer threads repeatedly use the synchronous "wait for
-		current readers" function of the interface selected by
-		torture_type, with a delay between calls to allow for various
-		different numbers of writers running in parallel.
-		nfakewriters defaults to 4, which provides enough parallelism
-		to trigger special cases caused by multiple writers, such as
-		the synchronize_srcu() early return optimization.
-
-nreaders	This is the number of RCU reading threads supported.
-		The default is twice the number of CPUs.  Why twice?
-		To properly exercise RCU implementations with preemptible
-		read-side critical sections.
-
-onoff_interval
-		The number of seconds between each attempt to execute a
-		randomly selected CPU-hotplug operation.  Defaults to
-		zero, which disables CPU hotplugging.  In HOTPLUG_CPU=n
-		kernels, rcutorture will silently refuse to do any
-		CPU-hotplug operations regardless of what value is
-		specified for onoff_interval.
-
-onoff_holdoff	The number of seconds to wait until starting CPU-hotplug
-		operations.  This would normally only be used when
-		rcutorture was built into the kernel and started
-		automatically at boot time, in which case it is useful
-		in order to avoid confusing boot-time code with CPUs
-		coming and going.
-
-shuffle_interval
-		The number of seconds to keep the test threads affinitied
-		to a particular subset of the CPUs, defaults to 3 seconds.
-		Used in conjunction with test_no_idle_hz.
-
-shutdown_secs	The number of seconds to run the test before terminating
-		the test and powering off the system.  The default is
-		zero, which disables test termination and system shutdown.
-		This capability is useful for automated testing.
-
-stall_cpu	The number of seconds that a CPU should be stalled while
-		within both an rcu_read_lock() and a preempt_disable().
-		This stall happens only once per rcutorture run.
-		If you need multiple stalls, use modprobe and rmmod to
-		repeatedly run rcutorture.  The default for stall_cpu
-		is zero, which prevents rcutorture from stalling a CPU.
-
-		Note that attempts to rmmod rcutorture while the stall
-		is ongoing will hang, so be careful what value you
-		choose for this module parameter!  In addition, too-large
-		values for stall_cpu might well induce failures and
-		warnings in other parts of the kernel.  You have been
-		warned!
-
-stall_cpu_holdoff
-		The number of seconds to wait after rcutorture starts
-		before stalling a CPU.  Defaults to 10 seconds.
-
-stat_interval	The number of seconds between output of torture
-		statistics (via printk()).  Regardless of the interval,
-		statistics are printed when the module is unloaded.
-		Setting the interval to zero causes the statistics to
-		be printed -only- when the module is unloaded, and this
-		is the default.
-
-stutter		The length of time to run the test before pausing for this
-		same period of time.  Defaults to "stutter=5", so as
-		to run and pause for (roughly) five-second intervals.
-		Specifying "stutter=0" causes the test to run continuously
-		without pausing, which is the old default behavior.
-
-test_boost	Whether or not to test the ability of RCU to do priority
-		boosting.  Defaults to "test_boost=1", which performs
-		RCU priority-inversion testing only if the selected
-		RCU implementation supports priority boosting.  Specifying
-		"test_boost=0" never performs RCU priority-inversion
-		testing.  Specifying "test_boost=2" performs RCU
-		priority-inversion testing even if the selected RCU
-		implementation does not support RCU priority boosting,
-		which can be used to test rcutorture's ability to
-		carry out RCU priority-inversion testing.
-
-test_boost_interval
-		The number of seconds in an RCU priority-inversion test
-		cycle.	Defaults to "test_boost_interval=7".  It is
-		usually wise for this value to be relatively prime to
-		the value selected for "stutter".
-
-test_boost_duration
-		The number of seconds to do RCU priority-inversion testing
-		within any given "test_boost_interval".  Defaults to
-		"test_boost_duration=4".
-
-test_no_idle_hz	Whether or not to test the ability of RCU to operate in
-		a kernel that disables the scheduling-clock interrupt to
-		idle CPUs.  Boolean parameter, "1" to test, "0" otherwise.
-		Defaults to omitting this test.
-
-torture_type	The type of RCU to test, with string values as follows:
-
-		"rcu":  rcu_read_lock(), rcu_read_unlock() and call_rcu(),
-			along with expedited, synchronous, and polling
-			variants.
-
-		"rcu_bh": rcu_read_lock_bh(), rcu_read_unlock_bh(), and
-			call_rcu_bh(), along with expedited and synchronous
-			variants.
-
-		"rcu_busted": This tests an intentionally incorrect version
-			of RCU in order to help test rcutorture itself.
-
-		"srcu": srcu_read_lock(), srcu_read_unlock() and
-			call_srcu(), along with expedited and
-			synchronous variants.
-
-		"sched": preempt_disable(), preempt_enable(), and
-			call_rcu_sched(), along with expedited,
-			synchronous, and polling variants.
-
-		"tasks": voluntary context switch and call_rcu_tasks(),
-			along with expedited and synchronous variants.
-
-		Defaults to "rcu".
-
-verbose		Enable debug printk()s.  Default is disabled.
-
+Module parameters are detailed in
+Documentation/admin-guide/kernel-parameters.txt.
 
 OUTPUT
 
-- 
2.7.4

