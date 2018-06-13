Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8216CC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 369A5208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 369A5208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935251AbeFMQpO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 12:45:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:35284 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934619AbeFMQpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 12:45:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BB81FACA1;
        Wed, 13 Jun 2018 16:45:10 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DF40D1E0D63; Wed, 13 Jun 2018 18:45:09 +0200 (CEST)
Date:   Wed, 13 Jun 2018 18:45:09 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH] bdi: Fix another oops in wb_workfn()
Message-ID: <20180613164509.oeb3fsjylfpfzxuh@quack2.suse.cz>
References: <3cf4b0e3-31b6-8cdc-7c1e-15ba575a7879@i-love.sakura.ne.jp>
 <20180611091248.2i6nt27h5mxrodm2@quack2.suse.cz>
 <20180611160131.GQ1351649@devbig577.frc2.facebook.com>
 <20180611162920.mwapvuqotvhkntt3@quack2.suse.cz>
 <20180611172053.GR1351649@devbig577.frc2.facebook.com>
 <20180612155754.x5k2yndh5t6wlmpy@quack2.suse.cz>
 <b210e55c-b06a-41ff-8592-0dbe21875779@i-love.sakura.ne.jp>
 <20180613144606.nvbcyg2rdjpxhf7s@quack2.suse.cz>
 <7f4ae045-dfe4-6677-7418-f6f60b6c26f1@i-love.sakura.ne.jp>
 <CA+55aFx=CwNCg08HUeyYWc-WWuPkQBXVJDvHfrBjraTy-3MRWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFx=CwNCg08HUeyYWc-WWuPkQBXVJDvHfrBjraTy-3MRWQ@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 13-06-18 09:25:03, Linus Torvalds wrote:
> On Wed, Jun 13, 2018 at 9:21 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >
> > Since multiple addresses share bit_wait_table[256], isn't it possible that
> > cgwb_start_shutdown() prematurely returns false due to wake_up_bit() by
> > hash-conflicting addresses (i.e. not limited to clear_and_wake_up_bit() from
> > wb_shutdown())? I think that we cannot be sure without confirming that
> > test_bit(WB_shutting_down, &wb->state) == false after returning from schedule().
> 
> Right.
> 
> That's _always_ true, btw. Something else entirely could have woken
> you up. TASK_UNINTERRUPTIBLE does not mean "nothing else wakes me", it
> just means "_signals_ don't wake me".
> 
> So every single sleep always needs to be in a loop. Always.

Agreed and in my patch it actually is in a loop - the one iterating the
list of active writeback structures. If we get a false wakeup, we find the
same structure in the list again and wait again...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
