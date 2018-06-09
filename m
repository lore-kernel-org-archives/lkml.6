Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id l6NvL0sSHFtnTQAAmS7hNA
	; Sat, 09 Jun 2018 17:46:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 902D9608C1; Sat,  9 Jun 2018 17:46:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1BD1E601D2;
	Sat,  9 Jun 2018 17:46:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1BD1E601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=angband.pl
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932140AbeFIRqG (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 13:46:06 -0400
Received: from tartarus.angband.pl ([89.206.35.136]:50510 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753342AbeFIRqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 13:46:05 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1fRhw8-0001pY-Uv; Sat, 09 Jun 2018 19:46:00 +0200
Date: Sat, 9 Jun 2018 19:46:00 +0200
From: Adam Borowski <kilobyte@angband.pl>
To: Jens Axboe <axboe@kernel.dk>
Cc: Dmitry Vyukov <dvyukov@google.com>, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: mainline boot is broken: KASAN: use-after-free in
 blk_flush_complete_seq
Message-ID: <20180609174600.enboaxbsqhgjydt5@angband.pl>
References: <CACT4Y+ZmRj61ia-WQBC=M72o=OZWk5LSnzf2qOEuOLHAa4do_A@mail.gmail.com>
 <1d8de494-0a52-33f5-4c8d-0ec08cfb101c@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d8de494-0a52-33f5-4c8d-0ec08cfb101c@kernel.dk>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 09, 2018 at 06:33:06AM -0600, Jens Axboe wrote:
> On 6/9/18 3:34 AM, Dmitry Vyukov wrote:
> > Boot of mainline kernel is currently broken.
> > On commit 7d3bf613e99abbd96ac7b90ee3694a246c975021.
> > Config:
> > https://gist.githubusercontent.com/dvyukov/9f7f1fd9e477efd85b221b3a21036c20/raw/7c56ede0840494b26045976960866f2b265c6f64/gistfile1.txt
> > Should have been introduced very recently.
> 
> Can you try the below?

Helps on my setup.
 
> > You may need to also patch "umh: fix race condition", because that's
> > another boot crasher currently present in tree.
>
> Not sure that that refers to.

I for one didn't trip into that.

> diff --git a/block/blk-flush.c b/block/blk-flush.c
> index 058abdb50f31..ce41f666de3e 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -169,9 +169,11 @@ static bool blk_flush_complete_seq(struct request *rq,
>  	struct request_queue *q = rq->q;
>  	struct list_head *pending = &fq->flush_queue[fq->flush_pending_idx];
>  	bool queued = false, kicked;
> +	unsigned int cmd_flags;
>  
>  	BUG_ON(rq->flush.seq & seq);
>  	rq->flush.seq |= seq;
> +	cmd_flags = rq->cmd_flags;
>  
>  	if (likely(!error))
>  		seq = blk_flush_cur_seq(rq);
> @@ -212,7 +214,7 @@ static bool blk_flush_complete_seq(struct request *rq,
>  		BUG();
>  	}
>  
> -	kicked = blk_kick_flush(q, fq, rq->cmd_flags);
> +	kicked = blk_kick_flush(q, fq, cmd_flags);
>  	return kicked | queued;
>  }
>  

Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ I've read an article about how lively happy music boosts
⣾⠁⢰⠒⠀⣿⡁ productivity.  You can read it, too, you just need the
⢿⡄⠘⠷⠚⠋⠀ right music while doing so.  I recommend Skepticism
⠈⠳⣄⠀⠀⠀⠀ (funeral doom metal).
