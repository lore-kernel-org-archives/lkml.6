Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE719C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FC0023F40
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FC0023F40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753864AbeGFJZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 05:25:47 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53878 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753743AbeGFJZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 05:25:44 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fbMyX-0004hE-Kd; Fri, 06 Jul 2018 11:24:25 +0200
Date:   Fri, 6 Jul 2018 11:24:25 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Paolo Bonzini <pbonzini@redhat.com>
cc:     Pavel Tatashin <pasha.tatashin@oracle.com>,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com,
        peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com,
        pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v12 04/11] kvm/x86: remove kvm memblock dependency
In-Reply-To: <fc67276e-643d-8a78-29e3-273c6dc79275@redhat.com>
Message-ID: <alpine.DEB.2.21.1807061101040.1664@nanos.tec.linutronix.de>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com> <20180621212518.19914-5-pasha.tatashin@oracle.com> <fc67276e-643d-8a78-29e3-273c6dc79275@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jul 2018, Paolo Bonzini wrote:
> On 21/06/2018 23:25, Pavel Tatashin wrote:
> > KVM clock is initialized later compared to other hypervisor because it has
> > dependency on memblock allocator.
> > 
> > Lets bring it inline with other hypervisors by removing this dependency by
> > using memory from BSS instead of allocating it.
> > 
> > The benefits:
> > - remove ifdef from common code
> > - earlier availability of TSC.
> > - remove dependency on memblock, and reduce code
> > - earlier kvm sched_clock()
> > 
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> 
> The reason for this is to avoid wasting a lot of BSS memory when KVM is
> not in use.  Thomas is going to send his take on this!

Got it working with per cpu variables, but there is a different subtle
issue with that.

The pvclock data is mapped into the VDSO as well, i.e. as a full page.

Right now with the linear array, which is forced to be page sized at least
this only maps pvclock data or zeroed data (after the last CPU) into the
VDSO.

With PER CPU variables this would map arbitraty other per cpu data which
happens to be in the same page into the VDSO. Not really what we want.

That means to utilize PER CPU data this requires to allocate page sized
pvclock data space for each CPU to prevent leaking arbitrary stuff.

As this data is allocated on demand, i.e. only if kvmclock is used, this
might be tolerable, but I'm not so sure.

Thanks,

	tglx
