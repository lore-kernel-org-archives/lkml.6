Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A18CC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D992173B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfADKyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 05:54:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35732 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfADKyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 05:54:45 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E2EE97AE9A;
        Fri,  4 Jan 2019 10:54:44 +0000 (UTC)
Received: from localhost (ovpn-200-16.brq.redhat.com [10.40.200.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 63C035D6A9;
        Fri,  4 Jan 2019 10:54:41 +0000 (UTC)
Date:   Fri, 4 Jan 2019 11:54:35 +0100
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+4ad25edc7a33e4ab91e0@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Subject: Re: kernel panic: stack is corrupted in udp4_lib_lookup2
Message-ID: <20190104115435.478b4b4a@redhat.com>
In-Reply-To: <CACT4Y+aAofhchOpKTjLGGkQb5PAa74Uyp7kowdSoAwt130ZpAg@mail.gmail.com>
References: <000000000000513fb7057e8d7013@google.com>
        <f2e566ac-5c4c-11ae-d436-ebb3522a2195@gmail.com>
        <20190103210743.6518841e@redhat.com>
        <CA+FuTScFwA3F44MvbaWrOYJ2EYgdKAmoMzEGjOLcz3ZPVQLLDA@mail.gmail.com>
        <20190103225404.66b0ec9f@redhat.com>
        <CACT4Y+aAofhchOpKTjLGGkQb5PAa74Uyp7kowdSoAwt130ZpAg@mail.gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 04 Jan 2019 10:54:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2019 11:32:12 +0100
Dmitry Vyukov <dvyukov@google.com> wrote:

> On Thu, Jan 3, 2019 at 10:54 PM Stefano Brivio <sbrivio@redhat.com> wrote:
> >
> > On Thu, 3 Jan 2019 15:15:06 -0600
> > Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> >  
> > > syzbot generated stack traces with
> > >
> > > [  183.517380]  udpv6_err+0x46/0x60
> > > [  183.520739]  ? __udp6_lib_err+0x1890/0x1890
> > > [  183.525054]  gue6_err_proto_handler+0x199/0x280  
> >
> > Where? I can't find that in any logs linked from the dashboard at
> > https://syzkaller.appspot.com/bug?extid=4ad25edc7a33e4ab91e0 :(  
> 
> Stefano, there are these 4 bugs reported that have similarly looking
> reproducers involving udp sockets and that crash modes that looks like
> stack corruption/overflow:
> 
> https://syzkaller.appspot.com/bug?extid=14005fa30c9a07192934
> https://syzkaller.appspot.com/bug?extid=d14090007dc9ba5fa9b7
> https://syzkaller.appspot.com/bug?extid=137ed32ec9a6d5b0d5fe
> https://syzkaller.appspot.com/bug?id=d5bc3e0c66d200d72216ab343a67c4327e4a3452
> 
> Are these the same bug as this?

Judging from the reproducers for the first three, they seem to be. I
guess I can trigger tests also for those by sending a (sharp)syz
test ... e-mail with the patch to the Reported-by: addresses, right?

And the three reports you pointed out from the pile of corrupted
reports also seem to match, others look unrelated.

-- 
Stefano
