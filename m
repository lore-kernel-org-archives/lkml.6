Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E482EC65C31
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 15:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87640208E7
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 15:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87640208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbeJFWGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 18:06:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60582 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727595AbeJFWGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 18:06:22 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B34E130820D1;
        Sat,  6 Oct 2018 15:02:43 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E41E02010D55;
        Sat,  6 Oct 2018 15:02:42 +0000 (UTC)
Date:   Sat, 6 Oct 2018 23:02:40 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org, tglx@linutronix.de, thgarnie@google.com,
        corbet@lwn.net, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4/3 v2] x86/mm/doc: Enhance the x86-64 virtual memory
 layout descriptions
Message-ID: <20181006150240.GF5140@MiWiFi-R3L-srv>
References: <20181006084327.27467-1-bhe@redhat.com>
 <20181006122259.GB418@gmail.com>
 <20181006143821.GA72401@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181006143821.GA72401@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Sat, 06 Oct 2018 15:02:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/18 at 04:38pm, Ingo Molnar wrote:
> +Notes:
> +
> + - Negative addresses such as "-23 TB" are absolute addresses in bytes, counted down
> +   from the top of the 64-bit address space. It's easier to understand the layout
> +   when seen both in absolute addresses and in distance-from-top notation.
> +
> +   For example 0xffffe90000000000 == -23 TB, it's 23 TB lower than the top of the
> +   64-bit address space (ffffffffffffffff).
> +
> +   Note that as we get closer to the top of the address space, the notation changes
> +   from TB to GB and then MB/KB.
> +
> + - "16M TB" might look weird at first sight, but it's an easier to visualize size
> +   notation than "16 EB", which few will recognize at first sight as 16 exabytes.
> +   It also shows it nicely how incredibly large 64-bit address space is.

Thanks, this looks much better than the old version and my change.

Reviewed-by: Baoquan He <bhe@redhat.com>

Thanks
Baoquan
> +
> +========================================================================================================================
> +    Start addr    |   Offset   |     End addr     |  Size   | VM area description
> +========================================================================================================================
> +                  |            |                  |         |
> + 0000000000000000 |    0       | 00007fffffffffff |  128 TB | user-space virtual memory, different per mm
> +__________________|____________|__________________|_________|___________________________________________________________
> +                  |            |                  |         |
> + 0000800000000000 | +128    TB | ffff7fffffffffff | ~16M TB | ... huge, almost 64 bits wide hole of non-canonical
> +                  |            |                  |         |     virtual memory addresses up to the -128 TB
> +                  |            |                  |         |     starting offset of kernel mappings.
> +__________________|____________|__________________|_________|___________________________________________________________
> +                                                            |
> +                                                            | Kernel-space virtual memory, shared between all processes:
> +____________________________________________________________|___________________________________________________________
> +                  |            |                  |         |
> + ffff800000000000 | -128    TB | ffff87ffffffffff |    8 TB | ... guard hole, also reserved for hypervisor
> + ffff880000000000 | -120    TB | ffffc7ffffffffff |   64 TB | direct mapping of all physical memory (page_offset_base)
> + ffffc80000000000 |  -56    TB | ffffc8ffffffffff |    1 TB | ... unused hole
> + ffffc90000000000 |  -55    TB | ffffe8ffffffffff |   32 TB | vmalloc/ioremap space (vmalloc_base)
> + ffffe90000000000 |  -23    TB | ffffe9ffffffffff |    1 TB | ... unused hole
> + ffffea0000000000 |  -22    TB | ffffeaffffffffff |    1 TB | virtual memory map (vmemmap_base)
> + ffffeb0000000000 |  -21    TB | ffffebffffffffff |    1 TB | ... unused hole
> + ffffec0000000000 |  -20    TB | fffffbffffffffff |   16 TB | KASAN shadow memory
> + fffffc0000000000 |   -4    TB | fffffdffffffffff |    2 TB | ... unused hole
> +                  |            |                  |         | vaddr_end for KASLR
> + fffffe0000000000 |   -2    TB | fffffe7fffffffff |  0.5 TB | cpu_entry_area mapping
> + fffffe8000000000 |   -1.5  TB | fffffeffffffffff |  0.5 TB | LDT remap for PTI
> + ffffff0000000000 |   -1    TB | ffffff7fffffffff |  0.5 TB | %esp fixup stacks
> +__________________|____________|__________________|_________|____________________________________________________________
> +                                                            |
> +                                                            | Identical layout to the 47-bit one from here on:
> +____________________________________________________________|____________________________________________________________
> +                  |            |                  |         |
> + ffffff8000000000 | -512    GB | ffffffeeffffffff |  444 GB | ... unused hole
> + ffffffef00000000 |  -68    GB | fffffffeffffffff |   64 GB | EFI region mapping space
> + ffffffff00000000 |   -4    GB | ffffffff7fffffff |    2 GB | ... unused hole
> + ffffffff80000000 |   -2    GB | ffffffff9fffffff |  512 MB | kernel text mapping, mapped to physical address 0
> + ffffffff80000000 |-2048    MB |                  |         |
> + ffffffffa0000000 |-1536    MB | fffffffffeffffff | 1520 MB | module mapping space
> + ffffffffff000000 |  -16    MB |                  |         |
> +    FIXADDR_START | ~-11    MB | ffffffffff5fffff | ~0.5 MB | kernel-internal fixmap range, variable size and offset
> + ffffffffff600000 |  -10    MB | ffffffffff600fff |    4 kB | legacy vsyscall ABI
> + ffffffffffe00000 |   -2    MB | ffffffffffffffff |    2 MB | ... unused hole
> +__________________|____________|__________________|_________|___________________________________________________________
> +
> +
> +====================================================
> +Complete virtual memory map with 5-level page tables
> +====================================================
> +
> +Notes:
> +
> + - With 56-bit addresses, user-space memory gets expanded by a factor of 512x,
> +   from 0.125 PB to 64 PB. All kernel mappings shift down to the -64 PT starting
> +   offset and many of the regions expand to support the much larger physical
> +   memory supported.
> +
> +========================================================================================================================
> +    Start addr    |   Offset   |     End addr     |  Size   | VM area description
> +========================================================================================================================
> +                  |            |                  |         |
> + 0000000000000000 |    0       | 00ffffffffffffff |   64 PB | user-space virtual memory, different per mm
> +__________________|____________|__________________|_________|___________________________________________________________
> +                  |            |                  |         |
> + 0000800000000000 |  +64    PB | ffff7fffffffffff | ~16K PB | ... huge, still almost 64 bits wide hole of non-canonical
> +                  |            |                  |         |     virtual memory addresses up to the -128 TB
> +                  |            |                  |         |     starting offset of kernel mappings.
> +__________________|____________|__________________|_________|___________________________________________________________
> +                                                            |
> +                                                            | Kernel-space virtual memory, shared between all processes:
> +____________________________________________________________|___________________________________________________________
> +                  |            |                  |         |
> + ff00000000000000 |  -64    PB | ff0fffffffffffff |    4 PB | ... guard hole, also reserved for hypervisor
> + ff10000000000000 |  -60    PB | ff8fffffffffffff |   32 PB | direct mapping of all physical memory (page_offset_base)
> + ff90000000000000 |  -28    PB | ff9fffffffffffff |    4 PB | LDT remap for PTI
> + ffa0000000000000 |  -24    PB | ffd1ffffffffffff | 12.5 PB | vmalloc/ioremap space (vmalloc_base)
> + ffd2000000000000 |  -11.5  PB | ffd3ffffffffffff |  0.5 PB | ... unused hole
> + ffd4000000000000 |  -11    PB | ffd5ffffffffffff |  0.5 PB | virtual memory map (vmemmap_base)
> + ffd6000000000000 |  -10.5  PB | ffdeffffffffffff | 2.25 PB | ... unused hole
> + ffdf000000000000 |   -8.25 PB | fffffdffffffffff |   ~8 PB | KASAN shadow memory
> + fffffc0000000000 |   -4    TB | fffffdffffffffff |    2 TB | ... unused hole
> +                  |            |                  |         | vaddr_end for KASLR
> + fffffe0000000000 |   -2    TB | fffffe7fffffffff |  0.5 TB | cpu_entry_area mapping
> + fffffe8000000000 |   -1.5  TB | fffffeffffffffff |  0.5 TB | ... unused hole
> + ffffff0000000000 |   -1    TB | ffffff7fffffffff |  0.5 TB | %esp fixup stacks
> +__________________|____________|__________________|_________|____________________________________________________________
> +                                                            |
> +                                                            | Identical layout to the 47-bit one from here on:
> +____________________________________________________________|____________________________________________________________
> +                  |            |                  |         |
> + ffffff8000000000 | -512    GB | ffffffeeffffffff |  444 GB | ... unused hole
> + ffffffef00000000 |  -68    GB | fffffffeffffffff |   64 GB | EFI region mapping space
> + ffffffff00000000 |   -4    GB | ffffffff7fffffff |    2 GB | ... unused hole
> + ffffffff80000000 |   -2    GB | ffffffff9fffffff |  512 MB | kernel text mapping, mapped to physical address 0
> + ffffffff80000000 |-2048    MB |                  |         |
> + ffffffffa0000000 |-1536    MB | fffffffffeffffff | 1520 MB | module mapping space
> + ffffffffff000000 |  -16    MB |                  |         |
> +    FIXADDR_START | ~-11    MB | ffffffffff5fffff | ~0.5 MB | kernel-internal fixmap range, variable size and offset
> + ffffffffff600000 |  -10    MB | ffffffffff600fff |    4 kB | legacy vsyscall ABI
> + ffffffffffe00000 |   -2    MB | ffffffffffffffff |    2 MB | ... unused hole
> +__________________|____________|__________________|_________|___________________________________________________________
>  
>  Architecture defines a 64-bit virtual address. Implementations can support
>  less. Currently supported are 48- and 57-bit virtual addresses. Bits 63
