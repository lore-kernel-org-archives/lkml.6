Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AF9C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18CB520827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QUbfcQpk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18CB520827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbeKEVuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:50:11 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:52305 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbeKEVuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:50:10 -0500
Received: by mail-it1-f193.google.com with SMTP id t190-v6so6638697itb.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 04:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FUE2AL8GDztjZvNMDN7j4je0OfJeqEWCeDy5fS/DNCM=;
        b=QUbfcQpkoDHVljBmsAMwbUpfU3C7z/i6Zd2omwy10H0ykTHQG0NgHeibEZXH9rqlQN
         nRXYxdEeJFniQN7i7YmsWYRlM2mA1S2SN8TqfTTgCjCbQyhm6Clr6fEllsFXw4gDZcam
         pX/g+mwqhViQiA6f3sOn8ebJDVUew3YucKQYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FUE2AL8GDztjZvNMDN7j4je0OfJeqEWCeDy5fS/DNCM=;
        b=T1Og9AKJRAZGozJOy3xGdx/6lkZEPXL+lpFTAiYVJNfEiMX+MO/jNuC+A7CjHtAwjM
         B//Vv0j5HabkhrwPoKkkTBhQVbXhYcC4oSOdB7g/iMwNApTXdbmmtwwZDaPN6R3yHKSQ
         CgFpa/CQTuZnlgKOPvSAcjtpr014fVsufY3C6hv6yYPwgnb3hcOestBQwDJFou1RNGQ4
         VHUetXiXMOor4IBdvRCl1ecz+KAUXsZesSgTGtSnL4xt37g/n2OSgaGp4UkKSlZ8ym2s
         YbpwNLJgpwfvnwn9WgQ6ke4dHrm483eiwLgUR774b/jg6118xxqDuJH5eXNxuy1CRlVk
         oDkQ==
X-Gm-Message-State: AGRZ1gKKUWyzV0LBohq9azzj0AehWPYdE/v6CQTiz5kYB22mR77Rcr2P
        6YTHjP3bGoV+aY4f3a6rKKtlzTFZ2IDOBDHGCoQ8Hg==
X-Google-Smtp-Source: AJdET5fzgZUSaV2vPp5/0fOIiAT+MvuGTAhjHsDgg3FyQexHzyafdMWB1YMrljcrVcFALEJQmBOF+GeBfnQrf+35TFw=
X-Received: by 2002:a24:8347:: with SMTP id d68-v6mr7077619ite.158.1541421038245;
 Mon, 05 Nov 2018 04:30:38 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:4f16:0:0:0:0:0 with HTTP; Mon, 5 Nov 2018 04:30:37 -0800 (PST)
In-Reply-To: <20181101160759.GB17659@arm.com>
References: <20181001140910.086E768BC7@newverein.lst.de> <20181001141652.5478C68BE1@newverein.lst.de>
 <20181023175553.gaobskk26koft6s2@linux-8ccs> <20181026172500.g65bl2p7cvey3qsx@linux-8ccs>
 <20181029152834.GA16289@arm.com> <20181030131910.zuqw523rq4pi7apb@linux-8ccs> <20181101160759.GB17659@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 5 Nov 2018 13:30:37 +0100
Message-ID: <CAKv+Gu-nq+zWur+swiCxsGtMFpm1KtA4KTdkejJQdjuS9Rg10Q@mail.gmail.com>
Subject: Re: [PATCH v2] arm64/module: use mod->klp_info section header
 information for livepatch modules
To:     Will Deacon <will.deacon@arm.com>
Cc:     Jessica Yu <jeyu@kernel.org>, Torsten Duwe <duwe@lst.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 November 2018 at 17:07, Will Deacon <will.deacon@arm.com> wrote:
> Hello, Jessica,
>
> On Tue, Oct 30, 2018 at 02:19:10PM +0100, Jessica Yu wrote:
>> +++ Will Deacon [29/10/18 15:28 +0000]:
>> >On Fri, Oct 26, 2018 at 07:25:01PM +0200, Jessica Yu wrote:
>> >>diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
>> >>index fef773c94e9d..ac9b97f9ae5e 100644
>> >>--- a/arch/arm64/include/asm/module.h
>> >>+++ b/arch/arm64/include/asm/module.h
>> >>@@ -25,6 +25,7 @@ struct mod_plt_sec {
>> >>    struct elf64_shdr       *plt;
>> >>    int                     plt_num_entries;
>> >>    int                     plt_max_entries;
>> >>+   int                     plt_shndx;
>> >>};
>> >
>> >Does this mean we can drop the plt pointer from this struct altogether, and
>> >simply offset into the section headers when applying the relocations?
>>
>> Hmm, if everyone is OK with dropping the plt pointer from struct
>> mod_plt_sec, then I think we can simplify this patch even further.
>>
>> With the plt shndx saved, we can additionally pass a pointer to
>> sechdrs to module_emit_plt_entry(), and with that just offset into the
>> section headers as you suggest. Since livepatch *already* passes in
>> the correct copy of the section headers (mod->klp_info->sechdrs) to
>> apply_relocate_add(), we wouldn't even need to modify the arm64
>> module_finalize() to change mod->arch.core.plt to point into
>> mod->klp_info->sechdrs anymore and we can drop all the changes to the
>> module loader too.
>>
>> Something like the following maybe?
>
> This looks pretty good, thanks! My only (minor) objection is that the
> renaming of plt_sec -> plt_info throughout makes the patch a lot more
> churny than it needs to be, for questionable gain.
>
> Anyway, it looks functionally correct and I've tested loading/unloading
> the "hello world" test module with both PLTs enabled and disabled.
>
> Acked-by: Will Deacon <will.deacon@arm.com>
>

For the simplified version:

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
