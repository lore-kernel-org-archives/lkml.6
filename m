Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B0113C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 705FC20020
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 705FC20020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935472AbeFMLwB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 07:52:01 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:48381 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754096AbeFMLv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 07:51:59 -0400
Received: from fsav404.sakura.ne.jp (fsav404.sakura.ne.jp [133.242.250.103])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w5DBpBus013000;
        Wed, 13 Jun 2018 20:51:11 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav404.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav404.sakura.ne.jp);
 Wed, 13 Jun 2018 20:51:11 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav404.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w5DBpA17012994
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 13 Jun 2018 20:51:10 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] bdi: Fix another oops in wb_workfn()
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>, Jens Axboe <axboe@kernel.dk>,
        syzbot <syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <CACT4Y+Y7Mj1JngLst1aRHDhURXQMn-eTjyPFjDdGAT0ZV-dHrw@mail.gmail.com>
 <CACT4Y+bBfwpcP2h0URpqwiNMQ5SFJdPDHThUu2xetmrxgC+3BQ@mail.gmail.com>
 <CACT4Y+bHDWDapwOonO1EpR6TiRa=qf9nSDtHArq75yCGuHf=gg@mail.gmail.com>
 <CACT4Y+Z4i=bD49cb4pJ5zOMxVu675NT8wCNk+c2n2XJVOXG2bg@mail.gmail.com>
 <2b437c6f-3e10-3d83-bdf3-82075d3eaa1a@i-love.sakura.ne.jp>
 <3cf4b0e3-31b6-8cdc-7c1e-15ba575a7879@i-love.sakura.ne.jp>
 <20180611091248.2i6nt27h5mxrodm2@quack2.suse.cz>
 <20180611160131.GQ1351649@devbig577.frc2.facebook.com>
 <20180611162920.mwapvuqotvhkntt3@quack2.suse.cz>
 <20180611172053.GR1351649@devbig577.frc2.facebook.com>
 <20180612155754.x5k2yndh5t6wlmpy@quack2.suse.cz>
 <b210e55c-b06a-41ff-8592-0dbe21875779@i-love.sakura.ne.jp>
Message-ID: <6d3dc916-94fd-3684-7861-6b120e5616ee@i-love.sakura.ne.jp>
Date:   Wed, 13 Jun 2018 20:51:13 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <b210e55c-b06a-41ff-8592-0dbe21875779@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tetsuo Handa wrote:
> Or, toggling a dedicated flag using test_and_change_bit():
> 
> 
>  include/linux/backing-dev-defs.h | 1 +
>  mm/backing-dev.c                 | 8 +++++++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
> index 0bd432a..93ff83c 100644
> --- a/include/linux/backing-dev-defs.h
> +++ b/include/linux/backing-dev-defs.h
> @@ -26,6 +26,7 @@ enum wb_state {
>  	WB_writeback_running,	/* Writeback is in progress */
>  	WB_has_dirty_io,	/* Dirty inodes on ->b_{dirty|io|more_io} */
>  	WB_start_all,		/* nr_pages == 0 (all) work pending */
> +	WB_postpone_kfree,      /* cgwb_bdi_unregister() will access later */
>  };
>  
>  enum wb_congested_state {
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 347cc83..422d7a7 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -516,7 +516,10 @@ static void cgwb_release_workfn(struct work_struct *work)
>  	fprop_local_destroy_percpu(&wb->memcg_completions);
>  	percpu_ref_exit(&wb->refcnt);
>  	wb_exit(wb);
> -	kfree_rcu(wb, rcu);
> +	spin_lock_irq(&cgwb_lock);
> +	if (!test_and_change_bit(WB_postpone_kfree, &wb->state))
> +		kfree_rcu(wb, rcu);
> +	spin_unlock_irq(&cgwb_lock);
>  }
>  
>  static void cgwb_release(struct percpu_ref *refcnt)
> @@ -721,9 +724,12 @@ static void cgwb_bdi_unregister(struct backing_dev_info *bdi)
>  	while (!list_empty(&bdi->wb_list)) {
>  		wb = list_first_entry(&bdi->wb_list, struct bdi_writeback,
>  				      bdi_node);
> +		set_bit(WB_postpone_kfree, &wb->state);
>  		spin_unlock_irq(&cgwb_lock);
>  		wb_shutdown(wb);
>  		spin_lock_irq(&cgwb_lock);
> +		if (!test_and_change_bit(WB_postpone_kfree, &wb->state))
> +			kfree_rcu(wb, rcu);
>  	}
>  	spin_unlock_irq(&cgwb_lock);
>  }

Forgot to include below change, but isn't this approach the simplest?

@@ -370,7 +370,6 @@ static void wb_shutdown(struct bdi_writeback *wb)
 	set_bit(WB_shutting_down, &wb->state);
 	spin_unlock_bh(&wb->work_lock);
 
-	cgwb_remove_from_bdi_list(wb);
 	/*
 	 * Drain work list and shutdown the delayed_work.  !WB_registered
 	 * tells wb_workfn() that @wb is dying and its work_list needs to
@@ -379,6 +378,7 @@ static void wb_shutdown(struct bdi_writeback *wb)
 	mod_delayed_work(bdi_wq, &wb->dwork, 0);
 	flush_delayed_work(&wb->dwork);
 	WARN_ON(!list_empty(&wb->work_list));
+	cgwb_remove_from_bdi_list(wb);
 	/*
 	 * Make sure bit gets cleared after shutdown is finished. Matches with
 	 * the barrier provided by test_and_clear_bit() above.
-- 

