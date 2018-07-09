Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAF5C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A4F20881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:54:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0A4F20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932674AbeGILyW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:54:22 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57884 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932469AbeGILyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:54:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3FFE7A9;
        Mon,  9 Jul 2018 04:54:20 -0700 (PDT)
Received: from [10.1.210.23] (e110467-lin.cambridge.arm.com [10.1.210.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A88B3F318;
        Mon,  9 Jul 2018 04:54:20 -0700 (PDT)
Subject: Re: a question about IP checksum helper for arm64
To:     Bo Yan <byan@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, luke.starrett@broadcom.com
References: <141d76cc-d43b-5412-fb39-426d7c2261b9@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <6a3e91ff-ce9f-8120-732e-a33dad6d0146@arm.com>
Date:   Mon, 9 Jul 2018 12:54:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <141d76cc-d43b-5412-fb39-426d7c2261b9@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bo,

On 06/07/18 17:27, Bo Yan wrote:
> Hi Robin, Luke,
> 
> Recently I bumped into an error when running GCC undefined behavior 
> sanitizer:
> 
> UBSAN: Undefined behaviour in 
> kernel-4.9/arch/arm64/include/asm/checksum.h:34:6
>         load of misaligned address ffffffc198c8b254 for type 'const 
> __int128 unsigned'
>         which requires 16 byte alignment

What's your config and reproducer here? I've had UBSan enabled a few 
times since that patch went in and never noticed anything. I've just 
tried it with 4.18-rc3 and indeed don't see anything from just booting 
the machine and making some network traffic. It does indeed fire if I 
also turn on CONFIG_UBSAN_ALIGNMENT, but then it's almost lost among a 
million other warnings for all manner of types - that's to be expected 
since, as the help text says, "Enabling this option on architectures 
that support unaligned accesses may produce a lot of false positives."

> 
> The relevant code:
> 
>          tmp = *(const __uint128_t *)iph;
>          iph += 16;
>          ihl -= 4;
>          tmp += ((tmp >> 64) | (tmp << 64));
>          sum = tmp >> 64;
>          do {
>                  sum += *(const u32 *)iph;
>                  iph += 4;
>          } while (--ihl);
> 
> But, I checked the generated disassembly, it doesn't look like anything 
> special is generated taking advantage of that.
> 
> I'm using Linaro GCC 6.4-2017.08, expecting ldp instructions to be 
> emitted, but don't see it.

My regular toolchain is currently Linaro 7.2.1-2017.11, but I also tried 
the last GCC 6 I had installed (6.3.1-2017.05), and for both at -O2 I 
see LDP emitted as expected for most of the identifiable int128 accesses 
(both in a standalone test harness and a quick survey of kernel code via 
'aarch64-linux-gnu-objdump -S net/ipv4/*.o'). Of course, there may well 
be places where the compiler gets clever enough to elide all or part of 
that load where data is already held in registers - I've not audited 
*that* closely - but the whole point of having a pure C implementation 
is that it can be aggressively inlined more than inline asm ever could.

> There were some prior discussions about GCC behavior, like this thread: 
> https://patchwork.kernel.org/patch/9081911/ , in which you talked about 
> the difference between GCC4 and GCC5.3. It looks to me this is regressed 
> in Linaro GCC6.4 build.
> 
> I have not checked newer GCC versions.
> 
> Will it be more stable to just do this with inline assembly instead of 
> relying on __uint128_t data type?
> 
> GCC documentation says __int128 is supported for targets which have an 
> integer mode wide enough to hold 128 bits. aarch64 doesn't have such an 
> integer mode.

Yet AArch64 GCC definitely does support __uint128_t, or this code 
wouldn't even build ;)

Robin.

> 
> Thanks
> 
> Bo
