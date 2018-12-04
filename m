Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FD1C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 408EF206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 408EF206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbeLDTds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:33:48 -0500
Received: from mga03.intel.com ([134.134.136.65]:29578 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbeLDTdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:33:47 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2018 11:33:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,315,1539673200"; 
   d="scan'208";a="107276999"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.154])
  by orsmga003.jf.intel.com with ESMTP; 04 Dec 2018 11:33:46 -0800
Date:   Tue, 4 Dec 2018 11:33:46 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 6/5] x86/fault: Clean up the page fault oops decoder a bit
Message-ID: <20181204193346.GD17374@linux.intel.com>
References: <cover.1542841400.git.luto@kernel.org>
 <11212acb25980cd1b3030875cd9502414fbb214d.1542841400.git.luto@kernel.org>
 <20181122084119.GA44720@gmail.com>
 <20181127153202.GA27075@linux.intel.com>
 <CALCETrW00oTpXOONwbONHHuiyqp9QbNMe0gvVgf8X3_X0fidqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrW00oTpXOONwbONHHuiyqp9QbNMe0gvVgf8X3_X0fidqw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 11:22:25AM -0800, Andy Lutomirski wrote:
> On Tue, Nov 27, 2018 at 7:32 AM Sean Christopherson
> <sean.j.christopherson@intel.com> wrote:
> > diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> > index 2ff25ad33233..510e263c256b 100644
> > --- a/arch/x86/mm/fault.c
> > +++ b/arch/x86/mm/fault.c
> > @@ -660,8 +660,10 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code, unsigned long ad
> >         err_str_append(error_code, err_txt, X86_PF_RSVD,  "[RSVD]" );
> >         err_str_append(error_code, err_txt, X86_PF_INSTR, "[INSTR]");
> >         err_str_append(error_code, err_txt, X86_PF_PK,    "[PK]"   );
> > -
> > -       pr_alert("#PF error: %s\n", error_code ? err_txt : "[normal kernel read fault]");
> > +       err_str_append(~error_code, err_txt, X86_PF_USER, "[KERNEL]");
> > +       err_str_append(~error_code, err_txt, X86_PF_WRITE | X86_PF_INSTR,
> > +                                                         "[READ]");
> > +       pr_alert("#PF error code: %s\n", err_txt);
> >
> 
> Seems generally nice, but I would suggest making the bit-not-set name
> be another parameter to err_str_append().  I'm also slightly uneasy
> about making "KERNEL" look like a bit, but I guess it doesn't bother
> me too much.

What about "SUPERVISOR" instead of "KERNEL"?  It'd be consistent with
the SDM and hopefully less likely to be misconstrued as something else.

> Want to send a real patch?

Will do.
