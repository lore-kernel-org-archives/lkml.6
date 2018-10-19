Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35ABECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53E7020869
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53E7020869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbeJSXVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 19:21:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:51004 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726663AbeJSXVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 19:21:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E560AADAB;
        Fri, 19 Oct 2018 15:14:39 +0000 (UTC)
Date:   Fri, 19 Oct 2018 17:14:38 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Jessica Yu <jeyu@kernel.org>
cc:     Torsten Duwe <duwe@lst.de>, Will Deacon <will.deacon@arm.com>,
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
Subject: Re: [PATCH v3 3/4] arm64: implement live patching
In-Reply-To: <20181019121847.eug4p2mxr32cebk2@linux-8ccs>
Message-ID: <alpine.LSU.2.21.1810191709050.4692@pobox.suse.cz>
References: <20181001140910.086E768BC7@newverein.lst.de> <20181001141652.5478C68BE1@newverein.lst.de> <alpine.LSU.2.21.1810171051560.21847@pobox.suse.cz> <20181018125820.iw54zbirq74ulknj@linux-8ccs> <alpine.LSU.2.21.1810191338020.4692@pobox.suse.cz>
 <20181019121847.eug4p2mxr32cebk2@linux-8ccs>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> >If I am not mistaken, we do not care for arch.init.plt in livepatch. Is
> >that correct?
> 
> I do not believe patching of __init functions is supported (right?) So
> we do not need to keep arch.init.plt alive post-module-load.

I think we can do that. Theoretically. I'm not sure if it is actually 
useful. Module's init functions are called after the modules is patched, 
so there is no obstacle.

But arch.init.plt would be useful only for the relocations of the patching 
module, right? Patching functions would not part of init section anyway, I 
think, so arch.init.plt is useless post-module-load.
 
> >> int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
> >> 			      char *secstrings, struct module *mod)
> >> {
> >> @@ -210,11 +225,13 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr,
> >> Elf_Shdr
> >> *sechdrs,
> >>   * entries. Record the symtab address as well.
> >>   */
> >> 	for (i = 0; i < ehdr->e_shnum; i++) {
> >> -		if (!strcmp(secstrings + sechdrs[i].sh_name, ".plt"))
> >> +		if (!strcmp(secstrings + sechdrs[i].sh_name, ".plt")) {
> >> 			mod->arch.core.plt = sechdrs + i;
> >> -		else if (!strcmp(secstrings + sechdrs[i].sh_name,
> >> ".init.plt"))
> >> +			mod->arch.core.plt_shndx = i;
> >> +		} else if (!strcmp(secstrings + sechdrs[i].sh_name,
> >> ".init.plt")) {
> >> 			mod->arch.init.plt = sechdrs + i;
> >> -		else if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE) &&
> >> +			mod->arch.init.plt_shndx = i;
> >
> >It is initialized here, but that's not necessarily a bad thing.
> 
> I think I added this line for consistency, but I actually don't think
> it is needed. We only would need to keep the section index for
> arch.core.plt then.

Yes. I'd welcome a comment somewhere in both cases. Either that we 
initialize it just for consistency, or that we don't, because it's not 
needed.

Miroslav
