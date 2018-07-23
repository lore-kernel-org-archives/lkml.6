Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C516ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 122C320685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:34:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 122C320685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.ee
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388186AbeGWVhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:37:04 -0400
Received: from smtp1.it.da.ut.ee ([193.40.5.66]:57270 "EHLO smtp1.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388022AbeGWVhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:37:04 -0400
Received: from math.ut.ee (unknown [IPv6:2001:bb8:2002:2400:5054:ff:fe3b:8db9])
        by smtp1.it.da.ut.ee (Postfix) with ESMTP id 7478D206E2;
        Mon, 23 Jul 2018 23:34:07 +0300 (EEST)
Received: by math.ut.ee (Postfix, from userid 1014)
        id 61C7E22091E; Mon, 23 Jul 2018 23:34:05 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
        by math.ut.ee (Postfix) with ESMTP id 68B8F220905;
        Mon, 23 Jul 2018 23:34:05 +0300 (EEST)
Date:   Mon, 23 Jul 2018 23:34:05 +0300 (EEST)
From:   Meelis Roos <mroos@linux.ee>
To:     Daniel Borkmann <daniel@iogearbox.net>
cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>
Subject: Re: bisected: 4.18-rc* regression: x86-32 troubles (with timers?)
In-Reply-To: <32227088-7754-c160-8046-e860f42ca91c@iogearbox.net>
Message-ID: <alpine.LRH.2.21.1807232322430.11834@math.ut.ee>
References: <alpine.LRH.2.21.1807041414080.3671@math.ut.ee> <CAK8P3a1RkNc_kShHBJ6QENrQheQi=C93DmnknC1S_uJDcTDqww@mail.gmail.com> <alpine.LRH.2.21.1807051254050.21817@math.ut.ee> <alpine.LRH.2.21.1807151803010.17406@math.ut.ee>
 <CAK8P3a2NtB_FmiSjrzZb=HoshEzo+MP2xwafC3QcMg79rffipg@mail.gmail.com> <alpine.LRH.2.21.1807161948380.27791@math.ut.ee> <alpine.LRH.2.21.1807162200180.27791@math.ut.ee> <alpine.LRH.2.21.1807202339490.8506@math.ut.ee> <alpine.LRH.2.21.1807210154100.8506@math.ut.ee>
 <CAK8P3a19pCbn5Ns0jVqGTiSmGj4AOgjWL0CQtAA-sYRqY4Gvjw@mail.gmail.com> <32227088-7754-c160-8046-e860f42ca91c@iogearbox.net>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> Now this seems more relevant:
> >>
> >> mroos@rx100s2:~/linux$ nice git bisect good
> >> 24dea04767e6e5175f4750770281b0c17ac6a2fb is the first bad commit
> >> commit 24dea04767e6e5175f4750770281b0c17ac6a2fb
> >> Author: Daniel Borkmann <daniel@iogearbox.net>
> >> Date:   Fri May 4 01:08:23 2018 +0200
> >>
> >>     bpf, x32: remove ld_abs/ld_ind
> >>
> >>     Since LD_ABS/LD_IND instructions are now removed from the core and
> >>     reimplemented through a combination of inlined BPF instructions and
> >>     a slow-path helper, we can get rid of the complexity from x32 JIT.
> > 
> > This does seem much more likely than the previous bisection, given
> > that you ended up in an x86-32 specific commit (the subject says x32,
> > but that is a mistake). I also checked that systemd indeed does
> > call into bpf in a number of places, possibly for the journald socket.
> > 
> > OTOH, it's still hard to tell how that commit can have ended up
> > corrupting the clock read function in systemd. To cross-check,
> > could you try reverting that commit on the latest kernel and see
> > if it still works?
> 
> I would be curious as well about that whether revert would make it
> work. What's the value of sysctl net.core.bpf_jit_enable ? Does it
> change anything if you set it to 0 (only interpreter) or 1 (JIT
> enabled). Seems a bit strange to me that bisect ended at this commit
> given the issue you have. The JIT itself was also new in this window
> fwiw. In any case some more debug info would be great to have.

net.core.bpf_jit_enable is 1.

Since it breaks bootup, I can not easily change the value at runtime (it 
would be postfactum). Do you mean changing the 
CONFIG_BPF_JIT_ALWAYS_ON=y option?

Anyway, I started compile of v4.18-rc5 that was the latest I tested, 
with the commit in question reverted. Will see if I can test tomorrow 
morning. But I will leave tomorrow for a week and can only test further 
things if they happen to boot fine (no manual reboot possible for a 
week).

-- 
Meelis Roos (mroos@linux.ee)
