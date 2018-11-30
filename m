Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7E6C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 789C02146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="G46baR2z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 789C02146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbeK3UFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 15:05:35 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:44476 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbeK3UFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 15:05:35 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id F330324E2028;
        Fri, 30 Nov 2018 00:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1543568219; bh=kEMhFEDusg95NEIcjdxz9UqRVrNdXFdtGDaBsYw/API=;
        h=Subject:To:References:CC:From:Date:In-Reply-To:From;
        b=G46baR2zZGhTZEywcBR4xXYFSNP3aZ2xB0A1OsnUqyee6KsjzFf5JsM25tBbYFp2L
         MWPqVGiGvgiabT/oPUVkNaxlwUWEFZeO5BPA9wbJanqqvQ6k8I2mauhb+VTnARMGa8
         hx7UcMciKNAAZTI06lQVeBbMIv1cnkUzcmYkfmXT4/frmA40sb2otIOwzUSEPKpeqd
         CNFf49u+8dSbCdcZV1GZNUCJi5tQkC/uOGpAcmRo3Msj0WrCoFrID5y9zECUW0ZBSA
         9Gp9cavMM2yBvUzng47g1TmotSTdcxAd/t3wVe0EiwtS8kFfE3y4g7Hd5Vu8p5VTYB
         +GYC3QQ9SJ25Q==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 884F335FD;
        Fri, 30 Nov 2018 00:56:58 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 30 Nov 2018 00:56:58 -0800
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 30 Nov 2018 09:56:56 +0100
Received: from [10.0.2.15] (10.107.19.26) by DE02WEHTCB.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 30 Nov
 2018 09:56:55 +0100
Subject: Re: [PATCH v2] ARC: io.h: Implement reads{x}()/writes{x}()
To:     Arnd Bergmann <arnd@arndb.de>
References: <19fb2e394afcb073bbc109e432417fbbc03323f6.1543499759.git.joabreu@synopsys.com>
 <ff1e11923e92405d883474d715008c0a@AcuMS.aculab.com>
 <89122bd8-bca2-2ae1-0dd0-160abbebcace@synopsys.com>
 <d2d133e5-267c-c42a-7329-22892bbbdee4@synopsys.com>
 <CAK8P3a2U3ft3crF2SiAuc=PQdDooEUaVAN9gQDyxsxvBn5+xRw@mail.gmail.com>
CC:     David Laight <David.Laight@aculab.com>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        <alexey.brodkin@synopsys.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        "Vitor Soares" <vitor.soares@synopsys.com>
From:   Jose Abreu <jose.abreu@synopsys.com>
Message-ID: <57437493-31bb-eced-032c-1f54470b030e@synopsys.com>
Date:   Fri, 30 Nov 2018 08:56:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2U3ft3crF2SiAuc=PQdDooEUaVAN9gQDyxsxvBn5+xRw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.19.26]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-11-2018 21:20, Arnd Bergmann wrote:
> On Thu, Nov 29, 2018 at 5:14 PM Jose Abreu <jose.abreu@synopsys.com> wrote:
>
>> --->8--
>> static noinline void test_readsl(char *buf, int len)
>> {
>>         readsl(0xdeadbeef, buf, len);
>> }
>> --->8---
>>
>> And the disassembly:
>> --->8---
>> 00000e88 <test_readsl>:
>>  e88:    breq.dr1,0,eac <0xeac>        /* if (count) */
>>  e8c:    and r2,r0,3
>>
>>  e90:    mov_s lp_count,r1            /* r1 = count */
>>  e92:    brne r2,0,eb0 <0xeb0>        /* if (bptr % ((t) / 8)) */
>>
>>  e96:    sub r0,r0,4
>>  e9a:    nop_s
>>
>>  e9c:    lp eac <0xeac>                /* first loop */
>>  ea0:    ld r2,[0xdeadbeef]
>>  ea8:    st.a r2,[r0,4]
>>  eac:    j_s [blink]
>>  eae:    nop_s
>>
>>  eb0:    lp ed6 <0xed6>                /* second loop */
>>  eb4:    ld r2,[0xdeadbeef]
>>  ebc:    lsr r5,r2,8
>>  ec0:    lsr r4,r2,16
>>  ec4:    lsr r3,r2,24
>>  ec8:    stb_s r2,[r0,0]
>>  eca:    stb r5,[r0,1]
>>  ece:    stb r4,[r0,2]
>>  ed2:    stb_s r3,[r0,3]
>>  ed4:    add_s r0,r0,4
>>  ed6:    j_s [blink]
>>
>> --->8---
>>
>> See how the if condition added in this version is checked in
>> <test_readsl+0xe92> and then it takes two different loops.
> This looks good to me. I wonder what the result is for CPUs
> that /do/ support unaligned accesses. Normally put_unaligned()
> should fall back to a simple store in that case, but I'm not
> sure it can fold the two stores back into one and skip the
> alignment check. Probably not worth overoptimizing for that
> case (the MMIO access latency should be much higher than
> anything you could gain here), but I'm still curious about
> how well our get/put_unaligned macros work.

Here is disassembly for an ARC CPU that supports unaligned accesses:

-->8---
00000d48 <test_readsl>:
 d48:    breq_s r1,0,28            /* if (count) */
 d4a:    tst    r0,0x3
 d4e:    bne_s 32                /* if (bptr % ((t) / 8)) */
 
 d50:    ld r2,[0xdeadbeef]        /* first loop */
 d58:    sub_s r1,r1,0x1
 d5a:    tst_s r1,r1
 d5c:    bne.d -12
 d60:    st.ab r2,[r0,4]
 
 d64:    dmb    0x1                    /* common exit point */
 d68:    j_s    [blink]
 d6a:    nop_s
 
 d6c:    ld r2,[0xdeadbeef]        /* second loop */
 d74:    sub_s r1,r1,0x1
 d76:    tst_s r1,r1
 d78:    bne.d -12
 d7c:    st.ab r2,[r0,4]

 d80:    b_s -28                    /* jmp to 0xd64 */
 d82:    nop_s
--->8---

Notice how first and second loop are exactly equal ...

Thanks and Best Regards,
Jose Miguel Abreu

>
>        Arnd

