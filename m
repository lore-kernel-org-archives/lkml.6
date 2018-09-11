Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE61C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44EF82086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:30:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44EF82086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbeIKR3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 13:29:06 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41649 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbeIKR3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 13:29:06 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fzhnn-00059x-Oz; Tue, 11 Sep 2018 14:29:56 +0200
Date:   Tue, 11 Sep 2018 14:29:55 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Cyril Novikov <cnovikov@lynx.com>
cc:     Philipp Eppelt <philipp.eppelt@kernkonzept.com>,
        linux-kernel@vger.kernel.org
Subject: Re: x86/apic: MSI address malformed for "flat" driver
In-Reply-To: <27bccfd2-0ede-cd3a-2717-741d3dffebdf@lynx.com>
Message-ID: <alpine.DEB.2.21.1809111024020.5110@nanos.tec.linutronix.de>
References: <d407ee89-3d6c-b55d-d633-abf7644e9766@kernkonzept.com> <alpine.DEB.2.21.1809072012310.1402@nanos.tec.linutronix.de> <27bccfd2-0ede-cd3a-2717-741d3dffebdf@lynx.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Sep 2018, Cyril Novikov wrote:
> On 9/7/2018 12:11 PM, Thomas Gleixner wrote:
> > On Thu, 6 Sep 2018, Philipp Eppelt wrote:
> > > 
> > > The "flat" driver defines the MSI addressing scheme to be used as
> > > logical addressing in flat mode. The MSI msg address is composed
> > > accordingly, but sets MSI_ADDR_REDIRECTION_CPU which is a zero at bit[3].
> > 
> > Correct. That's what it means:
> > 
> >    * When RH is 0, the interrupt is directed to the processor listed in the
> >      Destination ID field.
> > 
> > So for DM:
> > 
> >    * If RH is 0, then the DM bit is ignored and the message is sent ahead
> >      independent of whether the physical or logical destination mode is
> >      used.
> > 
> > which is means that the delivery does not do any magic redirections,
> > because the Redirection Hint is off. If RH is set, then the delivery can
> > redirect according to the rules in the DM section. We are not using that
> > because we want targeted single CPU delivery.
> > 
> > The interpretation of the DID field is purely depending on the local APIC
> > itself by matching the APIC ID against the DID field. And the local APIC ID
> > of CPU0 is 1 << 0, i.e. 0x1 which matches the MSI message you see.
> 
> I believe you are wrong here and the local APIC ID of CPU0 is 0.
>
> processor       : 0
> vendor_id       : GenuineIntel
> ...
> physical id     : 0
> siblings        : 8
> core id         : 0
> cpu cores       : 4
> apicid          : 0
> 
> The fact that the code works means that DM is not ignored when RH is 0. In
> other words, RH=0 DM=1 means logical destination mode.

Sorry, I did not explain it very well. Let me try again.

  * If RH is 0, then the DM bit is ignored and the message is sent ahead
    independent of whether the physical or logical destination mode is
    used.

The PCI device simply writes the message data to that address, it does not
even know what the individual bits mean. It's a write of data to address.

The write gets then directed to the APIC bus or the Processor System Bus
depending on the CPU by a translation unit. The translated message which
goes on the bus to which the APIC(s) are connected contains the DM bit
which is always evaluated by the local APICs for matching.

You can simply verify that by inverting the DM field. You probably get
completely malfunctioning interrupts or if you're lucky they are delivered
to the wrong CPU.

Why? Because the APIC has two match mechanisms.

 If the message on the system/apic bus has DM = 0 then it matches
 the Phsyical APIC ID which you can see in /proc/cpuinfo

 If the message on the system/apic bus has DM = 1 then it matches the
 Logical APIC ID which is stored in the LDR register. apic flat sets that
 to 1 << CPUNr, i.e. 0x01 for CPU0.

If RH is set in the address then the translation unit tries to be smart
about the delivery, i.e. by directing it to the processor which has the
lowest interrupt priority. In logical mode it choses ONE processor out of
the destination ID bits, i.e. the resulting message on the system/apic bus
contains only a single bit. Physical mode is single CPU destination anyway
so there is no real difference to RH=0.

If RH is not set then the logic translates the message without
modifications including the DM bit. If the destination ID would have more
than a single bit set, then the interrupt would be simultaneously delivered
to all CPUs which have a matching bit in the LDR. Not desired for device
interrupts, but the single CPU affinity of the vector allocation guarantees
that there is only one bit set. The kernel still uses multiple bits for
IPIs.

Yes, we could switch APIC flat to use phsyical mode in the MSI and the
IOAPIC case, but I did not see a reason to do so.

Hope that clarifies it.

Out of curiosity: What kind of problem are you trying to solve?

Thanks,

	tglx
