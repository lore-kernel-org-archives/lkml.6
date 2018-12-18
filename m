Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A12C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6967218A6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbeLRWFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:05:38 -0500
Received: from mga04.intel.com ([192.55.52.120]:38212 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727163AbeLRWFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:05:38 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2018 14:05:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,370,1539673200"; 
   d="scan'208";a="110480709"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga008.fm.intel.com with ESMTP; 18 Dec 2018 14:05:37 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id C9E29300B49; Tue, 18 Dec 2018 14:05:37 -0800 (PST)
Date:   Tue, 18 Dec 2018 14:05:37 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Aubrey Li <aubrey.li@intel.com>, mingo@redhat.com,
        peterz@infradead.org, hpa@zytor.com, tim.c.chen@linux.intel.com,
        arjan@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/3] x86/fpu: track AVX-512 usage of tasks
Message-ID: <20181218220537.GJ25620@tassilo.jf.intel.com>
References: <20181218042218.8653-1-aubrey.li@intel.com>
 <alpine.DEB.2.21.1812181448170.12686@nanos.tec.linutronix.de>
 <62997df2-0817-b54d-b11e-00a567f1d67c@linux.intel.com>
 <alpine.DEB.2.21.1812181630530.14031@nanos.tec.linutronix.de>
 <b14a9c82-3336-0f13-1a27-fba929e6b4fb@linux.intel.com>
 <20181218213826.GI25620@tassilo.jf.intel.com>
 <d892d7bb-2a66-497c-4728-138c8e5e077f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d892d7bb-2a66-497c-4728-138c8e5e077f@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 01:44:41PM -0800, Dave Hansen wrote:
> On 12/18/18 1:38 PM, Andi Kleen wrote:
> >> I misunderstood, you mean 32bit kernel, not 32bit machine. Theoretically 32bit
> >> kernel can use AVX512, but not sure if anyone use it like this. get_jiffies_64()
> >> includes jiffies_lock ops so not good in context switch. So I want to use raw
> >> jiffies_64 here. jiffies is a good candidate but it has wraparound overflow issue.
> >> Other time source are expensive here.
> >>
> >> Should I limit the code only running on 64bit kernel? 
> > Yes making it 64bit only should be fine.
> 
> I think I'd rather just disable AVX512 itself on 32-bit and be done with
> it.  I think more than half of the ~2k of XSAVE space that it consumes
> in *every* *task* is just pure waste because it has to be 0's.
> 
> This ~2k of extra space is also lowmem, which makes it even more valuable.

That will actually break programs.

If someone compiled binaries with -march=native on a system with AVX512
they wouldn't work anymore.

Don't think we can do it.


-Andi
