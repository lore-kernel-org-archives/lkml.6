Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CF4C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E607320890
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:11:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E607320890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752584AbeGCXLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 19:11:07 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:38205 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750764AbeGCXLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 19:11:05 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0T3w9gsf_1530659453;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T3w9gsf_1530659453)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 04 Jul 2018 07:10:58 +0800
Subject: Re: [PATCH 1/2] fs: ext4: use BUG_ON if writepage call comes from
 direct reclaim
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, mgorman@techsingularity.net,
        adilger.kernel@dilger.ca, akpm@linux-foundation.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1530591079-33813-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180703103948.GB27426@thunk.org>
 <6c305241-d502-b8ea-a187-54c33e4ca692@linux.alibaba.com>
Message-ID: <f15b7474-66bd-515b-9c0e-16909bb2255d@linux.alibaba.com>
Date:   Tue, 3 Jul 2018 16:10:51 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <6c305241-d502-b8ea-a187-54c33e4ca692@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/3/18 10:05 AM, Yang Shi wrote:
>
>
> On 7/3/18 3:39 AM, Theodore Y. Ts'o wrote:
>> On Tue, Jul 03, 2018 at 12:11:18PM +0800, Yang Shi wrote:
>>> direct reclaim doesn't write out filesystem page, only kswapd could do
>>> it. So, if the call comes from direct reclaim, it is definitely a bug.
>>>
>>> And, Mel Gormane also mentioned "Ultimately, this will be a BUG_ON." In
>>> commit 94054fa3fca1fd78db02cb3d68d5627120f0a1d4 ("xfs: warn if direct
>>> reclaim tries to writeback pages").
>>>
>>> Although it is for xfs, ext4 has the similar behavior, so elevate
>>> WARN_ON to BUG_ON.
>>>
>>> And, correct the comment accordingly.
>>>
>>> Cc: Mel Gorman <mgorman@techsingularity.net>
>>> Cc: "Theodore Ts'o" <tytso@mit.edu>
>>> Cc: Andreas Dilger <adilger.kernel@dilger.ca>
>>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>> What's the upside of crashing the kernel if the file sytsem can 
>> handle it?

BTW, the comment does sound misleading. Direct reclaim is not a 
legitimate context to call writepage. I'd like to correct at least.

Thanks,
Yang

>
> I'm not sure if it is a good choice to let filesystem handle such 
> vital VM regression. IMHO, writing out filesystem page from direct 
> reclaim context is a vital VM bug. It means something is definitely 
> wrong in VM. It should never happen.
>
> It sounds ok to have filesystem throw out warning and handle it, but 
> I'm not sure if someone will just ignore the warning, but it should 
> *never* be ignored.
>
> Yang
>
>>
>>                                                 - Ted
>

