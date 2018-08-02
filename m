Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3D5C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257FC214FF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:30:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 257FC214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbeHBLUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 07:20:53 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:21644 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbeHBLUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 07:20:53 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41h4fJ6Ybrz9ttlZ;
        Thu,  2 Aug 2018 11:30:32 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 31Ph5a-JHjag; Thu,  2 Aug 2018 11:30:32 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41h4fJ5zwcz9ttl9;
        Thu,  2 Aug 2018 11:30:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2BBA48B845;
        Thu,  2 Aug 2018 11:30:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id qOQPdc2gfZeM; Thu,  2 Aug 2018 11:30:34 +0200 (CEST)
Received: from po14934vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id ACF7C8B843;
        Thu,  2 Aug 2018 11:30:33 +0200 (CEST)
Subject: Re: [PATCH] powerpc/mm: fix always true/false warning in slice.c
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, malat@debian.org,
        aneesh.kumar@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <63b696ab7be8b941fa1e1589f28260320d12a32a.1529589640.git.christophe.leroy@c-s.fr>
 <871scqwbbo.fsf@concordia.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <1f090f15-eda3-90b1-2aab-ac73d9abb550@c-s.fr>
Date:   Thu, 2 Aug 2018 09:30:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <871scqwbbo.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/29/2018 02:55 AM, Michael Ellerman wrote:
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
>> This patch fixes the following warnings (obtained with make W=1).
>>
>> arch/powerpc/mm/slice.c: In function 'slice_range_to_mask':
>> arch/powerpc/mm/slice.c:73:12: error: comparison is always true due to limited range of data type [-Werror=type-limits]
>>    if (start < SLICE_LOW_TOP) {
> 
> Presumably only on 32-bit ?

Sure

> 
>> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
>> index 9530c6db406a..17c57760e06c 100644
>> --- a/arch/powerpc/mm/slice.c
>> +++ b/arch/powerpc/mm/slice.c
>> @@ -79,7 +86,7 @@ static void slice_range_to_mask(unsigned long start, unsigned long len,
>>   			- (1u << GET_LOW_SLICE_INDEX(start));
>>   	}
>>   
>> -	if ((start + len) > SLICE_LOW_TOP) {
>> +	if (!slice_addr_is_low(end)) {
>>   		unsigned long start_index = GET_HIGH_SLICE_INDEX(start);
>>   		unsigned long align_end = ALIGN(end, (1UL << SLICE_HIGH_SHIFT));
>>   		unsigned long count = GET_HIGH_SLICE_INDEX(align_end) - start_index;
> 
> This worries me.

I'll change it in v2 to:
  	if (SLICE_NUM_HIGH && !slice_addr_is_low(end)) {


> 
> By casting before the comparison in the helper you squash the compiler
> warning, but the code is still broken if (start + len) overflows.
> 
> Presumably that "never happens", but it just seems fishy.
> 
> The other similar check in that file does:
> 
>    if (SLICE_NUM_HIGH && ((start + len) > SLICE_LOW_TOP)) {
> 
> Where SLICE_NUM_HIGH == 0 on 32-bit.
> 
> 
> Could we fix the less than comparisons with SLICE_LOW_TOP with something
> similar, eg:
> 
> 	if (!SLICE_NUM_HIGH || start < SLICE_LOW_TOP) {
> 
> ie. limit them to the 64-bit code?

That's not enough to make GCC happy:

arch/powerpc/mm/slice.c: In function ‘slice_range_to_mask’:
arch/powerpc/mm/slice.c:74:31: error: comparison is always true due to 
limited range of data type [-Werror=type-limits]
   if (!SLICE_NUM_HIGH || start < SLICE_LOW_TOP) {

Christophe


> 
> cheers
> 
