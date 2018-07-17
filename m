Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7CCECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50A220C0B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:06:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D50A220C0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbeGQJhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:37:54 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9680 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728610AbeGQJhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 05:37:54 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EC48386DB91B9;
        Tue, 17 Jul 2018 17:05:58 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.382.0; Tue, 17 Jul 2018
 17:05:53 +0800
Subject: Re: [PATCH v2] f2fs: clear the remaining prefree_map of the section
To:     Yunlong Song <yunlong.song@huawei.com>, <jaegeuk@kernel.org>,
        <chao@kernel.org>, <yunlong.song@icloud.com>
CC:     <miaoxie@huawei.com>, <bintian.wang@huawei.com>,
        <shengyong1@huawei.com>, <heyunlei@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1531735421-73669-1-git-send-email-yunlong.song@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <b81bb907-44cd-4cf3-4ddf-a759adec61fb@huawei.com>
Date:   Tue, 17 Jul 2018 17:05:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1531735421-73669-1-git-send-email-yunlong.song@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/16 18:03, Yunlong Song wrote:
> For the case when sbi->segs_per_sec > 1 with lfs mode, take
> section:segment = 5 for example, if the section prefree_map is
> ...previous section | current section (1 1 0 1 1) | next section...,
> then the start = x, end = x + 1, after start = start_segno +
> sbi->segs_per_sec, start = x + 5, then it will skip x + 3 and x + 4, but
> their bitmap is still set, which will cause duplicated
> f2fs_issue_discard of this same section in the next write_checkpoint, so
> fix it.

I mean:

Subject: [PATCH] f2fs: issue discard align to section in LFS mode

---
 fs/f2fs/segment.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index f12dad627fb4..6640c790cf64 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1761,6 +1761,7 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
 	unsigned int start = 0, end = -1;
 	unsigned int secno, start_segno;
 	bool force = (cpc->reason & CP_DISCARD);
+	bool need_align = test_opt(sbi, LFS) && sbi->segs_per_sec > 1;

 	mutex_lock(&dirty_i->seglist_lock);

@@ -1772,10 +1773,15 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
 		end = find_next_zero_bit(prefree_map, MAIN_SEGS(sbi),
 								start + 1);

-		for (i = start; i < end; i++)
-			clear_bit(i, prefree_map);
+		if (need_align) {
+			start = rounddown(start, sbi->segs_per_sec);
+			end = roundup(start, sbi->segs_per_sec);
+		}

-		dirty_i->nr_dirty[PRE] -= end - start;
+		for (i = start; i < end; i++) {
+			if (test_and_clear_bit(i, prefree_map))
+				dirty_i->nr_dirty[PRE]--;
+		}

 		if (!test_opt(sbi, DISCARD))
 			continue;
@@ -2564,6 +2570,7 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 	struct discard_policy dpolicy;
 	unsigned long long trimmed = 0;
 	int err = 0;
+	bool need_align = test_opt(sbi, LFS) && sbi->segs_per_sec > 1;

 	if (start >= MAX_BLKADDR(sbi) || range->len < sbi->blocksize)
 		return -EINVAL;
@@ -2582,6 +2589,12 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 	end_segno = (end >= MAX_BLKADDR(sbi)) ? MAIN_SEGS(sbi) - 1 :
 						GET_SEGNO(sbi, end);

+	if (need_align) {
+		start_segno = rounddown(start_segno, sbi->segs_per_sec);
+		end_segno = roundup(end_segno, sbi->segs_per_sec);
+		end_segno = min(end_segno, MAIN_SEGS(sbi) - 1);
+	}
+
 	cpc.reason = CP_DISCARD;
 	cpc.trim_minlen = max_t(__u64, 1, F2FS_BYTES_TO_BLK(range->minlen));
 	cpc.trim_start = start_segno;
-- 
2.18.0.rc1



> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>  fs/f2fs/segment.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index cfff7cf..5dc1d5cc 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1729,6 +1729,15 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
>  		if (!test_opt(sbi, DISCARD))
>  			continue;
>  
> +		if (test_opt(sbi, LFS) && sbi->segs_per_sec > 1) {
> +			start = rounddown(start, sbi->segs_per_sec);
> +			i = end;
> +			end = roundup(end, sbi->segs_per_sec);
> +			while (++i < end)
> +				if (test_and_clear_bit(i, prefree_map))
> +					dirty_i->nr_dirty[PRE]--;
> +		}
> +
>  		if (force && start >= cpc->trim_start &&
>  					(end - 1) <= cpc->trim_end)
>  				continue;
> 

