Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754425AbeCGNyJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 08:54:09 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33600 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751159AbeCGNyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 08:54:07 -0500
Date: Wed, 7 Mar 2018 14:53:24 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: lapic: stop advertising DIRECTED_EOI when in-kernel
 IOAPIC is in use
Message-ID: <20180307135323.GB12290@flask>
References: <20180209130133.28387-1-vkuznets@redhat.com>
 <87r2oyzug5.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r2oyzug5.fsf@vitty.brq.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-05 11:29+0100, Vitaly Kuznetsov:
> Vitaly Kuznetsov <vkuznets@redhat.com> writes:
> 
> > Devices which use level-triggered interrupts under Windows 2016 with
> > Hyper-V role enabled don't work: Windows disables EOI broadcast in SPIV
> > unconditionally. Our in-kernel IOAPIC implementation emulates an old IOAPIC
> > version which has no EOI register so EOI never happens.
> >
> > The issue was discovered and discussed a while ago:
> > https://www.spinics.net/lists/kvm/msg148098.html
> >
> 
> Radim, Paolo,
> 
> do we have a consensus here? (I wouldn't mind re-writing commit message
> in case you think we shouldn't blame Windows, I just want to have the
> annoying bug fixed :-)

I have applied the patch, thanks.

I think the commit message is correct (this is a Windows bug):

* Current SDM has a different wording that only talks about
  EOI-broadcast suppression capability of the CPU.

* The x2APIC document mentions that "the bit is reserved to 0 if the
  processor doesn't support Directed EOI" and IOAPIC is not a part of
  the processor, so I would assume that it doesn't hold.

  Basically, I think that the document confuses "Directed EOI" CPU
  feature and "directed EOI" IOAPIC feature, which got amended in SDM.
