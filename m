Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536E0ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 260E92082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:21:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 260E92082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbeJYDu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 23:50:56 -0400
Received: from mga06.intel.com ([134.134.136.31]:30598 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbeJYDu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 23:50:56 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 12:21:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,421,1534834800"; 
   d="scan'208";a="275300210"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by fmsmga006.fm.intel.com with ESMTP; 24 Oct 2018 12:21:37 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 0C75430137B; Wed, 24 Oct 2018 12:21:37 -0700 (PDT)
Date:   Wed, 24 Oct 2018 12:21:37 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [v3 03/12] x86/fsgsbase/64: Add intrinsics/macros for FSGSBASE
 instructions
Message-ID: <20181024192137.GI6218@tassilo.jf.intel.com>
References: <20181023184234.14025-1-chang.seok.bae@intel.com>
 <20181023184234.14025-4-chang.seok.bae@intel.com>
 <CALCETrWWBYgaJfPykTpJ9=TsptVL_ieOR3JdYVVW02=O9CM17Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWWBYgaJfPykTpJ9=TsptVL_ieOR3JdYVVW02=O9CM17Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 11:53:54AM -0700, Andy Lutomirski wrote:
> On Tue, Oct 23, 2018 at 11:43 AM Chang S. Bae <chang.seok.bae@intel.com> wrote:
> >
> > From: Andi Kleen <ak@linux.intel.com>
> >
> > Add C intrinsics and assembler macros for the new FSBASE and GSBASE
> > instructions.
> >
> > Very straight forward. Used in followon patches.
> >
> > [ luto: Rename the variables from FS and GS to FSBASE and GSBASE and
> >   make <asm/fsgsbase.h> safe to include on 32-bit kernels. ]
> >
> > v2: Use __always_inline
> >
> > [ chang: Revise the changelog. Place them in <asm/fsgsbase.h>. Replace
> >   the macros with GAS-compatible ones. ]
> >
> > If GCC supports it, we can add -mfsgsbase to CFLAGS and use the builtins
> > here for extra performance.
> 
> Reviewed-by: Andy Lutomirski <luto@kernel.org> # C parts only
> 
> With the caveat that I'm not convinced that the memory clobbers are
> needed.  The __force_order trick in special_insns.h would probably be
> more appropriate.
> 
> I don't feel qualified to review the asm part without some research.
> Whereas hpa or Boris could probably review it with their eyes closed.

BTW the other option would be to update the min-binutils requirement 
to 2.21 (currently it is 2.20) and then write it directly without .byte. 
I believe 2.21 added support for these instructions.

(It's only a binutils requirement, don't need gcc support)

-Andi
