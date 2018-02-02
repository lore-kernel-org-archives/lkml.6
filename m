Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752575AbeBBXkB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 18:40:01 -0500
Received: from mail-it0-f50.google.com ([209.85.214.50]:33247 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751827AbeBBXjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 18:39:52 -0500
X-Google-Smtp-Source: AH8x2253C6b7aZgEJXTOoq8NyTow753FJwGB9WPDx3tMhH7NbHIxKfUWAJ7o+aIl+0JITVue9mkvGA==
Date: Fri, 2 Feb 2018 15:39:48 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>, David Ahern <dsahern@gmail.com>,
        syzbot
        <bot+21b498fc12cf2041655f8e1eeae0733807d794b3@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, syzkaller-bugs@googlegroups.com,
        David Miller <davem@davemloft.net>, Florian Westphal <fw@strlen.de>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Xin Long <lucien.xin@gmail.com>, jakub.kicinski@netronome.com,
        mschiffer@universe-factory.net,
        Vladislav Yasevich <vyasevich@gmail.com>, Jiri Benc <jbenc@redhat.com>,
        netdev <netdev@vger.kernel.org>, Neil Horman <nhorman@tuxdriver.com>,
        linux-sctp@vger.kernel.org
Subject: Re: INFO: task hung in bpf_exit_net
Message-ID: <20180202233948.rciole6bmr7s72tp@gmail.com>
References: <001a1143fd00a8cc790560b0b552@google.com>
 <CACT4Y+Ze8t3ipFyhfy9XfmvUw4tob+dAUiVMQ-xHimYDXpSiRw@mail.gmail.com>
 <f519a1f0-8166-027e-e063-13aa718ce4e4@gmail.com>
 <CACT4Y+aaSX4S3KHJjqkiQhhOZAtEN_fMD1m_Ve3rz4u4x9KSWg@mail.gmail.com>
 <20171222182807.GC32765@localhost.localdomain>
 <20171222190437.GC6123@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171222190437.GC6123@localhost.localdomain>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 22, 2017 at 05:04:37PM -0200, Marcelo Ricardo Leitner wrote:
> On Fri, Dec 22, 2017 at 04:28:07PM -0200, Marcelo Ricardo Leitner wrote:
> > On Fri, Dec 22, 2017 at 11:58:08AM +0100, Dmitry Vyukov wrote:
> > ...
> > > > Same with this one, perhaps related to / fixed by:
> > > >     http://patchwork.ozlabs.org/patch/850957/
> > > >
> > > 
> > > 
> > > 
> > > Looking at the log, this one seems to be an infinite loop in SCTP code
> > > with console output in it. Kernel is busy printing gazilion of:
> > > 
> > > [  176.491099] sctp: sctp_transport_update_pmtu: Reported pmtu 508 too
> > > low, using default minimum of 512
> > > ** 110 printk messages dropped **
> > > [  176.503409] sctp: sctp_transport_update_pmtu: Reported pmtu 508 too
> > > low, using default minimum of 512
> > > ** 103 printk messages dropped **
> > > ...
> > > [  246.742374] sctp: sctp_transport_update_pmtu: Reported pmtu 508 too
> > > low, using default minimum of 512
> > > [  246.742484] sctp: sctp_transport_update_pmtu: Reported pmtu 508 too
> > > low, using default minimum of 512
> > > [  246.742590] sctp: sctp_transport_update_pmtu: Reported pmtu 508 too
> > > low, using default minimum of 512
> > > 
> > > Looks like a different issue.
> > > 
> > 
> > Oh. I guess this is caused by the interface having a MTU smaller than
> > SCTP_DEFAULT_MINSEGMENT (512), as the icmp frag needed handler
> > (sctp_icmp_frag_needed) will trigger an instant retransmission.
> > But as the MTU is smaller, SCTP won't update it, but will issue the
> > retransmission anyway.
> > 
> > I will test this soon. Should be fairly easy to trigger it.
> 
> Reproduced it.
> 
> netns A veth0(1500) - veth1(1500) B veth2(508) - veth3(508) C
> 
> When A sends a sctp packet bigger than 508, it triggers the issue as B
> will reply a icmp frag needed with a size that sctp won't accept but
> will retransmit anyway.
> 

syzbot hasn't encountered this hang again (although, it just happened once in
the first place).  I assume it was fixed by commit b6c5734db070, so telling
syzbot this:

#syz fix: sctp: fix the handling of ICMP Frag Needed for too small MTUs

- Eric
