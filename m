Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A016C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB5D72146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="End16h5w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB5D72146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbeK3DTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:19:02 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:50752 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbeK3DTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:19:01 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id A506610C165A;
        Thu, 29 Nov 2018 08:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1543507989; bh=iI8VcSX2wwSpl+sNkdDq35GSueAOhPaM+gKpCn2bBKg=;
        h=Subject:To:References:CC:From:Date:In-Reply-To:From;
        b=End16h5wmjrbzF80Spi1zl5decbfFy+MsrVwCJ8TcpLqkybiOw7tTDPUvcnIXGCBz
         JXVO/uUMgGF4E7p3TRCdtKr0enCLV/T5OjEVoejTFjG6+c7ei2vz2C9H79Hfd8kmEO
         ry6SwXh1DibOgMq8ZY3qLPuMLLfK9+xESxl5YYEVcrr5o570NQya8M+f0nYKEwFIII
         Da3So6pu2j1J0shPMpQEWffzMQfT5qgqoNifX9xkbl0JvAZVcwRKouo28wBV0ATXdD
         xfccMPN89cGR/M1vvWD+/A7/5ug52BC8qULGlYYIbPxVWslZhvb5YrPsa2X857vyte
         XXspU01B6/mtg==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 6295931A3;
        Thu, 29 Nov 2018 08:13:09 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 29 Nov 2018 08:13:09 -0800
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 29 Nov 2018 17:13:07 +0100
Received: from [10.0.2.15] (10.107.19.26) by DE02WEHTCB.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 29 Nov
 2018 17:13:06 +0100
Subject: Re: [PATCH v2] ARC: io.h: Implement reads{x}()/writes{x}()
To:     David Laight <David.Laight@ACULAB.COM>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <19fb2e394afcb073bbc109e432417fbbc03323f6.1543499759.git.joabreu@synopsys.com>
 <ff1e11923e92405d883474d715008c0a@AcuMS.aculab.com>
 <89122bd8-bca2-2ae1-0dd0-160abbebcace@synopsys.com>
CC:     Vineet Gupta <vineet.gupta1@synopsys.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        "Vitor Soares" <vitor.soares@synopsys.com>
From:   Jose Abreu <jose.abreu@synopsys.com>
Message-ID: <d2d133e5-267c-c42a-7329-22892bbbdee4@synopsys.com>
Date:   Thu, 29 Nov 2018 16:13:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <89122bd8-bca2-2ae1-0dd0-160abbebcace@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.19.26]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-11-2018 14:42, Jose Abreu wrote:
> On 29-11-2018 14:38, David Laight wrote:
>> From: Jose Abreu
>>> Sent: 29 November 2018 14:29
>>>
>>> Some ARC CPU's do not support unaligned loads/stores. Currently, generic
>>> implementation of reads{b/w/l}()/writes{b/w/l}() is being used with ARC.
>>> This can lead to misfunction of some drivers as generic functions do a
>>> plain dereference of a pointer that can be unaligned.
>>>
>>> Let's use {get/put}_unaligned() helper instead of plain dereference of
>>> pointer in order to fix this.
>> ...
>>> +#define __raw_readsx(t,f) \
>>> +static inline void __raw_reads##f(const volatile void __iomem *addr, \
>>> +				  void *buffer, unsigned int count) \
>>> +{ \
>>> +	if (count) { \
>>> +		const unsigned long bptr = (unsigned long)buffer; \
>>> +		u##t *buf = buffer; \
>>> +\
>>> +		do { \
>>> +			u##t x = __raw_read##f(addr); \
>>> +\
>>> +			/* Some ARC CPU's don't support unaligned accesses */ \
>>> +			if (bptr % ((t) / 8)) { \
>>> +				put_unaligned(x, buf++); \
>>> +			} else { \
>>> +				*buf++ = x; \
>>> +			} \
>>> +		} while (--count); \
>>> +	} \
>>> +}
>> Does the compiler move the alignment test outside the loop?
>> You really want two copies of the loop body.
> Hmm, I would expect so because the if condition takes two const
> args ... I will try check that.

And it did optimize :)

Sample C Source:
--->8--
static noinline void test_readsl(char *buf, int len)
{
        readsl(0xdeadbeef, buf, len);
}
--->8---

And the disassembly:
--->8---
00000e88 <test_readsl>:
 e88:    breq.dr1,0,eac <0xeac>        /* if (count) */
 e8c:    and r2,r0,3

 e90:    mov_s lp_count,r1            /* r1 = count */
 e92:    brne r2,0,eb0 <0xeb0>        /* if (bptr % ((t) / 8)) */

 e96:    sub r0,r0,4
 e9a:    nop_s
 
 e9c:    lp eac <0xeac>                /* first loop */
 ea0:    ld r2,[0xdeadbeef]
 ea8:    st.a r2,[r0,4]
 eac:    j_s [blink]
 eae:    nop_s

 eb0:    lp ed6 <0xed6>                /* second loop */
 eb4:    ld r2,[0xdeadbeef]
 ebc:    lsr r5,r2,8
 ec0:    lsr r4,r2,16
 ec4:    lsr r3,r2,24
 ec8:    stb_s r2,[r0,0]
 eca:    stb r5,[r0,1]
 ece:    stb r4,[r0,2]
 ed2:    stb_s r3,[r0,3]
 ed4:    add_s r0,r0,4
 ed6:    j_s [blink]

--->8---

See how the if condition added in this version is checked in
<test_readsl+0xe92> and then it takes two different loops.

Thanks and Best Regards,
Jose Miguel Abreu

>
> Thanks and Best Regards,
> Jose Miguel Abreu
>
>> 	David
>>
>> -
>> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
>> Registration No: 1397386 (Wales)
>>

