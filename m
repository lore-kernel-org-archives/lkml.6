Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD5DECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC642084C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECC642084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731244AbeGTBM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 21:12:57 -0400
Received: from nautica.notk.org ([91.121.71.147]:48362 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730798AbeGTBM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 21:12:57 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 11D49C009; Fri, 20 Jul 2018 02:27:20 +0200 (CEST)
Date:   Fri, 20 Jul 2018 02:27:05 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+b173e77096a8ba815511@syzkaller.appspotmail.com>,
        jack@suse.cz, jlayton@redhat.com, syzkaller-bugs@googlegroups.com,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        linux-mm@kvack.org, v9fs-developer@lists.sourceforge.net,
        mgorman@techsingularity.net
Subject: Re: [V9fs-developer] KASAN: use-after-free Read in
 generic_perform_write
Message-ID: <20180720002704.GA20844@nautica>
References: <00000000000047116205715df655@google.com>
 <20180719170718.8d4e7344fe79b2ad411dde98@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180719170718.8d4e7344fe79b2ad411dde98@linux-foundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote on Thu, Jul 19, 2018:
> On Thu, 19 Jul 2018 11:01:01 -0700 syzbot <syzbot+b173e77096a8ba815511@syzkaller.appspotmail.com> wrote:
> > Hello,
> > 
> > syzbot found the following crash on:
> > 
> > HEAD commit:    1c34981993da Add linux-next specific files for 20180719
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=16e6ac44400000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=7002497517b09aec
> > dashboard link: https://syzkaller.appspot.com/bug?extid=b173e77096a8ba815511
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > 
> > Unfortunately, I don't have any reproducer for this crash yet.
> 
> Thanks.  I cc'ed v9fs-developer, optimistically.  That list manager is
> weird :(

I agree that list is weird, does anyone know the reason v9fs-developer
is not a vger.k.o list? Or a reason not to change? It's still not too
late...

> I'm suspecting v9fs.  Does that fs attempt to write to the fs from a
> kmalloced buffer?

Difficult to say without any idea of what syzkaller tried doing, but it
looks like it hook'd up a fd opened to a local ext4 file into a trans_fd
mount; so sending a packet to the "server" would trigger a local write
instead.
The reason it's freed too early probably is that the reply came from a
read before the write happened; this is going to be tricky to fix as
that write is 100% asynchronous without any feedback right now (the
design assumes that the write has to have finished by the time reply
came), but if we want to protect ourselves from rogue servers we'll have
to think about something.

I'll write it down to not forget, thanks for the cc.

-- 
Dominique Martinet
