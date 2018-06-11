Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id NWVAFdePHlu7BgAAmS7hNA
	; Mon, 11 Jun 2018 15:06:22 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B543860791; Mon, 11 Jun 2018 15:06:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4B89B600D0;
	Mon, 11 Jun 2018 15:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4B89B600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754115AbeFKPGU (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 11:06:20 -0400
Received: from mga17.intel.com ([192.55.52.151]:34531 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752452AbeFKPGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 11:06:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2018 08:06:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,502,1520924400";
   d="scan'208";a="48445016"
Received: from unknown (HELO [143.183.136.147]) ([143.183.136.147])
  by orsmga008.jf.intel.com with ESMTP; 11 Jun 2018 08:06:02 -0700
Message-ID: <1528729376.4526.0.camel@2b52.sc.intel.com>
Subject: Re: [PATCH 02/10] x86/cet: Introduce WRUSS instruction
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. J. Lu" <hjl.tools@gmail.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        mike.kravetz@oracle.com
Date: Mon, 11 Jun 2018 08:02:56 -0700
In-Reply-To: <20180611081704.GI12180@hirez.programming.kicks-ass.net>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com>
         <20180607143807.3611-3-yu-cheng.yu@intel.com>
         <CALCETrU45Cuzvfz3c1+-+7=9KS2N33Bpp1JqBtaGxhPo8U+Fqg@mail.gmail.com>
         <20180611081704.GI12180@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-06-11 at 10:17 +0200, Peter Zijlstra wrote:
> On Thu, Jun 07, 2018 at 09:40:02AM -0700, Andy Lutomirski wrote:
> > On Thu, Jun 7, 2018 at 7:41 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> 
> > Peterz, isn't there some fancy better way we're supposed to handle the
> > error return these days?
> 
> > > +       asm volatile("1:.byte 0x66, 0x0f, 0x38, 0xf5, 0x37\n"
> > > +                    "xor %[err],%[err]\n"
> > > +                    "2:\n"
> > > +                    ".section .fixup,\"ax\"\n"
> > > +                    "3: mov $-1,%[err]; jmp 2b\n"
> > > +                    ".previous\n"
> > > +                    _ASM_EXTABLE(1b, 3b)
> > > +               : [err] "=a" (err)
> > > +               : [val] "S" (val), [addr] "D" (addr)
> > > +               : "memory");
> 
> So the alternative is something like:
> 
> __visible bool ex_handler_wuss(const struct exception_table_entry *fixup,
> 			       struct pt_regs *regs, int trapnr)
> {
> 	regs->ip = ex_fixup_addr(fixup);
> 	regs->ax = -1L;
> 
> 	return true;
> }
> 
> 
> 	int err = 0;
> 
> 	asm volatile("1: INSN_WUSS\n"
> 		     "2:\n"
> 		     _ASM_EXTABLE_HANDLE(1b, 2b, ex_handler_wuss)
> 		     : "=a" (err)
> 		     : "S" (val), "D" (addr));
> 
> But I'm not at all sure that's actually better.

Thanks!  I will fix it.

Yu-cheng
