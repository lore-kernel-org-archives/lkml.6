Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48111C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEB7023C19
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:45:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEB7023C19
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934054AbeGCQpx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:45:53 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44931 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932759AbeGCQpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:45:51 -0400
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1faOR3-0005hQ-EG; Tue, 03 Jul 2018 18:45:49 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] cgroup: use irqsave in cgroup_rstat_flush_locked()
Date:   Tue,  3 Jul 2018 18:45:44 +0200
Message-Id: <20180703164544.25268-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All callers of cgroup_rstat_flush_locked() acquire cgroup_rstat_lock
either with spin_lock_irq() or spin_lock_irqsave().
cgroup_rstat_flush_locked() itself acquires cgroup_rstat_cpu_lock which
is a raw_spin_lock. This lock is also acquired in cgroup_rstat_updated()
in IRQ context and therefore requires _irqsave() locking suffix in
cgroup_rstat_flush_locked().
Since there is no difference between spin_lock_t and raw_spin_lock_t
on !RT lockdep does not complain here. On RT lockdep complains because
the interrupts were not disabled here and a deadlock is possible.

Acquire the raw_spin_lock_t with disabled interrupts.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/cgroup/rstat.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index d503d1a9007c..63fc5e472c82 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -157,8 +157,9 @@ static void cgroup_rstat_flush_locked(struct cgroup *cg=
rp, bool may_sleep)
 		raw_spinlock_t *cpu_lock =3D per_cpu_ptr(&cgroup_rstat_cpu_lock,
 						       cpu);
 		struct cgroup *pos =3D NULL;
+		unsigned long flags;
=20
-		raw_spin_lock(cpu_lock);
+		raw_spin_lock_irqsave(cpu_lock, flags);
 		while ((pos =3D cgroup_rstat_cpu_pop_updated(pos, cgrp, cpu))) {
 			struct cgroup_subsys_state *css;
=20
@@ -170,7 +171,7 @@ static void cgroup_rstat_flush_locked(struct cgroup *cg=
rp, bool may_sleep)
 				css->ss->css_rstat_flush(css, cpu);
 			rcu_read_unlock();
 		}
-		raw_spin_unlock(cpu_lock);
+		raw_spin_unlock_irqrestore(cpu_lock, flags);
=20
 		/* if @may_sleep, play nice and yield if necessary */
 		if (may_sleep && (need_resched() ||
--=20
2.18.0

