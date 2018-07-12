Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595DDC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E9D2146F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:13:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12E9D2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403898AbeGLCU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 22:20:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46192 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2403883AbeGLCU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 22:20:57 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6C244Xh125313
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 22:13:45 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k5teexgj4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 22:13:44 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 11 Jul 2018 22:13:43 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 11 Jul 2018 22:13:41 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6C2De7g18153840
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Jul 2018 02:13:40 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F36BB2064;
        Wed, 11 Jul 2018 22:13:39 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDBAAB205F;
        Wed, 11 Jul 2018 22:13:38 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.161.121])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 11 Jul 2018 22:13:38 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 06C8916C41DD; Wed, 11 Jul 2018 19:16:00 -0700 (PDT)
Date:   Wed, 11 Jul 2018 19:15:59 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     David Woodhouse <dwmw2@infradead.org>, peterz@infradead.org,
        mhillenb@amazon.de, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH v2] kvm/x86: Inform RCU of quiescent state when entering
 guest mode
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180711174843.GX3593@linux.vnet.ibm.com>
 <20180711180101.3711464-1-dwmw2@infradead.org>
 <20180711182053.GA3593@linux.vnet.ibm.com>
 <20180711183645.GA23820@linux.vnet.ibm.com>
 <62e945ee-a58e-f9b3-279c-74cd0f5809da@de.ibm.com>
 <20180711202752.GC3593@linux.vnet.ibm.com>
 <2f7ba67e-0442-13cc-628c-2dca56520c21@de.ibm.com>
 <20180711213259.GF3593@linux.vnet.ibm.com>
 <20180711233727.GA9888@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711233727.GA9888@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18071202-0040-0000-0000-0000044D8CAA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009354; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01060050; UDB=6.00544097; IPR=6.00837970;
 MB=3.00022109; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-12 02:13:42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071202-0041-0000-0000-00000853B277
Message-Id: <20180712021559.GA413@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-11_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807120022
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 04:37:27PM -0700, Paul E. McKenney wrote:
> On Wed, Jul 11, 2018 at 02:32:59PM -0700, Paul E. McKenney wrote:
> > On Wed, Jul 11, 2018 at 11:11:19PM +0200, Christian Borntraeger wrote:
> > > 
> > > 
> > > On 07/11/2018 10:27 PM, Paul E. McKenney wrote:
> > > > On Wed, Jul 11, 2018 at 08:39:36PM +0200, Christian Borntraeger wrote:
> > > >>
> > > >>
> > > >> On 07/11/2018 08:36 PM, Paul E. McKenney wrote:
> > > >>> On Wed, Jul 11, 2018 at 11:20:53AM -0700, Paul E. McKenney wrote:
> > > >>>> On Wed, Jul 11, 2018 at 07:01:01PM +0100, David Woodhouse wrote:
> > > >>>>> From: David Woodhouse <dwmw@amazon.co.uk>
> > > >>>>>
> > > >>>>> RCU can spend long periods of time waiting for a CPU which is actually in
> > > >>>>> KVM guest mode, entirely pointlessly. Treat it like the idle and userspace
> > > >>>>> modes, and don't wait for it.
> > > >>>>>
> > > >>>>> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> > > >>>>
> > > >>>> And idiot here forgot about some of the debugging code in RCU's dyntick-idle
> > > >>>> code.  I will reply with a fixed patch.
> > > >>>>
> > > >>>> The code below works just fine as long as you don't enable CONFIG_RCU_EQS_DEBUG,
> > > >>>> so should be OK for testing, just not for mainline.
> > > >>>
> > > >>> And here is the updated code that allegedly avoids splatting when run with
> > > >>> CONFIG_RCU_EQS_DEBUG.
> > > >>>
> > > >>> Thoughts?
> > > >>>
> > > >>> 							Thanx, Paul
> > > >>>
> > > >>> ------------------------------------------------------------------------
> > > >>>
> > > >>> commit 12cd59e49cf734f907f44b696e2c6e4b46a291c3
> > > >>> Author: David Woodhouse <dwmw@amazon.co.uk>
> > > >>> Date:   Wed Jul 11 19:01:01 2018 +0100
> > > >>>
> > > >>>     kvm/x86: Inform RCU of quiescent state when entering guest mode
> > > >>>     
> > > >>>     RCU can spend long periods of time waiting for a CPU which is actually in
> > > >>>     KVM guest mode, entirely pointlessly. Treat it like the idle and userspace
> > > >>>     modes, and don't wait for it.
> > > >>>     
> > > >>>     Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> > > >>>     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > >>>     [ paulmck: Adjust to avoid bad advice I gave to dwmw, avoid WARN_ON()s. ]
> > > >>>
> > > >>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > >>> index 0046aa70205a..b0c82f70afa7 100644
> > > >>> --- a/arch/x86/kvm/x86.c
> > > >>> +++ b/arch/x86/kvm/x86.c
> > > >>> @@ -7458,7 +7458,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
> > > >>>  		vcpu->arch.switch_db_regs &= ~KVM_DEBUGREG_RELOAD;
> > > >>>  	}
> > > >>>
> > > >>> +	rcu_kvm_enter();
> > > >>>  	kvm_x86_ops->run(vcpu);
> > > >>> +	rcu_kvm_exit();
> > > >>
> > > >> As indicated in my other mail. This is supposed to be handled in the guest_enter|exit_ calls around
> > > >> the run function. This would also handle other architectures. So if the guest_enter_irqoff code is
> > > >> not good enough, we should rather fix that instead of adding another rcu hint.
> > > > 
> > > > Something like this, on top of the earlier patch?  I am not at all
> > > > confident of this patch because there might be other entry/exit
> > > > paths I am missing.  Plus there might be RCU uses on the arch-specific
> > > > patch to and from the guest OS.
> > > > 
> > > > Thoughts?
> > > > 
> > > 
> > > If you instrment guest_enter/exit, you should cover all cases and all architectures as far
> > > as I can tell. FWIW, we did this rcu_note thing back then actually handling this particular
> > > case of long running guests blocking rcu for many seconds. And I am pretty sure that
> > > this did help back then.
> > 
> > And my second patch on the email you replied to replaced the only call
> > to rcu_virt_note_context_switch().  So maybe it covers what it needs to,
> > but yes, there might well be things I missed.  Let's see what David
> > comes up with.
> > 
> > What changed was RCU's reactions to longish grace periods.  It used to
> > be very aggressive about forcing the scheduler to do otherwise-unneeded
> > context switches, which became a problem somewhere between v4.9 and v4.15.
> > I therefore reduced the number of such context switches, which in turn
> > caused KVM to tell RCU about quiescent states way too infrequently.
> > 
> > The advantage of the rcu_kvm_enter()/rcu_kvm_exit() approach is that
> > it tells RCU of an extended duration in the guest, which means that
> > RCU can ignore the corresponding CPU, which in turn allows the guest
> > to proceed without any RCU-induced interruptions.
> > 
> > Does that make sense, or am I missing something?  I freely admit to
> > much ignorance of both kvm and s390!  ;-)
> 
> But I am getting some rcutorture near misses on the commit that
> introduces rcu_kvm_enter() and rcu_kvm_exit() to the x86 arch-specific
> vcpu_enter_guest() function.  These near misses occur when running
> rcutorture scenarios TREE01 and TREE03, and in my -rcu tree rather
> than the v4.15 version of this patch.
> 
> Given that I am making pervasive changes to the way that RCU works,
> it might well be that this commit is an innocent bystander.  I will
> run tests overnight and let you know what comes up.

And thus far, the verdict is "intermittent".  I am starting a new
series with CONFIG_RCU_EQS_DEBUG=y, which should detect any mismatched
rcu_kvm_enter()/rcu_kvm_exit() pairs.

							Thanx, Paul

