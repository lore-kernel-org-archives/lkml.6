Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7C3C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A0B24141
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:05:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A0B24141
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934253AbeGCRFZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:05:25 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:38626 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934156AbeGCRFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:05:23 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0T3vawT7_1530637505;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T3vawT7_1530637505)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 04 Jul 2018 01:05:12 +0800
Subject: Re: [PATCH 1/2] fs: ext4: use BUG_ON if writepage call comes from
 direct reclaim
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, mgorman@techsingularity.net,
        adilger.kernel@dilger.ca, darrick.wong@oracle.com,
        dchinner@redhat.com, akpm@linux-foundation.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1530591079-33813-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180703103948.GB27426@thunk.org>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <6c305241-d502-b8ea-a187-54c33e4ca692@linux.alibaba.com>
Date:   Tue, 3 Jul 2018 10:05:04 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180703103948.GB27426@thunk.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/3/18 3:39 AM, Theodore Y. Ts'o wrote:
> On Tue, Jul 03, 2018 at 12:11:18PM +0800, Yang Shi wrote:
>> direct reclaim doesn't write out filesystem page, only kswapd could do
>> it. So, if the call comes from direct reclaim, it is definitely a bug.
>>
>> And, Mel Gormane also mentioned "Ultimately, this will be a BUG_ON." In
>> commit 94054fa3fca1fd78db02cb3d68d5627120f0a1d4 ("xfs: warn if direct
>> reclaim tries to writeback pages").
>>
>> Although it is for xfs, ext4 has the similar behavior, so elevate
>> WARN_ON to BUG_ON.
>>
>> And, correct the comment accordingly.
>>
>> Cc: Mel Gorman <mgorman@techsingularity.net>
>> Cc: "Theodore Ts'o" <tytso@mit.edu>
>> Cc: Andreas Dilger <adilger.kernel@dilger.ca>
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> What's the upside of crashing the kernel if the file sytsem can handle it?

I'm not sure if it is a good choice to let filesystem handle such vital 
VM regression. IMHO, writing out filesystem page from direct reclaim 
context is a vital VM bug. It means something is definitely wrong in VM. 
It should never happen.

It sounds ok to have filesystem throw out warning and handle it, but I'm 
not sure if someone will just ignore the warning, but it should *never* 
be ignored.

Yang

>
>         	   	     	      	  	    - Ted

