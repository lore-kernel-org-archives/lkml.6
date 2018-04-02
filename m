Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754484AbeDBVj6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 17:39:58 -0400
Received: from mail-yb0-f174.google.com ([209.85.213.174]:39802 "EHLO
        mail-yb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754304AbeDBVj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 17:39:56 -0400
X-Google-Smtp-Source: AIpwx48S3rLsVcC1r7Nf4Uia1HFphvg8PpBDR6tzwot7MpNUbG6IRmmEhUIrWW6K7lMMqDjepobCFQ==
Date: Mon, 2 Apr 2018 14:39:53 -0700
From: "tj@kernel.org" <tj@kernel.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "kernel-team@fb.com" <kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 2/2] blk-mq: Fix request handover from timeout path to
 normal execution
Message-ID: <20180402213953.GG388343@devbig577.frc2.facebook.com>
References: <20180402190053.GC388343@devbig577.frc2.facebook.com>
 <20180402190120.GD388343@devbig577.frc2.facebook.com>
 <b52fa22c-c7fa-5ebd-35cb-527786e6d08e@wdc.com>
 <20180402211047.GF388343@devbig577.frc2.facebook.com>
 <e23487ab30cfe5337a4321ad10ddbd6514be9ab9.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e23487ab30cfe5337a4321ad10ddbd6514be9ab9.camel@wdc.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Apr 02, 2018 at 09:31:34PM +0000, Bart Van Assche wrote:
> > > > +	 * As nothing prevents from completion happening while
> > > > +	 * ->aborted_gstate is set, this may lead to ignored completions
> > > > +	 * and further spurious timeouts.
> > > > +	 */
> > > > +	if (rq->rq_flags & RQF_MQ_TIMEOUT_RESET)
> > > > +		blk_mq_rq_update_aborted_gstate(rq, 0);
...
> I think it can happen that the above code sees that (rq->rq_flags &
> RQF_MQ_TIMEOUT_RESET) != 0, that blk_mq_start_request() executes the
> following code:
> 
> 	blk_mq_rq_update_state(rq, MQ_RQ_IN_FLIGHT);
> 	blk_add_timer(rq);
> 
> and that subsequently blk_mq_rq_update_aborted_gstate(rq, 0) is called,
> which will cause the next completion to be lost. Is fixing one occurrence
> of a race and reintroducing it in another code path really an improvement?

I'm not following at all.  How would blk_mq_start_request() get called
on the request while it's still owned by the timeout handler?  That
gstate clearing is what transfers the ownership back to the
non-timeout path.

Thanks.

-- 
tejun
