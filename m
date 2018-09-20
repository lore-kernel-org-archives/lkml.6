Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BD1ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E263C2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:18:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E263C2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730962AbeITWCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:02:31 -0400
Received: from mail5.windriver.com ([192.103.53.11]:47742 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbeITWCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:02:31 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id w8KGH4g4017154
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Thu, 20 Sep 2018 09:17:14 -0700
Received: from [128.224.162.216] (128.224.162.216) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 20 Sep
 2018 09:16:53 -0700
Subject: Re: [PATCH v2 1/2] printk: Fix panic caused by passing log_buf_len to
 command line
To:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
CC:     <pmladek@suse.com>, <sergey.senozhatsky@gmail.com>,
        <linux-kernel@vger.kernel.org>
References: <1537291068-443145-1-git-send-email-zhe.he@windriver.com>
 <20180919015030.GA423@jagdpanzerIV>
 <6c354803-5341-7237-9ee3-7882252c7483@windriver.com>
 <20180919023932.GA14090@jagdpanzerIV>
 <20180918224312.6e9aef50@vmware.local.home>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <1545bc85-b64a-4b45-d40f-79567ac621dc@windriver.com>
Date:   Fri, 21 Sep 2018 00:16:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180918224312.6e9aef50@vmware.local.home>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [128.224.162.216]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年09月19日 10:43, Steven Rostedt wrote:
> On Wed, 19 Sep 2018 11:39:32 +0900
> Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
>
>> On (09/19/18 10:27), He Zhe wrote:
>>> On 2018年09月19日 09:50, Sergey Senozhatsky wrote:  
>>>> On (09/19/18 01:17), zhe.he@windriver.com wrote:  
>>>>> @@ -1048,7 +1048,14 @@ static void __init log_buf_len_update(unsigned size)
>>>>>  /* save requested log_buf_len since it's too early to process it */
>>>>>  static int __init log_buf_len_setup(char *str)
>>>>>  {
>>>>> -	unsigned size = memparse(str, &str);
>>>>> +	unsigned size;  
>>>> 	unsigned int size;  
>>> This is in v1 but then Steven suggested that it should be split out
>>> and only keep the pure fix part here.  
>> Ah, I see.
>>
>> Hmm... memparse() returns u64 value. A user *probably* can ask the kernel
>> to allocate log_buf larger than 'unsigned int'.
>>
>> So may be I'd do two fixes here:
>>
>>  First  - switch to u64 size.
>>  Second - check for NULL str.
>>
>>
>> Steven, Petr, what do you think?
>>
> I think I would switch it around. Check for NULL first, and then switch
> to u64. It was always an int, do we need to backport converting it to
> u64 to stable? The NULL check is a definite, the overflow of int
> shouldn't crash anything.

To switch to u64, several variables need to be adjusted to new type to aligned
with new_log_buf_len. And currently new_log_buf_len is passed to
memblock_virt_alloc(phys_addr_t, phys_addr_t). So we can't simply define
new_log_buf_len as u64. We need to define it as phys_addr_t tomake it work
well for both 32bit and 64bit arches, since a 32-bit architecture can set
ARCH_PHYS_ADDR_T_64BIT if it needs a 64-bit phys_addr_t.

What do you think?

#ifdef CONFIG_PHYS_ADDR_T_64BIT
typedef u64 phys_addr_t;
#else
typedef u32 phys_addr_t;
#endif

Thanks,
Zhe


> -- Steve
>

