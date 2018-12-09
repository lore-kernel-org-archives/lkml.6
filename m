Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2F6C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F482081F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ttQSV/Ci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F482081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbeLIWYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:24:08 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33428 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728581AbeLIWXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:23:07 -0500
Received: by mail-lf1-f67.google.com with SMTP id i26so6624305lfc.0;
        Sun, 09 Dec 2018 14:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IcMz+xvQnh6MfG/Y0Fi4hdrivP7aU7J9YPwfdLT1MVI=;
        b=ttQSV/CirS13Ui/6hqP6AI+Rj10Ci9UygCvmTAu9vT9dAemKSHmz2sv+KHyKCX7xDt
         R113ttwfOsFQ+M9zBEX4nLTOUOq2NAKx7b/XOL/cHSeHmmBWDeLrh4yvHBYNYV5gjYe4
         xbXCZGCyrkVgFHpz0HgGWW73eEFdukI2Jfv59jm7mJ8t0diXBOSG9Kq3f9E+XcYyR6AP
         quXPgPOQYzG0872oTfAjWvO2ZWzsm0ExldIGrjTbHeahMH0DwblqVfhOW7L1TQ8P/wPk
         vvn/vFkzHcE9vQItmPF3YL7uv3RtIXEAo83vvPvXQo37NMU2sNtChMQfQ6I8MVYBqUYf
         IS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IcMz+xvQnh6MfG/Y0Fi4hdrivP7aU7J9YPwfdLT1MVI=;
        b=V3NIaZ3onG+i00boL5Wrhn9lIqiDO0sD+1NbvMb1UkK7d13KnmM2Yt1R/NATdjmnt+
         ONfYem1X9gbyOgkqnsjebcbYqXfs4lZqVLQv2eqJhpQ99EvUvUbePRKDlo1vRFUufTde
         83xxZO63In3f3lH25Opjk3FRoVODYwxGefdyZNh6kdd1h//6Jju/tr0Brsdi8a2NR/mD
         giIMkuHy+Hke1Wfx7tiBfAVlbc9GDCgky0rQVVCd8gwFGvRHl9IfCoQQq5a1IMeuQhml
         yL+EEzrb8EQwm7jCPIcwPyv5oPFUxm/JxF3ze9S+/kQHEhfkonxipEmkAkopcEUdbqQo
         ZhsA==
X-Gm-Message-State: AA+aEWZut1CoXgF9SFySDbva/Tj79QByPb8UFaYBdKWtCRFns+wzWyNP
        BTTVC0xtq5gEacuLx8z/QouvjZQexkE=
X-Google-Smtp-Source: AFSGD/XCSsjCOyEJH/dnT/DbjgoX66Fafz0aiz41CLS8mt1eIt1a8yLRE+Wa/TN4mqvke2/q6nkdCA==
X-Received: by 2002:a19:5a05:: with SMTP id o5mr5888553lfb.140.1544394184226;
        Sun, 09 Dec 2018 14:23:04 -0800 (PST)
Received: from [192.168.10.160] (91-159-62-226.elisa-laajakaista.fi. [91.159.62.226])
        by smtp.gmail.com with ESMTPSA id q11sm1774242lfc.92.2018.12.09.14.23.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 14:23:03 -0800 (PST)
Subject: Re: [PATCH 2/6] __wr_after_init: write rare for static allocation
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Kees Cook <keescook@chromium.org>, igor.stoppa@huawei.com,
        Nadav Amit <nadav.amit@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20181204121805.4621-1-igor.stoppa@huawei.com>
 <20181204121805.4621-3-igor.stoppa@huawei.com>
 <20181206044413.GB24603@bombadil.infradead.org>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <8959c79b-dd9d-8b1f-87b6-e2c971aa2342@gmail.com>
Date:   Mon, 10 Dec 2018 00:22:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181206044413.GB24603@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/12/2018 06:44, Matthew Wilcox wrote:
> On Tue, Dec 04, 2018 at 02:18:01PM +0200, Igor Stoppa wrote:
>> +void *__wr_op(unsigned long dst, unsigned long src, __kernel_size_t len,
>> +	      enum wr_op_type op)
>> +{
>> +	temporary_mm_state_t prev;
>> +	unsigned long flags;
>> +	unsigned long offset;
>> +	unsigned long wr_poking_addr;
>> +
>> +	/* Confirm that the writable mapping exists. */
>> +	BUG_ON(!wr_ready);
>> +
>> +	if (WARN_ONCE(op >= WR_OPS_NUMBER, "Invalid WR operation.") ||
>> +	    WARN_ONCE(!is_wr_after_init(dst, len), "Invalid WR range."))
>> +		return (void *)dst;
>> +
>> +	offset = dst - (unsigned long)&__start_wr_after_init;
>> +	wr_poking_addr = wr_poking_base + offset;
>> +	local_irq_save(flags);
> 
> Why not local_irq_disable()?  Do we have a use-case for wanting to access
> this from interrupt context?

No, not that I can think of. It was "just in case", but I can remove it.

>> +	/* XXX make the verification optional? */
> 
> Well, yes.  It seems like debug code to me.

Ok, I was not sure about this, because text_poke() does it as part of 
its normal operations.

>> +	/* Randomize the poking address base*/
>> +	wr_poking_base = TASK_UNMAPPED_BASE +
>> +		(kaslr_get_random_long("Write Rare Poking") & PAGE_MASK) %
>> +		(TASK_SIZE - (TASK_UNMAPPED_BASE + wr_range));
> 
> I don't think this is a great idea.  We want to use the same mm for both
> static and dynamic wr memory, yes?  So we should have enough space for
> all of ram, not splatter the static section all over the address space.
> 
> On x86-64 (4 level page tables), we have a 64TB space for all of physmem
> and 128TB of user space, so we can place the base anywhere in a 64TB
> range.

I was actually wondering about the dynamic part.
It's still not clear to me if it's possible to write the code in a 
sufficiently generic way that it could work on all 64 bit architectures.
I'll start with x86-64 as you suggest.

--
igor

