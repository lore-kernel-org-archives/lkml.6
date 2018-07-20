Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B40ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 730F5206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:12:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 730F5206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731821AbeGTOAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:00:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45888 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731209AbeGTOAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:00:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 17A5D401EF01;
        Fri, 20 Jul 2018 13:12:08 +0000 (UTC)
Received: from flask (unknown [10.43.2.80])
        by smtp.corp.redhat.com (Postfix) with SMTP id 07BE87C42;
        Fri, 20 Jul 2018 13:12:05 +0000 (UTC)
Received: by flask (sSMTP sendmail emulation); Fri, 20 Jul 2018 15:12:05 +0200
Date:   Fri, 20 Jul 2018 15:12:05 +0200
From:   Radim Krcmar <rkrcmar@redhat.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     David Matlack <dmatlack@google.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH v3 2/6] KVM: X86: Implement PV IPIs in linux guest
Message-ID: <20180720131204.GA12043@flask>
References: <1530598891-21370-1-git-send-email-wanpengli@tencent.com>
 <1530598891-21370-3-git-send-email-wanpengli@tencent.com>
 <CALzav=fUmJZSvDgTvsB-7nyv1KiAMHgVcq-N+k0WCn3OsrVpNw@mail.gmail.com>
 <CANRm+Cx8qy7Ttf42zNuEPDGBc-6J1jMpe8di7UGUL2E6bxmMDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANRm+Cx8qy7Ttf42zNuEPDGBc-6J1jMpe8di7UGUL2E6bxmMDg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 20 Jul 2018 13:12:08 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 20 Jul 2018 13:12:08 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rkrcmar@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-20 11:45+0800, Wanpeng Li:
> On Fri, 20 Jul 2018 at 07:05, David Matlack <dmatlack@google.com> wrote:
> >
> > On Mon, Jul 2, 2018 at 11:23 PM Wanpeng Li <kernellwp@gmail.com> wrote:
> > >
> > > From: Wanpeng Li <wanpengli@tencent.com>
> > >
> > > Implement paravirtual apic hooks to enable PV IPIs.
> >
> > Very cool. Thanks for working on this!
> 
> Thanks David!
> 
> >
> > >
> > > apic->send_IPI_mask
> > > apic->send_IPI_mask_allbutself
> > > apic->send_IPI_allbutself
> > > apic->send_IPI_all
> > >
> > > The PV IPIs supports maximal 128 vCPUs VM, it is big enough for cloud
> > > environment currently,
> >
> > From the Cloud perspective, 128 vCPUs is already obsolete. GCE's
> > n1-utlramem-160 VMs have 160 vCPUs where the maximum APIC ID is 231.
> > I'd definitely prefer an approach that scales to higher APIC IDs, like
> > Paolo's offset idea.
> 
> Ok, I will try the offset method in next version.
> 
> >
> > To Radim's point of real world performance testing, do you know what
> > is the primary source of multi-target IPIs? If it's TLB shootdowns we
> > might get a bigger bang for our buck with a PV TLB Shootdown.

I assume it is the TLB shootdown by a large margin, but never profiled
it.

We could add a more complex PV TLB shootdown that does the whole TLB
invalidation inside KVM, but I don't think it would be significantly
faster, because we need to force a VM exit if the target VCPU is
running.  With PV IPI, we get exit-less IPI injection and a VM exit for
TLB invalidation.

> The "Function Call interrupts", there is a lot of callers for
> smp_call_function_many() except TLB Shootdowns in linux kernel which
> try to run a function on a set of other CPUs. TLB Shootdown still can
> get benefit from PV IPIs even if PV TLB Shootdown is enabled since
> IPIs should be sent to the vCPUs which are active and will incur
> vmexits. PV IPIs will benefit both vCPUs overcommit and
> non-overcommit(which PV TLB Shootdown can't help) scenarios. Btw,
> hyperv also implements PV IPIs even if PV TLB Shootdown is present.
> https://lkml.org/lkml/2018/7/3/537

Hyper-V in a better spot as guests can be using hypervisor's VPIDX for
cpu bitmaps and pass it to the IPI hypercall, so there is no APIC ID
translation on either side -- the IPI hypercall seems worth it just for
the simpler logic.

Hyper-V can also address up to 4096 VCPUs in one hypercall (optimized as
sparse 2 level 64-ary tree), so we might want to do something like that
(with higher ceiling) as the probability of being within 128 APIC IDs
should rapidly diminish with growing number of VCPUs.
