Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3436BC04EBB
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 20:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB97320874
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 20:04:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB97320874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbeKYGxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 01:53:14 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:52216 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbeKYGxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 01:53:13 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gQe9l-0006QY-BK; Sat, 24 Nov 2018 20:03:57 +0000
Date:   Sat, 24 Nov 2018 20:03:57 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     syzbot <syzbot+ce18da013d76d837144d@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, gregkh@linuxfoundation.org,
        kgraul@linux.ibm.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, stranche@codeaurora.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: WARNING in csum_and_copy_to_iter
Message-ID: <20181124200357.GC2217@ZenIV.linux.org.uk>
References: <0000000000001ecaa1057b6e4489@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000001ecaa1057b6e4489@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 11:40:03AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    edeca3a769ad Merge tag 'sound-4.20-rc4' of git://git.kerne..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12bee26d400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=73e2bc0cb6463446
> dashboard link: https://syzkaller.appspot.com/bug?extid=ce18da013d76d837144d
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15ccd1f5400000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+ce18da013d76d837144d@syzkaller.appspotmail.com

Caused by commit 95506588d2c1d72ca29adef8ae9bf771bcfb4ced
Author: Slavomir Kaslev <kaslevs@vmware.com>
Date:   Fri Nov 16 11:27:53 2018 +0200

    socket: do a generic_file_splice_read when proto_ops has no splice_read

exposing all ->recvmsg() instances to pipe-backed iov_iter as possible destination.
It's not all that hard to fix (I'll probably have a candidate patch by tonight,
it's just a matter of adding the only missing primitive), but... shouldn't that
patch have sat in -next for at least some testing first?  Because it's very
easy to reproduce - splice from e.g. UDP socket will step into it.  Sure, the
sky is not falling (unless you set panic-on-WARN, that is); the damn thing
would've failed anyway, but...
