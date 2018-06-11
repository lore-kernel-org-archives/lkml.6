Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id FAPAEyAwHlvTZAAAmS7hNA
	; Mon, 11 Jun 2018 08:17:45 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 57328607BB; Mon, 11 Jun 2018 08:17:45 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mkut4LyW"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DD86360791;
	Mon, 11 Jun 2018 08:17:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DD86360791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754162AbeFKIRn (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 04:17:43 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56734 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754146AbeFKIRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 04:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6BMWYUn12JKyHvd/D7ydLx4ChhZ9FP/umOV3TpOFp2w=; b=mkut4LyWjRaeNFd2N7nVTvosS
        3QYp0Kqcgl922ouu9CycSjXn6yult5uQWQSV8AVBQuHNGa+ShUmcnuGz9Ccyrkh9/loteI4YaCD7k
        DSd0HVUfF251aUJx8H0MnEvctmlPn7npf6aG4VwxvlCAAv0rbC9GtnIOPJ+GGklMqBMk+ikxZB4MD
        pxNvQYKEMhPfdif1uymAfpP906YoCEPTUYR0AgJoAbcvwUifVsmzlfbVbNWfIFL2YXC76N1oP86Mj
        5vctuOaMfo+oi31iLoVzsm9K6GXHbe7lZx3LFjIiD7vL1Q3fq7SZ/uu3vxm+SujkYWpDGsgxlq+7b
        ynA9/easQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSI0g-0004s9-40; Mon, 11 Jun 2018 08:17:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D149F201EA7B1; Mon, 11 Jun 2018 10:17:04 +0200 (CEST)
Date: Mon, 11 Jun 2018 10:17:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>,
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
Subject: Re: [PATCH 02/10] x86/cet: Introduce WRUSS instruction
Message-ID: <20180611081704.GI12180@hirez.programming.kicks-ass.net>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com>
 <20180607143807.3611-3-yu-cheng.yu@intel.com>
 <CALCETrU45Cuzvfz3c1+-+7=9KS2N33Bpp1JqBtaGxhPo8U+Fqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrU45Cuzvfz3c1+-+7=9KS2N33Bpp1JqBtaGxhPo8U+Fqg@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 09:40:02AM -0700, Andy Lutomirski wrote:
> On Thu, Jun 7, 2018 at 7:41 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:

> Peterz, isn't there some fancy better way we're supposed to handle the
> error return these days?

> > +       asm volatile("1:.byte 0x66, 0x0f, 0x38, 0xf5, 0x37\n"
> > +                    "xor %[err],%[err]\n"
> > +                    "2:\n"
> > +                    ".section .fixup,\"ax\"\n"
> > +                    "3: mov $-1,%[err]; jmp 2b\n"
> > +                    ".previous\n"
> > +                    _ASM_EXTABLE(1b, 3b)
> > +               : [err] "=a" (err)
> > +               : [val] "S" (val), [addr] "D" (addr)
> > +               : "memory");

So the alternative is something like:

__visible bool ex_handler_wuss(const struct exception_table_entry *fixup,
			       struct pt_regs *regs, int trapnr)
{
	regs->ip = ex_fixup_addr(fixup);
	regs->ax = -1L;

	return true;
}


	int err = 0;

	asm volatile("1: INSN_WUSS\n"
		     "2:\n"
		     _ASM_EXTABLE_HANDLE(1b, 2b, ex_handler_wuss)
		     : "=a" (err)
		     : "S" (val), "D" (addr));

But I'm not at all sure that's actually better.
