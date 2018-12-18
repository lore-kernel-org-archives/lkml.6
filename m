Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD718C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4513218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbeLRONI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:13:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45350 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbeLRONI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:13:08 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C4DD4C049E12;
        Tue, 18 Dec 2018 14:13:07 +0000 (UTC)
Received: from localhost (ovpn-200-20.brq.redhat.com [10.40.200.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D38EC10595B1;
        Tue, 18 Dec 2018 14:13:03 +0000 (UTC)
Date:   Tue, 18 Dec 2018 15:12:58 +0100
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        netdev <netdev@vger.kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Xin Long <lucien.xin@gmail.com>
Subject: Re: WARNING in __rcu_read_unlock
Message-ID: <20181218151258.38796e76@redhat.com>
In-Reply-To: <CACT4Y+az3--Y2f0OKSbF0kxwckdkKSASVog=XkX=+cXCt5r3ew@mail.gmail.com>
References: <0000000000005e47a2057d0edc49@google.com>
        <20181216190412.GE4170@linux.ibm.com>
        <CACT4Y+b+mSs2FV3BY+MsHDTPPgvPaCdMmJONd9c4zEU67CdmOA@mail.gmail.com>
        <20181217112916.GG4170@linux.ibm.com>
        <1583d5fc-34bf-3a81-363d-01a1085a7363@linux.intel.com>
        <CACT4Y+aKn4XsGVgt3ELGnnJcg6H-m+dSdV018dLvJhrpshycWA@mail.gmail.com>
        <20641819-e4fb-f3bd-34c8-c68106cccd0e@gmail.com>
        <20181217162421.6d636ee5@redhat.com>
        <CACT4Y+YXFrnQh9h1KQf8=NcHugmxTj+d7AQdGCvRX_xsHwr1qA@mail.gmail.com>
        <20181218001828.49cea463@redhat.com>
        <CACT4Y+ZFpO26Tgqpi+Jies9XOiiCgAdp2DV0z_54hCNTqkJsiw@mail.gmail.com>
        <20181218134024.45d2d5e3@redhat.com>
        <CACT4Y+az3--Y2f0OKSbF0kxwckdkKSASVog=XkX=+cXCt5r3ew@mail.gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 18 Dec 2018 14:13:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Dropping syzbot from Cc:]

On Tue, 18 Dec 2018 14:26:00 +0100
Dmitry Vyukov <dvyukov@google.com> wrote:

> On Tue, Dec 18, 2018 at 1:40 PM Stefano Brivio <sbrivio@redhat.com>
> wrote:
>
> > Maybe it would be nice to have a semi-automated way to isolate and
> > describe/name specific conditions found by syzbot via fuzzing and
> > turn those into tests that are then repeated periodically. I'm not
> > sure how that would look like, but I think it's still more
> > maintainable than a pile of C reproducers with forged packets in
> > selftests/net.  
> 
> It would be nice to do something like this. Filed
> https://github.com/google/syzkaller/issues/884
> However, there are few open questions that I am not sure how to
> resolve yet...

I don't have a github account, so let me comment on your questions here:

> 1. How to effectively fetch so many repros from datastore without
> hitting timeouts? We probably need to limit this to 1 repro per bug,
> but still that's many repros.

I guess this would be less of a problem if reproducers are selected
based on input from developers, instead of just taking all the
reproducers. E.g. one could answer a report with something like:

	#syz regression-test: <name>
	<description>

in this case I would have answered:

	#syz regression-test: icmp-udp-in-gue-recursion
	ICMP exceptions on UDP direct encapsulation in GUE

and something could be automatically appended to the test name,
perhaps e-mail and date. It would also be nice to be able to undo
this and delete a regression test.

> 2. Do we need some sorting based on namespace? E.g. stable releases
> may not include fixes for bugs fixed in upstream, then we will just
> crash lots of kernels in vain.

Same here, I guess developer input might help, but I'm not sure how to
formalise this.

> 3. syzkaller repros depend on exact syzkaller revision, new syzkaller
> won't be able to use old repros. Using C repros is much harder and
> they are not present for all bugs. Not sure what to do here.

Would it make a difference if you could use the "syz" reproducers and
translate them to C reproducer only once needed?

-- 
Stefano
