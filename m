Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA00C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B973724012
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:51:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B973724012
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754111AbeGFKvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 06:51:10 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54059 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754048AbeGFKvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 06:51:09 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fbOJU-0005yx-Bj; Fri, 06 Jul 2018 12:50:08 +0200
Date:   Fri, 6 Jul 2018 12:50:07 +0200 (CEST)
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
In-Reply-To: <alpine.DEB.2.21.1807061243400.1664@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1807061248410.1664@nanos.tec.linutronix.de>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com> <20180621212518.19914-5-pasha.tatashin@oracle.com> <fc67276e-643d-8a78-29e3-273c6dc79275@redhat.com> <alpine.DEB.2.21.1807061101040.1664@nanos.tec.linutronix.de> <52117b6e-cbdc-8583-494b-5e8e5d6d4265@redhat.com>
 <alpine.DEB.2.21.1807061142320.1664@nanos.tec.linutronix.de> <585b3646-5515-240a-db57-406d6c311a43@redhat.com> <alpine.DEB.2.21.1807061243400.1664@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jul 2018, Thomas Gleixner wrote:
> On Fri, 6 Jul 2018, Paolo Bonzini wrote:
> > On 06/07/2018 11:45, Thomas Gleixner wrote:
> > >> One possibility is to introduce another layer of indirection: in
> > >> addition to the percpu pvclock data, add a percpu pointer to the pvclock
> > >> data and initialize it to point to a page-aligned variable in BSS.  CPU0
> > >> (used by vDSO) doesn't touch the pointer and keeps using the BSS
> > >> variable, APs instead redirect the pointer to the percpu data.
> > > Yeah, thought about that, but the extra indirection is ugly. Instead of
> > > using per cpu data, I just can allocate the memory _after_ the allocators
> > > are up and running and use a single page sized static __initdata for the
> > > early boot.
> > 
> > Either works for me.  Assembly-wise, the indirection should be more or
> > less the same as what we have now; even more efficient because it
> > accesses a percpu pointer instead of computing it based on
> > smp_processor_id().
> 
> Good point. Let me try that.

Duh, that either requires a static key or a static PER_CPU pointer thingy,
which then wastes 8 bytes per cpu instead of 64 byte if unused.

Thanks,

	tglx
