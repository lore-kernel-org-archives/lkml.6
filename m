Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F08C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 002ED2064D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:20:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 002ED2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbeGXQ1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:27:30 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44653 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726857AbeGXQ1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:27:30 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CBB87DCFE5A4F;
        Tue, 24 Jul 2018 23:20:27 +0800 (CST)
Received: from [127.0.0.1] (10.111.220.140) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.382.0; Tue, 24 Jul 2018
 23:20:19 +0800
Subject: Re: [PATCH 2/5] f2fs: add cur_victim_sec for BG_GC to avoid skipping
 BG_GC victim
To:     Chao Yu <chao@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        <jaegeuk@kernel.org>, <yunlong.song@icloud.com>
CC:     <miaoxie@huawei.com>, <bintian.wang@huawei.com>,
        <shengyong1@huawei.com>, <heyunlei@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1532355022-163029-1-git-send-email-yunlong.song@huawei.com>
 <1532355022-163029-3-git-send-email-yunlong.song@huawei.com>
 <42824b9f-6ebb-2280-0a62-c74954fff39c@huawei.com>
 <a052ec0f-1581-a199-0eb4-7adeef6d55fc@huawei.com>
 <07419cf7-057a-e92a-2478-4f827a1d6b2f@kernel.org>
From:   Yunlong Song <yunlong.song@huawei.com>
Message-ID: <93455370-8524-6a1d-8104-4cf19510ec15@huawei.com>
Date:   Tue, 24 Jul 2018 23:19:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <07419cf7-057a-e92a-2478-4f827a1d6b2f@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.111.220.140]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/7/24 22:17, Chao Yu wrote:
> On 2018/7/24 21:39, Yunlong Song wrote:
>>
>> On 2018/7/24 21:11, Chao Yu wrote:
>>> On 2018/7/23 22:10, Yunlong Song wrote:
>>>> If f2fs aborts BG_GC, then the section bit of victim_secmap will be set,
>>>> which will cause the section skipped in the future get_victim of BG_GC.
>>>> In a worst case that each section in the victim_secmap is set and there
>>>> are enough free sections (so FG_GC can not be triggered), then BG_GC
>>>> will skip all the sections and cannot find any victims, causing BG_GC
>>> If f2fs aborts BG_GC, we'd better to clear victim_secmap?
>> We can keep the bit set in victim_secmap for FG_GC use next time as before, the
> No, I don't think we could assume that FGGC will come soon, and in adaptive
> mode, after we triggered SSR agressively, FG_GC will be much less.
>
> For your case, we need to clear victim_secmap.
However, if it is cleared, then FG_GC will lose the chance to have a 
quick selection of the victim
candidate, which BG_GC has selected and aborted in last round or there 
are still some blocks
ungced because these blocks belong to an opening atomic file. Especially 
for the large section
case, when BG_GC stops its job if IO state change from idle to busy, 
then it is better that FG_GC
can continue to gc the section selected before. So how about adding 
another map to record these
sections, and make FG_GC/BG_GC select these sections, as for the old 
victim_secmap, keep its
old logic, BG_GC can not select those sections in victim_secmap, but 
FG_GC can.

>
>> diffierent
>> is that this patch will make BG_GC ignore the bit set in victim_secmap, so BG_GC
>> can still
>> get the the section (which is in set) as victim and do GC jobs.
> I guess this scenario is the case our previous scheme tries to prevent, since if
> in selected section, all block there are cached and set dirty, BGGC will end up
> with doing nothing, it's inefficient.

OK, I understand.

>
> Thanks,
>
>>>> failed each time. Besides, SSR also uses BG_GC to get ssr segment, if
>>> Looks like foreground GC will try to grab section which is selected as
>>> victim of background GC?
>> Yes, this is exactly the value of victim_secmap, it helps FG_GC reduce time in
>> selecting victims
>> and continue the job which BG_GC has not finished.
>>
>>> Thanks,
>>>
>>>> many sections in the victim_secmap are set, then SSR cannot get a proper
>>>> ssr segment to allocate blocks, which makes SSR inefficiently. To fix
>>>> this problem, we can add cur_victim_sec for BG_GC similar like that in
>>>> FG_GC to avoid selecting the same section repeatedly.
>>>>
>>>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>>>> ---
>>>>    fs/f2fs/f2fs.h              |  3 ++-
>>>>    fs/f2fs/gc.c                | 15 +++++++++------
>>>>    fs/f2fs/segment.h           |  3 ++-
>>>>    fs/f2fs/super.c             |  3 ++-
>>>>    include/trace/events/f2fs.h | 18 ++++++++++++------
>>>>    5 files changed, 27 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>> index 57a8851..f8a7b42 100644
>>>> --- a/fs/f2fs/f2fs.h
>>>> +++ b/fs/f2fs/f2fs.h
>>>> @@ -1217,7 +1217,8 @@ struct f2fs_sb_info {
>>>>        /* for cleaning operations */
>>>>        struct mutex gc_mutex;            /* mutex for GC */
>>>>        struct f2fs_gc_kthread    *gc_thread;    /* GC thread */
>>>> -    unsigned int cur_victim_sec;        /* current victim section num */
>>>> +    unsigned int cur_fg_victim_sec;        /* current FG_GC victim section
>>>> num */
>>>> +    unsigned int cur_bg_victim_sec;        /* current BG_GC victim section
>>>> num */
>>>>        unsigned int gc_mode;            /* current GC state */
>>>>        /* for skip statistic */
>>>>        unsigned long long skipped_atomic_files[2];    /* FG_GC and BG_GC */
>>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>>> index 2ba470d..705d419 100644
>>>> --- a/fs/f2fs/gc.c
>>>> +++ b/fs/f2fs/gc.c
>>>> @@ -367,8 +367,6 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
>>>>              if (sec_usage_check(sbi, secno))
>>>>                goto next;
>>>> -        if (gc_type == BG_GC && test_bit(secno, dirty_i->victim_secmap))
>>>> -            goto next;
>>>>              cost = get_gc_cost(sbi, segno, &p);
>>>>    @@ -391,14 +389,17 @@ static int get_victim_by_default(struct f2fs_sb_info
>>>> *sbi,
>>>>            if (p.alloc_mode == LFS) {
>>>>                secno = GET_SEC_FROM_SEG(sbi, p.min_segno);
>>>>                if (gc_type == FG_GC)
>>>> -                sbi->cur_victim_sec = secno;
>>>> -            else
>>>> +                sbi->cur_fg_victim_sec = secno;
>>>> +            else {
>>>>                    set_bit(secno, dirty_i->victim_secmap);
>>>> +                sbi->cur_bg_victim_sec = secno;
>>>> +            }
>>>>            }
>>>>            *result = (p.min_segno / p.ofs_unit) * p.ofs_unit;
>>>>              trace_f2fs_get_victim(sbi->sb, type, gc_type, &p,
>>>> -                sbi->cur_victim_sec,
>>>> +                sbi->cur_fg_victim_sec,
>>>> +                sbi->cur_bg_victim_sec,
>>>>                    prefree_segments(sbi), free_segments(sbi));
>>>>        }
>>>>    out:
>>>> @@ -1098,7 +1099,9 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>>>>        }
>>>>          if (gc_type == FG_GC)
>>>> -        sbi->cur_victim_sec = NULL_SEGNO;
>>>> +        sbi->cur_fg_victim_sec = NULL_SEGNO;
>>>> +    else
>>>> +        sbi->cur_bg_victim_sec = NULL_SEGNO;
>>>>          if (!sync) {
>>>>            if (has_not_enough_free_secs(sbi, sec_freed, 0)) {
>>>> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
>>>> index 5049551..b21bb96 100644
>>>> --- a/fs/f2fs/segment.h
>>>> +++ b/fs/f2fs/segment.h
>>>> @@ -787,7 +787,8 @@ static inline block_t sum_blk_addr(struct f2fs_sb_info
>>>> *sbi, int base, int type)
>>>>      static inline bool sec_usage_check(struct f2fs_sb_info *sbi, unsigned int
>>>> secno)
>>>>    {
>>>> -    if (IS_CURSEC(sbi, secno) || (sbi->cur_victim_sec == secno))
>>>> +    if (IS_CURSEC(sbi, secno) || (sbi->cur_fg_victim_sec == secno) ||
>>>> +        (sbi->cur_bg_victim_sec == secno))
>>>>            return true;
>>>>        return false;
>>>>    }
>>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>>> index 7187885..ef69ebf 100644
>>>> --- a/fs/f2fs/super.c
>>>> +++ b/fs/f2fs/super.c
>>>> @@ -2386,7 +2386,8 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
>>>>        sbi->root_ino_num = le32_to_cpu(raw_super->root_ino);
>>>>        sbi->node_ino_num = le32_to_cpu(raw_super->node_ino);
>>>>        sbi->meta_ino_num = le32_to_cpu(raw_super->meta_ino);
>>>> -    sbi->cur_victim_sec = NULL_SECNO;
>>>> +    sbi->cur_fg_victim_sec = NULL_SECNO;
>>>> +    sbi->cur_bg_victim_sec = NULL_SECNO;
>>>>        sbi->max_victim_search = DEF_MAX_VICTIM_SEARCH;
>>>>          sbi->dir_level = DEF_DIR_LEVEL;
>>>> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
>>>> index 7956989..0f01f82 100644
>>>> --- a/include/trace/events/f2fs.h
>>>> +++ b/include/trace/events/f2fs.h
>>>> @@ -693,10 +693,12 @@
>>>>    TRACE_EVENT(f2fs_get_victim,
>>>>          TP_PROTO(struct super_block *sb, int type, int gc_type,
>>>> -            struct victim_sel_policy *p, unsigned int pre_victim,
>>>> +            struct victim_sel_policy *p, unsigned int pre_fg_victim,
>>>> +            unsigned int pre_bg_victim,
>>>>                unsigned int prefree, unsigned int free),
>>>>    -    TP_ARGS(sb, type, gc_type, p, pre_victim, prefree, free),
>>>> +    TP_ARGS(sb, type, gc_type, p, pre_fg_victim, pre_bg_victim,
>>>> +        prefree, free),
>>>>          TP_STRUCT__entry(
>>>>            __field(dev_t,    dev)
>>>> @@ -707,7 +709,8 @@
>>>>            __field(unsigned int,    victim)
>>>>            __field(unsigned int,    cost)
>>>>            __field(unsigned int,    ofs_unit)
>>>> -        __field(unsigned int,    pre_victim)
>>>> +        __field(unsigned int,    pre_fg_victim)
>>>> +        __field(unsigned int,    pre_bg_victim)
>>>>            __field(unsigned int,    prefree)
>>>>            __field(unsigned int,    free)
>>>>        ),
>>>> @@ -721,14 +724,16 @@
>>>>            __entry->victim        = p->min_segno;
>>>>            __entry->cost        = p->min_cost;
>>>>            __entry->ofs_unit    = p->ofs_unit;
>>>> -        __entry->pre_victim    = pre_victim;
>>>> +        __entry->pre_fg_victim    = pre_fg_victim;
>>>> +        __entry->pre_bg_victim    = pre_bg_victim;
>>>>            __entry->prefree    = prefree;
>>>>            __entry->free        = free;
>>>>        ),
>>>>          TP_printk("dev = (%d,%d), type = %s, policy = (%s, %s, %s), "
>>>>            "victim = %u, cost = %u, ofs_unit = %u, "
>>>> -        "pre_victim_secno = %d, prefree = %u, free = %u",
>>>> +        "pre_fg_victim_secno = %d, pre_bg_victim_secno = %d, "
>>>> +        "prefree = %u, free = %u",
>>>>            show_dev(__entry->dev),
>>>>            show_data_type(__entry->type),
>>>>            show_gc_type(__entry->gc_type),
>>>> @@ -737,7 +742,8 @@
>>>>            __entry->victim,
>>>>            __entry->cost,
>>>>            __entry->ofs_unit,
>>>> -        (int)__entry->pre_victim,
>>>> +        (int)__entry->pre_fg_victim,
>>>> +        (int)__entry->pre_bg_victim,
>>>>            __entry->prefree,
>>>>            __entry->free)
>>>>    );
>>>>
>>> .
>>>
> .
>

-- 
Thanks,
Yunlong Song


