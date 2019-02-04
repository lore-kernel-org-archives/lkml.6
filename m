Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C98C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB642082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbfBDWUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 17:20:43 -0500
Received: from mga05.intel.com ([192.55.52.43]:39489 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727225AbfBDWUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 17:20:43 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2019 14:20:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,560,1539673200"; 
   d="scan'208";a="272489666"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga004.jf.intel.com with ESMTP; 04 Feb 2019 14:20:42 -0800
Date:   Mon, 4 Feb 2019 14:14:30 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Chan <michael.chan@broadcom.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v3 08/10] x86/setcpuid: Add kernel option setcpuid
Message-ID: <20190204221430.GA70667@romley-ivt3.sc.intel.com>
References: <1549084491-57808-1-git-send-email-fenghua.yu@intel.com>
 <1549084491-57808-9-git-send-email-fenghua.yu@intel.com>
 <alpine.DEB.2.21.1902041745370.3006@nanos.tec.linutronix.de>
 <9fa7406b-113f-fe0a-9fc7-ef00b3a6b620@intel.com>
 <20190204195704.GJ29639@zn.tnic>
 <5c2f0af3-1740-f16b-6ff6-6bec6a325034@intel.com>
 <20190204214044.GN29639@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204214044.GN29639@zn.tnic>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 10:40:45PM +0100, Borislav Petkov wrote:
> On Mon, Feb 04, 2019 at 12:46:30PM -0800, Dave Hansen wrote:
> > Intel can obviously add or remove enumeration for a feature after
> > silicon ships.  But, that eats up microcode "patch" space which is an
> > even more valuable resource than the microcode "ROM" space.  That patch
> > space is a very constrained resource when creating things like the
> > side-channel mitigations.  The way I read this situation is that this
> > feature fills a bit small of a niche to justify consuming patch space.
> 
> Yap, makes sense. I've heard that argumentation before, btw.
> 
> > So, the compromise we reached in this case is that Intel will fully
> > document the future silicon architecture, and then write the kernel
> > implementation to _that_.
> 
> Yap.
> 
> > Then, for the weirdo deployments where this feature is not enumerated,
> > we have the setcpuid= to fake the enumeration in software.
> >
> > The reason I'm pushing for setcpuid= instead of a one-off is that I
> > don't expect this to be the last time Intel does this. I'd rather have
> > one setcpuid= than a hundred things like "ac_split_lock_disable".
> 
> So my only issue with this is the user having to type this in in order
> to get the feature.

With "setcpuid=", there is no additional code to add as long as
enumeration code is available.

> 
> VS
> 
> automatically enabling it during boot in early_init_intel() or so. No
> need for any user intervention. It'll be just like a forgotten CPUID bit
> and we've done those before.

Every time a new feature like this case, the early_init_intel() needs
to be changed for FMS etc.

I guess that's a reason we want to use "setcpuid=" to deal with different
cases withou changing code.

Thanks.

-Fenghua
