Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0FDC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D997B2133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbeLRItO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:49:14 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:16149 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726316AbeLRItM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:49:12 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 04226EBF28B95;
        Tue, 18 Dec 2018 16:49:08 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Tue, 18 Dec 2018
 16:49:08 +0800
Subject: Re: [f2fs-dev] [PATCH 3/3] f2fs: flush stale issued discard
 candidates
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20181214050127.45025-1-jaegeuk@kernel.org>
 <20181214050127.45025-3-jaegeuk@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <639940cc-f7a8-e679-3b28-3b3b2485652b@huawei.com>
Date:   Tue, 18 Dec 2018 16:49:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181214050127.45025-3-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/14 13:01, Jaegeuk Kim wrote:
> Sometimes, I could observe # of issuing_discard to be 1 which blocks background
> jobs due to is_idle()=false.
> The only way to get out of it was to trigger gc_urgent. This patch avoids that
> by checking any candidates as done in the list.

Well, as below code, once we issued discard commands, we will wait all
queued discard end their IO, so do you know what flow can cause such
condition...?

		issued = __issue_discard_cmd(sbi, &dpolicy);
		if (issued > 0) {
			__wait_all_discard_cmd(sbi, &dpolicy);

Or, I doubt that 'issued' statistical info could be wrong.

Thanks,

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/segment.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 49ea9009ab5a..acbbc924e518 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1651,6 +1651,10 @@ static int issue_discard_thread(void *data)
>  		if (dcc->discard_wake)
>  			dcc->discard_wake = 0;
>  
> +		/* clean up pending candidates before going to sleep */
> +		if (atomic_read(&dcc->queued_discard))
> +			__wait_all_discard_cmd(sbi, NULL);
> +
>  		if (try_to_freeze())
>  			continue;
>  		if (f2fs_readonly(sbi->sb))
> 

