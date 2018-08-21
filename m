Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B57C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 12:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 130FE20C0F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 12:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="ScL7lQfV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 130FE20C0F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbeHUQDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 12:03:31 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44221 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbeHUQDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 12:03:31 -0400
Received: by mail-lj1-f193.google.com with SMTP id q127-v6so14183861ljq.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 05:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xhoKh/2tMSdlZnjrzz1R+CDLjcZPU7Ka5t0/zzc1QvY=;
        b=ScL7lQfVvBE83MspWGEeHqfAcDy7tL/QXAai4ZUnucAkpCktQVnUg5WocgIvGW18Mo
         /P8Bvhc/1558B8clNyaHb6DzOJSptXoIVVMCNoqbH7BHW9nYcXel/gJxQzxhGCe7P9Nq
         OOBVugIKzdrQN6abwfuJBZ6BoM/hOo2CKoyQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xhoKh/2tMSdlZnjrzz1R+CDLjcZPU7Ka5t0/zzc1QvY=;
        b=ChOaosq2emyMn6saXibrX5N3VkfOskFo0qgH5fpC4tBcxZ4tBIXcB2qkQpYlrkir7k
         da6pHJtfq0pBpvslXVG9rewL2X5eNoLMMKtInOzxHKA5zxC3wOZS13KwHE9Ogg+TF4VD
         ln1Izus23jbkojZ+U0YNlNEVtHECkIppqF/5KrKIFhC6KJjKj+3MYhWBzUdiYjWXd2wG
         dkLOntw2Q/7zFEpy9BL5/fNBLo03aGlgfpvbNrF05YWOeLaPiHL0dgc2KBJScEXSz/jr
         8jCd6kjeAEyR3PPosw4rGWZtJaXwkW9T4k4kAl0i5hptRJ8WgZxuisyDpo5sb2slJBfa
         NhVQ==
X-Gm-Message-State: AOUpUlFVDLc6GmesXM5xlXojUfVvoYu68fQ8zwChwtt+/F58aEhD82kb
        4Yismeos8DFHBwwUWECeF4Pqjw==
X-Google-Smtp-Source: AA+uWPw4MMM+YtYicAHfXidYsabeMK54MEZqPV3t0vHHzpwJE4VtbJGVQwJ+u9J4Od7KjDXV4w4/wA==
X-Received: by 2002:a2e:7d10:: with SMTP id y16-v6mr14863699ljc.29.1534855409880;
        Tue, 21 Aug 2018 05:43:29 -0700 (PDT)
Received: from [172.16.11.40] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id y65-v6sm1993817lfa.97.2018.08.21.05.43.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 05:43:29 -0700 (PDT)
Subject: Re: [RFC][PATCH] lib/string: introduce sysfs_strncpy() and
 sysfs_strlcpy()
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Martin Wilck <mwilck@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
References: <20180821062459.1807-1-sergey.senozhatsky@gmail.com>
 <0e06858f-3625-692a-582d-d828a3cc3ebe@rasmusvillemoes.dk>
 <20180821095055.GA400@jagdpanzerIV>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <4bef099f-b2e1-0327-271d-75662b366c07@rasmusvillemoes.dk>
Date:   Tue, 21 Aug 2018 14:43:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180821095055.GA400@jagdpanzerIV>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-21 11:50, Sergey Senozhatsky wrote:
> Hi Rasmus,
> 
> On (08/21/18 09:59), Rasmus Villemoes wrote:
>>> +char *sysfs_strncpy(char *dest, const char *src, size_t count)
>>> +{
>>> +	char *c;
>>> +
>>> +	strncpy(dest, skip_spaces(src), count);
>>
>> I'd like to see where and how you'd use this, but I'm very skeptical of
>> count being used both for the size of the dest buffer as well as an
>> essentially random argument to strncpy - if count is also the maximum
>> number of bytes to read from the src, you'd need to take the
>> skip_spaces() into account, because there are not count bytes left after
>> that...
>> And if src is not necessarily nul-terminated, skip_spaces() by
>> itself is wrong.
> 
> I think that sysfs input is always properly NULL-terminated. It may or
> may not contain \n, but \0 is expected to be there.

Maybe. But it shouldn't hurt to make it accept a src size (the caller
can always pass -1 is he's sure the input is nul-terminated) - I'm
thinking a new interface might also have uses outside sysfs.

>> Moreover, I don't think we should add more users or wrappers for strncpy
>> - I highly doubt the sysfs users you have in mind want the "fill the
>> rest of the buffer with '\0'" nor the "not enough room for a terminating
>> '\0'? Oh well, what could possibly go wrong" semantics.
> 
> The reason I added both strncpy() and strlcpy() was that there are lots
> of sysfs ->store() callbacks which use strncpy().
> 
> E.g.
> 	channel_dimm_label_store()
> 	dimmdev_label_store()
> 	pmbus_add_label()
> 	axp20x_store_attr()
> 	cmdline_store()

Hm, do any of those actually want the skipping of leading whitespace?
pmbus_add_label doesn't even seem to kill a trailing newline?

It's probably hard to create one interface that will work for all cases.
Some are happy with truncating the user input, some refuse to do the
copy if truncation might happen, some probably do the copy (clobbering
what was there) but then detect the truncation somehow and return EINVAL
or whatever. Also, some copy to a pre-existing buffer, while others
kmalloc() a buffer and populate it with strncpy. The latter would
probably be better served using kstrndup or a small variant.

>> I think you're too focused on making wrappers around str[ln]cpy
>> preserving parts of those functions' API. Instead, try to figure out
>> what sysfs users actually want, name the functions after that, and then
>> whether they use strncpy or sprintf or strscpy internally is completely
>> irrelevant.
> 
> [Good] point, that's why the patch is in RFC stage: to figure out
> what do we actually want.

Dunno, looking at your examples above I'm a bit more skeptical that
there is a lot of common ground. But of course there are hundreds of
other store callbacks, so surely one can simplify some with a new helper.

Rasmus

