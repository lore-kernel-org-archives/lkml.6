Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E41EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F7D520673
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="e9EAnnPE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F7D520673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388178AbeK3BsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:48:10 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:47276 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387714AbeK3BsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:48:09 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 99F3E10C08CC;
        Thu, 29 Nov 2018 06:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1543502554; bh=yaa6er+gvN33SEO//p4seoTIdtqTBwRlv+If4fIiUPI=;
        h=Subject:To:References:CC:From:Date:In-Reply-To:From;
        b=e9EAnnPEo2TLfuPDuwwiOE94f0qkxyw0poOCc37a5cfyHRkzCY4M8s8TnshmJ9W08
         JQTgcVa8wOeWTgncnRrPHMKH7Ff9aR/X0eAGltXUuBLdmrPi59x0R6D+ysNRAWikX2
         /aHZ8BD6yTIo3Y4PHGj4S6HqhpGLOAi+yjI99RV+DaR0rmR6qKft/+MHolPvS/CKXr
         wd9PdH5RHZ1qaJMYrQoPmEJFjGs6gMlOslZpyMj0v9a0jZYCK3MeTxsUKzuBZ6Nf8o
         BTOwqM6UtRu0Jn2tdOEDQK/715sTZUmxAJLYV3j0HFDiSQpKhRlTuo/sZZpk+njJNu
         ZoPrZUS8qFuig==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        by mailhost.synopsys.com (Postfix) with ESMTP id 8C6903B2A;
        Thu, 29 Nov 2018 06:42:34 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 29 Nov 2018 06:42:34 -0800
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 29 Nov 2018 15:42:32 +0100
Received: from [10.0.2.15] (10.107.19.26) by DE02WEHTCB.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 29 Nov
 2018 15:42:31 +0100
Subject: Re: [PATCH v2] ARC: io.h: Implement reads{x}()/writes{x}()
To:     David Laight <David.Laight@ACULAB.COM>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <19fb2e394afcb073bbc109e432417fbbc03323f6.1543499759.git.joabreu@synopsys.com>
 <ff1e11923e92405d883474d715008c0a@AcuMS.aculab.com>
CC:     Vineet Gupta <vineet.gupta1@synopsys.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        "Vitor Soares" <vitor.soares@synopsys.com>
From:   Jose Abreu <jose.abreu@synopsys.com>
Message-ID: <89122bd8-bca2-2ae1-0dd0-160abbebcace@synopsys.com>
Date:   Thu, 29 Nov 2018 14:42:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <ff1e11923e92405d883474d715008c0a@AcuMS.aculab.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.19.26]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-11-2018 14:38, David Laight wrote:
> From: Jose Abreu
>> Sent: 29 November 2018 14:29
>>
>> Some ARC CPU's do not support unaligned loads/stores. Currently, generic
>> implementation of reads{b/w/l}()/writes{b/w/l}() is being used with ARC.
>> This can lead to misfunction of some drivers as generic functions do a
>> plain dereference of a pointer that can be unaligned.
>>
>> Let's use {get/put}_unaligned() helper instead of plain dereference of
>> pointer in order to fix this.
> ...
>> +#define __raw_readsx(t,f) \
>> +static inline void __raw_reads##f(const volatile void __iomem *addr, \
>> +				  void *buffer, unsigned int count) \
>> +{ \
>> +	if (count) { \
>> +		const unsigned long bptr = (unsigned long)buffer; \
>> +		u##t *buf = buffer; \
>> +\
>> +		do { \
>> +			u##t x = __raw_read##f(addr); \
>> +\
>> +			/* Some ARC CPU's don't support unaligned accesses */ \
>> +			if (bptr % ((t) / 8)) { \
>> +				put_unaligned(x, buf++); \
>> +			} else { \
>> +				*buf++ = x; \
>> +			} \
>> +		} while (--count); \
>> +	} \
>> +}
> Does the compiler move the alignment test outside the loop?
> You really want two copies of the loop body.

Hmm, I would expect so because the if condition takes two const
args ... I will try check that.

Thanks and Best Regards,
Jose Miguel Abreu

>
> 	David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>

