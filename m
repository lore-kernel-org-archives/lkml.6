Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACB7ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3860D208E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:00:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3860D208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbeGMJNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:13:42 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50187 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726626AbeGMJNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:13:42 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 74DE9A456CDA2;
        Fri, 13 Jul 2018 16:59:56 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.382.0; Fri, 13 Jul 2018
 16:59:48 +0800
Subject: Re: [PATCH 2/5] f2fs: clear the remaining prefree_map of the section
To:     Yunlong Song <yunlong.song@huawei.com>, <jaegeuk@kernel.org>,
        <chao@kernel.org>, <yunlong.song@icloud.com>
CC:     <miaoxie@huawei.com>, <bintian.wang@huawei.com>,
        <shengyong1@huawei.com>, <heyunlei@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1531408170-45758-1-git-send-email-yunlong.song@huawei.com>
 <1531408170-45758-3-git-send-email-yunlong.song@huawei.com>
 <c9a3972b-dc52-19ca-7ed0-2f754d89ab33@huawei.com>
 <75dc9cad-8166-82c5-e085-88c9623f5c5e@huawei.com>
 <12f3c3d2-6586-ca73-8770-8f97b436d643@huawei.com>
 <52acc420-2a08-c5e9-f63e-74d63fb11126@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <9e5ce0bb-22ed-6b30-4592-8d7e371f31a4@huawei.com>
Date:   Fri, 13 Jul 2018 16:59:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <52acc420-2a08-c5e9-f63e-74d63fb11126@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/13 11:51, Yunlong Song wrote:
> Because in f2fs_clear_prefree_segments, the codes:
> ...
>      while (1) {
>          int i;
>          start = find_next_bit(prefree_map, MAIN_SEGS(sbi), end + 1);
>          if (start >= MAIN_SEGS(sbi))
>              break;
>          end = find_next_zero_bit(prefree_map, MAIN_SEGS(sbi),
>                                  start + 1);
> 
>          for (i = start; i < end; i++)
>              clear_bit(i, prefree_map);
> ...
> next:
>          secno = GET_SEC_FROM_SEG(sbi, start);
>          start_segno = GET_SEG_FROM_SEC(sbi, secno);
>          if (!IS_CURSEC(sbi, secno) &&
>              !get_valid_blocks(sbi, start, true))
>              f2fs_issue_discard(sbi, START_BLOCK(sbi, start_segno),
>                  sbi->segs_per_sec << sbi->log_blocks_per_seg);
> 
>          start = start_segno + sbi->segs_per_sec;
>          if (start < end)
>              goto next;
>          else
>              end = start - 1;
> ...
> In round 2, for prefree_map: 1 1 0 1 1, start = 0, end = 2, then
> 
> start = start_segno + sbi->segs_per_sec makes start = 5
> 
> if (start < end)  --> start = 5, end = 2
> 
> so end = start -1  --> end = 4, then return to while again, this time skips
> prefree bit 3 and 4.

I got it, thanks for the explanation.

If we are in LFS mode & with big section, what about aligning start/end to
section boundary for fstrim or real-time discard operation, and decide to issue
discard only when whole section is invalid and the last segment in section is
freed in current checkpoint? so that we can issue discard aligned to section
size as much as possible and avoid redundant discard.

Thanks,

> 
> On 2018/7/13 11:42, Chao Yu wrote:
>> On 2018/7/13 11:28, Yunlong Song wrote:
>>> round 1: section bitmap : 1 1 1 1 1, all valid, prefree_map: 0 0 0 0 0
>>> then rm data block NO.2, block NO.2 becomes invalid, prefree_map: 0 0 1 0 0
>>> write_checkpoint: section bitmap: 1 1 0 1 1, prefree_map: 0 0 0 0 0,
>>> prefree of NO.2 is cleared, and no discard issued
>>>
>>> round2: rm data block NO.0, NO.1, NO.3, NO.4
>>> all invalid, but prefree bit of NO.2 is set and cleared in round1, then
>>> prefree_map: 1 1 0 1 1
>>> write_checkpoint: section bitmap: 0 0 0 0 0, prefree_map: 0 0 0 1 1, no
>> Why prefree_map is not 0 0 0 0 0?
>>
>> Thanks,
>>
>>> valid blocks of this section, so discard issued
>>> but this time prefree bit of NO.3 and NO.4 is skipped...
>>>
>>> round3:
>>> write_checkpoint: section bitmap: 0 0 0 0 0, prefree_map: 0 0 0 1 1 - >
>>> 0 0 0 0 0, no valid blocks of this section, so discard issued
>>> this time prefree bit of NO.3 and NO.4 is cleared, but the discard of
>>> this section is sent again...
>>>
>>> On 2018/7/13 11:13, Chao Yu wrote:
>>>> On 2018/7/12 23:09, Yunlong Song wrote:
>>>>> For the case when sbi->segs_per_sec > 1, take section:segment = 5 for
>>>>> example, if the section prefree_map is ...previous section | current
>>>>> section (1 1 0 1 1) | next section..., then the start = x, end = x + 1,
>>>>> after start = start_segno + sbi->segs_per_sec, start = x + 5, then it
>>>>> will skip x + 3 and x + 4, but their bitmap is still set, which will
>>>>> cause duplicated f2fs_issue_discard of this same section in the next
>>>>> write_checkpoint, so fix it.
>>>> I didn't get it, if # 2 segment is not prefree state, so it still has valid
>>>> blocks there, so we won't issue discard due to below condition, right?
>>>>
>>>> 		if (!IS_CURSEC(sbi, secno) &&
>>>> 			!get_valid_blocks(sbi, start, true))
>>>>
>>>> Thanks,
>>>>
>>>>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>>>>> ---
>>>>>    fs/f2fs/segment.c | 19 +++++++++++++++++--
>>>>>    1 file changed, 17 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>>>> index 47b6595..fd38b61 100644
>>>>> --- a/fs/f2fs/segment.c
>>>>> +++ b/fs/f2fs/segment.c
>>>>> @@ -1684,8 +1684,23 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
>>>>>    		start = start_segno + sbi->segs_per_sec;
>>>>>    		if (start < end)
>>>>>    			goto next;
>>>>> -		else
>>>>> -			end = start - 1;
>>>>> +		else {
>>>>> +			start_segno = start;
>>>>> +
>>>>> +			while (1) {
>>>>> +				start = find_next_bit(prefree_map, start_segno,
>>>>> +									end + 1);
>>>>> +				if (start >= start_segno)
>>>>> +					break;
>>>>> +				end = find_next_zero_bit(prefree_map, start_segno,
>>>>> +										start + 1);
>>>>> +				for (i = start; i < end; i++)
>>>>> +					clear_bit(i, prefree_map);
>>>>> +				dirty_i->nr_dirty[PRE] -= end - start;
>>>>> +			}
>>>>> +
>>>>> +			end = start_segno - 1;
>>>>> +		}
>>>>>    	}
>>>>>    	mutex_unlock(&dirty_i->seglist_lock);
>>>>>    
>>>>>
>>>> .
>>>>
>>
>> .
>>
> 

