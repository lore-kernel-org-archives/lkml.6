Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6908BC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31FA12147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="YraNo2eF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfAGVuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 16:50:44 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:48836 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbfAGVun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 16:50:43 -0500
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id AC5C15C1536;
        Mon,  7 Jan 2019 22:50:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1546897841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=psMMRwMe3dh8O9dmvDsVPlF676cuwlu4ZsKyROzhdTw=;
        b=YraNo2eFRUxtwPvLHDJfsgXzwGw/y95mPvGUakQiaJZH8MUYogQwjHJ56BkWcGErBQkvpQ
        46SFYUt6hkou4ZRertpFf1Av2fPyjHcDtbHpBDbI5gHIZwoSU3z+YAZFhEz8uvQAysFvXw
        T0vrHTu/h/yjoZldgGiXhP1VN6goR1c=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Mon, 07 Jan 2019 22:50:41 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Nicolas Pitre <nicolas.pitre@linaro.org>
Cc:     linux@armlinux.org.uk, ndesaulniers@google.com,
        natechancellor@gmail.com, arnd@arndb.de, ard.biesheuvel@linaro.org,
        peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        julien.thierry@arm.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] ARM: uaccess: use unified assembler language
 syntax
In-Reply-To: <nycvar.YSQ.7.76.1901051106410.1783@knanqh.ubzr>
References: <cover.1546551693.git.stefan@agner.ch>
 <5ef2acc655abfbe8bfa2cd30ecc5c2286b8fdfa3.1546551693.git.stefan@agner.ch>
 <nycvar.YSQ.7.76.1901051106410.1783@knanqh.ubzr>
Message-ID: <3f615e62b2d3eefab0b1c17fe19bf1d2@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.01.2019 17:12, Nicolas Pitre wrote:
> On Thu, 3 Jan 2019, Stefan Agner wrote:
> 
>> Convert the conditional infix to a postfix to make sure this inline
>> assembly is unified syntax. Since gcc assumes non-unified syntax
>> when emitting ARM instructions, make sure to define the syntax as
>> unified.
>>
>> This allows to use LLVM's integrated assembler.
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>> Changes since v1:
>> - Explicitly use unified syntax for inline assembly
>>
>>
>>  arch/arm/include/asm/uaccess.h | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
>> index 6390a40f16e7..a50f9b4e2574 100644
>> --- a/arch/arm/include/asm/uaccess.h
>> +++ b/arch/arm/include/asm/uaccess.h
>> @@ -86,7 +86,8 @@ static inline void set_fs(mm_segment_t fs)
>>  #define __range_ok(addr, size) ({ \
>>  	unsigned long flag, roksum; \
>>  	__chk_user_ptr(addr);	\
>> -	__asm__("adds %1, %2, %3; sbcccs %1, %1, %0; movcc %0, #0" \
>> +	__asm__(".syntax unified\n" \
>> +		"adds %1, %2, %3; sbcscc %1, %1, %0; movcc %0, #0" \
> 
> Instead of sprinkling ".syntax unified" around, you could consider 
> including <asm/unified.h> when needed.

This seems not to help in this case. When I include <asm/unified.h> at
the beginning of uaccess.h GCC still seems to emit ".syntax unified".

I guess this is since we are dealing with inline assembly. As far as I
understand its really gcc which emits a ".syntax divided" by default
when compiling ARM mode. There is an option "-masm-syntax-unified" which
according to the gcc man page should do what we need, but it seems
broken, see also: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=88648

I agree this patch is not particularly pretty, but it is the only
solution I found to make this inline assembly work with gcc and Clang.

--
Stefan
