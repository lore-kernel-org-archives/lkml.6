Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25030C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C98442081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:42:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C98442081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbeKCEuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:50:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38160 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726083AbeKCEuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:50:51 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA2JdVGm099553
        for <linux-kernel@vger.kernel.org>; Fri, 2 Nov 2018 15:42:22 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ngv6h9ph6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 15:42:21 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 2 Nov 2018 19:42:20 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 2 Nov 2018 19:42:18 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA2JgH2Z2490824
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 2 Nov 2018 19:42:17 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C9C9B2067;
        Fri,  2 Nov 2018 19:42:17 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF354B2064;
        Fri,  2 Nov 2018 19:42:16 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.141])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  2 Nov 2018 19:42:16 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 1CC7116C2ABB; Fri,  2 Nov 2018 12:42:18 -0700 (PDT)
Date:   Fri, 2 Nov 2018 12:42:18 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Christoffer Dall <christoffer.dall@arm.com>
Cc:     Lance Roy <ldr709@gmail.com>, linux-kernel@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Eric Auger <eric.auger@redhat.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 16/16] KVM: arm/arm64: vgic: Replace spin_is_locked()
 with lockdep
Reply-To: paulmck@linux.ibm.com
References: <20181003053902.6910-1-ldr709@gmail.com>
 <20181003053902.6910-17-ldr709@gmail.com>
 <20181102184533.GA12057@e113682-lin.lund.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102184533.GA12057@e113682-lin.lund.arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18110219-0040-0000-0000-0000048BA5D6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009973; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01111711; UDB=6.00576143; IPR=6.00891803;
 MB=3.00024008; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-02 19:42:20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110219-0041-0000-0000-00000894A743
Message-Id: <20181102194218.GB4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-02_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811020175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 07:45:33PM +0100, Christoffer Dall wrote:
> On Tue, Oct 02, 2018 at 10:39:02PM -0700, Lance Roy wrote:
> > lockdep_assert_held() is better suited to checking locking requirements,
> > since it won't get confused when someone else holds the lock. This is
> > also a step towards possibly removing spin_is_locked().
> > 
> > Signed-off-by: Lance Roy <ldr709@gmail.com>
> > Cc: Christoffer Dall <christoffer.dall@arm.com>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: <kvmarm@lists.cs.columbia.edu>
> 
> Acked-by: Christoffer Dall <christoffer.dall@arm.com>

Applied, thank you!

							Thanx, Paul

> > ---
> >  virt/kvm/arm/vgic/vgic.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
> > index 7cfdfbc910e0..50e25438fb3c 100644
> > --- a/virt/kvm/arm/vgic/vgic.c
> > +++ b/virt/kvm/arm/vgic/vgic.c
> > @@ -196,7 +196,7 @@ void vgic_irq_set_phys_active(struct vgic_irq *irq, bool active)
> >   */
> >  static struct kvm_vcpu *vgic_target_oracle(struct vgic_irq *irq)
> >  {
> > -	DEBUG_SPINLOCK_BUG_ON(!spin_is_locked(&irq->irq_lock));
> > +	lockdep_assert_held(&irq->irq_lock);
> >  
> >  	/* If the interrupt is active, it must stay on the current vcpu */
> >  	if (irq->active)
> > @@ -273,7 +273,7 @@ static void vgic_sort_ap_list(struct kvm_vcpu *vcpu)
> >  {
> >  	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
> >  
> > -	DEBUG_SPINLOCK_BUG_ON(!spin_is_locked(&vgic_cpu->ap_list_lock));
> > +	lockdep_assert_held(&vgic_cpu->ap_list_lock);
> >  
> >  	list_sort(NULL, &vgic_cpu->ap_list_head, vgic_irq_cmp);
> >  }
> > @@ -311,7 +311,7 @@ bool vgic_queue_irq_unlock(struct kvm *kvm, struct vgic_irq *irq,
> >  {
> >  	struct kvm_vcpu *vcpu;
> >  
> > -	DEBUG_SPINLOCK_BUG_ON(!spin_is_locked(&irq->irq_lock));
> > +	lockdep_assert_held(&irq->irq_lock);
> >  
> >  retry:
> >  	vcpu = vgic_target_oracle(irq);
> > @@ -702,7 +702,7 @@ static inline void vgic_fold_lr_state(struct kvm_vcpu *vcpu)
> >  static inline void vgic_populate_lr(struct kvm_vcpu *vcpu,
> >  				    struct vgic_irq *irq, int lr)
> >  {
> > -	DEBUG_SPINLOCK_BUG_ON(!spin_is_locked(&irq->irq_lock));
> > +	lockdep_assert_held(&irq->irq_lock);
> >  
> >  	if (kvm_vgic_global_state.type == VGIC_V2)
> >  		vgic_v2_populate_lr(vcpu, irq, lr);
> > @@ -736,7 +736,7 @@ static int compute_ap_list_depth(struct kvm_vcpu *vcpu,
> >  
> >  	*multi_sgi = false;
> >  
> > -	DEBUG_SPINLOCK_BUG_ON(!spin_is_locked(&vgic_cpu->ap_list_lock));
> > +	lockdep_assert_held(&vgic_cpu->ap_list_lock);
> >  
> >  	list_for_each_entry(irq, &vgic_cpu->ap_list_head, ap_list) {
> >  		int w;
> > @@ -761,7 +761,7 @@ static void vgic_flush_lr_state(struct kvm_vcpu *vcpu)
> >  	bool multi_sgi;
> >  	u8 prio = 0xff;
> >  
> > -	DEBUG_SPINLOCK_BUG_ON(!spin_is_locked(&vgic_cpu->ap_list_lock));
> > +	lockdep_assert_held(&vgic_cpu->ap_list_lock);
> >  
> >  	count = compute_ap_list_depth(vcpu, &multi_sgi);
> >  	if (count > kvm_vgic_global_state.nr_lr || multi_sgi)
> > -- 
> > 2.19.0
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

