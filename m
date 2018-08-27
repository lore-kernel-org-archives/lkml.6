Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D9FC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 05:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DF7A208DC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 05:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DF7A208DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbeH0JJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 05:09:32 -0400
Received: from nautica.notk.org ([91.121.71.147]:47505 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbeH0JJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 05:09:32 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id A18ABC009; Mon, 27 Aug 2018 07:24:27 +0200 (CEST)
Date:   Mon, 27 Aug 2018 07:24:12 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     syzbot <syzbot+d4252148d198410b864f@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, ericvh@gmail.com,
        linux-kernel@vger.kernel.org, lucho@ionkov.net,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
Subject: Re: KASAN: invalid-free in p9stat_free
Message-ID: <20180827052412.GA26294@nautica>
References: <000000000000af648b057456e234@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000000000000af648b057456e234@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot wrote on Sun, Aug 26, 2018:
> HEAD commit:    e27bc174c9c6 Add linux-next specific files for 20180824
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=15dc19a6400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=28446088176757ea
> dashboard link: https://syzkaller.appspot.com/bug?extid=d4252148d198410b864f
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15f8efba400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1178256a400000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+d4252148d198410b864f@syzkaller.appspotmail.com
> 
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> ==================================================================
> BUG: KASAN: double-free or invalid-free in p9stat_free+0x35/0x100
> net/9p/protocol.c:48

That looks straight-forward enough, p9pdu_vreadf does p9stat_free on
error then v9fs_dir_readdir does the same ; there is nothing else that
could return an error without going through the first free so we could
just remove the later one...

There are a couple other users of the 'S' pdu read (that reads the stat
struct and frees it on error), so it's probably best to keep the current
behaviour as far as this is concerned, what we could do though is make
the free function idempotent (write NULLs in the freed fields), but I do
not see this being done often, do you know what the policy is about
this kind of pattern nowadays?

The struct is cleanly zeroed before being read so there is no risk of
double-frees between iterations so zeroing pointers is not strictly
required, but it does make things safer in general.


-- 
Dominique Martinet
