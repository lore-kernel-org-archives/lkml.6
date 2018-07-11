Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD86C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF6120C0D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF6120C0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390070AbeGKROb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 13:14:31 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:49885 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388327AbeGKROa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 13:14:30 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0T4QoO.Q_1531328933;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T4QoO.Q_1531328933)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 12 Jul 2018 01:08:55 +0800
Subject: Re: [RFC v4 0/3] mm: zap pages with read mmap_sem in munmap for large
 mapping
To:     Michal Hocko <mhocko@kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     willy@infradead.org, ldufour@linux.vnet.ibm.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1531265649-93433-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180711103312.GH20050@dhcp22.suse.cz>
 <20180711111311.hrh5kxdottmpdpn2@kshutemo-mobl1>
 <20180711115332.GM20050@dhcp22.suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <4076e0b4-f3a8-6d71-2a98-e7b8cc6986d4@linux.alibaba.com>
Date:   Wed, 11 Jul 2018 10:08:52 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180711115332.GM20050@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/11/18 4:53 AM, Michal Hocko wrote:
> On Wed 11-07-18 14:13:12, Kirill A. Shutemov wrote:
>> On Wed, Jul 11, 2018 at 12:33:12PM +0200, Michal Hocko wrote:
>>> this is not a small change for something that could be achieved
>>> from the userspace trivially (just call madvise before munmap - library
>>> can hide this). Most workloads will even not care about races because
>>> they simply do not play tricks with mmaps and userspace MM. So why do we
>>> want to put the additional complexity into the kernel?
>> As I said before, kernel latency issues have to be addressed in kernel.
>> We cannot rely on userspace being kind here.
> Those who really care and create really large mappings will know how to
> do this properly. Most others just do not care enough. So I am not
> really sure this alone is a sufficient argument.
>
> I personally like the in kernel auto tuning but as I've said the
> changelog should be really clear why all the complications are
> justified. This would be a lot easier to argue about if it was a simple
> 	if (len > THARSHOLD)
> 		do_madvise(DONTNEED)
> 	munmap().

The main difference AFAICS, is it can't deal with the parallel faults 
and those special mappings. Someone may not care about it, but someone may.

Yang

> approach. But if we really have to care about parallel faults and munmap
> consitency this will always be tricky

