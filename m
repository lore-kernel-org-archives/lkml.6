Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06699C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE27E2183E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbfAGXs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 18:48:57 -0500
Received: from nautica.notk.org ([91.121.71.147]:35419 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbfAGXs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 18:48:57 -0500
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 258CFC01B; Tue,  8 Jan 2019 00:48:54 +0100 (CET)
Date:   Tue, 8 Jan 2019 00:48:39 +0100
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Salvatore Bonaccorso <carnil@debian.org>,
        Steven Sistare <steven.sistare@oracle.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, John Stultz <john.stultz@linaro.org>,
        sboyd@codeaurora.org, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, Peter Zijlstra <peterz@infradead.org>,
        prarit@redhat.com, feng.tang@intel.com,
        Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, pbonzini@redhat.com,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        qemu-devel@nongnu.org
Subject: Re: [PATCH v15 23/26] sched: early boot clock
Message-ID: <20190107234839.GA15269@nautica>
References: <20180719205545.16512-1-pasha.tatashin@oracle.com>
 <20180719205545.16512-24-pasha.tatashin@oracle.com>
 <20181106054212.GA31768@nautica>
 <95c3920e-bf80-0c7e-7854-01a1c3189c23@oracle.com>
 <20190102202032.GA1034@eldamar.local>
 <CA+CK2bC70pnL0Wimb0xt99J4nNfi8W3zuUHgAk-jsPuOP9jpHA@mail.gmail.com>
 <20190103234339.GA17457@nautica>
 <CA+CK2bDj1f=VpT+k-e8kSSaoLJ3W9-JPPq9udFdDwd6ijXi28g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+CK2bDj1f=VpT+k-e8kSSaoLJ3W9-JPPq9udFdDwd6ijXi28g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Tatashin wrote on Mon, Jan 07, 2019:
> I could not reproduce the problem. Did you suspend to memory between
> wake ups? Does this time jump happen every time, even if your laptop
> sleeps for a minute?

I'm not sure I understand "suspend to memory between the wake ups".
The full sequence is:
 - start a VM (just in case, I let it boot till the end)
 - suspend to memory (aka systemctl suspend) the host
 - after resuming the host, soft reboot the VM (login through
serial/ssh/whatever and reboot or in the qemu console 'system_reset')

I've just slept exactly one minute and reproduced again with the fedora
stock kernel now (4.19.13-300.fc29.x86_64) in the VM.

Interestingly I'm not getting the same offset between multiple reboots
now despite not suspending again; but if I don't suspend I cannot seem
to get it to give an offset at all (only tried for a few minutes; this
might not be true) ; OTOH I pushed my luck further and even with a five
seconds sleep I'm getting a noticeable offset on first VM reboot after
resume:

[    0.000000] Hypervisor detected: KVM
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[  179.362163] kvm-clock: cpu 0, msr 13c01001, primary cpu clock
[  179.362163] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns

Honestly not sure what more information I could give, I'll try on some
other hardware than my laptop (if I can get a server to resume after
suspend through ipmi or wake on lan); but I don't have anything I could
install ubuntu on to try their qemu's version... although I really don't
want to believe that's the difference...

Thanks,
-- 
Dominique
