Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AACC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6256320883
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:56:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6256320883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754464AbeGJKz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 06:55:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:41358 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751418AbeGJKzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 06:55:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9EDB6ADC2;
        Tue, 10 Jul 2018 10:55:53 +0000 (UTC)
Date:   Tue, 10 Jul 2018 12:55:51 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+e9f364d3b15ce41d8451@syzkaller.appspotmail.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        David Miller <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: INFO: rcu detected stall in llcp_sock_sendmsg
Message-ID: <20180710105551.ds6weeo7y7keekb5@pathway.suse.cz>
References: <0000000000000cc1f0057096efe6@google.com>
 <CACT4Y+Zc+UKpGwEEMfKOsZ1s+AAFYFrVmjO0-u7NNjODRiJ7tg@mail.gmail.com>
 <6e2e4cfa-2cde-ec28-933d-1ee17c8b1da9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e2e4cfa-2cde-ec28-933d-1ee17c8b1da9@gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2018-07-09 14:05:08, Eric Dumazet wrote:
> 
> 
> On 07/09/2018 01:50 PM, Dmitry Vyukov wrote:
> > On Mon, Jul 9, 2018 at 10:34 PM, syzbot
> > <syzbot+e9f364d3b15ce41d8451@syzkaller.appspotmail.com> wrote:
> >> Hello,
> >>
> >> syzbot found the following crash on:
> >>
> >> HEAD commit:    1e4b044d2251 Linux 4.18-rc4
> >> git tree:       upstream
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=1414c2c2400000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=25856fac4e580aa7
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=e9f364d3b15ce41d8451
> >> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> >>
> >> Unfortunately, I don't have any reproducer for this crash yet.
> >>
> >> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> >> Reported-by: syzbot+e9f364d3b15ce41d8451@syzkaller.appspotmail.com
> > 
> > Looks like the problem is actually in nfc, so +nfc maintainers.
> 
> Note this issue was discussed before, maybe we should patch NFC without waiting for nfc maintainer.

Do you have any particular solution in mind, please? See below.

> ----------------------------------------------------
> 
> On 06/25/2018 10:12 PM, Sergey Senozhatsky wrote:
> > On (06/26/18 07:07), Dmitry Vyukov wrote:
> > [..]
> >>>  #include <net/nfc/nfc.h>
> >>> @@ -755,7 +756,8 @@ int nfc_llcp_send_ui_frame(struct nfc_llcp_sock *sock, u8 ssap, u8 dsap,
> >>>                 pdu = nfc_alloc_send_skb(sock->dev, &sock->sk, MSG_DONTWAIT,
> >>>                                          frag_len + LLCP_HEADER_SIZE, &err);
> >>>                 if (pdu == NULL) {
> >>> -                       pr_err("Could not allocate PDU\n");
> >>> +                       pr_err_ratelimited("Could not allocate PDU\n");
> >>> +                       cond_resched();
> >>>                         continue;
> >>>                 }
> >>
> >>
> >> But this thread is still in an infinite (unkillable?) loop? If yes, we
> >> are waiting for the next syzbot report 
> >
> > The loop is still infinite, correct, but we have a preemption point now.
> > Sure, net people can come with a much better solution, I'll be happy to
> > scratch my patch.
> >
> 
> This can not be the right solution, think about current thread being real time,
> cond_resched() might be a nop.
> 
> We should probably not loop at all, or not use MSG_DONTWAIT.

These two solutions look promising. But they both need to
get reviewed by someone familiar with the code.

On one hand, nfc_llcp_send_ui_frame() already returns some errors
before sending anything. But I am not sure how to deal with situation
when a fragment of the message has already been sent.

Best Regards,
Petr
