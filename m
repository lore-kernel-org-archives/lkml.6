Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A14C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A87E2243E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A87E2243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbeKNFV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:21:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37298 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725748AbeKNFV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 00:21:56 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wADJJ2KQ025543
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 14:22:25 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nr352c8jr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 14:22:24 -0500
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 13 Nov 2018 19:22:23 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 13 Nov 2018 19:22:19 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wADJMImS23920668
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Nov 2018 19:22:18 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07C07B206A;
        Tue, 13 Nov 2018 19:22:18 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CECC4B2072;
        Tue, 13 Nov 2018 19:22:17 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.172.133])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 13 Nov 2018 19:22:17 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8177316C5DBF; Tue, 13 Nov 2018 11:22:17 -0800 (PST)
Date:   Tue, 13 Nov 2018 11:22:17 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH tip/core/rcu 20/41] kprobes: eplace synchronize_sched()
 with synchronize_rcu()
Reply-To: paulmck@linux.ibm.com
References: <20181111194104.GA4787@linux.ibm.com>
 <20181111194410.6368-20-paulmck@linux.ibm.com>
 <20181112120048.12b3fb7549f4b292fea1eefd@kernel.org>
 <20181112031916.GF4170@linux.ibm.com>
 <20181113100836.567dcbdafa13546928b62d7a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113100836.567dcbdafa13546928b62d7a@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18111319-2213-0000-0000-00000316E734
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010043; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116963; UDB=6.00579304; IPR=6.00897072;
 MB=3.00024145; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-13 19:22:22
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111319-2214-0000-0000-00005C3DFA35
Message-Id: <20181113192217.GN4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-13_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811130175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 10:08:36AM -0800, Masami Hiramatsu wrote:
> On Sun, 11 Nov 2018 19:19:16 -0800
> "Paul E. McKenney" <paulmck@linux.ibm.com> wrote:
> 
> > On Mon, Nov 12, 2018 at 12:00:48PM +0900, Masami Hiramatsu wrote:
> > > On Sun, 11 Nov 2018 11:43:49 -0800
> > > "Paul E. McKenney" <paulmck@linux.ibm.com> wrote:
> > > 
> > > > Now that synchronize_rcu() waits for preempt-disable regions of code
> > > > as well as RCU read-side critical sections, synchronize_sched() can be
> > > > replaced by synchronize_rcu().  This commit therefore makes this change.
> > > 
> > > Would you mean synchronize_rcu() can ensure that any interrupt handler
> > > (which should run under preempt-disable state) run out (even on non-preemptive
> > > kernel)?
> > 
> > Yes, but only as of this merge window.  See this commit:
> > 
> > 3e3100989869 ("rcu: Defer reporting RCU-preempt quiescent states when disabled")
> 
> OK, I also found that now those are same.
> 
> 45975c7d21a1 ("rcu: Define RCU-sched API in terms of RCU for Tree RCU PREEMPT builds")
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Applied, thank you!

							Thanx, Paul

> Thank you!
> 
> > 
> > Don't try this in v4.19 or earlier, but v4.20 and later is OK.  ;-)
> > 
> > 							Thanx, Paul
> > 
> > > If so, I agree with these changes.
> > > 
> > > Thank you,
> > > 
> > > > 
> > > > Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> > > > Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
> > > > Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> > > > Cc: "David S. Miller" <davem@davemloft.net>
> > > > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > > > ---
> > > >  kernel/kprobes.c | 10 +++++-----
> > > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > > > index 90e98e233647..08e31d863191 100644
> > > > --- a/kernel/kprobes.c
> > > > +++ b/kernel/kprobes.c
> > > > @@ -229,7 +229,7 @@ static int collect_garbage_slots(struct kprobe_insn_cache *c)
> > > >  	struct kprobe_insn_page *kip, *next;
> > > >  
> > > >  	/* Ensure no-one is interrupted on the garbages */
> > > > -	synchronize_sched();
> > > > +	synchronize_rcu();
> > > >  
> > > >  	list_for_each_entry_safe(kip, next, &c->pages, list) {
> > > >  		int i;
> > > > @@ -1382,7 +1382,7 @@ static int register_aggr_kprobe(struct kprobe *orig_p, struct kprobe *p)
> > > >  			if (ret) {
> > > >  				ap->flags |= KPROBE_FLAG_DISABLED;
> > > >  				list_del_rcu(&p->list);
> > > > -				synchronize_sched();
> > > > +				synchronize_rcu();
> > > >  			}
> > > >  		}
> > > >  	}
> > > > @@ -1597,7 +1597,7 @@ int register_kprobe(struct kprobe *p)
> > > >  		ret = arm_kprobe(p);
> > > >  		if (ret) {
> > > >  			hlist_del_rcu(&p->hlist);
> > > > -			synchronize_sched();
> > > > +			synchronize_rcu();
> > > >  			goto out;
> > > >  		}
> > > >  	}
> > > > @@ -1776,7 +1776,7 @@ void unregister_kprobes(struct kprobe **kps, int num)
> > > >  			kps[i]->addr = NULL;
> > > >  	mutex_unlock(&kprobe_mutex);
> > > >  
> > > > -	synchronize_sched();
> > > > +	synchronize_rcu();
> > > >  	for (i = 0; i < num; i++)
> > > >  		if (kps[i]->addr)
> > > >  			__unregister_kprobe_bottom(kps[i]);
> > > > @@ -1966,7 +1966,7 @@ void unregister_kretprobes(struct kretprobe **rps, int num)
> > > >  			rps[i]->kp.addr = NULL;
> > > >  	mutex_unlock(&kprobe_mutex);
> > > >  
> > > > -	synchronize_sched();
> > > > +	synchronize_rcu();
> > > >  	for (i = 0; i < num; i++) {
> > > >  		if (rps[i]->kp.addr) {
> > > >  			__unregister_kprobe_bottom(&rps[i]->kp);
> > > > -- 
> > > > 2.17.1
> > > > 
> > > 
> > > 
> > > -- 
> > > Masami Hiramatsu <mhiramat@kernel.org>
> > > 
> > 
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>
> 

