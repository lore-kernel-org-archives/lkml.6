Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4E5C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE74B21848
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbfA2SKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:10:38 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41282 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbfA2SKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:10:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E167EBD;
        Tue, 29 Jan 2019 10:10:36 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0AB333F557;
        Tue, 29 Jan 2019 10:10:34 -0800 (PST)
Date:   Tue, 29 Jan 2019 18:10:32 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
Cc:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        'Mark Rutland' <mark.rutland@arm.com>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>,
        "'will.deacon@arm.com'" <will.deacon@arm.com>,
        "'james.morse@arm.com'" <james.morse@arm.com>
Subject: Re: [PATCH v3 0/1] arm64: Add workaround for Fujitsu A64FX erratum
 010001
Message-ID: <20190129181032.GC224095@arrakis.emea.arm.com>
References: <8898674D84E3B24BA3A2D289B872026A6A2C04E6@G01JPEXMBKW03>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8898674D84E3B24BA3A2D289B872026A6A2C04E6@G01JPEXMBKW03>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Could you please copy the whole description from the cover letter to the
actual patch and only send one email (full description as in here
together with the patch)? If we commit this to the kernel, it would be
useful to have the information in the log for reference later on.

More comments below:

On Tue, Jan 29, 2019 at 12:29:58PM +0000, Zhang, Lei wrote:
> On some variants of the Fujitsu-A64FX cores ver(1.0, 1.1),  
> memory accesses may cause undefined fault (Data abort, DFSC=0b111111).
> This problem will be fixed by next version of Fujitsu-A64FX.
> 
> This fault occurs under a specific hardware condition 
> when a load/store instruction perform an address translation using:
>   case-1  TTBR0_EL1 with TCR_EL1.NFD0 == 1.
>   case-2  TTBR0_EL2 with TCR_EL2.NFD0 == 1.
>   case-3  TTBR1_EL1 with TCR_EL1.NFD1 == 1.
>   case-4  TTBR1_EL2 with TCR_EL2.NFD1 == 1.
> And this fault occurs completely spurious.

So this looks like new information on the hardware behaviour since the
v2 of the patch. Can this fault occur for any type of instruction
accessing the memory or only for SVE instructions?

> Since TCR_ELx.NFD1 is set to '1' at the kernel in versions 
> past 4.17, the case-3 or case-4 may happen.
> 
> This fault can be taken only at stage-1, 
> so this fault is taken from EL0 to EL1/EL2, from EL1 to EL1, 
> or from EL2 to EL2.
> 
> I would like to post a workaround to avoid this problem on 
> existing Fujitsu-A64FX version.

How likely is it to trigger this erratum? In other words, aren't we
better off with a spurious fault that we ignore rather than toggling the
TCR_ELx.NFD1 bit?

> There are 2 points in this workaround.
> Point1: trap from EL1 to EL1, EL2 to EL2
> Set '0' to TCR_ELx.NFD1in kernel-entry, 
> and set '1' in kernel-exit.
> 
> From the view point of ARM specification, there is no problem to 
> reset TCR_ELx.{NFD0,NFD1} while in EL1/EL2, because 
> TCR_ELx.{NFD0,NFD1} controls whether to perform a translation 
> table walk in response to an access from EL0.

The problem is that this bit may be cached in the TLB (I haven't checked
the ARM ARM but that's usually the case with the TCR_ELx bits). If
that's the case, you can't guarantee a change unless you also perform a
TLBI VMALL. Arguably, if Fujitsu's microarchitecture doesn't cache the
NFD bits in the TLB, we could apply the workaround but I'd rather have
the spurious trap if it's not too often.

> I confirmed that:
> ・There is no load/store instruction between 
>   tramp_ventry and setting TCR_ELx.NFD1 to '0'.
> ・There is no load/store instruction between 
>   setting TCR_ELx.NFD1 to '1' and tramp_exit.

Could speculative loads also trigger this? Another option would be to
toggle it during kernel_neon_begin/end (with the caveat of TLBI as
mentioned above).

-- 
Catalin
