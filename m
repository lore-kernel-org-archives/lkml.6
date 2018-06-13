Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C6B67C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F29D2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F29D2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935019AbeFMJ1P (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 05:27:15 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43875 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933732AbeFMJ1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 05:27:13 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fT23G-00044n-K3; Wed, 13 Jun 2018 11:26:50 +0200
Date:   Wed, 13 Jun 2018 11:26:49 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Nicholas Piggin <npiggin@gmail.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@intel.com>,
        Don Zickus <dzickus@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Weisbecker <frederic@kernel.org>,
        Babu Moger <babu.moger@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Colin Ian King <colin.king@canonical.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: Re: [RFC PATCH 12/23] kernel/watchdog: Introduce a struct for NMI
 watchdog operations
In-Reply-To: <20180613084219.GT12258@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1806131121180.2280@nanos.tec.linutronix.de>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com> <1528851463-21140-13-git-send-email-ricardo.neri-calderon@linux.intel.com> <20180613174141.539fc6c1@roar.ozlabs.ibm.com>
 <20180613084219.GT12258@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2018, Peter Zijlstra wrote:
> On Wed, Jun 13, 2018 at 05:41:41PM +1000, Nicholas Piggin wrote:
> > On Tue, 12 Jun 2018 17:57:32 -0700
> > Ricardo Neri <ricardo.neri-calderon@linux.intel.com> wrote:
> > 
> > > Instead of exposing individual functions for the operations of the NMI
> > > watchdog, define a common interface that can be used across multiple
> > > implementations.
> > > 
> > > The struct nmi_watchdog_ops is defined for such operations. These initial
> > > definitions include the enable, disable, start, stop, and cleanup
> > > operations.
> > > 
> > > Only a single NMI watchdog can be used in the system. The operations of
> > > this NMI watchdog are accessed via the new variable nmi_wd_ops. This
> > > variable is set to point the operations of the first NMI watchdog that
> > > initializes successfully. Even though at this moment, the only available
> > > NMI watchdog is the perf-based hardlockup detector. More implementations
> > > can be added in the future.
> > 
> > Cool, this looks pretty nice at a quick glance. sparc and powerpc at
> > least have their own NMI watchdogs, it would be good to have those
> > converted as well.
> 
> Yeah, agreed, this looks like half a patch.

Though I'm not seeing the advantage of it. That kind of NMI watchdogs are
low level architecture details so having yet another 'ops' data structure
with a gazillion of callbacks, checks and indirections does not provide
value over the currently available weak stubs.

> > Is hpet a cross platform thing, or just x86? We should avoid
> > proliferation of files under kernel/ I think, so with these watchdog
> > driver structs then maybe implementations could go in drivers/ or
> > arch/
> 
> HPET is mostly an x86 thing (altough it can be found elsewhere), but the

On ia64 and I doubt that anyone wants to take on the task of underwater
welding it to Itanic.

> whole thing relies on the x86 NMI mechanism and is thus firmly arch/
> material (like the sparc and ppc thing).

Right. Trying to make this 'generic' is not really solving anything.

Thanks,

	tglx

