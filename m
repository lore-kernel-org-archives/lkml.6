Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URG_BIZ,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED671ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E56E2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:14:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E56E2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbeGRUyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 16:54:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36380 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730123AbeGRUyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 16:54:10 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6IKDeGi123905
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 16:14:40 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ka8tkrncq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 16:14:40 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 18 Jul 2018 16:14:38 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 18 Jul 2018 16:14:36 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6IKEZ0J9109852
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Jul 2018 20:14:35 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4C00B2066;
        Wed, 18 Jul 2018 16:14:25 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 94DD8B2064;
        Wed, 18 Jul 2018 16:14:25 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 18 Jul 2018 16:14:25 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9D02316C1D4F; Wed, 18 Jul 2018 13:17:00 -0700 (PDT)
Date:   Wed, 18 Jul 2018 13:17:00 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, mhillenb@amazon.de,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [RFC] Make need_resched() return true when rcu_urgent_qs
 requested
Reply-To: paulmck@linux.vnet.ibm.com
References: <1531396842.8759.125.camel@infradead.org>
 <20180712125351.GP3593@linux.vnet.ibm.com>
 <20180712161704.GA20726@linux.vnet.ibm.com>
 <20180716154015.GA21419@linux.vnet.ibm.com>
 <1531815548.19223.23.camel@infradead.org>
 <20180717125653.GH12945@linux.vnet.ibm.com>
 <20180718153628.GA24359@linux.vnet.ibm.com>
 <1531929711.3414.29.camel@infradead.org>
 <20180718163712.GB12945@linux.vnet.ibm.com>
 <1531942865.3414.35.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1531942865.3414.35.camel@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18071820-0060-0000-0000-0000028E3C99
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009387; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01062718; UDB=6.00545662; IPR=6.00840573;
 MB=3.00022190; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-18 20:14:38
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071820-0061-0000-0000-000045D870A2
Message-Id: <20180718201700.GN12945@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-18_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807180220
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 09:41:05PM +0200, David Woodhouse wrote:
> 
> 
> On Wed, 2018-07-18 at 09:37 -0700, Paul E. McKenney wrote:
> > On Wed, Jul 18, 2018 at 06:01:51PM +0200, David Woodhouse wrote:
> > > 
> > > On Wed, 2018-07-18 at 08:36 -0700, Paul E. McKenney wrote:
> > > > 
> > > > And I finally did get some near misses from an earlier commit, so we
> > > > should consider your patch to be officially off the hook.
> > >
> > > Yay, I like it when it's not my fault. I'll redo it with the ifdef
> > > CONFIG_NO_HZ_FULL.
> >
> > Hey, I didn't say it wasn't your fault, only that it -officially- wasn't
> > your fault.  ;-)
> 
> I can live with being innocent until proven guilty.
> 
> > > 
> > > What should it do for the !CONFIG_NO_HZ_FULL case? The existing call in
> > > guest_enter_irqoff() clearly wasn't actually doing the right thing
> > > anyway, hence the need for the need_resched() patch in $SUBJECT... so
> > > should I just leave it doing nothing in guest_enter_irqoff()? 
> >
> > One starting point would be the combination of your patch and my
> > patch, with -rcu commit IDs and diff below.  But yes, it needs to be
> > !CONFIG_NO_HZ_FULL.  And no, I am not at all confident that I actually
> > found all the places needing change in the core code, so this needs some
> > serious review both by the KVM guys and the NO_HZ_FULL guys.
> 
> Right, that looks fairly much like the version I'd ended up with. So my
> question was...
> 
> > --- a/include/linux/context_tracking.h
> > +++ b/include/linux/context_tracking.h
> > @@ -118,12 +118,12 @@ static inline void guest_enter_irqoff(void)
> >  	 * one time slice). Lets treat guest mode as quiescent state, just like
> >  	 * we do with user-mode execution.
> >  	 */
> 
> ...if we change this to something like...
> 
> #ifdef CONFIG_NO_HZ_FULL
> > +	rcu_kvm_enter();
> #else
> > 	if (!context_tracking_cpu_is_enabled())
> > 		rcu_virt_note_context_switch(smp_processor_id());
> #endif
> 
> ... do you actually want me to keep the #else case there? It blatantly
> wasn't working anyway for us, perhaps because the condition was false?
> That's why I started fixing need_resched() in the first place, and that
> fix ought to cover whatever this call to rcu_virt_note_context_switch()
> was supposed to be doing?

My thought would be something like this:

	if (context_tracking_cpu_is_enabled())
		rcu_kvm_enter();
	else
		rcu_virt_note_context_switch(smp_processor_id());

The reason I believe that this is the right approach is that even when
you have CONFIG_NO_HZ_FULL=y, some CPUs will still be nohz_full=n CPUs,
so you don't want to take the extra overhead on those CPUs.

But I could easily be confused here, so I am adding Frederic for his
thoughts.

							Thanx, Paul

