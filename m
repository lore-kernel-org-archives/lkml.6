Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D07C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F35208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:08:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22F35208E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeHWTii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 15:38:38 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:34983 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726330AbeHWTii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 15:38:38 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0T76vNp1_1535040464;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T76vNp1_1535040464)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 24 Aug 2018 00:07:53 +0800
Subject: Re: [RFC v8 PATCH 2/5] uprobes: introduce has_uprobes helper
To:     Oleg Nesterov <oleg@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, mhocko@kernel.org,
        willy@infradead.org, ldufour@linux.vnet.ibm.com,
        kirill@shutemov.name, akpm@linux-foundation.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-mm@kvack.org, liu.song.a23@gmail.com,
        ravi.bangoria@linux.ibm.com, linux-kernel@vger.kernel.org
References: <1534358990-85530-1-git-send-email-yang.shi@linux.alibaba.com>
 <1534358990-85530-3-git-send-email-yang.shi@linux.alibaba.com>
 <e7147e14-bc38-03d0-90a4-5e0ca7e40050@suse.cz>
 <20180822150718.GB52756@linux.vnet.ibm.com>
 <20180823151554.GC10652@redhat.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <dc0d9e87-4f38-a6f9-8513-1c682bfaccc7@linux.alibaba.com>
Date:   Thu, 23 Aug 2018 09:07:43 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180823151554.GC10652@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/23/18 8:15 AM, Oleg Nesterov wrote:
> On 08/22, Srikar Dronamraju wrote:
>> * Vlastimil Babka <vbabka@suse.cz> [2018-08-22 12:55:59]:
>>
>>> On 08/15/2018 08:49 PM, Yang Shi wrote:
>>>> We need check if mm or vma has uprobes in the following patch to check
>>>> if a vma could be unmapped with holding read mmap_sem.
> Confused... why can't we call uprobe_munmap() under read_lock(mmap_sem) ?

I'm not sure if it is safe or not because it is not recommended and not 
safe to update vma's vm flags with read mmap_sem. uprobe_munmap() may 
update mm flags (MMF_RECALC_UPROBES). So, it sounds safer to not call it 
under read mmap_sem.

>
> OK, it can race with find_active_uprobe() but I do not see anything really
> wrong, and a false-positive MMF_RECALC_UPROBES is fine.

Thanks for confirming this. If it is ok to have such race, we don't have 
to have has_uprobes() helper anymore since it can be just called under 
read mmap_sem without any special handling.

Yang

>
> Again, I think we should simply kill uprobe_munmap(), but this needs another
> discussion.
>
> Oleg.

