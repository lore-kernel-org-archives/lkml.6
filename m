Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3847AC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 028F724EC8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:02:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 028F724EC8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753082AbeGBSCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:02:54 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:41633 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752339AbeGBSCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:02:53 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0T3r6iRk_1530554550;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T3r6iRk_1530554550)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 03 Jul 2018 02:02:38 +0800
Subject: Re: [RFC v3 PATCH 3/5] mm: refactor do_munmap() to extract the common
 part
To:     Michal Hocko <mhocko@kernel.org>
Cc:     willy@infradead.org, ldufour@linux.vnet.ibm.com,
        akpm@linux-foundation.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, linux-mm@kvack.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <1530311985-31251-1-git-send-email-yang.shi@linux.alibaba.com>
 <1530311985-31251-4-git-send-email-yang.shi@linux.alibaba.com>
 <20180702134226.GX19043@dhcp22.suse.cz>
 <5aa8953d-3781-8b22-89f6-994a52ea0172@linux.alibaba.com>
 <20180702175835.GH19043@dhcp22.suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <20e2cd1a-7969-fa5e-4298-3bb1e6563acf@linux.alibaba.com>
Date:   Mon, 2 Jul 2018 11:02:28 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180702175835.GH19043@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/2/18 10:58 AM, Michal Hocko wrote:
> On Mon 02-07-18 09:59:06, Yang Shi wrote:
>>
>> On 7/2/18 6:42 AM, Michal Hocko wrote:
>>> On Sat 30-06-18 06:39:43, Yang Shi wrote:
>>>> Introduces two new helper functions:
>>>>     * munmap_addr_sanity()
>>>>     * munmap_lookup_vma()
>>>>
>>>> They will be used by do_munmap() and the new do_munmap with zapping
>>>> large mapping early in the later patch.
>>>>
>>>> There is no functional change, just code refactor.
>>> There are whitespace changes which make the code much harder to review
>>> than necessary.
>>>> +static inline bool munmap_addr_sanity(unsigned long start, size_t len)
>>>>    {
>>>> -	unsigned long end;
>>>> -	struct vm_area_struct *vma, *prev, *last;
>>>> +	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE - start)
>>>> +		return false;
>>>> -	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start)
>>>> -		return -EINVAL;
>>> e.g. here.
>> Oh, yes. I did some coding style cleanup too.
> If you want to do some coding style cleanups make them a separate patch.
> The resulting diff would be much easier to review.

Sure, thanks

>

