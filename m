Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79750ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A4172083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQNUfavf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A4172083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbeJYUO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 16:14:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:32988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727206AbeJYUO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 16:14:59 -0400
Received: from linux-8ccs (ip5f5adbf1.dynamic.kabel-deutschland.de [95.90.219.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDDC620831;
        Thu, 25 Oct 2018 11:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540467753;
        bh=/lDqC7tsHJhi2MFD4gFFiKAERUxCmSaUl7jEVgZA7nA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iQNUfavfR6WeKhWeIV/ejJRS5C70LCFCDm/inOk9a6oeMQ+2TfKVFoWQq5Bu1lw8d
         gEwqaFa4oAwlKYCniWuFjePxq4Ukn3NdSOdHT2vakv+mPQKI/lJ02pzvnpnurGdk9P
         EkIp17krxKtNPn5TNMb8tO05TnB0cOTRlPZ/GeKo=
Date:   Thu, 25 Oct 2018 13:42:28 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Petr Mladek <pmladek@suse.com>, Torsten Duwe <duwe@lst.de>,
        Will Deacon <will.deacon@arm.com>,
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
Subject: Re: [PATCH] arm64/module: use mod->klp_info section header
 information
Message-ID: <20181025114228.4zkwvdfwrwhngwod@linux-8ccs>
References: <20181001140910.086E768BC7@newverein.lst.de>
 <20181001141652.5478C68BE1@newverein.lst.de>
 <20181023175553.gaobskk26koft6s2@linux-8ccs>
 <20181025080816.525dppcfrrevf6jc@pathway.suse.cz>
 <alpine.LSU.2.21.1810251051330.9841@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1810251051330.9841@pobox.suse.cz>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.16-default x86_64
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Miroslav Benes [25/10/18 11:00 +0200]:
>On Thu, 25 Oct 2018, Petr Mladek wrote:
>
>> On Tue 2018-10-23 19:55:54, Jessica Yu wrote:
>> > The arm64 module loader keeps a pointer into info->sechdrs to keep track
>> > of section header information for .plt section(s). A pointer to the
>> > relevent section header (struct elf64_shdr) in info->sechdrs is stored
>> > in mod->arch.{init,core}.plt. This pointer may be accessed while
>> > applying relocations in apply_relocate_add() for example. And unlike
>> > normal modules, livepatch modules can call apply_relocate_add() after
>> > module load. But the info struct (and therefore info->sechdrs) gets
>> > freed at the end of load_module() and so mod->arch.{init,core}.plt
>> > becomes an invalid pointer after the module is done loading.
>> >
>> > Luckily, livepatch modules already keep a copy of Elf section header
>> > information in mod->klp_info. So make sure livepatch modules on arm64
>> > have access to the section headers in klp_info and set
>> > mod->arch.{init,core}.plt to the appropriate section header in
>> > mod->klp_info so that they can call apply_relocate_add() even after
>> > module load.
>> >
>> > diff --git a/kernel/module.c b/kernel/module.c
>> > index f475f30eed8c..f3ac04cc9fc3 100644
>> > --- a/kernel/module.c
>> > +++ b/kernel/module.c
>> > @@ -3367,6 +3367,8 @@ int __weak module_finalize(const Elf_Ehdr *hdr,
>> >
>> > static int post_relocation(struct module *mod, const struct load_info *info)
>> > {
>> > +	int err;
>> > +
>> > 	/* Sort exception table now relocations are done. */
>> > 	sort_extable(mod->extable, mod->extable + mod->num_exentries);
>> >
>> > @@ -3377,8 +3379,18 @@ static int post_relocation(struct module *mod, const struct load_info *info)
>> > 	/* Setup kallsyms-specific fields. */
>> > 	add_kallsyms(mod, info);
>> >
>> > +	if (is_livepatch_module(mod)) {
>> > +		err = copy_module_elf(mod, info);
>> > +		if (err < 0)
>> > +			return err;
>> > +	}
>> > +
>> > 	/* Arch-specific module finalizing. */
>> > -	return module_finalize(info->hdr, info->sechdrs, mod);
>> > +	err = module_finalize(info->hdr, info->sechdrs, mod);
>> > +	if (err < 0)
>>
>> 	if (err < 0 && is_livepatch_module(mod))
>
>Ah, right.
>
>> > +		free_module_elf(mod);
>> > +
>> > +	return err;
>> > }
>>
>> Also we need to free the copied stuff in load_module() when
>> anything called after post_relocation() fails. I think
>> that the following would work:
>>
>> --- a/kernel/module.c
>> +++ b/kernel/module.c
>> @@ -3823,6 +3823,8 @@ static int load_module(struct load_info *info, const char __user *uargs,
>>  	kfree(mod->args);
>>   free_arch_cleanup:
>>  	module_arch_cleanup(mod);
>> +	if (is_livepatch_module(mod))
>> +		free_module_elf(mod);
>>   free_modinfo:
>>  	free_modinfo(mod);
>>   free_unload:
>
>Yes, we need to free it somewhere and I missed it. free_arch_cleanup seems
>to be the correct place.

Good catches, thank you both!

>> But I suggest to just move copy_module_elf() up and keep
>> calling it from load_module() directly. It would make
>> the error handling more clear.
>
>Unfortunately it is not that simple. arm64's module_finalize() uses
>mod->klp_info with the patch, so copy_module_elf() must be called before.
>We could move module_finalize() from post_relocation() to load_module()
>and place copy_module_elf() between those two, but I don't know. That's up
>to Jessica.

Yeah, it's a stylistic preference - will shuffle those calls around
and see what looks best. v2 to come shortly.

Thanks!

Jessica
