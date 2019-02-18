Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AD1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 22:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD22721479
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 22:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731920AbfBRWmp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 17:42:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57604 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726881AbfBRWmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 17:42:45 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5717C40F00;
        Mon, 18 Feb 2019 22:42:44 +0000 (UTC)
Received: from gondolin (ovpn-116-217.ams2.redhat.com [10.36.116.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 552F860BE2;
        Mon, 18 Feb 2019 22:42:38 +0000 (UTC)
Date:   Mon, 18 Feb 2019 23:42:35 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     Tony Krowiak <akrowiak@linux.ibm.com>, borntraeger@de.ibm.com,
        alex.williamson@redhat.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        freude@linux.ibm.com, mimu@linux.ibm.com
Subject: Re: [PATCH v3 2/9] s390: ap: kvm: setting a hook for PQAP
 instructions
Message-ID: <20190218234235.7d9f547c.cohuck@redhat.com>
In-Reply-To: <ee84fc90-e158-9c36-b56f-67fe7777f683@linux.ibm.com>
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
        <1550152269-6317-3-git-send-email-pmorel@linux.ibm.com>
        <4b21f059-1d37-f341-bac7-5b1fe0d06521@linux.ibm.com>
        <ee84fc90-e158-9c36-b56f-67fe7777f683@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 18 Feb 2019 22:42:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Feb 2019 19:29:10 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 15/02/2019 23:02, Tony Krowiak wrote:
> > On 2/14/19 8:51 AM, Pierre Morel wrote:  

> >> +/*
> >> + * handle_pqap: Handling pqap interception
> >> + * @vcpu: the vcpu having issue the pqap instruction
> >> + *
> >> + * This callback only handles PQAP/AQIC instruction and
> >> + * calls a dedicated callback for this instruction if
> >> + * a driver did register one in the CRYPTO satellite of the
> >> + * SIE block.
> >> + *
> >> + * Do not change the behavior if, return -EOPNOTSUPP if:
> >> + * - the hook is not used do not change the behavior.
> >> + * - AP instructions are not available or not available to the guest
> >> + * - the instruction is not PQAP with function code indicating
> >> + *   AQIC do not change the previous behavior.
> >> + *
> >> + * For PQAP/AQIC instruction, verify privilege and specifications
> >> + *
> >> + * return the value returned by the callback.
> >> + */
> >> +static int handle_pqap(struct kvm_vcpu *vcpu)
> >> +{
> >> +    uint8_t fc;
> >> +
> >> +    /* Verify that the hook callback is registered */
> >> +    if (!vcpu->kvm->arch.crypto.pqap_hook)
> >> +        return -EOPNOTSUPP;
> >> +    /* Verify that the AP instruction are available */
> >> +    if (!ap_instructions_available())
> >> +        return -EOPNOTSUPP;
> >> +    /* Verify that the guest is allowed to use AP instructions */
> >> +    if (!(vcpu->arch.sie_block->eca & ECA_APIE))
> >> +        return -EOPNOTSUPP;
> >> +    /* Verify that the function code is AQIC */
> >> +    fc = vcpu->run->s.regs.gprs[0] >> 24;
> >> +    if (fc != 0x03)
> >> +        return -EOPNOTSUPP;  
> > 
> > This does not belong here. Function code 3 is one of 7 function codes
> > that can be sent with the PQAP instruction. This belongs in the PQAP
> > hook code.  
> 
> On one hand, effectively I would prefer to put the code in the VFIO 
> driver code.
> On the other hand, doing this would lead to export the code for 
> test_kvm_facility() and kvm_s390_inject_program_int() from the kvm-s390.h
> 
> I choose not to export these functions from the KVM code.
> 
> Would like opinion from KVM maintainers?

Looking at this (and without access to the specification...), I think
the check for problem state makes sense in here (if this applies to all
PQAP functions equally, which seems likely). The check for the facility
makes more sense in the handler. You can probably still inject the
specification exception here if you use a clever return code.

Another option: Provide a way to register a callback per function code;
this allows you to still do the check here and extend it later for
other function codes (which will probably be indicated by another
facility).

> 
> >   
> >> +
> >> +    /* PQAP instructions are allowed for guest kernel only */
> >> +    if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
> >> +        return kvm_s390_inject_program_intkvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
> >> +    /* AQIC instruction is allowed only if facility 65 is available */
> >> +    if (!test_kvm_facility(vcpu->kvm, 65))
> >> +        return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
> >> +    /* All right, call the callback */
> >> +    return vcpu->kvm->arch.crypto.pqap_hook(vcpu);
> >> +}
> >> +
> >>   static int handle_stfl(struct kvm_vcpu *vcpu)
> >>   {
> >>       int rc;
> >> @@ -878,6 +926,8 @@ int kvm_s390_handle_b2(struct kvm_vcpu *vcpu)
> >>           return handle_sthyi(vcpu);
> >>       case 0x7d:
> >>           return handle_stsi(vcpu);
> >> +    case 0xaf:
> >> +        return handle_pqap(vcpu);
> >>       case 0xb1:
> >>           return handle_stfl(vcpu);
> >>       case 0xb2:
> >>  
> >   
> 
> 

