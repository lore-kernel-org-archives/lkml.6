Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAA9C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 07:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E954220C03
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 07:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="QdBpDpB6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E954220C03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbeHTKui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 06:50:38 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36343 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbeHTKuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 06:50:37 -0400
Received: by mail-lj1-f194.google.com with SMTP id u7-v6so10814359lji.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 00:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BH66WabL7OyAbi2Zn7VrVIZdTp0G3cBXQf3ukYai08g=;
        b=QdBpDpB6cjGGnfxIvOs9eBuBL3vREBaxxbRNK3mSPlz2LOskwe3sZD3iysnALer5BK
         paAak//sC/5J8Qq82wk1UMSa8ZLRtussChKQQTFK4U4MkZMO7aFRC9t/U64HRCDG7ffd
         8QBzEdjCPQAfOwAroMcjwC/dH6ZZVXwRURILA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BH66WabL7OyAbi2Zn7VrVIZdTp0G3cBXQf3ukYai08g=;
        b=mtH9VyyiwGM8iNceHtr/mI8b7Mexx7NZdsnOT85gKbxA72SeqcAOVAwsXgbO+Bx6tj
         WbG4mjgTrwvgJBesCoHCv4Q6PEbji3XyPBimldrozmcqqVJfhsV1wlTd5bMOn6Cy8KL8
         oSmOEHn7psJuII97b9dDQioSJy1d1mpAhOp3MUqu1aa5B1YtWheyxaeRFSd511/0F2qh
         YpqhLiv/hXEzwDVoC0IGFzCSA/m3VXiTeg5KsqZej4mq56epLxPFS7BegBF65sfn4KJO
         r95vvJotH0xqmWC51S6pjg9k7Eef1Wg73CO0nc3KkIgWGyfDLKbpaQ9r/hb7GLjucEMi
         5hvQ==
X-Gm-Message-State: AOUpUlHl3F1Jqup6zs2NmOOGh3b+vqUZOIeguzQbIHQfxdWKdnpb9KA2
        haov659J7hZfLHv6x8ZOu8wZcn6R9W+xPA==
X-Google-Smtp-Source: AA+uWPwT4PHl9vMI29L1lmWR16z5Y9SWnhglyZUj7F00cYuYMj1LNylKM4ZTcmPDS6DxvAWKzb6/yQ==
X-Received: by 2002:a2e:9599:: with SMTP id w25-v6mr7673492ljh.6.1534750563309;
        Mon, 20 Aug 2018 00:36:03 -0700 (PDT)
Received: from [172.16.11.40] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id z21-v6sm1471503ljb.59.2018.08.20.00.36.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 00:36:02 -0700 (PDT)
Subject: Re: [PATCH 6/7] lib/bitmap.c: fix remaining space computation in
 bitmap_print_to_pagebuf
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180818131623.8755-1-linux@rasmusvillemoes.dk>
 <20180818131623.8755-7-linux@rasmusvillemoes.dk>
 <CAHp75VcLbbyJ5ir=CPxMp1O_ULZx5WyWq4sbDL2OBO5kg843vw@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <238a1f81-03f3-19cf-86a9-2a36af0e8093@rasmusvillemoes.dk>
Date:   Mon, 20 Aug 2018 09:36:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VcLbbyJ5ir=CPxMp1O_ULZx5WyWq4sbDL2OBO5kg843vw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-19 14:37, Andy Shevchenko wrote:
> On Sat, Aug 18, 2018 at 4:17 PM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>>  int bitmap_print_to_pagebuf(bool list, char *buf, const unsigned long *maskp,
>>                             int nmaskbits)
>>  {
>> -       ptrdiff_t len = PTR_ALIGN(buf + PAGE_SIZE - 1, PAGE_SIZE) - buf;
>> +       ptrdiff_t len = PAGE_SIZE - ((unsigned long)buf & (PAGE_SIZE-1));
> 
> Don't we have offset_in_page() helper macro?

Indeed, thanks! Andrew, if you pick this up, can you use the much more
obvious

PAGE_SIZE - offset_in_page(buf)

instead? bitmap.c already (unsurprisingly) includes mm.h through some
recursive path.

Rasmus
