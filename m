Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19500C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE1812087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbfBDMDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 07:03:11 -0500
Received: from verein.lst.de ([213.95.11.211]:48528 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728399AbfBDMDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 07:03:11 -0500
Received: by newverein.lst.de (Postfix, from userid 2005)
        id 0B62868D93; Mon,  4 Feb 2019 13:03:09 +0100 (CET)
Date:   Mon, 4 Feb 2019 13:03:09 +0100
From:   Torsten Duwe <duwe@lst.de>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Julien Thierry <julien.thierry@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        "Singh, Balbir" <bsingharora@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        live-patching@vger.kernel.org
Subject: Re: [PATCH v7 2/3] arm64: implement ftrace with regs
Message-ID: <20190204120308.GA7660@lst.de>
References: <20190118163736.6A99268CEB@newverein.lst.de> <20190118163908.E338E68D93@newverein.lst.de> <bdcbdda9-d9e8-20e5-429e-35473ade56cc@arm.com> <20190122132832.GB16778@lst.de> <CAKv+Gu_sk-jbT3BfTVt1jdx5tR3KCGYzU63T8bv+TYy0Oizy+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_sk-jbT3BfTVt1jdx5tR3KCGYzU63T8bv+TYy0Oizy+g@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 02:55:12PM +0100, Ard Biesheuvel wrote:
> On Tue, 22 Jan 2019 at 14:28, Torsten Duwe <duwe@lst.de> wrote:
> >
> > On Tue, Jan 22, 2019 at 10:18:17AM +0000, Julien Thierry wrote:
> > > Hi Torsten,
> > >
> > > A few suggestions below.
> > >
> > > > +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> > > > +#define ARCH_SUPPORTS_FTRACE_OPS 1
> > > > +#define REC_IP_BRANCH_OFFSET AARCH64_INSN_SIZE
> > > > +/* All we need is some magic value. Simply use "_mCount:" */
> > >
> > > Nit: Should the casing be "_mcount" ?
> >
> > No! The string makes it clear what it's supposed to be and the peculiar
> > casing makes it unique and leaves no doubt were it came from. So whenever
> > you see this register value in a crash dump you don't have to wonder about
> > weird linkage errors, as it surely did not originate from a symtab.
> >
> 
> In that case, do you need to deal with endianness here?
> 
> > > > +#define MCOUNT_ADDR                (0x5f6d436f756e743a)

Strictly speaking, yes. OTOH "wrong-andian" machines always show a difference
when memory is dumped in bigger units than bytes, so when you see the register
value in hex...

Since all that's needed is a somewhat unique constant, let's not over-engineer
this ok?

If there are no other comments I'll send out v8 with the discussed changes.

	Torsten

