Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBCAC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 031AD2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:59:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 031AD2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbeLEI7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:59:30 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:40133 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726102AbeLEI7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:59:30 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TEv2g.D_1544000312;
Received: from xunleideMacBook-Pro.local(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0TEv2g.D_1544000312)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 05 Dec 2018 16:58:32 +0800
Reply-To: xlpang@linux.alibaba.com
Subject: Re: [PATCH 1/3] mm/memcg: Fix min/low usage in
 propagate_protected_usage()
To:     Roman Gushchin <guro@fb.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20181203080119.18989-1-xlpang@linux.alibaba.com>
 <20181203180008.GB31090@castle.DHCP.thefacebook.com>
From:   Xunlei Pang <xlpang@linux.alibaba.com>
Message-ID: <03652447-d9ba-45ea-3365-46a4caf96748@linux.alibaba.com>
Date:   Wed, 5 Dec 2018 16:58:31 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181203180008.GB31090@castle.DHCP.thefacebook.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

On 2018/12/4 AM 2:00, Roman Gushchin wrote:
> On Mon, Dec 03, 2018 at 04:01:17PM +0800, Xunlei Pang wrote:
>> When usage exceeds min, min usage should be min other than 0.
>> Apply the same for low.
>>
>> Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
>> ---
>>  mm/page_counter.c | 12 ++----------
>>  1 file changed, 2 insertions(+), 10 deletions(-)
>>
>> diff --git a/mm/page_counter.c b/mm/page_counter.c
>> index de31470655f6..75d53f15f040 100644
>> --- a/mm/page_counter.c
>> +++ b/mm/page_counter.c
>> @@ -23,11 +23,7 @@ static void propagate_protected_usage(struct page_counter *c,
>>  		return;
>>  
>>  	if (c->min || atomic_long_read(&c->min_usage)) {
>> -		if (usage <= c->min)
>> -			protected = usage;
>> -		else
>> -			protected = 0;
>> -
>> +		protected = min(usage, c->min);
> 
> This change makes sense in the combination with the patch 3, but not as a
> standlone "fix". It's not a bug, it's a required thing unless you start scanning
> proportionally to memory.low/min excess.
> 
> Please, reflect this in the commit message. Or, even better, merge it into
> the patch 3.

The more I looked the more I think it's a bug, but anyway I'm fine with
merging it into patch 3 :-)

> 
> Also, please, make sure that cgroup kselftests are passing after your changes.

Sure, will do and send v2. Thanks for your inputs.
