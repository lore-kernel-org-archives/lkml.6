Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 09659C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B372C208B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B372C208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934832AbeFMQVK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 12:21:10 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:56359 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754536AbeFMQVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 12:21:08 -0400
Received: from fsav105.sakura.ne.jp (fsav105.sakura.ne.jp [27.133.134.232])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w5DGKLEE052053;
        Thu, 14 Jun 2018 01:20:21 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav105.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp);
 Thu, 14 Jun 2018 01:20:21 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w5DGKLok052049
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 14 Jun 2018 01:20:21 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] bdi: Fix another oops in wb_workfn()
To:     Jan Kara <jack@suse.cz>
Cc:     Tejun Heo <tj@kernel.org>, Dmitry Vyukov <dvyukov@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        syzbot <syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <CACT4Y+bHDWDapwOonO1EpR6TiRa=qf9nSDtHArq75yCGuHf=gg@mail.gmail.com>
 <CACT4Y+Z4i=bD49cb4pJ5zOMxVu675NT8wCNk+c2n2XJVOXG2bg@mail.gmail.com>
 <2b437c6f-3e10-3d83-bdf3-82075d3eaa1a@i-love.sakura.ne.jp>
 <3cf4b0e3-31b6-8cdc-7c1e-15ba575a7879@i-love.sakura.ne.jp>
 <20180611091248.2i6nt27h5mxrodm2@quack2.suse.cz>
 <20180611160131.GQ1351649@devbig577.frc2.facebook.com>
 <20180611162920.mwapvuqotvhkntt3@quack2.suse.cz>
 <20180611172053.GR1351649@devbig577.frc2.facebook.com>
 <20180612155754.x5k2yndh5t6wlmpy@quack2.suse.cz>
 <b210e55c-b06a-41ff-8592-0dbe21875779@i-love.sakura.ne.jp>
 <20180613144606.nvbcyg2rdjpxhf7s@quack2.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <7f4ae045-dfe4-6677-7418-f6f60b6c26f1@i-love.sakura.ne.jp>
Date:   Thu, 14 Jun 2018 01:20:16 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180613144606.nvbcyg2rdjpxhf7s@quack2.suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/06/13 23:46, Jan Kara wrote:
> On Wed 13-06-18 19:43:47, Tetsuo Handa wrote:
>> Can't we utilize RCU grace period (like shown below) ?
> 
> Honestly, the variant 1 looks too ugly to me. However variant 2 looks
> mostly OK. We can also avoid the schedule_timeout_uninterruptible(HZ / 10)
> from your patch by careful handling of the bit waitqueues. Also I'd avoid
> the addition argument to wb_writeback() and split the function instead. The
> patch resulting from your and mine ideas is attached. Thoughts?
> 
> 								Honza
> 

+static bool cgwb_start_shutdown(struct bdi_writeback *wb)
+	__releases(cgwb_lock)
+{
+	if (!wb_start_shutdown(wb)) {
+		DEFINE_WAIT(wait);
+		wait_queue_head_t *wqh = bit_waitqueue(&wb->state,
+						       WB_shutting_down);
+		bool sleep;
+
+		prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
+		sleep = test_bit(WB_shutting_down, &wb->state);
+		spin_unlock_irq(&cgwb_lock);
+		if (sleep)
+			schedule();
+		return false;
+	}
+	spin_unlock_irq(&cgwb_lock);
+	return true;
+}

Since multiple addresses share bit_wait_table[256], isn't it possible that
cgwb_start_shutdown() prematurely returns false due to wake_up_bit() by
hash-conflicting addresses (i.e. not limited to clear_and_wake_up_bit() from
wb_shutdown())? I think that we cannot be sure without confirming that
test_bit(WB_shutting_down, &wb->state) == false after returning from schedule().
