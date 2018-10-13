Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD08C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 09:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3838204EC
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 09:35:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3838204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbeJMRKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 13:10:48 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:32966 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbeJMRKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 13:10:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C2C9ED1;
        Sat, 13 Oct 2018 02:34:20 -0700 (PDT)
Received: from mbp (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80E513F5D3;
        Sat, 13 Oct 2018 02:34:14 -0700 (PDT)
Date:   Sat, 13 Oct 2018 10:34:11 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Eugene Syromiatnikov <esyr@redhat.com>
Cc:     linux-doc@vger.kernel.org, Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Pavel Machek <pavel@ucw.cz>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Joseph Myers <joseph@codesourcery.com>,
        linux-arch@vger.kernel.org,
        Steve Ellcey <sellcey@caviumnetworks.com>,
        Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>,
        Andreas Schwab <schwab@suse.de>,
        Alexander Graf <agraf@suse.de>,
        Bamvor Zhangjian <bamv2005@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Adam Borowski <kilobyte@angband.pl>,
        Manuel Montezelo <manuel.montezelo@gmail.com>,
        James Hogan <james.hogan@imgtec.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Pinski <pinskia@gmail.com>,
        Lin Yongting <linyongting@huawei.com>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Wookey <wookey@wookware.org>, Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Florian Weimer <fweimer@redhat.com>, linux-api@vger.kernel.org,
        Nathan_Lynch <Nathan_Lynch@mentor.com>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>
Subject: Re: [PATCH v9 00/24] ILP32 for ARM64
Message-ID: <20181013093411.o3id6yzkspsxr5jt@mbp>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
 <20180724173957.GA22106@yury-thinkpad>
 <20181010141017.GA2881@asgard.redhat.com>
 <20181010153655.GA212880@arrakis.emea.arm.com>
 <20181013021416.GE21972@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181013021416.GE21972@asgard.redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 04:14:16AM +0200, Eugene Syromiatnikov wrote:
> On Wed, Oct 10, 2018 at 04:36:56PM +0100, Catalin Marinas wrote:
> > On Wed, Oct 10, 2018 at 04:10:21PM +0200, Eugene Syromiatnikov wrote:
> > > I have some questions regarding AArch64 ILP32 implementation for which I
> > > failed to find an answer myself:
> > >  * How ptrace() tracer is supposed to distinguish between ILP32 and LP64
> > >    tracees? For MIPS N32 and x32 this is possible based on syscall
> > >    number, but for AArch64 ILP32 I do not see such a sign. There's also
> > >    ARM_ip is employed for signalling entering/exiting, I wonder whether
> > >    it's possible to employ it also for signalling tracee's personality.
> > 
> > With the current implementation, I don't think you can distinguish. From
> > the kernel perspective, the register set is the same. What is the
> > use-case for this?
> 
> Err, a ptrace()-based tracer trying to trace a process, for example?

I first thought it wouldn't matter for ptrace-based tracers since the
syscall numbers are (mostly) the same. But the arguments layout in
register is indeed different, so I see your point now about having to
distinguish.

> > We could add a new regset to expose the ILP32 state (NT_ARM_..., I can't
> > think of a name now but probably not PER* as this implies PER_LINUX_...
> > which is independent from TIF_32BIT_*).
> 
> So that would require an additional ptrace() call on each syscall stop,
> is that correct?

The ILP32 state does not change at run-time, so it could only do a
ptrace() call once and save the information. No need to re-read it on
each syscall stop.

We could set a high bit in the syscall number reported to the ptrace
caller (though not changing the syscall ABI) but I haven't thought of
other consequences. For example, can the ptrace caller change the
syscall number?

> > >  * What's the reasoning behind capping syscall arguments to 32 bit? x32
> > >    and MIPS N32 do not have such a restriction (and do not need special
> > >    wrappers for syscalls that pass 64-bit values as a result, except
> > >    when they do,  as it is the case for preadv2 on x32); moreover, that
> > >    would lead to insurmountable difficulties for AArch64 ILP32 tracers
> > >    that try to trace LP64 tracees, as it would be impossible to pass
> > >    64-bit addresses to process_vm_{read,write} or ptrace PEEK/POKE.
> > 
> > We've attempted in earlier versions to allow a mix of 32 and 64-bit
> > register values from ILP32 but it got pretty complicated. The entry code
> > would need to know which registers need zeroing of the top 32-bit
> 
> If kernel specifies 64-bit wide registers for syscalls, then it's the
> caller's (libc's) responsibility to properly sign-extend arguments when
> needed, and glibc, for example, already has proper type definitions that
> aimed to handle this.

We tried, see my other reply.

-- 
Catalin
