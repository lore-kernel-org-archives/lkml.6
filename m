Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E095C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0254F20B6F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0254F20B6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732407AbeGKJuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:50:12 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60490 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbeGKJuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:50:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCC8BED1;
        Wed, 11 Jul 2018 02:46:43 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF3513F318;
        Wed, 11 Jul 2018 02:46:41 -0700 (PDT)
Date:   Wed, 11 Jul 2018 10:46:39 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        "hch@infradead.org" <hch@infradead.org>,
        James Morse <James.Morse@arm.com>,
        "linux@dominikbrodowski.net" <linux@dominikbrodowski.net>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [PATCHv4 11/19] arm64: don't reload GPRs after apply_ssbd
Message-ID: <20180711094639.abltbull7adjzcit@lakrids.cambridge.arm.com>
References: <20180702110415.10465-1-mark.rutland@arm.com>
 <20180702110415.10465-12-mark.rutland@arm.com>
 <20180706163844.GB27483@arm.com>
 <20180709142159.tsxgwhjm3qziymym@lakrids.cambridge.arm.com>
 <20180710103722.GH9486@e103592.cambridge.arm.com>
 <20180710173317.GC10177@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710173317.GC10177@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 06:33:18PM +0100, Will Deacon wrote:
> On Tue, Jul 10, 2018 at 11:37:24AM +0100, Dave Martin wrote:
> > For the kernel, I suggest using a .L prefix so that the generated
> > symbols don't bloat the vmlinux symbol table (similar to numbered local
> > labels) -- unless you really want the symbols retained.
> > 
> > Having a common prefix for all "unique" assembler symbols may help us
> > to avoid namespace collisions, say
> > 
> > .L__asm__foo_\@
> > .L__asm__bar_\@
> 
> Hmm, yes, and that would allow us to replace the open-coded labels in
> our assembler.h macros as well, wouldn't it?

Yup.

For this patch, I'll rename skip_apply_ssbd\@ to .L__asm_ssbd_skip\@.

I'll send another patch (or series) converting our other macros to this
scheme. We can either take that with this series, or as subsequent
cleanup.

Thanks,
Mark.
