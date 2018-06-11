Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id truzLZ4qHlswFgAAmS7hNA
	; Mon, 11 Jun 2018 07:54:06 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id AC3C5607E4; Mon, 11 Jun 2018 07:54:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 10079605A5;
	Mon, 11 Jun 2018 07:54:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 10079605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754109AbeFKHyD (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 03:54:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:40713 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754014AbeFKHyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 03:54:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2EFA3AE79;
        Mon, 11 Jun 2018 07:54:01 +0000 (UTC)
From: Andreas Schwab <schwab@suse.de>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RISC-V: Handle R_RISCV_32 in modules
References: <mhng-3f91f2da-55ae-41b8-b5b2-956ea638bed0@palmer-si-x1c4>
X-Yow: We have DIFFERENT amounts of HAIR --
Date: Mon, 11 Jun 2018 09:54:00 +0200
In-Reply-To: <mhng-3f91f2da-55ae-41b8-b5b2-956ea638bed0@palmer-si-x1c4>
        (Palmer Dabbelt's message of "Fri, 08 Jun 2018 15:33:35 -0700 (PDT)")
Message-ID: <mvm8t7liwrr.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 08 2018, Palmer Dabbelt <palmer@sifive.com> wrote:

> On Thu, 07 Jun 2018 03:27:27 PDT (-0700), schwab@suse.de wrote:
>> With CONFIG_MODVERSIONS=y the R_RISCV_32 relocation is used by the
>> __kcrctab section.
>>
>> Signed-off-by: Andreas Schwab <schwab@suse.de>
>> ---
>>  arch/riscv/kernel/module.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
>> index 5dddba301d..1d5e9b934b 100644
>> --- a/arch/riscv/kernel/module.c
>> +++ b/arch/riscv/kernel/module.c
>> @@ -17,6 +17,17 @@
>>  #include <linux/errno.h>
>>  #include <linux/moduleloader.h>
>>
>> +static int apply_r_riscv_32_rela(struct module *me, u32 *location, Elf_Addr v)
>> +{
>> +	if (v != (u32)v) {
>
> My worry with this kind of check is that it relies on some sort of
> undefined behavior in C and that at some point in the future GCC will just
> go decide the check can never fail.  I checked and GCC doesn't elide these
> checks now, so I might be wrong.
>
> Is this defined to do what it looks like it's doing?

This is unsigned arithmetic, thus fully defined.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
