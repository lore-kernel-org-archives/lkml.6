Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADECC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E747C20671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:22:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E747C20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732085AbeGSSGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:06:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51922 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731442AbeGSSGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:06:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7AD7ECE1CD;
        Thu, 19 Jul 2018 17:22:05 +0000 (UTC)
Received: from flask (unknown [10.43.2.80])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8DBE6111AF0C;
        Thu, 19 Jul 2018 17:22:03 +0000 (UTC)
Received: by flask (sSMTP sendmail emulation); Thu, 19 Jul 2018 19:22:02 +0200
Date:   Thu, 19 Jul 2018 19:22:02 +0200
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH v3 2/6] KVM: X86: Implement PV IPIs in linux guest
Message-ID: <20180719172202.GD11749@flask>
References: <1530598891-21370-1-git-send-email-wanpengli@tencent.com>
 <1530598891-21370-3-git-send-email-wanpengli@tencent.com>
 <20180719162826.GB11749@flask>
 <1357a0b5-0cd8-8cb5-6c61-c9662219bed0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1357a0b5-0cd8-8cb5-6c61-c9662219bed0@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 19 Jul 2018 17:22:05 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 19 Jul 2018 17:22:05 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rkrcmar@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-19 18:47+0200, Paolo Bonzini:
> On 19/07/2018 18:28, Radim Krčmář wrote:
> >> +
> >> +	kvm_hypercall3(KVM_HC_SEND_IPI, ipi_bitmap_low, ipi_bitmap_high, vector);
> > and
> > 
> > 	kvm_hypercall3(KVM_HC_SEND_IPI, ipi_bitmap[0], ipi_bitmap[1], vector);
> > 
> > Still, the main problem is that we can only address 128 APICs.
> > 
> > A simple improvement would reuse the vector field (as we need only 8
> > bits) and put a 'offset' in the rest.  The offset would say which
> > cluster of 128 are we addressing.  24 bits of offset results in 2^31
> > total addressable CPUs (we probably should even use that many bits).
> > The downside of this is that we can only address 128 at a time.
> > 
> > It's basically the same as x2apic cluster mode, only with 128 cluster
> > size instead of 16, so the code should be a straightforward port.
> > And because x2apic code doesn't seem to use any division by the cluster
> > size, we could even try to use kvm_hypercall4, add ipi_bitmap[2], and
> > make the cluster size 192. :)
> 
> I did suggest an offset earlier in the discussion.
> 
> The main problem is that consecutive CPU ids do not map to consecutive
> APIC ids.  But still, we could do an hypercall whenever the total range
> exceeds 64.  Something like

Right, the cluster x2apic implementation came with a second mapping to make
this in linear time and send as little IPIs as possible:

·       /* Collapse cpus in a cluster so a single IPI per cluster is sent */
·       for_each_cpu(cpu, tmpmsk) {
·       ·       struct cluster_mask *cmsk = per_cpu(cluster_masks, cpu);

·       ·       dest = 0;
·       ·       for_each_cpu_and(clustercpu, tmpmsk, &cmsk->mask)
·       ·       ·       dest |= per_cpu(x86_cpu_to_logical_apicid, clustercpu);

·       ·       if (!dest)
·       ·       ·       continue;

·       ·       __x2apic_send_IPI_dest(dest, vector, apic->dest_logical);
·       ·       /* Remove cluster CPUs from tmpmask */
·       ·       cpumask_andnot(tmpmsk, tmpmsk, &cmsk->mask);
·       }

I think that the extra memory consumption would be excusable.
