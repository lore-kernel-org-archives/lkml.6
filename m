Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C09C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 07:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEEC6214FE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 07:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="gubs4/kn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEEC6214FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbeHULSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 07:18:53 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34172 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbeHULSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 07:18:52 -0400
Received: by mail-lf1-f67.google.com with SMTP id g9-v6so7653174lfh.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 00:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dDhM0qwwryuViNWNx8Hxpg5zZTF9a+dZ1IO/v6pGa+Q=;
        b=gubs4/knXZBoJPPOMx1GKVVbACdbMeqQfQsEqQEZTArAno22VFOCwMmz5+P3j2ifh2
         RTVdPTKPtBprme1S2IXBIPw+FH30NrwuuIHv+wJ+u7NMw+t2uSaNWlN9wUAfJWNajgZK
         y4P0Nf1AtH6Gk9mEB7dhMCUorhaW7EJZTO1fQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dDhM0qwwryuViNWNx8Hxpg5zZTF9a+dZ1IO/v6pGa+Q=;
        b=ib9hmFFkVqXPYRkIsPvyDmLAnpbY1Qzn+SSfGheBzv5+LMoxlw4PUC+XGxAqwdEE6n
         MjECSNL7iFRjPDe4NCdsCXSYQxolonm/2iXlrSSP9+ZEbxHbgydxUFPF3sjUNL9++GPT
         zrJ8pffiCHS6OPydvl3Le+2uCmwA0ALZGO2/7b4p3kHqArSUx5CrsFwB7sdSbpii8U6L
         awv3chDSVAjlnN+3mexjVXGLr88ImAyqw+BVNQelOZzcynTACB/gIR/OywWOsictlTcr
         vvu+365unjIDuREo8vjPzmXNMujODiqCYlJ9meqW/TGI5NCN94Mgn8OGzN9OfETE2yyP
         taDA==
X-Gm-Message-State: AOUpUlEwe/yy+FFZKjFBhS/3QjA+ctnzMsFC/JcZBL/JMzT8ljA6xyR3
        YutzcTk2QmjdlBLJVU1nwTBYEQ==
X-Google-Smtp-Source: AA+uWPxrzF2P+N7FLvBQyI8Ah2pdOCoAOOlEDvdB0oJ7o5LmtCv3hY4OR6LS8T8NOMg8YdmSb1QhfQ==
X-Received: by 2002:a19:db94:: with SMTP id t20-v6mr30794377lfi.126.1534838384709;
        Tue, 21 Aug 2018 00:59:44 -0700 (PDT)
Received: from [172.16.11.40] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id y85-v6sm2199727lfi.46.2018.08.21.00.59.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 00:59:44 -0700 (PDT)
Subject: Re: [RFC][PATCH] lib/string: introduce sysfs_strncpy() and
 sysfs_strlcpy()
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Martin Wilck <mwilck@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
References: <20180821062459.1807-1-sergey.senozhatsky@gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <0e06858f-3625-692a-582d-d828a3cc3ebe@rasmusvillemoes.dk>
Date:   Tue, 21 Aug 2018 09:59:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180821062459.1807-1-sergey.senozhatsky@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-21 08:24, Sergey Senozhatsky wrote:
> +/**
> + * sysfs_strncpy - Trim a length-limited C-string (wgutesoaces and a trailing
> + *                 newline symbol) and copy into a buffer
> + * @dest: Where to copy the string to
> + * @src: Where to copy the string from
> + * @count: The maximum number of bytes to copy
> + *
> + * A wrapper around strncpy().
> + *
> + */
> +char *sysfs_strncpy(char *dest, const char *src, size_t count)
> +{
> +	char *c;
> +
> +	strncpy(dest, skip_spaces(src), count);

I'd like to see where and how you'd use this, but I'm very skeptical of
count being used both for the size of the dest buffer as well as an
essentially random argument to strncpy - if count is also the maximum
number of bytes to read from the src, you'd need to take the
skip_spaces() into account, because there are not count bytes left after
that... And if src is not necessarily nul-terminated, skip_spaces() by
itself is wrong.

Moreover, I don't think we should add more users or wrappers for strncpy
- I highly doubt the sysfs users you have in mind want the "fill the
rest of the buffer with '\0'" nor the "not enough room for a terminating
'\0'? Oh well, what could possibly go wrong" semantics.

> +	c = dest + count - 1;
> +	while (c >= dest && (isspace(*c) || *c == '\n' || *c == '\0')) {

nit: '\n' certainly already passes the isspace() test.

> +		*c = '\0';
> +		c--;
> +	}
> +	return dest;
> +}
> +EXPORT_SYMBOL(sysfs_strncpy);
> +
> +/**
> + * sysfs_strlcpy - Trim a C-string (whitespaces and a trailing newline symbol)
> + *                 and copy it into a sized buffer
> + * @dest: Where to copy the string to
> + * @src: Where to copy the string from
> + * @size: size of destination buffer
> + *
> + * A wrapper around strlcpy().
> + *
> + */
> +size_t sysfs_strlcpy(char *dest, const char *src, size_t size)
> +{
> +	size_t ret;
> +	char *c;
> +
> +	ret = strlcpy(dest, skip_spaces(src), size);
> +
> +	size = strlen(dest);
> +	c = dest + size - 1;
> +	while (c >= dest && (isspace(*c) || *c == '\n'))
> +		c--;
> +	*(c + 1) = '\0';
> +	return ret;
> +}

What exactly is the return value? The string length of the src after
skipping leading whitespace? What does that really have to do with the
string now in dest, and what is the user supposed to do with it? A more
useful return value would either be "the length of the string now in
dest", or some sort of indicator that the input was truncated, if that
is ever possible.

I think you're too focused on making wrappers around str[ln]cpy
preserving parts of those functions' API. Instead, try to figure out
what sysfs users actually want, name the functions after that, and then
whether they use strncpy or sprintf or strscpy internally is completely
irrelevant.

Maybe

int strcpy_trim(char *dst, size_t dstsize, const char *src, size_t
srcsize) - copy (potentially not '\0'-terminated) src to dst, trimming
leading and trailing whitespace. dstsize must be positive, and dst is
guaranteed to be '\0'-terminated. Returns the length of the string now
in dst, or -EOVERFLOW if some none-whitespace character was chopped.

would cover all use cases?

Rasmus
