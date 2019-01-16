Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C836C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4034220859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="LH36R7JF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732445AbfAPLPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:15:14 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49710 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728612AbfAPLPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:15:14 -0500
Received: from zn.tnic (p200300EC2BC98A0074F02E32486DBF81.dip0.t-ipconnect.de [IPv6:2003:ec:2bc9:8a00:74f0:2e32:486d:bf81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E977C1EC0570;
        Wed, 16 Jan 2019 12:15:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547637313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=VTQcpgdPysbG/e4v7TklNTVNwYJfHF4P/ABZxargYos=;
        b=LH36R7JFK76zT08fTP1mEGzGseKZ2wUkEP0ITuOoWWovdrnzUlddrHsIhZbD2mh9VdVfy2
        ljy+rS54kFO8Dzkl5Dv/sI8pWWbUWpD6nPxggZf6Z83tEpGcP+v0we4BxEjcSXgP1Gr0//
        bQE0bB50m9ZYm7QiudqUao2XSVBcBcg=
Date:   Wed, 16 Jan 2019 12:15:07 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, keescook@chromium.org,
        bhe@redhat.com, msys.mizuma@gmail.com, indou.takao@jp.fujitsu.com,
        caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v15 6/6] x86/boot/KASLR: Limit KASLR to extracting kernel
 in immovable memory
Message-ID: <20190116111507.GD15409@zn.tnic>
References: <20190107032243.25324-1-fanc.fnst@cn.fujitsu.com>
 <20190107032243.25324-7-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190107032243.25324-7-fanc.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 11:22:43AM +0800, Chao Fan wrote:
> KASLR may randomly choose some positions which are located in movable
> memory regions. It will break memory hotplug feature and make the
> movable memory chosen by KASLR can't be removed.
> 
> The solution is to limit KASLR to choose memory regions in immovable
> node according to SRAT tables.
> When CONFIG_EARLY_SRAT_PARSE is enabled, walk through SRAT to get the
> information of immovable memory so that KASLR knows where should be
> chosen for randomization.
> 
> Rename process_mem_region() as __process_mem_region() and name new
> function as process_mem_region().

The commit message doesn't need to contain *what* you're doing in the
patch.

> 
> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> ---
>  arch/x86/boot/compressed/kaslr.c | 79 +++++++++++++++++++++++++++-----
>  1 file changed, 68 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index b251572e77af..7dbec6910203 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -97,6 +97,15 @@ static bool memmap_too_large;
>  /* Store memory limit specified by "mem=nn[KMG]" or "memmap=nn[KMG]" */
>  static unsigned long long mem_limit = ULLONG_MAX;
>  
> +#ifdef CONFIG_EARLY_SRAT_PARSE
> +/*
> + * Information of immovable memory regions.
> + * Max amount of memory regions is MAX_NUMNODES*2, so need such array
> + * to place immovable memory regions if all of the memory is immovable.
> + */

Why is that comment repeated here?

> +extern struct mem_vector immovable_mem[MAX_NUMNODES*2];
> +#endif
> +
>  
>  enum mem_avoid_index {
>  	MEM_AVOID_ZO_RANGE = 0,
> @@ -413,6 +422,9 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
>  	/* Mark the memmap regions we need to avoid */
>  	handle_mem_options();
>  
> +	/* Mark the immovable regions we need to choose */
> +	get_immovable_mem();

get != mark.

Which should tell you that the function name needs changing.

Also, this function is void and it could very well return
num_immovable_mem and num_immovable_mem can be a static variable in
kaslr.c instead of sloppily adding yet another global one.

> +
>  #ifdef CONFIG_X86_VERBOSE_BOOTUP
>  	/* Make sure video RAM can be used. */
>  	add_identity_map(0, PMD_SIZE);
> @@ -568,9 +580,9 @@ static unsigned long slots_fetch_random(void)
>  	return 0;
>  }
>  
> -static void process_mem_region(struct mem_vector *entry,
> -			       unsigned long minimum,
> -			       unsigned long image_size)
> +static void __process_mem_region(struct mem_vector *entry,
> +				 unsigned long minimum,
> +				 unsigned long image_size)
>  {
>  	struct mem_vector region, overlap;
>  	unsigned long start_orig, end;
> @@ -646,6 +658,57 @@ static void process_mem_region(struct mem_vector *entry,
>  	}
>  }
>  
> +static bool process_mem_region(struct mem_vector *region,
> +			       unsigned long long minimum,
> +			       unsigned long long image_size)
> +{
> +	int i;
> +	/*
> +	 * If no immovable memory found, or MEMORY_HOTREMOVE disabled,
> +	 * walk all the regions, so use region directly.
> +	 */
> +	if (!num_immovable_mem) {
> +		__process_mem_region(region, minimum, image_size);
> +
> +		if (slot_area_index == MAX_SLOT_AREA) {
> +			debug_putstr("Aborted e820/efi memmap scan (slot_areas full)!\n");
> +			return 1;
> +		}
> +		return 0;
> +	}
> +
> +#ifdef CONFIG_EARLY_SRAT_PARSE
> +	/*
> +	 * If immovable memory found, filter the intersection between
> +	 * immovable memory and region to __process_mem_region().
> +	 * Otherwise, go on old code.
> +	 */
> +	for (i = 0; i < num_immovable_mem; i++) {
> +		unsigned long long start, end, entry_end, region_end;
> +		struct mem_vector entry;
> +
> +		if (!mem_overlaps(region, &immovable_mem[i]))
> +			continue;
> +
> +		start = immovable_mem[i].start;
> +		end = start + immovable_mem[i].size;
> +		region_end = region->start + region->size;
> +
> +		entry.start = clamp(region->start, start, end);
> +		entry_end = clamp(region_end, start, end);
> +		entry.size = entry_end - entry.start;
> +
> +		__process_mem_region(&entry, minimum, image_size);
> +
> +		if (slot_area_index == MAX_SLOT_AREA) {
> +			debug_putstr("Aborted e820/efi memmap scan (slot_areas full)!\n");

Change this error message a bit to differ from the above for easier debugging.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
