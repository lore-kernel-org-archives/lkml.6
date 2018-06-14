Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6B960C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 01:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 197A3208E2
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 01:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 197A3208E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935850AbeFNBe4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 21:34:56 -0400
Received: from mga14.intel.com ([192.55.52.115]:43361 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935695AbeFNBey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 21:34:54 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2018 18:34:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,220,1526367600"; 
   d="scan'208";a="49737936"
Received: from voyager.sc.intel.com (HELO voyager) ([10.3.52.149])
  by orsmga006.jf.intel.com with ESMTP; 13 Jun 2018 18:34:52 -0700
Date:   Wed, 13 Jun 2018 18:31:17 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20180614013117.GC22652@voyager>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1528851463-21140-13-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <20180613174141.539fc6c1@roar.ozlabs.ibm.com>
 <20180613084219.GT12258@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1806131121180.2280@nanos.tec.linutronix.de>
 <20180613215225.2a938abc@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613215225.2a938abc@roar.ozlabs.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 09:52:25PM +1000, Nicholas Piggin wrote:
> On Wed, 13 Jun 2018 11:26:49 +0200 (CEST)
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > On Wed, 13 Jun 2018, Peter Zijlstra wrote:
> > > On Wed, Jun 13, 2018 at 05:41:41PM +1000, Nicholas Piggin wrote:  
> > > > On Tue, 12 Jun 2018 17:57:32 -0700
> > > > Ricardo Neri <ricardo.neri-calderon@linux.intel.com> wrote:
> > > >   
> > > > > Instead of exposing individual functions for the operations of the NMI
> > > > > watchdog, define a common interface that can be used across multiple
> > > > > implementations.
> > > > > 
> > > > > The struct nmi_watchdog_ops is defined for such operations. These initial
> > > > > definitions include the enable, disable, start, stop, and cleanup
> > > > > operations.
> > > > > 
> > > > > Only a single NMI watchdog can be used in the system. The operations of
> > > > > this NMI watchdog are accessed via the new variable nmi_wd_ops. This
> > > > > variable is set to point the operations of the first NMI watchdog that
> > > > > initializes successfully. Even though at this moment, the only available
> > > > > NMI watchdog is the perf-based hardlockup detector. More implementations
> > > > > can be added in the future.  
> > > > 
> > > > Cool, this looks pretty nice at a quick glance. sparc and powerpc at
> > > > least have their own NMI watchdogs, it would be good to have those
> > > > converted as well.  
> > > 
> > > Yeah, agreed, this looks like half a patch.  
> > 
> > Though I'm not seeing the advantage of it. That kind of NMI watchdogs are
> > low level architecture details so having yet another 'ops' data structure
> > with a gazillion of callbacks, checks and indirections does not provide
> > value over the currently available weak stubs.
> 
> The other way to go of course is librify the perf watchdog and make an
> x86 watchdog that selects between perf and hpet... I also probably
> prefer that for code such as this, but I wouldn't strongly object to
> ops struct if I'm not writing the code. It's not that bad is it?

My motivation to add the ops was that the hpet and perf watchdog share
significant portions of code. I could look into creating the library for
common code and relocate the hpet watchdog into arch/x86 for the hpet-
specific parts.

Thanks and BR,
Ricardo
