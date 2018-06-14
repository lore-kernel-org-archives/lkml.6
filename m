Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9098FC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 01:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF19208D5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 01:02:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FF19208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935996AbeFNBCm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 21:02:42 -0400
Received: from mga03.intel.com ([134.134.136.65]:4866 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935789AbeFNBCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 21:02:40 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2018 18:02:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,220,1526367600"; 
   d="scan'208";a="47595887"
Received: from voyager.sc.intel.com (HELO voyager) ([10.3.52.149])
  by fmsmga008.fm.intel.com with ESMTP; 13 Jun 2018 18:02:14 -0700
Date:   Wed, 13 Jun 2018 17:58:39 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Don Zickus <dzickus@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Weisbecker <frederic@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Babu Moger <babu.moger@oracle.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Colin Ian King <colin.king@canonical.com>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Christoffer Dall <cdall@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Rientjes <rientjes@google.com>,
        iommu@lists.linux-foundation.org
Subject: Re: [RFC PATCH 22/23] watchdog/hardlockup/hpet: Only enable the HPET
 watchdog via a boot parameter
Message-ID: <20180614005839.GA22358@voyager>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1528851463-21140-23-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <c2edf778-79cf-009d-6617-13e54ad8b93b@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2edf778-79cf-009d-6617-13e54ad8b93b@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 10:26:57PM -0700, Randy Dunlap wrote:
> On 06/12/2018 05:57 PM, Ricardo Neri wrote:
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index f2040d4..a8833c7 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -2577,7 +2577,7 @@
> >  			Format: [state][,regs][,debounce][,die]
> >  
> >  	nmi_watchdog=	[KNL,BUGS=X86] Debugging features for SMP kernels
> > -			Format: [panic,][nopanic,][num]
> > +			Format: [panic,][nopanic,][num,][hpet]
> >  			Valid num: 0 or 1
> >  			0 - turn hardlockup detector in nmi_watchdog off
> >  			1 - turn hardlockup detector in nmi_watchdog on
> 
> This says that I can use "nmi_watchdog=hpet" without using 0 or 1.
> Is that correct?

Yes, this what I meant. In my view, if you set nmi_watchdog=hpet it
implies that you want to activate the NMI watchdog. In this case, perf.

I can see how this will be ambiguous for the case of perf and arch NMI
watchdogs.

Alternative, a new parameter could be added; such as nmi_watchdog_type. I
didn't want to add it in this patchset as I think that a single parameter
can handle the enablement and type of the NMI watchdog.

What do you think?

Thanks and BR,
Ricardo
