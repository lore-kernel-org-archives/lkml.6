Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38699C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E7420878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="L5DL+RF7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9E7420878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeJBOYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:24:46 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39927 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbeJBOYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:24:46 -0400
Received: by mail-lf1-f66.google.com with SMTP id w21-v6so686447lff.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 00:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Yy3tWEV24OJmqGeTEeNUzgpjwd59c6tb4SjZY7nGfJE=;
        b=L5DL+RF7lYyNHzOmQj99BhjK4JvB6mn3UzBRAIIH6RUz+QVpMtgRphDFKWC2yMnEIM
         dco+gYoxqIGXigC4DISDVvZaQFiaqdIts+b2z84HhDHHa374y6TAesj+GsQa9l/yV2DC
         gAru37IQC/e1zk2riCmxOng3fnWfzMf+mZZt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yy3tWEV24OJmqGeTEeNUzgpjwd59c6tb4SjZY7nGfJE=;
        b=lTZi55tFajFOj0ISZ0xkuMpIz9anRi3DjGlq/1L4skxdGueUY6ZUSCLxIaK8LUaUtU
         pJGVxjU873x8YQtfjTtPUpLZrXFG6K6gwMfdeFhtIckw/ZrmoOKHvaNiLBd8Al7fVtON
         gYzzG+EZ4HscnuncUFrmW8wUaVvurN4ggjDH1ybgrNh0dVhldhWILh4B2VnfqgIKS63q
         8jzTVFqb1DYRR1Aar5C/DXXCgqco2M+4tnl/rwdfnoWE0zU5PzIF9mcK216kgd9H/OQ+
         ySr6VsaaIBXuYbOSWAeTzfQzrrHXdA3+4iLtjVjtQ51wlhKOTCUgQYRhYcDU+SS+0Hp3
         1UAQ==
X-Gm-Message-State: ABuFfoh9OsqTrJirhlLq5N/QTpaMnstPE0Ehl6kf6Hss926WyFqSdhQ5
        O/qjm5EgDRff6ASk902JUSr73A==
X-Google-Smtp-Source: ACcGV61MCuw9o0WrIgUpBty8vDZDxc9LeIs9QZFsGjIzcGA4YXzznj+IpN047acQwnLebSEEsMaH2w==
X-Received: by 2002:a19:c20e:: with SMTP id l14-v6mr7336742lfc.113.1538466169937;
        Tue, 02 Oct 2018 00:42:49 -0700 (PDT)
Received: from [172.16.11.40] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id v85-v6sm2971639lfa.18.2018.10.02.00.42.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 00:42:49 -0700 (PDT)
Subject: Re: [RESEND PATCH v4 1/8] bitops: Introduce the for_each_set_clump
 macro
To:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        linus.walleij@linaro.org, akpm@linux-foundation.org
Cc:     linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        Arnd Bergmann <arnd@arndb.de>
References: <cover.1538441919.git.vilhelm.gray@gmail.com>
 <f5250b9c78377e476667be1b616c86cf573b57dc.1538441919.git.vilhelm.gray@gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <40ecad49-2797-0d30-b52d-a2e6838dc1ab@rasmusvillemoes.dk>
Date:   Tue, 2 Oct 2018 09:42:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f5250b9c78377e476667be1b616c86cf573b57dc.1538441919.git.vilhelm.gray@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-02 03:13, William Breathitt Gray wrote:
> This macro iterates for each group of bits (clump) with set bits, within
> a bitmap memory region. For each iteration, "clump" is set to the found
> clump index, "index" is set to the word index of the bitmap containing
> the found clump, and "offset" is set to the bit offset of the found
> clump within the respective bitmap word.

I can't say I'm a fan. It seems rather clumsy and ad-hoc - though I do
see how it matches the code you replace in drivers/gpio/. When I
initially read the cover letter, I assumed that one would get a sequence
of 4-bit values, but one has to dig the actual value out of the bitmap
afterwards using all of index, offset and a mask computed from clump_size.

> +
> +/**
> + * find_next_clump - find next clump with set bits in a memory region
> + * @index: location to store bitmap word index of found clump
> + * @offset: bits offset of the found clump within the respective bitmap word
> + * @bits: address to base the search on
> + * @size: bitmap size in number of clumps

That's a rather inconvenient unit, no? And rather easy to get wrong, I
can easily see people passing nbits instead.

I think you could reduce the number of arguments to this helper and the
macro, while getting rid of some confusion: Drop index and offset, let
clump_index be start_index and measured in bit positions (like
find_next_bit et al), and let the return value also be a bit position.
And instead of index and offset, have another unsigned long* output
parameter that gives the actual value at [return value:return
value+clump_size]. IOW, I think the prototype should be close to
find_next_bit, except that in case of "clumps", there's an extra piece
of information to return.

> + * @clump_index: clump index at which to start searching
> + * @clump_size: clump size in bits
> + *
> + * Returns the clump index for the next clump with set bits; the respective
> + * bitmap word index is stored at the location pointed by @index, and the bits
> + * offset of the found clump within the respective bitmap word is stored at the
> + * location pointed by @offset. If no bits are set, returns @size.
> + */
> +size_t find_next_clump(size_t *const index, unsigned int *const offset,
> +		       const unsigned long *const bits, const size_t size,
> +		       const size_t clump_index, const unsigned int clump_size)
> +{
> +	size_t i;
> +	unsigned int bits_offset;
> +	unsigned long word_mask;
> +	const unsigned long clump_mask = GENMASK(clump_size - 1, 0);
> +
> +	for (i = clump_index; i < size; i++) {
> +		bits_offset = i * clump_size;
> +
> +		*index = BIT_WORD(bits_offset);
> +		*offset = bits_offset % BITS_PER_LONG;
> +
> +		word_mask = bits[*index] & (clump_mask << *offset);
> +		if (!word_mask)
> +			continue;

The cover letter says

  The clump_size argument can be an arbitrary number of bits and is not
  required to be a multiple of 2.

by which I assume you mean "power of 2", but either way, the above code
does not seem to take into account the case where bits_offset +
clump_size straddles a word boundary, so it wouldn't work for a
clump_size that does not divide BITS_PER_LONG.

May I suggest another approach:

unsigned long bitmap_get_value(const unsigned long *bitmap, unsigned
start, unsigned width): Get the value of bitmap[start:start+width] for
1<=width<=BITS_PER_LONG (it's up to the caller to ensure this is within
the defined region). That can almost be an inline

bitmap_get_value(const unsigned long *bitmap, unsigned start, unsigned
width)
{
  unsigned idx = BIT_WORD(start);
  unsigned offset = start % BITS_PER_LONG;
  unsigned long lower = bitmap[idx] >> offset;
  unsigned long upper = offset <= BITS_PER_LONG - width ? 0 :
bitmap[idx+1] << (BITS_PER_LONG - offset);
  return (lower | upper) & GENMASK(width-1, 0)
}

Then you can implement the for_each_set_clump by a (IMO) more readable

  for (i = 0, start = 0; i < num_ports; i++, start += gpio_reg_size) {
    word_mask = bitmap_get_value(mask, start, gpio_reg_size);
    if (!word_mask)
      continue;
    ...
  }

Or, if you do want find_next_clump/for_each_set_clump, that can be
implemented in terms of this.

Rasmus
