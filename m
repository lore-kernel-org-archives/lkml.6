Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 14D01C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C44AB208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C44AB208D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754974AbeFNKLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 06:11:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:58843 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754737AbeFNKLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 06:11:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B58FFAE5E;
        Thu, 14 Jun 2018 10:11:06 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 551961E1135; Thu, 14 Jun 2018 12:11:05 +0200 (CEST)
Date:   Thu, 14 Jun 2018 12:11:05 +0200
From:   Jan Kara <jack@suse.cz>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Dmitry Vyukov <dvyukov@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH] bdi: Fix another oops in wb_workfn()
Message-ID: <20180614101105.mcs7b75olai7gfxp@quack2.suse.cz>
References: <20180611160131.GQ1351649@devbig577.frc2.facebook.com>
 <20180611162920.mwapvuqotvhkntt3@quack2.suse.cz>
 <20180611172053.GR1351649@devbig577.frc2.facebook.com>
 <20180612155754.x5k2yndh5t6wlmpy@quack2.suse.cz>
 <b210e55c-b06a-41ff-8592-0dbe21875779@i-love.sakura.ne.jp>
 <20180613144606.nvbcyg2rdjpxhf7s@quack2.suse.cz>
 <7f4ae045-dfe4-6677-7418-f6f60b6c26f1@i-love.sakura.ne.jp>
 <CA+55aFx=CwNCg08HUeyYWc-WWuPkQBXVJDvHfrBjraTy-3MRWQ@mail.gmail.com>
 <20180613164509.oeb3fsjylfpfzxuh@quack2.suse.cz>
 <4a70ca66-3352-10aa-d351-e3fa3baebffc@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a70ca66-3352-10aa-d351-e3fa3baebffc@i-love.sakura.ne.jp>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 14-06-18 06:04:04, Tetsuo Handa wrote:
> On 2018/06/14 1:45, Jan Kara wrote:
> > On Wed 13-06-18 09:25:03, Linus Torvalds wrote:
> >> On Wed, Jun 13, 2018 at 9:21 AM Tetsuo Handa
> >> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >>>
> >>> Since multiple addresses share bit_wait_table[256], isn't it possible that
> >>> cgwb_start_shutdown() prematurely returns false due to wake_up_bit() by
> >>> hash-conflicting addresses (i.e. not limited to clear_and_wake_up_bit() from
> >>> wb_shutdown())? I think that we cannot be sure without confirming that
> >>> test_bit(WB_shutting_down, &wb->state) == false after returning from schedule().
> >>
> >> Right.
> >>
> >> That's _always_ true, btw. Something else entirely could have woken
> >> you up. TASK_UNINTERRUPTIBLE does not mean "nothing else wakes me", it
> >> just means "_signals_ don't wake me".
> >>
> >> So every single sleep always needs to be in a loop. Always.
> > 
> > Agreed and in my patch it actually is in a loop - the one iterating the
> > list of active writeback structures. If we get a false wakeup, we find the
> > same structure in the list again and wait again...
> 
> Indeed. I overlooked that wb = list_first_entry() will select same wb again
> if cgwb_remove_from_bdi_list() is not yet called. Well, we could update
> "(in which case we also wait for it to finish)" part or move the body of
> cgwb_start_shutdown() to cgwb_bdi_unregister() so that it becomes clear
> that false wake-up is not a problem in this case.

I prefer to keep the wb shutdown in a separate function but I've added some
comments to explain that.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
