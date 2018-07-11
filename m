Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247B8C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB294208E5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB294208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732368AbeGKKvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 06:51:07 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33074 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbeGKKvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 06:51:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8EAA80D;
        Wed, 11 Jul 2018 03:47:24 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAAA63F589;
        Wed, 11 Jul 2018 03:47:22 -0700 (PDT)
Date:   Wed, 11 Jul 2018 11:47:20 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, dave.martin@arm.com, hch@infradead.org,
        james.morse@arm.com, linux@dominikbrodowski.net,
        linux-fsdevel@vger.kernel.org, marc.zyngier@arm.com,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCHv4 00/19] arm64: invoke syscalls with pt_regs
Message-ID: <20180711104720.3h65gkbsphaugqht@lakrids.cambridge.arm.com>
References: <20180702110415.10465-1-mark.rutland@arm.com>
 <20180710103901.GA31318@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710103901.GA31318@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 11:39:02AM +0100, Will Deacon wrote:
> On Mon, Jul 02, 2018 at 12:03:56PM +0100, Mark Rutland wrote:
> > This series reworks arm64's syscall handling to minimize the propagation
> > of user-controlled register values into speculated code paths. As with
> > x86 [1], a wrapper is generated for each syscall, which extracts the
> > argument from a struct pt_regs. During kernel entry from userspace,
> > registers are zeroed.
> > 
> > The arm64 kernel code directly invokes some syscalls which the x86 code
> > doesn't, so I've added ksys_* wrappers for these, following the x86
> > example. The rest of the series is arm64-specific.
> > 
> > I've pushed the series out to my arm64/syscall-regs branch [2] on
> > kernel.org.
> 
> One thing I noticed with this series applied is that our sys_call_table
> declarations all get a bit muddled:
> 
> arm64/kernel/sys.c:		void * const sys_call_table[]
> arm64/kernel/sys32.c:		void * const compat_sys_call_table[]
> arm64/kernel/syscall.c:		extern syscall_fn_t sys_call_table[];
> 				extern syscall_fn_t compat_sys_call_table[];
> arm64/include/asm/syscall.h:	extern const void *sys_call_table[];
> 
> Can we tidy this up so that syscall.h provides a declaration using
> syscall_fn_t, allowing us to drop the additional externs?

Sure; done.

As a result, I've had to fold a few more consts into function prototypes
in subsequent patches, but that's probably a good thing.

This also makes me realise that once the generation of the table address
is converted to C, we can drop the alignment on the tables. That was
solely to simplify the asm invoking the syscall, allowing it to generate
the address with an adrp. The C code never relied on this, since the
alignment was not in the declaration of the tables.

I've spun an additional patch for that, too.

I've pushed hte result out to my arm64/syscall-regs branch. I guess I'll
post a v5 once that's seen some testing.

Thanks,
Mark.
