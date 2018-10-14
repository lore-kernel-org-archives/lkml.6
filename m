Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48DEC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76A5F20645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76A5F20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbeJNXXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:23:47 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36197 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728029AbeJNXMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:12:00 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLo-0004cf-8h; Sun, 14 Oct 2018 16:30:40 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLX-0000YD-Le; Sun, 14 Oct 2018 16:30:23 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Pablo Neira Ayuso" <pablo@netfilter.org>,
        "Julian Anastasov" <ja@ssi.bg>, "Simon Horman" <horms@verge.net.au>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.205393079@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 270/366] ipvs: fix stats update from local clients
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Anastasov <ja@ssi.bg>

commit d5e032fc5697b6c0d6b4958bcacb981a08f8174e upstream.

Local clients are not properly synchronized on 32-bit CPUs when
updating stats (3.10+). Now it is possible estimation_timer (timer),
a stats reader, to interrupt the local client in the middle of
write_seqcount_{begin,end} sequence leading to loop (DEADLOCK).
The same interrupt can happen from received packet (SoftIRQ)
which updates the same per-CPU stats.

Fix it by disabling BH while updating stats.

Found with debug:

WARNING: inconsistent lock state
4.17.0-rc2-00105-g35cb6d7-dirty #2 Not tainted
--------------------------------
inconsistent {IN-SOFTIRQ-R} -> {SOFTIRQ-ON-W} usage.
ftp/2545 [HC0[0]:SC0[0]:HE1:SE1] takes:
86845479 (&syncp->seq#6){+.+-}, at: ip_vs_schedule+0x1c5/0x59e [ip_vs]
{IN-SOFTIRQ-R} state was registered at:
 lock_acquire+0x44/0x5b
 estimation_timer+0x1b3/0x341 [ip_vs]
 call_timer_fn+0x54/0xcd
 run_timer_softirq+0x10c/0x12b
 __do_softirq+0xc1/0x1a9
 do_softirq_own_stack+0x1d/0x23
 irq_exit+0x4a/0x64
 smp_apic_timer_interrupt+0x63/0x71
 apic_timer_interrupt+0x3a/0x40
 default_idle+0xa/0xc
 arch_cpu_idle+0x9/0xb
 default_idle_call+0x21/0x23
 do_idle+0xa0/0x167
 cpu_startup_entry+0x19/0x1b
 start_secondary+0x133/0x182
 startup_32_smp+0x164/0x168
irq event stamp: 42213

other info that might help us debug this:
Possible unsafe locking scenario:

      CPU0
      ----
 lock(&syncp->seq#6);
 <Interrupt>
   lock(&syncp->seq#6);

*** DEADLOCK ***

Fixes: ac69269a45e8 ("ipvs: do not disable bh for long time")
Signed-off-by: Julian Anastasov <ja@ssi.bg>
Acked-by: Simon Horman <horms@verge.net.au>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
[bwh: Backported to 3.16:
 - Drop change in ip_vs_conn_stats(), which doesn't use a seqlock
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/net/netfilter/ipvs/ip_vs_core.c
+++ b/net/netfilter/ipvs/ip_vs_core.c
@@ -118,6 +118,8 @@ ip_vs_in_stats(struct ip_vs_conn *cp, st
 		struct ip_vs_cpu_stats *s;
 		struct ip_vs_service *svc;
 
+		local_bh_disable();
+
 		s = this_cpu_ptr(dest->stats.cpustats);
 		s->ustats.inpkts++;
 		u64_stats_update_begin(&s->syncp);
@@ -138,6 +140,8 @@ ip_vs_in_stats(struct ip_vs_conn *cp, st
 		u64_stats_update_begin(&s->syncp);
 		s->ustats.inbytes += skb->len;
 		u64_stats_update_end(&s->syncp);
+
+		local_bh_enable();
 	}
 }
 
@@ -152,6 +156,8 @@ ip_vs_out_stats(struct ip_vs_conn *cp, s
 		struct ip_vs_cpu_stats *s;
 		struct ip_vs_service *svc;
 
+		local_bh_disable();
+
 		s = this_cpu_ptr(dest->stats.cpustats);
 		s->ustats.outpkts++;
 		u64_stats_update_begin(&s->syncp);
@@ -172,6 +178,8 @@ ip_vs_out_stats(struct ip_vs_conn *cp, s
 		u64_stats_update_begin(&s->syncp);
 		s->ustats.outbytes += skb->len;
 		u64_stats_update_end(&s->syncp);
+
+		local_bh_enable();
 	}
 }
 

