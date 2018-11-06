Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A21EC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D15E2085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D15E2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387609AbeKFTIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 14:08:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:44764 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729241AbeKFTIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 14:08:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8BF93B12F;
        Tue,  6 Nov 2018 09:44:29 +0000 (UTC)
Date:   Tue, 6 Nov 2018 10:44:27 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Will Deacon <will.deacon@arm.com>
cc:     Jessica Yu <jeyu@kernel.org>, Torsten Duwe <duwe@lst.de>,
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
Subject: Re: [PATCH v2] arm64/module: use plt section indices for
 relocations
In-Reply-To: <20181105192637.GB25023@brain-police>
Message-ID: <alpine.LSU.2.21.1811061043270.23386@pobox.suse.cz>
References: <20181001140910.086E768BC7@newverein.lst.de> <20181001141652.5478C68BE1@newverein.lst.de> <20181105175722.removbbpilqxu7tr@redbean> <20181105185323.hgoflyvkyujdyjxj@redbean> <20181105192637.GB25023@brain-police>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Nov 2018, Will Deacon wrote:

> On Mon, Nov 05, 2018 at 07:53:23PM +0100, Jessica Yu wrote:
> > Instead of saving a pointer to the .plt and .init.plt sections to apply
> > plt-based relocations, save and use their section indices instead.
> > 
> > The mod->arch.{core,init}.plt pointers were problematic for livepatch
> > because they pointed within temporary section headers (provided by the
> > module loader via info->sechdrs) that would be freed after module load.
> > Since livepatch modules may need to apply relocations post-module-load
> > (for example, to patch a module that is loaded later), using section
> > indices to offset into the section headers (instead of accessing them
> > through a saved pointer) allows livepatch modules on arm64 to pass in
> > their own copy of the section headers to apply_relocate_add() to apply
> > delayed relocations.
> > 
> > Signed-off-by: Jessica Yu <jeyu@kernel.org>
> > ---
> > 
> > v2:
> > 
> > - Do sechdrs[pltsec->plt_shndx].sh_addr instead of pointer math
> > 
> > Note: Addressed Will's comment about the pltsec -> plt_info rename and
> > removed that change to reduce unnecessary code churn. I didn't include the
> > Ack's for this reason so let me know if this version is OK as well.
> 
> Thanks, Jessica!
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> 
> > arch/arm64/include/asm/module.h |  8 +++++---
> > arch/arm64/kernel/module-plts.c | 36 ++++++++++++++++++++----------------
> > arch/arm64/kernel/module.c      |  9 +++++----
> > 3 files changed, 30 insertions(+), 23 deletions(-)
> 
> Actually, I guess I should just queue this for 4.21 given that it's
> completely self-contained.

FWIW you can also add my

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

Thanks, Jessica.

Miroslav
