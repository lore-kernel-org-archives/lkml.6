Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540C1C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A98220C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A98220C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbeIYPBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:01:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:53222 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726392AbeIYPBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:01:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BA429AF66;
        Tue, 25 Sep 2018 08:55:06 +0000 (UTC)
Date:   Tue, 25 Sep 2018 10:55:06 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        penguin-kernel@i-love.sakura.ne.jp,
        syzbot+6fb572170402d311dd39@syzkaller.appspotmail.com,
        Jan Kara <jack@suse.cz>, syzkaller-bugs@googlegroups.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: INFO: task hung in fsnotify_connector_destroy_workfn (2)
Message-ID: <20180925085506.ddzq42ci4ul3voxm@pathway.suse.cz>
References: <0000000000006364200575dfc280@google.com>
 <2f4ce251-cf84-8bd2-72fc-a3ff687d5188@I-love.SAKURA.ne.jp>
 <CAOQ4uxhmFsvy6y6NgcFPs4NF1Lg7J0h2VoWgiL8WfXdDz+Z0FQ@mail.gmail.com>
 <nycvar.YFH.7.76.1809241511500.15880@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1809241511500.15880@cbobk.fhfr.pm>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2018-09-24 15:19:35, Jiri Kosina wrote:
> On Sun, 16 Sep 2018, Amir Goldstein wrote:
> 
> > > > syzbot found the following crash on:
> > > >
> > > > HEAD commit:    11da3a7f84f1 Linux 4.19-rc3
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=141ffbca400000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=9917ff4b798e1a1e
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=6fb572170402d311dd39
> > > > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=136a60ae400000
> > > >
> > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > Reported-by: syzbot+6fb572170402d311dd39@syzkaller.appspotmail.com
> > > >
> > >
> > > Since it kept printk()ing for at least 93 seconds, it might have kept for 150 seconds.
> > >
> > > [  174.614333] hid-generic 0000:0000:0000.0003: unknown main item tag 0x0
> > > [  268.196102] INFO: task kworker/u4:1:23 blocked for more than 140 seconds.
> > >
> > > Since the reproducer is simple, this might be lockup due to continuous printk().
> > > If syzbot can reliably reproduce this problem using the reproducer, try
> > > ratelimiting printk().
> > 
> > Right.. and I was able to reproduce after setting CONFIG_HID_GENERIC=y
> > but unless I am missing something, the core problem doesn't seem related to
> > fsnotify and $SUBJECT, so CCing HID maintainer.
> 
> Alright, so you're basically triggering a never-ending flow of kmsgs being 
> printed out from HID parser due to doing crazy things with the parser, and 
> that causes the issues for the kworker trying to flush them out.

My understanding is that the flow of messages is long but it ends at
some point. For example, the many warnings for
"hid-generic 0000:0000:0000.0003" eventually ends with

[  221.223267] hid-generic 0000:0000:0000.0003: hidraw0: <UNKNOWN> HID v0.00 Device [syz1] on syz1


Next, there are usually intermixed messages for two devices, e.g.

[  174.776326] hid-generic 0000:0000:0000.0003: unknown main item tag 0x0
[  174.782734] hid-generic 0000:0000:0000.0004: unknown main item tag 0x0

Therefore I believe that console_lock is being transfered and no
process is stuck in printk()/console_unlock().


> I guess the patch below fixes it, however the kworker should not really be 
> blocked by this I think ... adding a few more printk folks to double-check 
> why the kworker would get stuck due to massive printk() flood.

It seems that the many printk() calls just delay the entire
process and rcu gets blocked for too long. The messages are
the same all the time. So some rate limiting looks like
a reasonable solution.

Best Regards,
Petr
