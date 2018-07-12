Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URG_BIZ,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEE6C476E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABAFF20849
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:14:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABAFF20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732361AbeGLQZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 12:25:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38844 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726775AbeGLQZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 12:25:02 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6CGDOjm101074
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 12:14:48 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k69pshpn4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 12:14:47 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 12 Jul 2018 12:14:47 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 12 Jul 2018 12:14:44 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6CGEh8I10223992
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Jul 2018 16:14:44 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F0A2B206A;
        Thu, 12 Jul 2018 12:14:42 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3837B2068;
        Thu, 12 Jul 2018 12:14:41 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 12 Jul 2018 12:14:41 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 53D5816C1728; Thu, 12 Jul 2018 09:17:04 -0700 (PDT)
Date:   Thu, 12 Jul 2018 09:17:04 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, mhillenb@amazon.de,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>
Subject: Re: [RFC] Make need_resched() return true when rcu_urgent_qs
 requested
Reply-To: paulmck@linux.vnet.ibm.com
References: <1531319025.8759.57.camel@infradead.org>
 <20180711144303.GQ3593@linux.vnet.ibm.com>
 <20180711164952.GA29994@linux.vnet.ibm.com>
 <e21c6d7666bfbad1e1c8295559a6ddc7e4110105.camel@infradead.org>
 <9ee4d6fd-02e2-2c73-36a7-36ef4f6413b0@de.ibm.com>
 <20180711201759.GB3593@linux.vnet.ibm.com>
 <1531340384.8759.86.camel@infradead.org>
 <20180711210828.GD3593@linux.vnet.ibm.com>
 <1531396842.8759.125.camel@infradead.org>
 <20180712125351.GP3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180712125351.GP3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18071216-0060-0000-0000-0000028B44E4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009357; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01060330; UDB=6.00544266; IPR=6.00838249;
 MB=3.00022118; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-12 16:14:46
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071216-0061-0000-0000-000045C622A7
Message-Id: <20180712161704.GA20726@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-12_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807120171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 05:53:51AM -0700, Paul E. McKenney wrote:
> On Thu, Jul 12, 2018 at 01:00:42PM +0100, David Woodhouse wrote:
> > 
> > 
> > On Wed, 2018-07-11 at 14:08 -0700, Paul E. McKenney wrote:
> > > 
> > > > Also... why in $DEITY's name was the existing
> > > > rcu_virt_note_context_switch() not actually sufficient? If we had that
> > > > there, why did we need an additional explicit calls to rcu_all_qs() in
> > > > the KVM loop, or the more complex fixes to need_resched() which
> > > > ultimately had the same effect, to avoid ten-second latencies?
> > > 
> > > My guess is that this was because control passed through the
> > > rcu_virt_note_context_switch() only once, and then subsequent
> > > scheduling-clock interrupts bypassed this code.
> 
> Gah!  My guess was instead that the code did a rcu_kvm_enter() going in,
> but somehow managed to miss the rcu_kvm_exit() going out.  But that makes
> absolutely no sense -- had that happened, rcutorture would likely have
> screamed bloody murder, loudly and often.  No mere near misses!
> 
> And besides, thus far, -ENOREPRODUCE.  :-/

OK, one close call in 63 hours of rcutorture, this one on scenario TREE03
(yesterday hit TREE01 and TREE03).  Time for probabilitistic long-runtime
bisection.  Plus thought about how to get more information out of the near
misses.  Fun!  ;-)

							Thanx, Paul

> Which indicates that I have an opportunity to improve rcutorture and
> that this patch was with high probability an innocent bystander.
> 
> > >                                                  But that is just a guess.
> > > I need to defer to someone who understands the KVM code better than I do.
> > 
> > I think it's more likely that we just never happened at all. It's
> > conditional. From the latest patch iteration (see it being removed):
> > 
> > @@ -118,12 +118,12 @@ static inline void guest_enter_irqoff(void)
> >          * one time slice). Lets treat guest mode as quiescent state, just like
> >          * we do with user-mode execution.
> >          */
> > -       if (!context_tracking_cpu_is_enabled())
> > -               rcu_virt_note_context_switch(smp_processor_id());
> > +       rcu_kvm_enter();
> >  }
> > 
> > 
> > Given the vmexit overhead, I don't think we can do the currently-
> > proposed rcu_kvm_enter() thing except for CONFIG_NO_HZ_FULL where it's
> > really necessary. I'll make that conditional, but probably on the RCU
> > side.
> > 
> > Without CONFIG_NO_HZ_FULL, rcu_kvm_exit() can do nothing, and
> > rcu_kvm_enter() can do rcu_virt_note_context_switch().
> > 
> > OK?
> 
> Makes sense to me!  And a big "thank you!" to Christian for testing
> and analyzing this in a timely fashion!!!
> 
> 							Thanx, Paul

