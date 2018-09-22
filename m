Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096FEECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 15:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC12020C0A
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 15:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pgp4XbLS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC12020C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbeIVVm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 17:42:59 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:35114 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbeIVVm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 17:42:59 -0400
Received: by mail-yw1-f67.google.com with SMTP id 14-v6so6382810ywe.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Sep 2018 08:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=feHpblfTImGvlf9+35jXQhQuP/j6SjiAxAIh2JsTDks=;
        b=Pgp4XbLSqI7L06PANKddKm4CuCb8EgKA6MfjlNCxXtdEv8vdtUGTqC61GG+ZWrZeQZ
         nh8Y2nlMUu/BIfLitxL1fs5WRRfKyzR6egJGDtMnhWmy9Udr9StalcMNHiT8dSq0m/9r
         jOd79ZpfgIMg4Z9q2zVuamEVWL512RFJLI4mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=feHpblfTImGvlf9+35jXQhQuP/j6SjiAxAIh2JsTDks=;
        b=q40VciiPlhIX3uCHJWay50yrSCECgQdjIzsNGFYm3Pxt5u7Co8+7EmgEs2rCnt01V0
         tVO6WYQqhnPykv0Z9KcYVmqw3/OYJsmhoxiN9aeMqtzgQDaT6B5weAGqIyegFYx5OlGl
         h/06GAUQAdPRDHnoKnXSeG0HdLLerepdeTb4yhUAY8LWiBfNTEU5VJpUs1CdUP2eZF72
         n8Yn33ll7QWf9ewGYipQBeLPzYzL2lyB+l9ad/Iwx2bnqcBK+r9fGjqft6p5LYxI68ky
         oPxxfDpgevhCAMC7nmx2gu/4z8eRrKgbJkfjtNkA+7ICU0EMsOpEXhMMdswRRl968U3i
         qAiA==
X-Gm-Message-State: ABuFfoi5B5jXvbqAVcgjkuFmd58lnXyeiQO+ZoUNzDfvnKQWRbL5eTbu
        blrgBJbF7gYzyyaWoI5o3YusBfKgV4Y=
X-Google-Smtp-Source: ANB0VdZdFCKQ+4HfAyndp7DpFIeeXx8xxoMFbXtYCYUWvaA4XrGBGZDx2GQvpUd791Vtr49eyGrzlg==
X-Received: by 2002:a81:2e95:: with SMTP id u143-v6mr1164027ywu.424.1537631336967;
        Sat, 22 Sep 2018 08:48:56 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id b2-v6sm5583532ywd.48.2018.09.22.08.48.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 08:48:54 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 184-v6so6693788ybg.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Sep 2018 08:48:54 -0700 (PDT)
X-Received: by 2002:a25:396:: with SMTP id 144-v6mr1272573ybd.403.1537631333748;
 Sat, 22 Sep 2018 08:48:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Sat, 22 Sep 2018 08:48:53
 -0700 (PDT)
In-Reply-To: <20180913104629.5179-4-fanc.fnst@cn.fujitsu.com>
References: <20180913104629.5179-1-fanc.fnst@cn.fujitsu.com> <20180913104629.5179-4-fanc.fnst@cn.fujitsu.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Sat, 22 Sep 2018 08:48:53 -0700
X-Gmail-Original-Message-ID: <CAGXu5jK13F7EY--zAVWq-=P2-Lt7n-K05ctL-vH7S=rcWKQoOw@mail.gmail.com>
Message-ID: <CAGXu5jK13F7EY--zAVWq-=P2-Lt7n-K05ctL-vH7S=rcWKQoOw@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] x86/boot/KASLR: Limit kaslr to choosing the
 immovable memory
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 3:46 AM, Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
> If CONFIG_MEMORY_HOTREMOVE enabled and the amount of immovable
> memory regions is not zero. Calculate the intersection between memory
> regions from e820/efi memory table and immovable memory regions.
>
> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> ---
>  arch/x86/boot/compressed/kaslr.c | 71 +++++++++++++++++++++++++++-----
>  1 file changed, 60 insertions(+), 11 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index 0c3567bc231c..0a7ef2daf169 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -101,6 +101,11 @@ static bool memmap_too_large;
>  /* Store memory limit specified by "mem=nn[KMG]" or "memmap=nn[KMG]" */
>  static unsigned long long mem_limit = ULLONG_MAX;
>
> +#ifdef CONFIG_MEMORY_HOTREMOVE
> +/* Store the immovable memory regions */
> +extern struct mem_vector immovable_mem[MAX_NUMNODES*2];
> +#endif
> +
>
>  enum mem_avoid_index {
>         MEM_AVOID_ZO_RANGE = 0,
> @@ -577,9 +582,9 @@ static unsigned long slots_fetch_random(void)
>         return 0;
>  }
>
> -static void process_mem_region(struct mem_vector *entry,
> -                              unsigned long minimum,
> -                              unsigned long image_size)
> +static void slots_count(struct mem_vector *entry,
> +                       unsigned long minimum,
> +                       unsigned long image_size)
>  {
>         struct mem_vector region, overlap;
>         unsigned long start_orig, end;
> @@ -655,6 +660,56 @@ static void process_mem_region(struct mem_vector *entry,
>         }
>  }
>
> +static bool process_mem_region(struct mem_vector *region,
> +                              unsigned long long minimum,
> +                              unsigned long long image_size)
> +{
> +       int i;
> +       /*
> +        * If no immovable memory found, or MEMORY_HOTREMOVE disabled,
> +        * walk all the regions, so use region directely.
> +        */
> +       if (num_immovable_mem == 0) {
> +               slots_count(region, minimum, image_size);
> +
> +               if (slot_area_index == MAX_SLOT_AREA) {
> +                       debug_putstr("Aborted e820/efi memmap scan (slot_areas full)!\n");
> +                       return 1;
> +               }
> +               return 0;
> +       }
> +
> +#ifdef CONFIG_MEMORY_HOTREMOVE
> +       /*
> +        * If immovable memory found, filter the intersection between
> +        * immovable memory and region to slots_count.
> +        * Otherwise, go on old code.
> +        */
> +       for (i = 0; i < num_immovable_mem; i++) {
> +               struct mem_vector entry;
> +               unsigned long long start, end, entry_end, region_end;
> +
> +               start = immovable_mem[i].start;
> +               end = start + immovable_mem[i].size;
> +               region_end = region->start + region->size;
> +
> +               entry.start = clamp(region->start, start, end);
> +               entry_end = clamp(region_end, start, end);
> +
> +               if (entry.start + image_size < entry_end) {

Can this logic be rewritten to use the existing mem_overlaps() check
instead? I think that would make it much more readable.

Otherwise, yes, this all looks fine.

-Kees

> +                       entry.size = entry_end - entry.start;
> +                       slots_count(&entry, minimum, image_size);
> +
> +                       if (slot_area_index == MAX_SLOT_AREA) {
> +                               debug_putstr("Aborted e820/efi memmap scan (slot_areas full)!\n");
> +                               return 1;
> +                       }
> +               }
> +       }
> +       return 0;
> +#endif
> +}
> +
>  #ifdef CONFIG_EFI
>  /*
>   * Returns true if mirror region found (and must have been processed
> @@ -720,11 +775,8 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
>
>                 region.start = md->phys_addr;
>                 region.size = md->num_pages << EFI_PAGE_SHIFT;
> -               process_mem_region(&region, minimum, image_size);
> -               if (slot_area_index == MAX_SLOT_AREA) {
> -                       debug_putstr("Aborted EFI scan (slot_areas full)!\n");
> +               if (process_mem_region(&region, minimum, image_size))
>                         break;
> -               }
>         }
>         return true;
>  }
> @@ -751,11 +803,8 @@ static void process_e820_entries(unsigned long minimum,
>                         continue;
>                 region.start = entry->addr;
>                 region.size = entry->size;
> -               process_mem_region(&region, minimum, image_size);
> -               if (slot_area_index == MAX_SLOT_AREA) {
> -                       debug_putstr("Aborted e820 scan (slot_areas full)!\n");
> +               if (process_mem_region(&region, minimum, image_size))
>                         break;
> -               }
>         }
>  }
>
> --
> 2.17.1
>
>
>



-- 
Kees Cook
Pixel Security
