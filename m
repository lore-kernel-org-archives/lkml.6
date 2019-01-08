Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3880AC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 132692087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfAHKFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 05:05:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:59340 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727001AbfAHKFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 05:05:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 566C1B0DF;
        Tue,  8 Jan 2019 10:05:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 08 Jan 2019 11:05:08 +0100
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: WARNING in ep_poll_callback
In-Reply-To: <CACT4Y+aFQgqYuq9ws8vJk-f9uafx8B8hYKtMwUgjcrTGAL_spQ@mail.gmail.com>
References: <000000000000d8bec0057eec0a92@google.com>
 <CACT4Y+aFQgqYuq9ws8vJk-f9uafx8B8hYKtMwUgjcrTGAL_spQ@mail.gmail.com>
Message-ID: <a4eae0108088505de523b301b1db9663@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-08 07:00, Dmitry Vyukov wrote:
> On Tue, Jan 8, 2019 at 6:59 AM syzbot
> <syzbot+aea82bf9ee6ffd9a79d9@syzkaller.appspotmail.com> wrote:
>> 
>> Hello,
>> 
>> syzbot found the following crash on:
>> 
>> HEAD commit:    139287cc2cc0 Add linux-next specific files for 
>> 20190108
>> git tree:       linux-next
>> console output: 
>> https://syzkaller.appspot.com/x/log.txt?x=16f563d7400000
>> kernel config:  
>> https://syzkaller.appspot.com/x/.config?x=1521b074ff5a5bdf
>> dashboard link: 
>> https://syzkaller.appspot.com/bug?extid=aea82bf9ee6ffd9a79d9
>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>> 
>> Unfortunately, I don't have any reproducer for this crash yet.
> 
> Looks like caused by:
> 
> commit f92cacf118171208f62519d92502a8dd0341286d
> Author: Roman Penyaev
> Date:   Tue Jan 8 12:15:44 2019 +1100
> 
>     epoll: loosen irq safety in ep_poll_callback()

Yes, that was my wrong assumption that all drivers disable irqs before
waking up a wait queue.  Of course for drivers like fuse this is not
a case. Thanks for reporting.

The fix is simple: just remove wrong assert line :)  The whole logic
stays correct: epoll always locks rwlock with irqs disabled and by
itself does not call from interrupt, thus it is up to driver how to
call wake_up_locked(), because if driver does not handle any interrupts
it is safe on its side to take a simple spin_lock.

Patch is sent:
https://lore.kernel.org/lkml/20190108100121.20247-1-rpenyaev@suse.de

--
Roman

