Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7196EC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B49020870
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFYySMpa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B49020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbeJ2WVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 18:21:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbeJ2WVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 18:21:35 -0400
Received: from linux-8ccs (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7A3E2082D;
        Mon, 29 Oct 2018 13:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540819973;
        bh=JNjwaXEZHdP4jeYASYZxaJhf42ltJbSy71S5GRmFAOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jFYySMpaBEqE7wIn0FpKSiIeHIW70WvYYH8eUMyou6OHHtVWiqOGplLQA17P81kuU
         JlkH4H/reyaxZv5bPmIGpViDdYeJwEOS+YHEd/BzSBLyrWTTr3RtlNC0GbfVjODisd
         2eTI/lddY+1iN3LFe1AcFvgwGrfFh5m69YqdyX74=
Date:   Mon, 29 Oct 2018 14:32:43 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Torsten Duwe <duwe@lst.de>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Petr Mladek <pmladek@suse.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: Re: [PATCH v2] arm64/module: use mod->klp_info section header
 information for livepatch modules
Message-ID: <20181029133243.wjrwnwgnqszojwpi@linux-8ccs>
References: <20181001140910.086E768BC7@newverein.lst.de>
 <20181001141652.5478C68BE1@newverein.lst.de>
 <20181023175553.gaobskk26koft6s2@linux-8ccs>
 <20181026172500.g65bl2p7cvey3qsx@linux-8ccs>
 <alpine.LSU.2.21.1810291415340.22023@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1810291415340.22023@pobox.suse.cz>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.16-default x86_64
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Miroslav Benes [29/10/18 14:24 +0100]:
>
>> diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
>> index dd23655fda3a..490e56070a7e 100644
>> --- a/arch/arm64/kernel/module.c
>> +++ b/arch/arm64/kernel/module.c
>> @@ -461,5 +461,15 @@ int module_finalize(const Elf_Ehdr *hdr,
>> #endif
>> 	}
>>
>> +#ifdef CONFIG_LIVEPATCH
>> +	/*
>> +	 * For livepatching, switch to the saved section header info for .plt
>> +	 * stored in mod->klp_info. This is needed so that livepatch is able to
>> +	 * call apply_relocate_add() after patch module load.
>> +	 */
>> +	if (is_livepatch_module(me))
>> +		me->arch.core.plt = me->klp_info->sechdrs + me->arch.core.plt_shndx;
>> +#endif
>
>I missed it before, but the hunk should be under "#ifdef
>CONFIG_ARM64_MODULE_PLTS" protection similarly to ftrace_trampoline just
>above. me->arch.core.plt may not exist otherwise.

Gah! Yes you are right, will fix.

Thanks,

Jessica
