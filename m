Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D26ECE568
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73DE620877
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:07:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73DE620877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbeIYDLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 23:11:09 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:39321 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbeIYDLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 23:11:09 -0400
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w8OL71IG073280;
        Tue, 25 Sep 2018 06:07:01 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp);
 Tue, 25 Sep 2018 06:07:01 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w8OL6uFD073255
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 25 Sep 2018 06:07:01 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v4] block/loop: Serialize ioctl operations.
To:     Jan Kara <jack@suse.cz>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        syzbot 
        <syzbot+4684a000d5abdade83fac55b1e7d1f935ef1936e@syzkaller.appspotmail.com>,
        syzbot <syzbot+bf89c128e05dd6c62523@syzkaller.appspotmail.com>
References: <1537009136-4839-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <1af79300-cb04-36e3-a650-168a5942161f@i-love.sakura.ne.jp>
 <20180923220300.GA12589@ming.t460p>
 <ba535251-c206-6242-3e6d-a4ed825c8114@i-love.sakura.ne.jp>
 <20180924184734.GH28775@quack2.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <70de0609-c9f5-1747-93dc-fc4d693f1c27@i-love.sakura.ne.jp>
Date:   Tue, 25 Sep 2018 06:06:56 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180924184734.GH28775@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/09/25 3:47, Jan Kara wrote:
>> +/*
>> + * unlock_loop - Unlock loop_mutex as needed.
>> + *
>> + * Explicitly call this function before calling fput() or blkdev_reread_part()
>> + * in order to avoid circular lock dependency. After this function is called,
>> + * current thread is no longer allowed to access "struct loop_device" memory,
>> + * for another thread would access that memory as soon as loop_mutex is held.
>> + */
>> +static void unlock_loop(void)
>> +{
>> +	if (loop_mutex_owner == current) {
> 
> Urgh, why this check? Conditional locking / unlocking is evil so it has to
> have *very* good reasons and there is not any explanation here. So far I
> don't see a reason why this is needed at all.

Yeah, this is why Jens hates this patch. But any alternative?



>> @@ -630,7 +669,12 @@ static void loop_reread_partitions(struct loop_device *lo,
>> +	unlock_loop();
> 
> Unlocking in loop_reread_partitions() makes the locking rules ugly. And
> unnecessarily AFAICT. Can't we just use lo_refcnt to protect us against
> loop_clr_fd() and freeing of 'lo' structure itself?

Really? I think that just elevating lo->lo_refcnt will cause another lockdep
warning because __blkdev_reread_part() requires bdev->bd_mutex being held.
Don't we need to drop the lock in order to solve original lockdep warning at [2] ?

int __blkdev_reread_part(struct block_device *bdev)
{
	struct gendisk *disk = bdev->bd_disk;

	if (!disk_part_scan_enabled(disk) || bdev != bdev->bd_contains)
		return -EINVAL;
	if (!capable(CAP_SYS_ADMIN))
		return -EACCES;

	lockdep_assert_held(&bdev->bd_mutex);

	return rescan_partitions(disk, bdev);
}

int blkdev_reread_part(struct block_device *bdev)
{
	int res;

	mutex_lock(&bdev->bd_mutex);
	res = __blkdev_reread_part(bdev);
	mutex_unlock(&bdev->bd_mutex);

	return res;
}

