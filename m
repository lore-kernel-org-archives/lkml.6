Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC02CC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 06:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66CF520881
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 06:02:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66CF520881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751210AbeGJGCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 02:02:03 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9214 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750879AbeGJGCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 02:02:01 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 187C5E4AE2C5D;
        Tue, 10 Jul 2018 14:01:47 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.382.0; Tue, 10 Jul 2018
 14:01:45 +0800
Subject: Re: [f2fs-dev] [PATCH 1/4] f2fs: flush journal nat entries for
 nat_bits during unmount
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20180706210903.77887-1-jaegeuk@kernel.org>
 <ee638123-4114-badc-7d82-989e480ed45e@kernel.org>
 <20180709204306.GD24534@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <e50c1305-ef02-0380-ca2a-3760247f0d64@huawei.com>
Date:   Tue, 10 Jul 2018 14:01:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180709204306.GD24534@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/10 4:43, Jaegeuk Kim wrote:
> On 07/09, Chao Yu wrote:
>> On 2018/7/7 5:09, Jaegeuk Kim wrote:
>>> Let's flush journal nat entries for speed up in the next run.
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>  fs/f2fs/node.c | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>>> index 29237aeca041..0f076fb0d828 100644
>>> --- a/fs/f2fs/node.c
>>> +++ b/fs/f2fs/node.c
>>> @@ -2613,6 +2613,13 @@ void f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>>  	nid_t set_idx = 0;
>>>  	LIST_HEAD(sets);
>>>  
>>> +	/* during unmount, let's flush nat_bits before checking dirty_nat_cnt */
>>> +	if (enabled_nat_bits(sbi, cpc)) {
>>> +		down_write(&nm_i->nat_tree_lock);
>>> +		remove_nats_in_journal(sbi);
>>> +		up_write(&nm_i->nat_tree_lock);
>>> +	}
>>
>> The case will cover that nm_i->dirty_nat_cnt is zero and there is cached nats in
>> journal?
> 
> Yes.
> 
>>
>> So enabled_nat_bits() below should be removed?
> 
> It's out of lock, nm_i->nat_tree_lock, logically..

CP_NAT_BITS_FLAG modification should be happened in mount or checkpoint, so
there should be no contention.

Anyway, keep it here is okay to me.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> 
>>
>> 	if (enabled_nat_bits(sbi, cpc) ||
>> 		!__has_cursum_space(journal, nm_i->dirty_nat_cnt, NAT_JOURNAL))
>> 		remove_nats_in_journal(sbi);
>>
>> Thanks,
>>
>>> +
>>>  	if (!nm_i->dirty_nat_cnt)
>>>  		return;
>>>  
>>>
> 
> .
> 

