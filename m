Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562D4C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0515B2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HAIqic0z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0515B2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbeJYTgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:36:39 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38429 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbeJYTgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:36:38 -0400
Received: by mail-ot1-f66.google.com with SMTP id l1so8682875otj.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 04:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GiYeJ0fu3Rb+xAfppx9URTKVBMbdBGdZ7pIhWmWLkPg=;
        b=HAIqic0zKAgkfd/VBFZMiKbS2vuFUilMEwTE7FJwBqVO+TNDVKxKIfqVI+L7fcJ9uH
         RWrjISAxPm+ELcskx/uWzJYsN624C9W/kWI9F0AEbukzoMg/F9d+C4yhgLXQVlpwZDRS
         PbQmy1mLAdzUL7Fpu+fvt41A3Rgxj/S3ixy0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GiYeJ0fu3Rb+xAfppx9URTKVBMbdBGdZ7pIhWmWLkPg=;
        b=l6ZTIkzYtNe1VbQzucLA5VtnupCwxv3WinghLsm+M9d6xv26o9e0Miki8WB1RukIQC
         yzKCMwCw3xQ37k7lO3eZdWR9tSA8fv5Dx364RG8OCW+xz/gesGYeTYRxpUpB/aI9pGbB
         VV7LqbmaXOlpmZjm7S2vxAXwMTXlo/+SfFUUTuQEl2cvpqv2+VQn8HOdrQHfiywBzW6R
         Me/3s+RRnBMs/zawl4EdC54zx7yEvmOvGLJj8O6i4323m7wXa+eG0CJbdZm2+YyTftLW
         DsfqTZTejNUtnLBPcpPiZDVm89VI6D/MPv5369PpMabGcIrgU6bZ7Cr4BVl5qxt0zRpg
         0e9A==
X-Gm-Message-State: AGRZ1gIcMCXfRK54XYiFQaoTffpSFlku7kXKvZGh7fqheyI9G34YTL6a
        hP4yXLJ+bKmyewssAXckdJxO2k1GjPwaJg==
X-Google-Smtp-Source: AJdET5cq0tajJfg8TmyBMW3gkdqL0DaJu6bPnQWfiNaqcZY8VK9SuqcqVfl7yK5V4eZA7b9Oap/qPA==
X-Received: by 2002:a9d:66f:: with SMTP id 102mr1114604otn.308.1540465461867;
        Thu, 25 Oct 2018 04:04:21 -0700 (PDT)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com. [209.85.210.46])
        by smtp.gmail.com with ESMTPSA id w17sm2444839oth.1.2018.10.25.04.04.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 04:04:20 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id p23so8660015otf.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 04:04:19 -0700 (PDT)
X-Received: by 2002:a9d:5a0e:: with SMTP id v14mr1064196oth.189.1540465459338;
 Thu, 25 Oct 2018 04:04:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:2056:0:0:0:0:0 with HTTP; Thu, 25 Oct 2018 04:03:47
 -0700 (PDT)
In-Reply-To: <20181025052901.GA17799@jagdpanzerIV>
References: <20181025012745.20884-1-rafael.tinoco@linaro.org> <20181025052901.GA17799@jagdpanzerIV>
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
Date:   Thu, 25 Oct 2018 08:03:47 -0300
X-Gmail-Original-Message-ID: <CABdQkv-wPbgXh-QCJHChguvYsEhgom8M195G+H3GRgButSqMww@mail.gmail.com>
Message-ID: <CABdQkv-wPbgXh-QCJHChguvYsEhgom8M195G+H3GRgButSqMww@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/zsmalloc.c: check encoded object value overflow
 for PAE
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Rafael David Tinoco <rafael.tinoco@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, Russell King <linux@armlinux.org.uk>,
        Mark Brown <broonie@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 2:29 AM, Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
> On (10/24/18 22:27), Rafael David Tinoco wrote:
>>  static unsigned long location_to_obj(struct page *page, unsigned int obj_idx)
>>  {
>> -     unsigned long obj;
>> +     unsigned long obj, pfn;
>> +
>> +     pfn = page_to_pfn(page);
>> +
>> +     if (unlikely(OBJ_OVERFLOW(pfn)))
>> +             BUG();
>
> The trend these days is to have less BUG/BUG_ON-s in the kernel.
>
>         -ss

For this case, IMHO, it is worth.

It will avoid a investigation like:
https://bugs.linaro.org/show_bug.cgi?id=3765#c7 and and #c8, where I
had to poison slab allocation - to force both zs_handle and zspage
slabs not to be merged - and to make sure the zspage slab had a good
magic number AND to identify why the bad paging request happened.

If this happens again, for any other arch supporting PAE that does not
declare MAX_POSSIBLE_PHYSMEM_BITS or MAX_PHYSMEM_BITS appropriately,
the kernel will panic, no matter what, by the time it reaches
obj_to_location(). Things can be more complicated about declarations
for PAE if we consider ARM can declare MAX_PHYSMEM_BITS differently in
arch/arm/mach-XXX and/or, for this case, when having, or not SPARSEMEM
set (if I had SPARSEMEM set I would not face this, for example).

If this occurs, the kernel will panic, no matter what, by the time it
reaches obj_to_location()... so why not to BUG() here and let user to
know exactly where it panic-ed and why ? Other option would be to
WARN() here and let it panic naturally because of bad paging request
in a very near future... please advise.

Thanks,
Best Rgds
-Rafael
