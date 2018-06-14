Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B33AAC004E4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 01:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E038208D9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 01:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E038208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935977AbeFNBEe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 21:04:34 -0400
Received: from mga06.intel.com ([134.134.136.31]:28517 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935616AbeFNBEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 21:04:32 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2018 18:04:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,220,1526367600"; 
   d="scan'208";a="49732763"
Received: from voyager.sc.intel.com (HELO voyager) ([10.3.52.149])
  by orsmga006.jf.intel.com with ESMTP; 13 Jun 2018 18:04:29 -0700
Date:   Wed, 13 Jun 2018 18:00:54 -0700
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
Subject: Re: [RFC PATCH 16/23] watchdog/hardlockup: Add an HPET-based
 hardlockup detector
Message-ID: <20180614010054.GB22358@voyager>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1528851463-21140-17-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1e5bc136-4123-328a-2d2e-e6f2faef5bf4@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e5bc136-4123-328a-2d2e-e6f2faef5bf4@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 10:23:47PM -0700, Randy Dunlap wrote:
> Hi,

Hi Randy,

> 
> On 06/12/2018 05:57 PM, Ricardo Neri wrote:
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index c40c7b7..6e79833 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -828,6 +828,16 @@ config HARDLOCKUP_DETECTOR_PERF
> >  	bool
> >  	select SOFTLOCKUP_DETECTOR
> >  
> > +config HARDLOCKUP_DETECTOR_HPET
> > +	bool "Use HPET Timer for Hard Lockup Detection"
> > +	select SOFTLOCKUP_DETECTOR
> > +	select HARDLOCKUP_DETECTOR
> > +	depends on HPET_TIMER && HPET
> > +	help
> > +	  Say y to enable a hardlockup detector that is driven by an High-Precision
> > +	  Event Timer. In addition to selecting this option, the command-line
> > +	  parameter nmi_watchdog option. See Documentation/admin-guide/kernel-parameters.rst
> 
> The "In addition ..." thing is a broken (incomplete) sentence.

Oops. I apologize. I missed this I will fix it in my next version.

Thanks and BR,
Ricardo
