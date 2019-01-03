Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A2BC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B64202184B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbfACUA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 15:00:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44640 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfACUA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 15:00:26 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5BEB676533;
        Thu,  3 Jan 2019 20:00:25 +0000 (UTC)
Received: from localhost (ovpn-200-16.brq.redhat.com [10.40.200.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 773181001947;
        Thu,  3 Jan 2019 20:00:21 +0000 (UTC)
Date:   Thu, 3 Jan 2019 21:00:15 +0100
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     syzbot <syzbot+4ad25edc7a33e4ab91e0@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: kernel panic: stack is corrupted in udp4_lib_lookup2
Message-ID: <20190103210015.56917c3b@redhat.com>
In-Reply-To: <CAF=yD-L_ZfYDi5874LU54=iJD52P27EabTmHGqXS6t71y7Orxg@mail.gmail.com>
References: <000000000000513fb7057e8d7013@google.com>
        <CA+FuTSfnaL3asZg6oDdwk2J741Cf9fbVxGrB_2jdXgOwvvk+tA@mail.gmail.com>
        <CAF=yD-L_ZfYDi5874LU54=iJD52P27EabTmHGqXS6t71y7Orxg@mail.gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 03 Jan 2019 20:00:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willem,

On Thu, 3 Jan 2019 13:41:43 -0600
Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:

> On Thu, Jan 3, 2019 at 1:39 PM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > On Thu, Jan 3, 2019 at 7:07 AM syzbot
> > <syzbot+4ad25edc7a33e4ab91e0@syzkaller.appspotmail.com> wrote:  
> > >
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    195303136f19 Merge tag 'kconfig-v4.21-2' of git://git.kern..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=12245d8f400000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=5e7dc790609552d7
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=4ad25edc7a33e4ab91e0
> > > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > >
> > > Unfortunately, I don't have any reproducer for this crash yet.
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+4ad25edc7a33e4ab91e0@syzkaller.appspotmail.com
> > >
> > > protocol 88fb is buggy, dev hsr_slave_1
> > > protocol 88fb is buggy, dev hsr_slave_0
> > > protocol 88fb is buggy, dev hsr_slave_1
> > > FAT-fs (loop0): invalid media value (0x00)
> > > FAT-fs (loop0): Can't find a valid FAT filesystem
> > > Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in:  
> >
> > This sounds similar to the stack corruption fixed recently in commit
> > e7cc082455cb ("udp: Support for error handlers of tunnels ...").
> >
> > That fix is for ipv4 gue_err(). ipv6 gue6_err() probably needs the same.  
> 
> Correction. The fix is 11789039da ("fou: prevent unbounded recursion
> in GUE error handler")

Yes, I looked into this, the fix for that issue is on the tree tested by
syzbot, and I think this is unrelated, also because KASan should say
something before we hit that.

By the way, do you happen to know if I objects from kernels tested by
syzbot are stored anywhere? It would be helpful to know for sure what's
at udp4_lib_lookup2+0x7ea.

-- 
Stefano
