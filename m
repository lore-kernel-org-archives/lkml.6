Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE65C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B6020825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B6020825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388057AbeKFEru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:47:50 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49398 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387556AbeKFEru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 23:47:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2873680D;
        Mon,  5 Nov 2018 11:26:40 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3EA23F5CF;
        Mon,  5 Nov 2018 11:26:39 -0800 (PST)
Date:   Mon, 5 Nov 2018 19:26:38 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Torsten Duwe <duwe@lst.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: Re: [PATCH v2] arm64/module: use plt section indices for relocations
Message-ID: <20181105192637.GB25023@brain-police>
References: <20181001140910.086E768BC7@newverein.lst.de>
 <20181001141652.5478C68BE1@newverein.lst.de>
 <20181105175722.removbbpilqxu7tr@redbean>
 <20181105185323.hgoflyvkyujdyjxj@redbean>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105185323.hgoflyvkyujdyjxj@redbean>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 07:53:23PM +0100, Jessica Yu wrote:
> Instead of saving a pointer to the .plt and .init.plt sections to apply
> plt-based relocations, save and use their section indices instead.
> 
> The mod->arch.{core,init}.plt pointers were problematic for livepatch
> because they pointed within temporary section headers (provided by the
> module loader via info->sechdrs) that would be freed after module load.
> Since livepatch modules may need to apply relocations post-module-load
> (for example, to patch a module that is loaded later), using section
> indices to offset into the section headers (instead of accessing them
> through a saved pointer) allows livepatch modules on arm64 to pass in
> their own copy of the section headers to apply_relocate_add() to apply
> delayed relocations.
> 
> Signed-off-by: Jessica Yu <jeyu@kernel.org>
> ---
> 
> v2:
> 
> - Do sechdrs[pltsec->plt_shndx].sh_addr instead of pointer math
> 
> Note: Addressed Will's comment about the pltsec -> plt_info rename and
> removed that change to reduce unnecessary code churn. I didn't include the
> Ack's for this reason so let me know if this version is OK as well.

Thanks, Jessica!

Acked-by: Will Deacon <will.deacon@arm.com>

> arch/arm64/include/asm/module.h |  8 +++++---
> arch/arm64/kernel/module-plts.c | 36 ++++++++++++++++++++----------------
> arch/arm64/kernel/module.c      |  9 +++++----
> 3 files changed, 30 insertions(+), 23 deletions(-)

Actually, I guess I should just queue this for 4.21 given that it's
completely self-contained.

Will
