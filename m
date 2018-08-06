Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE254C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E89A219DA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:09:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E89A219DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbeHFMR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 08:17:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:32998 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727700AbeHFMR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 08:17:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B461BAE54;
        Mon,  6 Aug 2018 10:09:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 55D741E0501; Mon,  6 Aug 2018 12:09:28 +0200 (CEST)
Date:   Mon, 6 Aug 2018 12:09:28 +0200
From:   Jan Kara <jack@suse.cz>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+9933e4476f365f5d5a1b@syzkaller.appspotmail.com>,
        linux-mm@kvack.org, mgorman@techsingularity.net,
        Michal Hocko <mhocko@kernel.org>, ak@linux.intel.com,
        jack@suse.cz, jlayton@redhat.com, linux-kernel@vger.kernel.org,
        mawilcox@microsoft.com, syzkaller-bugs@googlegroups.com,
        tim.c.chen@linux.intel.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: INFO: task hung in generic_file_write_iter
Message-ID: <20180806100928.x7anab3c3y5q4ssa@quack2.suse.cz>
References: <0000000000009ce88d05714242a8@google.com>
 <4b349bff-8ad4-6410-250d-593b13d8d496@I-love.SAKURA.ne.jp>
 <9b9fcdda-c347-53ee-fdbb-8a7d11cf430e@I-love.SAKURA.ne.jp>
 <20180720130602.f3d6dc4c943558875a36cb52@linux-foundation.org>
 <a2df1f24-f649-f5d8-0b2d-66d45b6cb61f@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2df1f24-f649-f5d8-0b2d-66d45b6cb61f@i-love.sakura.ne.jp>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 31-07-18 00:07:22, Tetsuo Handa wrote:
> On 2018/07/21 5:06, Andrew Morton wrote:
> > On Fri, 20 Jul 2018 19:36:23 +0900 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
> > 
> >>>
> >>> This report is stalling after mount() completed and process used remap_file_pages().
> >>> I think that we might need to use debug printk(). But I don't know what to examine.
> >>>
> >>
> >> Andrew, can you pick up this debug printk() patch?
> >> I guess we can get the result within one week.
> > 
> > Sure, let's toss it in -next for a while.
> > 
> >> >From 8f55e00b21fefffbc6abd9085ac503c52a302464 Mon Sep 17 00:00:00 2001
> >> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> >> Date: Fri, 20 Jul 2018 19:29:06 +0900
> >> Subject: [PATCH] fs/buffer.c: add debug print for __getblk_gfp() stall problem
> >>
> >> Among syzbot's unresolved hung task reports, 18 out of 65 reports contain
> >> __getblk_gfp() line in the backtrace. Since there is a comment block that
> >> says that __getblk_gfp() will lock up the machine if try_to_free_buffers()
> >> attempt from grow_dev_page() is failing, let's start from checking whether
> >> syzbot is hitting that case. This change will be removed after the bug is
> >> fixed.
> > 
> > I'm not sure that grow_dev_page() is hanging.  It has often been
> > suspected, but always is proven innocent.  Lets see.
> 
> syzbot reproduced this problem ( https://syzkaller.appspot.com/text?tag=CrashLog&x=11f2fc44400000 ) .
> It says that grow_dev_page() is returning 1 but __find_get_block() is failing forever. Any idea?

Looks like some kind of a race where device block size gets changed while
getblk() runs (and creates buffers for underlying page). I don't have time
to nail it down at this moment can have a look into it later unless someone
beats me to it.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
