Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1FBECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 15:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 374EF206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 15:36:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 374EF206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbeIVVaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 17:30:19 -0400
Received: from mail1.windriver.com ([147.11.146.13]:41159 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbeIVVaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 17:30:18 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w8MFa9qT017529
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sat, 22 Sep 2018 08:36:11 -0700 (PDT)
Received: from [128.224.162.216] (128.224.162.216) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.408.0; Sat, 22 Sep
 2018 08:36:09 -0700
Subject: Re: [PATCH v2 1/2] printk: Fix panic caused by passing log_buf_len to
 command line
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        <sergey.senozhatsky@gmail.com>, <linux-kernel@vger.kernel.org>
References: <1537291068-443145-1-git-send-email-zhe.he@windriver.com>
 <20180919015030.GA423@jagdpanzerIV>
 <6c354803-5341-7237-9ee3-7882252c7483@windriver.com>
 <20180919023932.GA14090@jagdpanzerIV>
 <20180918224312.6e9aef50@vmware.local.home>
 <1545bc85-b64a-4b45-d40f-79567ac621dc@windriver.com>
 <20180920123056.27b2cf18@gandalf.local.home>
 <20180921073753.mqayzofcofpmhiyu@pathway.suse.cz>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <02b53bc1-3803-50b1-d07e-a7962f9e5688@windriver.com>
Date:   Sat, 22 Sep 2018 23:36:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180921073753.mqayzofcofpmhiyu@pathway.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [128.224.162.216]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年09月21日 15:37, Petr Mladek wrote:
> On Thu 2018-09-20 12:30:56, Steven Rostedt wrote:
>> On Fri, 21 Sep 2018 00:16:50 +0800
>> He Zhe <zhe.he@windriver.com> wrote:
>>
>>> On 2018年09月19日 10:43, Steven Rostedt wrote:
>>>> On Wed, 19 Sep 2018 11:39:32 +0900
>>>> Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
>>>>  
>>>>> On (09/19/18 10:27), He Zhe wrote:  
>>>>>> On 2018年09月19日 09:50, Sergey Senozhatsky wrote:    
>>>>>>> On (09/19/18 01:17), zhe.he@windriver.com wrote:    
>>>>>>>> @@ -1048,7 +1048,14 @@ static void __init log_buf_len_update(unsigned size)
>>>>>>>>  /* save requested log_buf_len since it's too early to process it */
>>>>>>>>  static int __init log_buf_len_setup(char *str)
>>>>>>>>  {
>>>>>>>> -	unsigned size = memparse(str, &str);
>>>>>>>> +	unsigned size;    
>>>>>>> 	unsigned int size;    
>>>>>> This is in v1 but then Steven suggested that it should be split out
>>>>>> and only keep the pure fix part here.    
>>>>> Ah, I see.
>>>>>
>>>>> Hmm... memparse() returns u64 value. A user *probably* can ask the kernel
>>>>> to allocate log_buf larger than 'unsigned int'.
>>>>>
>>>>> So may be I'd do two fixes here:
>>>>>
>>>>>  First  - switch to u64 size.
>>>>>  Second - check for NULL str.
>>>>>
>>>>>
>>>>> Steven, Petr, what do you think?
>>>>>  
>>>> I think I would switch it around. Check for NULL first, and then switch
>>>> to u64. It was always an int, do we need to backport converting it to
>>>> u64 to stable? The NULL check is a definite, the overflow of int
>>>> shouldn't crash anything.  
>> Hi Zhe,
>>
>>> To switch to u64, several variables need to be adjusted to new type to aligned
>>> with new_log_buf_len. And currently new_log_buf_len is passed to
>>> memblock_virt_alloc(phys_addr_t, phys_addr_t). So we can't simply define
>>> new_log_buf_len as u64. We need to define it as phys_addr_t tomake it work
>>> well for both 32bit and 64bit arches, since a 32-bit architecture can set
>>> ARCH_PHYS_ADDR_T_64BIT if it needs a 64-bit phys_addr_t.
>> The above explanation verifies more that the NULL pointer check needs
>> to be first, and that the change in size should not be backported to
>> stable because it has a high risk to doing the change as compared to it
>> being a problem for older kernels.
> I agree that the NULL check should go first.
>
> I would personally keep the size as unsigned int. IMHO, a support
> for a log buffer bigger than 4GB is not worth the complexity.

Thank you, Petr, Steven and Sergey. I'll send v3 soon for the NULL check
and cast correction.



For 64 bit log buffer length, the variable changes should be OK. The main
obstacle might be that we need to modify the syscall below to make the
64 bit length returned back to user space. "error" is not long enough.

int do_syslog(int type, char __user *buf, int len, int source)
...
        case SYSLOG_ACTION_SIZE_BUFFER:                                         
                error = log_buf_len;                                            
                break;
...
    return error;
...

SYSCALL_DEFINE3(syslog, int, type, char __user *, buf, int, len)                
{                                                                                                                                                                                       
        return do_syslog(type, buf, len, SYSLOG_FROM_READER);                       
}



Besides, in terms of variable type alignment, there has already been a
similar problematic case in do_syslog as below. i.e. int = u64 - u64. It seems
this needs to be fixed.

int do_syslog(int type, char __user *buf, int len, int source)
...
    case SYSLOG_ACTION_SIZE_UNREAD:
        if (source == SYSLOG_FROM_PROC) {
            error = log_next_seq - syslog_seq;
...



I'd like to fix the above issues. But can I have your opinions about how to
handle the syscall?


Thanks,
Zhe

>
> Best Regards,
> Petr
>

