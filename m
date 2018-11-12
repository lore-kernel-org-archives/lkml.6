Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B37C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 03:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B2020881
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 03:24:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6B2020881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730526AbeKLNPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 08:15:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35664 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726270AbeKLNPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 08:15:51 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAC3O6F8046500
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 22:24:41 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2npxswnk6r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 22:24:40 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 12 Nov 2018 03:24:39 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 12 Nov 2018 03:24:34 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAC3OXMI62849130
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Nov 2018 03:24:33 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92E31B2519;
        Mon, 12 Nov 2018 03:19:25 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59E0FB2513;
        Mon, 12 Nov 2018 03:19:15 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.207.24])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 12 Nov 2018 03:19:15 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id A27C616C39E4; Sun, 11 Nov 2018 19:19:16 -0800 (PST)
Date:   Sun, 11 Nov 2018 19:19:16 -0800
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112120048.12b3fb7549f4b292fea1eefd@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18111203-0052-0000-0000-0000035465EE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010030; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116164; UDB=6.00578824; IPR=6.00896273;
 MB=3.00024116; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-12 03:24:39
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111203-0053-0000-0000-00005EBC075B
Message-Id: <20181112031916.GF4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-12_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811120030
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 12:00:48PM +0900, Masami Hiramatsu wrote:
> On Sun, 11 Nov 2018 11:43:49 -0800
> "Paul E. McKenney" <paulmck@linux.ibm.com> wrote:
> 
> > Now that synchronize_rcu() waits for preempt-disable regions of code
> > as well as RCU read-side critical sections, synchronize_sched() can be
> > replaced by synchronize_rcu().  This commit therefore makes this change.
> 
> Would you mean synchronize_rcu() can ensure that any interrupt handler
> (which should run under preempt-disable state) run out (even on non-preemptive
> kernel)?

Yes, but only as of this merge window.  See this commit:

3e3100989869 ("rcu: Defer reporting RCU-preempt quiescent states when disabled")

Don't try this in v4.19 or earlier, but v4.20 and later is OK.  ;-)

							Thanx, Paul

> If so, I agree with these changes.
> 
> Thank you,
> 
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> > Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
> > Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  kernel/kprobes.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index 90e98e233647..08e31d863191 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -229,7 +229,7 @@ static int collect_garbage_slots(struct kprobe_insn_cache *c)
> >  	struct kprobe_insn_page *kip, *next;
> >  
> >  	/* Ensure no-one is interrupted on the garbages */
> > -	synchronize_sched();
> > +	synchronize_rcu();
> >  
> >  	list_for_each_entry_safe(kip, next, &c->pages, list) {
> >  		int i;
> > @@ -1382,7 +1382,7 @@ static int register_aggr_kprobe(struct kprobe *orig_p, struct kprobe *p)
> >  			if (ret) {
> >  				ap->flags |= KPROBE_FLAG_DISABLED;
> >  				list_del_rcu(&p->list);
> > -				synchronize_sched();
> > +				synchronize_rcu();
> >  			}
> >  		}
> >  	}
> > @@ -1597,7 +1597,7 @@ int register_kprobe(struct kprobe *p)
> >  		ret = arm_kprobe(p);
> >  		if (ret) {
> >  			hlist_del_rcu(&p->hlist);
> > -			synchronize_sched();
> > +			synchronize_rcu();
> >  			goto out;
> >  		}
> >  	}
> > @@ -1776,7 +1776,7 @@ void unregister_kprobes(struct kprobe **kps, int num)
> >  			kps[i]->addr = NULL;
> >  	mutex_unlock(&kprobe_mutex);
> >  
> > -	synchronize_sched();
> > +	synchronize_rcu();
> >  	for (i = 0; i < num; i++)
> >  		if (kps[i]->addr)
> >  			__unregister_kprobe_bottom(kps[i]);
> > @@ -1966,7 +1966,7 @@ void unregister_kretprobes(struct kretprobe **rps, int num)
> >  			rps[i]->kp.addr = NULL;
> >  	mutex_unlock(&kprobe_mutex);
> >  
> > -	synchronize_sched();
> > +	synchronize_rcu();
> >  	for (i = 0; i < num; i++) {
> >  		if (rps[i]->kp.addr) {
> >  			__unregister_kprobe_bottom(&rps[i]->kp);
> > -- 
> > 2.17.1
> > 
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>
> 

