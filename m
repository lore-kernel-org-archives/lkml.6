Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2A3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED71A217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfBZMcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:32:41 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:49402 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726350AbfBZMck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 07:32:40 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TLMBuKI_1551184354;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TLMBuKI_1551184354)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 26 Feb 2019 20:32:34 +0800
Subject: Re: [bug report][stable] perf probe: failed to add events
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        luto@kernel.org, Jiufei Xue <jiufei.xue@linux.alibaba.com>,
        Xu Yu <xuyu@linux.alibaba.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org
References: <1a4240a8-288b-45d0-073d-d5cb8f0c63eb@linux.alibaba.com>
 <20190226090505.GA24409@kroah.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <c7ccd9cb-3a66-98a9-faa1-7ee5ed20ff88@linux.alibaba.com>
Date:   Tue, 26 Feb 2019 20:32:34 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190226090505.GA24409@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/2/26 17:05, Greg KH wrote:
> On Tue, Feb 26, 2019 at 03:31:14PM +0800, Joseph Qi wrote:
>> Hi,
>>
>> I'm using kernel v4.19.24 and have found that there is an issue when
>> using perf probe to define a new dynamic tracepoint.
>>
>> $ perf probe -a handle_mm_fault
>> Failed to write event: Numerical result out of range
>>   Error: Failed to add events.
>>
>> I've also tried kernel v4.20, and it can pass.
> 
> Ick, has this ever worked on the 4.19 stable tree?  If so, any chance
> you can run 'git bisect' to find the offending commit?
> 
From my test, v4.19.0 also has this issue.
Bisect locates that it is introduced by commit bf904d2762ee
"x86/pti/64: Remove the SYSCALL64 entry trampoline".

Thanks,
Joseph

>> So I've bisected and finally found the first good commit is:
>> bf904d2762ee x86/pti/64: Remove the SYSCALL64 entry trampoline
>> which is based on another commit:
>> 98f05b5138f0 Use the TSS sp2 slot for SYSCALL/SYSRET scratch space
>>
>> Once I've backpoted these two commits into 4.19.24, the above case can
>> pass, though I'm not sure how it is fixed.
>> So is there any plan to let them go into stable as well?
> 
> If they are needed, I'll gladly queue them up, but this feels like
> something might have broken, so it should be easier to just revert the
> offending commit instead.
> 
> Andy, any ideas?
> 
> thanks,
> 
> greg k-h
> 
