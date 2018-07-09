Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4B0C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A322E208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A322E208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933471AbeGITxz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 15:53:55 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:1635 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932893AbeGITxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 15:53:52 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b43bd4d0000>; Mon, 09 Jul 2018 12:53:49 -0700
Received: from HQMAIL108.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 09 Jul 2018 12:53:48 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 09 Jul 2018 12:53:48 -0700
Received: from [172.17.136.14] (172.17.136.14) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 9 Jul
 2018 19:53:51 +0000
Subject: Re: a question about IP checksum helper for arm64
To:     Robin Murphy <robin.murphy@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <luke.starrett@broadcom.com>
References: <141d76cc-d43b-5412-fb39-426d7c2261b9@nvidia.com>
 <6a3e91ff-ce9f-8120-732e-a33dad6d0146@arm.com>
X-Nvconfidentiality: public
From:   Bo Yan <byan@nvidia.com>
Message-ID: <988c3225-a961-5de0-eb22-7366891f65da@nvidia.com>
Date:   Mon, 9 Jul 2018 12:53:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <6a3e91ff-ce9f-8120-732e-a33dad6d0146@arm.com>
X-Originating-IP: [172.17.136.14]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL108.nvidia.com (172.18.146.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

That UBSAN error prompted me to check the generated instructions. The 
error by itself doesn't make sense to me because there is no requirement 
for 128b alignment on ldp/stp.

With 4.18-rc3, when I build for the default "defconfig" in 
arch/arm64/configs/, I see the disassembled code shows two ldr instead 
of a ldp.

One example is in function "ip_rcv" (/net/ipv4/ip_input.c). After 
disassembling vmlinux, I see following:

	if (unlikely(ip_fast_csum((u8 *)iph, iph->ihl)))
ffff0000089bcdb8:	38776b05 	ldrb	w5, [x24,x23]
static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
{
	__uint128_t tmp;
	u64 sum;

	tmp = *(const __uint128_t *)iph;
ffff0000089bcdbc:	f9400481 	ldr	x1, [x4,#8]
ffff0000089bcdc0:	f8776b00 	ldr	x0, [x24,x23]
ffff0000089bcdc4:	12000ca5 	and	w5, w5, #0xf
ffff0000089bcdc8:	510014a3 	sub	w3, w5, #0x5

This is done with "make ARCH=arm64 CROSS_COMPILE=... defconfig", so the 
default optimization level is -O2.

I tried the same test as you did: aarch64-linux-gnu-objdump -S -d *.o 
in net/ipv4. The result is inconsistent. In some instances, I do see ldp 
instruction being generated, in some other cases, it's two ldr. For 
example, in inet_gro_receive and ip_mc_check_igmp, it's compiled as I 
expected. For ip_rcv, it's not.

So it looks like this is not very consistent, but it also looks like in 
majority of cases it generates the ldp instructions.



On 07/09/2018 04:54 AM, Robin Murphy wrote:
> Hi Bo,
> 
> On 06/07/18 17:27, Bo Yan wrote:
>> Hi Robin, Luke,
>>
>> Recently I bumped into an error when running GCC undefined behavior 
>> sanitizer:
>>
>> UBSAN: Undefined behaviour in 
>> kernel-4.9/arch/arm64/include/asm/checksum.h:34:6
>>         load of misaligned address ffffffc198c8b254 for type 'const 
>> __int128 unsigned'
>>         which requires 16 byte alignment
> 
> What's your config and reproducer here? I've had UBSan enabled a few 
> times since that patch went in and never noticed anything. I've just 
> tried it with 4.18-rc3 and indeed don't see anything from just booting 
> the machine and making some network traffic. It does indeed fire if I 
> also turn on CONFIG_UBSAN_ALIGNMENT, but then it's almost lost among a 
> million other warnings for all manner of types - that's to be expected 
> since, as the help text says, "Enabling this option on architectures 
> that support unaligned accesses may produce a lot of false positives."
> 
>>
>> The relevant code:
>>
>>          tmp = *(const __uint128_t *)iph;
>>          iph += 16;
>>          ihl -= 4;
>>          tmp += ((tmp >> 64) | (tmp << 64));
>>          sum = tmp >> 64;
>>          do {
>>                  sum += *(const u32 *)iph;
>>                  iph += 4;
>>          } while (--ihl);
>>
>> But, I checked the generated disassembly, it doesn't look like 
>> anything special is generated taking advantage of that.
>>
>> I'm using Linaro GCC 6.4-2017.08, expecting ldp instructions to be 
>> emitted, but don't see it.
> 
> My regular toolchain is currently Linaro 7.2.1-2017.11, but I also tried 
> the last GCC 6 I had installed (6.3.1-2017.05), and for both at -O2 I 
> see LDP emitted as expected for most of the identifiable int128 accesses 
> (both in a standalone test harness and a quick survey of kernel code via 
> 'aarch64-linux-gnu-objdump -S net/ipv4/*.o'). Of course, there may well 
> be places where the compiler gets clever enough to elide all or part of 
> that load where data is already held in registers - I've not audited 
> *that* closely - but the whole point of having a pure C implementation 
> is that it can be aggressively inlined more than inline asm ever could.
> 
>> There were some prior discussions about GCC behavior, like this 
>> thread: https://patchwork.kernel.org/patch/9081911/ , in which you 
>> talked about the difference between GCC4 and GCC5.3. It looks to me 
>> this is regressed in Linaro GCC6.4 build.
>>
>> I have not checked newer GCC versions.
>>
>> Will it be more stable to just do this with inline assembly instead of 
>> relying on __uint128_t data type?
>>
>> GCC documentation says __int128 is supported for targets which have an 
>> integer mode wide enough to hold 128 bits. aarch64 doesn't have such 
>> an integer mode.
> 
> Yet AArch64 GCC definitely does support __uint128_t, or this code 
> wouldn't even build ;)
> 
> Robin.
> 
>>
>> Thanks
>>
>> Bo
