Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538A1C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 091FA208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:26:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 091FA208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731500AbeGaLFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 07:05:53 -0400
Received: from foss.arm.com ([217.140.101.70]:50756 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729731AbeGaLFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 07:05:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FEAD7A9;
        Tue, 31 Jul 2018 02:26:28 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 208F03F5BA;
        Tue, 31 Jul 2018 02:26:28 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id F3B781AE30AF; Tue, 31 Jul 2018 10:26:29 +0100 (BST)
Date:   Tue, 31 Jul 2018 10:26:29 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     James Morse <james.morse@arm.com>
Cc:     Bhupesh Sharma <bhsharma@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, bhupesh.linux@gmail.com,
        takahiro.akashi@linaro.org, catalin.marinas@arm.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2] arm64, kaslr: export offset in VMCOREINFO ELF notes
Message-ID: <20180731092629.GD4680@arm.com>
References: <1532931883-16132-1-git-send-email-bhsharma@redhat.com>
 <303e32f7-ff47-ea9b-d5a0-45a22e44d0a9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <303e32f7-ff47-ea9b-d5a0-45a22e44d0a9@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 10:19:35AM +0100, James Morse wrote:
> Hi Bhupesh,
> 
> On 30/07/18 07:24, Bhupesh Sharma wrote:
> > Include KASLR offset in arm64 VMCOREINFO ELF notes to assist in
> > debugging. vmcore parsing in user-space already expects this value in
> > the notes and we are providing it for portability of those existing
> > tools with x86.
> > 
> > Ideally we would like core code to do this (so that way this
> > information won't be missed when an architecture adds KASLR support),
> > but mips has CONFIG_RANDOMIZE_BASE, and doesn't provide kaslr_offset(),
> > so I am not sure if this is needed for mips (and other such similar arch
> > cases in future). So, lets keep this architecture specific for now.
> 
> (heh, I assumed you would rewrite my train-of-thought, but I guess this works!)
> 
> 
> > As an example of a user-space use-case, consider the
> > makedumpfile user-space utility which will need fixup to use this
> > KASLR offset to work with cases where we need to find a way to
> > translate symbol address from vmlinux to kernel run time address
> > in case of KASLR boot on arm64.
> 
> Acked-by: James Morse <james.morse@arm.com>
> 
> If we want to send this to stable, it looks like it should have been part of the
> KASLR series, f80fb3a3d5084 ("arm64: add support for kernel ASLR") was merged
> for v4.6.
> CC: <stable@vger.kernel.org> # 4.6.x

Hmm, does this warrant a stable backport? This hasn't ever worked, right?

Will
