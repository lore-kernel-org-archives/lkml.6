Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URG_BIZ,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E35C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE90620875
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE90620875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388586AbeGKO2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:28:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59846 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387949AbeGKO2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:28:04 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6BEFa3i125065
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 10:23:28 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k5kcpgnw1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 10:23:28 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 11 Jul 2018 10:23:27 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 11 Jul 2018 10:23:25 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6BENP9i3998154
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Jul 2018 14:23:25 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA9A7B2064;
        Wed, 11 Jul 2018 10:23:23 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B979CB205F;
        Wed, 11 Jul 2018 10:23:22 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 11 Jul 2018 10:23:22 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 782B416C196F; Wed, 11 Jul 2018 07:25:42 -0700 (PDT)
Date:   Wed, 11 Jul 2018 07:25:42 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Hillenbrand, Marius" <mhillenb@amazon.com>
Subject: Re: [RFC] Make need_resched() return true when rcu_urgent_qs
 requested
Reply-To: paulmck@linux.vnet.ibm.com
References: <1531162254.26547.3.camel@infradead.org>
 <20180709203441.GE3593@linux.vnet.ibm.com>
 <1531168538.26547.5.camel@infradead.org>
 <20180709204248.GF3593@linux.vnet.ibm.com>
 <1531169145.26547.8.camel@infradead.org>
 <20180709210532.GH3593@linux.vnet.ibm.com>
 <20180709220823.GA18045@linux.vnet.ibm.com>
 <1531306663.8759.39.camel@infradead.org>
 <20180711125137.GL3593@linux.vnet.ibm.com>
 <1531313902.8759.48.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1531313902.8759.48.camel@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18071114-0060-0000-0000-0000028A90B2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009350; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01059813; UDB=6.00543955; IPR=6.00837733;
 MB=3.00022102; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-11 14:23:27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071114-0061-0000-0000-000045C29515
Message-Id: <20180711142542.GM3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-11_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807110154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 01:58:22PM +0100, David Woodhouse wrote:
> On Wed, 2018-07-11 at 05:51 -0700, Paul E. McKenney wrote:
> > 
> > Interesting.  (I am assuming that the guest is printing these messages,
> > not the host, but please let me know if my assumption is incorrect.)
> 
> No, this is all in the host. When the VMM (qemu, etc.) opens more files
> and has to expand its fd_table, the threads which are currently in
> KVM's vcpu_run() are making synchronize_sched() take multiple seconds.
> 
> > Are the CPUs saturated?  If so, could you please try booting with
> > rcutree.kthread_prio=2?  If that prevents the messages from happening,
> > then I need to put some work into guaranteeing forward progress.
> > Otherwise, I need to figure out why the setting of rcu_urgent_qs is
> > being ignored.
> 
> The CPUs shouldn't be saturated. The guest is fairly much idle. I can
> best reproduce this by starting up the guest and then assigning a new
> PCI device. At that point fairly much nothing is happening at all.

OK, thank you for the information and again apologies for the hassle.
I will do what I should have done long ago and make the relevant addition
to rcutorture.

In the meantime, one workaround is to export rcu_momentary_dyntick_idle()
and to invoke it from within your loop, for example, as enabled by the
(untested, probably does not even build) patch below.

This approach is quite a bit heavier weight than the hoped-for eventual
fix, but it should get this out of the way to allow you to find other
problems in your testing.  ;-)

							Thanx, Paul

> > I will assume the latter for the moment and see if I can spot the
> > problem.

------------------------------------------------------------------------

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index b3dbf9502fd0..bbf23e1318a9 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -115,6 +115,7 @@ static inline bool rcu_irq_enter_disabled(void) { return false; }
 static inline void rcu_irq_exit_irqson(void) { }
 static inline void rcu_irq_enter_irqson(void) { }
 static inline void rcu_irq_exit(void) { }
+static inline void rcu_momentary_dyntick_idle(void) { }
 static inline void exit_rcu(void) { }
 #ifdef CONFIG_SRCU
 void rcu_scheduler_starting(void);
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 37d6fd3b7ff8..1bec142720dd 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -86,6 +86,7 @@ void rcu_irq_exit(void);
 void rcu_irq_enter_irqson(void);
 void rcu_irq_exit_irqson(void);
 bool rcu_irq_enter_disabled(void);
+void rcu_momentary_dyntick_idle(void);
 
 void exit_rcu(void);
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f9c0ca2ccf0c..da06a52e5e60 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -439,11 +439,12 @@ bool rcu_eqs_special_set(int cpu)
  *
  * The caller must have disabled interrupts.
  */
-static void rcu_momentary_dyntick_idle(void)
+void rcu_momentary_dyntick_idle(void)
 {
 	raw_cpu_write(rcu_dynticks.rcu_need_heavy_qs, false);
 	rcu_dynticks_momentary_idle();
 }
+EXPORT_SYMBOL_GPL(rcu_momentary_dyntick_idle);
 
 /*
  * Note a context switch.  This is a quiescent state for RCU-sched,

