Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC6EECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 509C721550
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="KmCPIfmQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 509C721550
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390510AbeIUVs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 17:48:27 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:46060 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbeIUVs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 17:48:27 -0400
Received: from [192.168.0.23] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 38C5B1280;
        Fri, 21 Sep 2018 17:58:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1537545534;
        bh=bg1ST8GqLxkmDBO4KFvn3FSPpC+3BWO8ba/H7GP95OQ=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KmCPIfmQhxCjyO6wZ7Ya3p8hZsVOE1v2SLJWDE1W9dlZyWbxAowOQ/myYUTGYMzYJ
         1mzji8vfqmwJmYRysU/lGmfDgJ6TEAy0GNEdnf1Is3qr6h51jFfccssLzBQWYSLe+5
         G6XyDd3DjJLR+XIwA8rjr8QhMxVyhdJO4jdrS2bM=
Reply-To: kieran.bingham+renesas@ideasonboard.com
Subject: Re: [PATCH] kernel/bounds: Provide prototype for foo
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-renesas-soc@vger.kernel.org, stable@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20180921142234.16882-1-kieran.bingham+renesas@ideasonboard.com>
 <20180921144527.GB16316@kroah.com>
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Organization: Ideas on Board
Message-ID: <6436e493-a3e4-7f9e-da1f-9db50643dff8@ideasonboard.com>
Date:   Fri, 21 Sep 2018 16:58:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180921144527.GB16316@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Thank you for quick response!

On 21/09/18 15:45, Greg Kroah-Hartman wrote:
> On Fri, Sep 21, 2018 at 03:22:33PM +0100, Kieran Bingham wrote:
>> kernel/bounds.c is recompiled on every build, and shows the following
>> warning when compiling with W=1:

So it turns out after a bit more checking that my statement above was a
small lie :)

My local build scripts were *causing* kernel/bounds.s to be rebuilt on
every build, which is why this stood out to me - because of two
competing compiles for the kernel image, and the dtb.

One with W=1 and the other without... (kbuild detected different flags,
and thus rebuilt the common objects)

And that's why I saw this warning on every build... and thought this was
a hot-path.


> Don't do that, you will get a lot of warnings that really don't make
> much sense.  Like this one :)


I know - but I can ignore all on my first build, then on incremental
builds where only files I change are compiled - it's much quieter :)

I see it as a benefit to compile *my* code with a higher warning level,
to prevent /me/ adding further warnings.


I realise of course this patch is just pandering to the compiler to shut
it up, as this is essentially an 'unused' dummy function from it's
perspective.

But in this instance, it's because the output is being compiled to an
assembly output (kernel/bounds.s) which is then later parsed, so there
isn't anywhere else to define the prototype, and the object code is only
referenced from the assembly output.


>>
>>   CC      kernel/bounds.s
>> linux/kernel/bounds.c:16:6: warning: no previous prototype for ‘foo’ [-Wmissing-prototypes]
>>  void foo(void)
>>       ^~~
>>
>> Provide a prototype to satisfy the compiler.
>>
>> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>> Cc: stable@vger.kernel.org
>>
>> ---
>> I compile all of my incremental builds with W=1, which allows me to know
>> instantly if I add a new compiler warning in code I generate.
>>
>> This warning always comes up and seems trivial to clean up.
>> ---
>>  kernel/bounds.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/kernel/bounds.c b/kernel/bounds.c
>> index c373e887c066..60136d937800 100644
>> --- a/kernel/bounds.c
>> +++ b/kernel/bounds.c
>> @@ -13,6 +13,8 @@
>>  #include <linux/log2.h>
>>  #include <linux/spinlock_types.h>
>>  
>> +void foo(void);
>> +
>>  void foo(void)
> 
> This file is a userspace tool that is used to later generate the
> include/generated/bounds.h file.

Well more accurately it is a file compiled directly to assembly which is
then later parsed to help generate the bounds.h file. It's not itself a
userspace tool, nothing executes this code...

It's just a compilation object to allow utilisation of the preprocessor
and compiler in ways that couldn't be done otherwise as far as I
understand it.


> If you really want to track this down and fix it properly, put the
> prototype in the .c file that ends up calling this function.  That's a
> fun task to dig through the build system to find :)

This is the only location.

The compilation output from V=1 (https://paste.debian.net/1043598/ for
the full output) shows the command generating this warning as:

  (with many flags redacted for readability)

aarch64-linux-gnu-gcc -Wp,-MD,kernel/.bounds.s.d  -nostdinc -Wall
-Wstrict-prototypes -DKBUILD_BASENAME='"bounds"'
-DKBUILD_MODNAME='"bounds"'  -fverbose-asm -S -o kernel/bounds.s
kernel/bounds.c



I still feel this patch has 'some' merit with the inaccurate leading
statement regarding this being output on every build removed from the
commit log.


What do you think ?

Worth a v2 with commit message fixed?
Or should I just drop this ?


> good luck!
> 
> greg k-h


--
Cheers

Kieran

