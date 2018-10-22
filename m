Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3B0C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 273962089C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 273962089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbeJVVLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 17:11:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:41138 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727210AbeJVVLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 17:11:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C8734AFCC;
        Mon, 22 Oct 2018 12:53:12 +0000 (UTC)
Date:   Mon, 22 Oct 2018 14:53:10 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
cc:     Jessica Yu <jeyu@kernel.org>, Torsten Duwe <duwe@lst.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        live-patching@vger.kernel.org
Subject: Re: [PATCH v3 3/4] arm64: implement live patching
In-Reply-To: <CAKv+Gu8Vg9-CwvU-u9gNGmtB7gTapuCPHjU5v7FWnPsVy6vptA@mail.gmail.com>
Message-ID: <alpine.LSU.2.21.1810221452070.13146@pobox.suse.cz>
References: <20181001140910.086E768BC7@newverein.lst.de> <20181001141652.5478C68BE1@newverein.lst.de> <alpine.LSU.2.21.1810171051560.21847@pobox.suse.cz> <20181018125820.iw54zbirq74ulknj@linux-8ccs> <CAKv+Gu_yNBN+Rpw98MAZaxzSjm20qMYD7+fiJ1fBHoUeDr9fBA@mail.gmail.com>
 <alpine.LSU.2.21.1810191714540.4692@pobox.suse.cz> <CAKv+Gu8Vg9-CwvU-u9gNGmtB7gTapuCPHjU5v7FWnPsVy6vptA@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Oct 2018, Ard Biesheuvel wrote:

> On 19 October 2018 at 23:21, Miroslav Benes <mbenes@suse.cz> wrote:
> >
> >> >> Ad relocations. I checked that everything in struct mod_arch_specific
> >> >> stays after the module is load. Both core and init get SHF_ALLOC set
> >> >> (mod->arch.core.plt->sh_flags in module_frob_arch_sections(). It is
> >> >> important because apply_relocate_add() may use those sections
> >> >> through module_emit_plt_entry() call.
> >> >
> >> >
> >> > Yes, it looks like the needed .plt sections will remain in module
> >> > memory. However, I think I found a slight issue... :/
> >> >
> >> > In module_frob_arch_sections(), mod->arch.core.plt is set to an offset
> >> > within info->sechdrs:
> >> >
> >> >             if (!strcmp(secstrings + sechdrs[i].sh_name, ".plt"))
> >> >                     mod->arch.core.plt = sechdrs + i;
> >> >
> >> > sechdrs is from info->sechdrs, which is freed at the end of
> >> > load_module() via free_copy(). So although the relevant plt section(s)
> >> > are in module memory, mod->arch.core.plt will point to invalid memory
> >> > after info is freed. In other words, the section (.plt) *is* in memory
> >> > but the section header (struct elf64_shdr) containing section metadata
> >> > like sh_addr, sh_size etc., is not.
> >> >
> >>
> >> Just for my understanding: this only matters for live patching, right?
> >
> > Yes. Live patching can do deferred relocations. When a module is loaded
> > and livepatched, the relevant symbols in the patching module are resolved.
> > We call apply_relocate_add(), which is arch-specific, and we must be sure
> > that everything used by apply_relocate_add() is preserved in the patching
> > module after it is loaded.
> >
> 
> So I suppose this could get interesting in cases where modules are far
> away from the kernel (i.e., more than -/+ 128 MB). Fortunately, the
> modules themselves are always placed in a 128 MB window, but this
> window could be out of reach for branches into the kernel proper. If
> we find ourselves in the situation where we need to patch calls into
> the kernel proper to point into this module, this may get interesting,
> since the PLT entries *must* be allocated along with the module that
> contains the branch instruction, or the PLT entry itself may be out of
> range, defeating the purpose.

Hm... Torsten, didn't you have to solve something similar in powerpc case? 

> >> The original PLT support was implemented to support loading modules
> >> outside of the -/+ 128 MB range of an arm64 relative branch/jump
> >> instruction, and was later enhanced [for the same reason] to support
> >> emitting a trampoline for the ftrace entrypoint.

