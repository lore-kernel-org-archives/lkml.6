Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29C2C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 23:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD022403E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 23:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FD022403E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753565AbeGEXVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 19:21:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58726 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753013AbeGEXVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 19:21:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1F7CA419932C;
        Thu,  5 Jul 2018 23:21:09 +0000 (UTC)
Received: from [10.72.12.18] (ovpn-12-18.pek2.redhat.com [10.72.12.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 157E376D0;
        Thu,  5 Jul 2018 23:21:05 +0000 (UTC)
Subject: Re: [PATCH 1/2] uio: change to use the mutex lock instead of the spin
 lock
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, pkalever@redhat.com,
        pkarampu@redhat.com, atumball@redhat.com, sabose@redhat.com,
        mchristi@redhat.com
References: <1530808048-9494-1-git-send-email-xiubli@redhat.com>
 <1530808048-9494-2-git-send-email-xiubli@redhat.com>
 <20180705163338.GA14941@kroah.com>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <24daa19c-eb1b-014e-c00f-8c8c3da0d935@redhat.com>
Date:   Fri, 6 Jul 2018 07:21:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180705163338.GA14941@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 05 Jul 2018 23:21:09 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 05 Jul 2018 23:21:09 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'xiubli@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/6 0:33, Greg KH wrote:
> On Thu, Jul 05, 2018 at 12:27:27PM -0400, xiubli@redhat.com wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> We are hitting a regression with the following commit:
>>
>> commit a93e7b331568227500186a465fee3c2cb5dffd1f
>> Author: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
>> Date:   Mon May 14 13:32:23 2018 +1200
>>
>>      uio: Prevent device destruction while fds are open
>>
>> The problem is the addition of spin_lock_irqsave in uio_write. This
>> leads to hitting  uio_write -> copy_from_user -> _copy_from_user ->
>> might_fault and the logs filling up with sleeping warnings.
>>
>> I also noticed some uio drivers allocate memory, sleep, grab mutexes
>> from callouts like open() and release and uio is now doing
>> spin_lock_irqsave while calling them.
>>
>> Reported-by: Mike Christie <mchristi@redhat.com>
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>> ---
>>   drivers/uio/uio.c          | 33 ++++++++++++++-------------------
>>   include/linux/uio_driver.h |  2 +-
>>   2 files changed, 15 insertions(+), 20 deletions(-)
> Any specific reason you did not also cc: the author of the above patch
> to review this one?
Ah, no, sorry for that, I just used the following script to get the 
mantainer and the list, and here was to late at night and I was a little 
dizzy forgetting that:

[root@gblock2 scsi]# ./scripts/get_maintainer.pl drivers/uio/
Greg Kroah-Hartman <gregkh@linuxfoundation.org> (maintainer:USERSPACE 
I/O (UIO))
linux-kernel@vger.kernel.org (open list)
[root@gblock2 scsi]#


And all the others are my team member, because this is a high priority 
bug fix, so I cced them to let them know the status of this patch set.

I will resend it right now.

Thanks very much for you reminding of this.

BRs
Xiubo


> Please fix up and resend.
>
> greg k-h


