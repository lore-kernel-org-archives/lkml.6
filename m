Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44BEC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 10:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C6F206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 10:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="IJKs8/4E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfBWKiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 05:38:19 -0500
Received: from mail.skyhub.de ([5.9.137.197]:47750 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbfBWKiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 05:38:19 -0500
Received: from zn.tnic (p200300EC2BDB49004460C94D34A9E8FA.dip0.t-ipconnect.de [IPv6:2003:ec:2bdb:4900:4460:c94d:34a9:e8fa])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F23E81EC021C;
        Sat, 23 Feb 2019 11:38:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1550918297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ngwZVIDy2UDCyrbXqx92leOuZ9icNJOE6TgaEx/6uPE=;
        b=IJKs8/4EUqFbl1L5ADuLqxrwQgKZA/EIZZAF3KNntm7E7sz/fLJK51UJZS8Hux0oTTMVYK
        tFHGA1NcZBaD9Ae895ehwandvbpK4BY/Ca7srW7j+gRQkuqAq+dV/59Iqbd4NePNA4KNht
        ddemskTNT5+l2GUMcYzrXhaj82pCDIY=
Date:   Sat, 23 Feb 2019 11:38:09 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+111bc509cd9740d7e4aa@syzkaller.appspotmail.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        "H. Peter Anvin" <hpa@zytor.com>, konrad.wilk@oracle.com,
        Len Brown <len.brown@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, puwen@hygon.cn,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>, wang.yi59@zte.com.cn,
        the arch/x86 maintainers <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: WARNING in rcu_check_gp_start_stall
Message-ID: <20190223103809.GB23376@zn.tnic>
References: <0000000000007da94e05827ea99a@google.com>
 <20190222222036.GC30766@zn.tnic>
 <CACT4Y+aq+5Hor2f-SsaO4VW3p1Xq2Xk-2OUeKhpp=aOx0XMmzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+aq+5Hor2f-SsaO4VW3p1Xq2Xk-2OUeKhpp=aOx0XMmzg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2019 at 11:33:33AM +0100, Dmitry Vyukov wrote:
> On Fri, Feb 22, 2019 at 11:20 PM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Fri, Feb 22, 2019 at 09:10:04AM -0800, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    8a61716ff2ab Merge tag 'ceph-for-5.0-rc8' of git://github...
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1531dd3f400000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=7132344728e7ec3f
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=111bc509cd9740d7e4aa
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d4966cc00000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c492d0c00000
> >
> > So I ran this for more than an hour in a guest here with the above
> > .config but nothing happened. The compiler I used is 8.2, dunno of that
> > makes the difference or I'm missing something else...
> 
> I was able to reproduce this on the first run:
> 
> # ./syz-execprog -procs=8 -repeat=0 hang

Ok, this is what I'm missing: I ran the reproducer directly but you run
a multithreaded thing with this syz-execprog. Where do I get that syz-
thing?

> There is a bunch of other bug reports about hangs where reproducers
> mention perf_event_open and sched_setattr.

This is a known issue, says peterz.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
