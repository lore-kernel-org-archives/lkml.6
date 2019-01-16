Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18018C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E32B62082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfAPRqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:46:38 -0500
Received: from gateway30.websitewelcome.com ([192.185.179.30]:13496 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726891AbfAPRqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:46:37 -0500
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id AF017F18E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 11:46:35 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id jpGtgRnjy2PzOjpGtg4DrK; Wed, 16 Jan 2019 11:46:35 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=34128 helo=[192.168.43.131])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gjpGs-001OZt-PY; Wed, 16 Jan 2019 11:46:35 -0600
Subject: Re: [PATCH] powerpc/ps3: Use struct_size() in kzalloc()
To:     Geoff Levand <geoff@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20190108210010.GA980@embeddedor>
 <595f7b4b-9e26-ae72-de5f-270dce677c65@infradead.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <0673a5d1-5b4b-b432-6fc9-ff020ee0ba5e@embeddedor.com>
Date:   Wed, 16 Jan 2019 11:46:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <595f7b4b-9e26-ae72-de5f-270dce677c65@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gjpGs-001OZt-PY
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.43.131]) [189.250.130.205]:34128
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geoff,

On 1/16/19 11:21 AM, Geoff Levand wrote:
> Hi Gustavo,
> 
> On 1/8/19 1:00 PM, Gustavo A. R. Silva wrote:
>> One of the more common cases of allocation size calculations is finding the
>> size of a structure that has a zero-sized array at the end, along with memory
>> for some number of elements for that array. For example:
>>
>> struct foo {
>>      int stuff;
>>      void *entry[];
>> };
>>
>> instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
>>
>> Instead of leaving these open-coded and prone to type mistakes, we can now
>> use the new struct_size() helper:
>>
>> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
>>
>> This code was detected with the help of Coccinelle.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>   arch/powerpc/platforms/ps3/device-init.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/ps3/device-init.c b/arch/powerpc/platforms/ps3/device-init.c
>> index e7075aaff1bb..59587b75493d 100644
>> --- a/arch/powerpc/platforms/ps3/device-init.c
>> +++ b/arch/powerpc/platforms/ps3/device-init.c
>> @@ -354,9 +354,7 @@ static int ps3_setup_storage_dev(const struct ps3_repository_device *repo,
>>   		 repo->dev_index, repo->dev_type, port, blk_size, num_blocks,
>>   		 num_regions);
>>   
>> -	p = kzalloc(sizeof(struct ps3_storage_device) +
>> -		    num_regions * sizeof(struct ps3_storage_region),
>> -		    GFP_KERNEL);
>> +	p = kzalloc(struct_size(p, regions, num_regions), GFP_KERNEL);
>>   	if (!p) {
>>   		result = -ENOMEM;
>>   		goto fail_malloc;
> It seems to me the motivation for this change is just to have a
> code change.  As I've said for other similar patches, I'm reluctant
> to accept such trivial changes to the PS3 code because it makes
> it harder for me to maintain the code in the long term.  When I
> need to do a git bisect to track down a problem I generally have
> a set of debugging patches that I apply on top of the bisect.  A
> change to the code like this creates the potential for a patch
> conflict that I then need to manually edit to resolve.
> 

This patch is part of a treewide effort aimed at preventing potential
integer overflows during allocation. As the commit log says, the
intention is to promote the use of struct_size instead of an
open-coded form that can be prone to mistakes. This macro is a
defense-in-depth strategy against overflows and it is a good idea
to use it as widely as possible.

I'm not stopping to see how old the code is. I'm only focusing on the
particular context of the memory allocation to understand what is the
name of the zero-sized array that should be used for struct_size(),
and if this macro can accurately replace the open-coded form.

> If this change was for relatively new code, or better, for a patch
> that was submitted but not yet merged, then my feelings would be
> different.  I think it would be really useful to have something
> that scans patches in patchwork.
> 

I understand your point.

Thanks
--
Gustavo
