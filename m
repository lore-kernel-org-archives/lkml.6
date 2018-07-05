Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA34C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 23:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10D4623F27
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 23:23:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D4623F27
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753904AbeGEXXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 19:23:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58764 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753464AbeGEXXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 19:23:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EF0AF400ADCF;
        Thu,  5 Jul 2018 23:23:22 +0000 (UTC)
Received: from [10.72.12.18] (ovpn-12-18.pek2.redhat.com [10.72.12.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 71EDA111DD0A;
        Thu,  5 Jul 2018 23:23:19 +0000 (UTC)
Subject: Re: [PATCH 2/2] uio: fix crash after the device is unregistered
To:     Jann Horn <jannh@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        pkalever@redhat.com, pkarampu@redhat.com, atumball@redhat.com,
        sabose@redhat.com, mchristi@redhat.com
References: <1530808048-9494-1-git-send-email-xiubli@redhat.com>
 <1530808048-9494-3-git-send-email-xiubli@redhat.com>
 <CAG48ez1Ze1Q08HtyC8PyhW5msQ8qwFDy6eDj8s9k_j4vmG7nJw@mail.gmail.com>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <2b211654-19d0-8001-d829-a3c640755348@redhat.com>
Date:   Fri, 6 Jul 2018 07:23:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez1Ze1Q08HtyC8PyhW5msQ8qwFDy6eDj8s9k_j4vmG7nJw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 05 Jul 2018 23:23:22 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 05 Jul 2018 23:23:22 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'xiubli@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/6 4:56, Jann Horn wrote:
> On Thu, Jul 5, 2018 at 10:53 PM <xiubli@redhat.com> wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> For the target_core_user use case, after the device is unregistered
>> it maybe still opened in user space, then the kernel will crash, like:
>>
> [...]
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>> ---
>>   drivers/uio/uio.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++--------
>>   1 file changed, 86 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
>> index 33c3bfe..2b9268a 100644
>> --- a/drivers/uio/uio.c
>> +++ b/drivers/uio/uio.c
> [...]
>> @@ -720,30 +775,46 @@ static int uio_mmap(struct file *filep, struct vm_area_struct *vma)
>>
>>          vma->vm_private_data = idev;
>>
>> +       mutex_lock(&idev->info_lock);
>> +       if (!idev->info) {
>> +               ret = -EINVAL;
>> +               goto out;
>> +       }
>> +
>>          mi = uio_find_mem_index(vma);
>> -       if (mi < 0)
>> -               return -EINVAL;
>> +       if (mi < 0) {
>> +               ret = -EINVAL;
>> +               goto out;
>> +       }
>>
>>          requested_pages = vma_pages(vma);
>>          actual_pages = ((idev->info->mem[mi].addr & ~PAGE_MASK)
>>                          + idev->info->mem[mi].size + PAGE_SIZE -1) >> PAGE_SHIFT;
>> -       if (requested_pages > actual_pages)
>> -               return -EINVAL;
>> +       if (requested_pages > actual_pages) {
>> +               ret = -EINVAL;
>> +               goto out;
>> +       }
>>
>>          if (idev->info->mmap) {
>>                  ret = idev->info->mmap(idev->info, vma);
>> -               return ret;
>> +               goto out;
>>          }
>>
>>          switch (idev->info->mem[mi].memtype) {
>>                  case UIO_MEM_PHYS:
>> -                       return uio_mmap_physical(vma);
>> +                       ret = uio_mmap_physical(vma);
>> +                       break;
>>                  case UIO_MEM_LOGICAL:
>>                  case UIO_MEM_VIRTUAL:
>> -                       return uio_mmap_logical(vma);
>> +                       ret = uio_mmap_logical(vma);
>> +                       break;
>>                  default:
>> -                       return -EINVAL;
>> +                       ret = -EINVAL;
>>          }
>> +
>> +out:
>> +       mutex_lock(&idev->info_lock);
> This is probably supposed to be mutex_unlock(...)?

Yeah yeah, right, Good catch :-)

Locally I had fixed this, but after my building and testing just forgot 
to amend it.

Will fix it.

Thanks very much.

BRs

