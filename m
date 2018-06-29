Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1336C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885CB23FF5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 885CB23FF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935779AbeF2VLM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 17:11:12 -0400
Received: from mga05.intel.com ([192.55.52.43]:11349 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932345AbeF2VLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 17:11:11 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 14:11:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,287,1526367600"; 
   d="scan'208";a="51568474"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga008.fm.intel.com with ESMTP; 29 Jun 2018 14:11:10 -0700
Date:   Fri, 29 Jun 2018 14:10:30 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v2 2/4] x86/split_lock: Align x86_capability to unsigned
 long to avoid split locked access
Message-ID: <20180629211030.GB68178@romley-ivt3.sc.intel.com>
References: <1530282807-66555-1-git-send-email-fenghua.yu@intel.com>
 <1530282807-66555-3-git-send-email-fenghua.yu@intel.com>
 <ae0b8cb1-a8a9-f0ef-3c20-f4fe4b9b6f4a@intel.com>
 <alpine.DEB.2.21.1806291824010.1595@nanos.tec.linutronix.de>
 <20180629190346.GO18979@romley-ivt3.sc.intel.com>
 <alpine.DEB.2.21.1806292148510.1595@nanos.tec.linutronix.de>
 <20180629203844.GA68178@romley-ivt3.sc.intel.com>
 <8fdfb671-f223-163b-12cd-3c97d94f91b4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fdfb671-f223-163b-12cd-3c97d94f91b4@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 01:48:45PM -0700, Dave Hansen wrote:
> On 06/29/2018 01:38 PM, Fenghua Yu wrote:
> > How to handle data that is used in generic code which can be used on
> > non-Intel platform? For exmple, if I do this change for struct efi in
> > include/linux/efi.h because set_bit() sets bits in efi.flags:
> > -       unsigned long flags;
> > +       unsigned long flags __aligned(unsigned long);
> >  } efi;
> > 
> > People may argue that the alignment unnecessarily increases size of 'efi'
> > on non-Intel platform which doesn't have split lock issue. Do we care this
> > argument?
> 
> Unaligned memory accesses are bad, pretty much universally.  This is a
> general good practice that we should have been doing anyway.  Let folks
> complain.  Don't let it stop you.
> 
> Also, look at the size of that structure.  Look at how many pointers it
> has.  Do you think *anyone* is going to complain about an extra 4 bytes
> in a 400-byte structure?
> 
> > Another question, there will be a bunch of one-line changes for
> > the alignment (i.e. adding __aligned(unsigned long)) in various files.
> > Will the changes be put in one big patch or in separate one-liner patches?
> 
> Just group them logically.

Sure.

Thanks.

-Fenghua
