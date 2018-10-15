Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6453C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 855A42064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:45:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 855A42064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbeJOUbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:31:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:54584 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726319AbeJOUbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 16:31:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D7028AE65;
        Mon, 15 Oct 2018 12:45:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A63461E3616; Mon, 15 Oct 2018 14:45:52 +0200 (CEST)
Date:   Mon, 15 Oct 2018 14:45:52 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Jan Kara <jack@suse.cz>,
        syzbot <syzbot+29143581b0ded3213e99@syzkaller.appspotmail.com>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: INFO: task hung in fanotify_handle_event
Message-ID: <20181015124552.GD30927@quack2.suse.cz>
References: <00000000000036c76a057842c97f@google.com>
 <20181015121541.GC30927@quack2.suse.cz>
 <CACT4Y+ZabUTpP6HZQVkVDvMYbktn=gP2C-m=ueKK3NRh7teY5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZabUTpP6HZQVkVDvMYbktn=gP2C-m=ueKK3NRh7teY5A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmirty!

On Mon 15-10-18 14:29:14, Dmitry Vyukov wrote:
> On Mon, Oct 15, 2018 at 2:15 PM, Jan Kara <jack@suse.cz> wrote:
> > Hello,
> >
> > On Mon 15-10-18 04:32:02, syzbot wrote:
> >> syzbot found the following crash on:
> >>
> >> HEAD commit:    90ad18418c2d Merge git://git.kernel.org/pub/scm/linux/kern..
> >> git tree:       upstream
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=17f1776e400000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=88e9a8a39dc0be2d
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=29143581b0ded3213e99
> >> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=123459d6400000
> >>
> >> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> >> Reported-by: syzbot+29143581b0ded3213e99@syzkaller.appspotmail.com
> >
> > Syzbot has apparently generated fanotify watch for FAN_OPEN_PERM event and
> > then the process got stuck waiting for userspace to respond to that event -
> > which never happened. So everything works as designed here - the process
> > placing FAN_OPEN_PERM mark is responsible for replying to the generated
> > events as all opens hang waiting for responses. That's why the
> > functionality is behind CAP_SYS_ADMIN after all... Could we fix syzbot to
> > actually generate replies for these events?
> 
> Is there a reliable way to kill such processes?
> Or admins are never supposed to kill any root processes and have not
> bugs whatsoever? :)

Currently the wait is not killable but yes, we want to make it killable
exactly because of userspace bugs :). But it is non-trivial because
currently the waker has also other responsibilities and all that stuff has
to be cleaned up when handling killed wait. Konstantin Khlebnikov was
working on that so I might need to prod him.

> syzkaller probably capable of generating replies in some cases, but
> unfortunately it can't work this way. It's practically not possible to
> ensure that it will always generate a proper reply and it will be
> actually delivered and the process won't be killed in the middle, or
> another thread won't crash or call exit_group concurrently, etc. The
> thing either needs to be reliable, work without any but's and be
> reliably killable, or it's not suitable for stress testing.
> If there is no reliable way to kill it, I think we need to disable
> FAN_OPEN_PERM entirely.

Understood. Then just disable FAN_OPEN_PERM & FAN_ACCESS_PERM for now.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
