Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F58ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 15:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 487A521473
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 15:05:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 487A521473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.ee
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbeGOP2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 11:28:25 -0400
Received: from smtp2.it.da.ut.ee ([193.40.5.67]:40454 "EHLO smtp2.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbeGOP2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 11:28:25 -0400
Received: from math.ut.ee (unknown [IPv6:2001:bb8:2002:2400:5054:ff:fe3b:8db9])
        by smtp2.it.da.ut.ee (Postfix) with ESMTP id 5D58690020;
        Sun, 15 Jul 2018 18:05:05 +0300 (EEST)
Received: by math.ut.ee (Postfix, from userid 1014)
        id 4B4A32207EE; Sun, 15 Jul 2018 18:05:03 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
        by math.ut.ee (Postfix) with ESMTP id 3207F220442;
        Sun, 15 Jul 2018 18:05:03 +0300 (EEST)
Date:   Sun, 15 Jul 2018 18:05:03 +0300 (EEST)
From:   Meelis Roos <mroos@linux.ee>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 4.18-rc* regression: x86-32 troubles (with timers?)
In-Reply-To: <alpine.LRH.2.21.1807051254050.21817@math.ut.ee>
Message-ID: <alpine.LRH.2.21.1807151803010.17406@math.ut.ee>
References: <alpine.LRH.2.21.1807041414080.3671@math.ut.ee> <CAK8P3a1RkNc_kShHBJ6QENrQheQi=C93DmnknC1S_uJDcTDqww@mail.gmail.com> <alpine.LRH.2.21.1807051254050.21817@math.ut.ee>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > I tried 4.18.0-rc1-00023-g9ffc59d57228 and now
> > > 4.18.0-rc3-00113-gfc36def997cf on a 32-bit server and then some other
> > > 32-bit machines, and got half-failed bootup - kernel and userspace come
> > > up but some services fail to start, including network and
> > > systemd-journald:
> > >
> > > systemd-journald[85]: Assertion 'clock_gettime(map_clock_id(clock_id), &ts) == 0' failed at ../src/basic/time-util.c:53, function now(). Aborting.
> > >
> > > I then tried multiple other machines. All x86-64 machines seem
> > > unaffected, some x86-32 machines are affected (Athlon with AMD750
> > > chipset, Fujitsu RX100-S2 with P4-3.4, and P4 with Intel 865 chipset),
> > > some very similar x86-32 machines are unaffected. I have different
> > > customized kernel configuration on them, so far I have not pinpointed
> > > any configuration option to be at fault.
> > >
> > > All machines run Debian unstable.
> > >
> > > 4.17.0 was working fine.
> > >
> > > Will continue with bisecting between 4.17.0 and
> > > 4.18.0-rc1-00023-g9ffc59d57228.

Bisection has been finished (I'm usually away from the problematic 
computers in summer), result is strange and seems unrelated:

0bc5fe857274133ca028ebb15ff2e8549a369916 is the first bad commit
commit 0bc5fe857274133ca028ebb15ff2e8549a369916
Author: Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>
Date:   Sat May 5 18:42:59 2018 -0700

    qed*: Refactor mf_mode to consist of bits.

    `mf_mode' field indicates the multi-partitioning mode the device is
    configured to. This method doesn't scale very well, adding a new MF mode
    requires going over all the existing conditions, and deciding whether those
    are needed for the new mode or not.
    The patch defines a set of bit-fields for modes which are derived according
    to the mode info shared by the MFW and all the configuration would be made
    according to those. To add a new mode, there would be a single place where
    we'll need to go and choose which bits apply and which don't.

    Signed-off-by: Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>
    Signed-off-by: Ariel Elior <ariel.elior@cavium.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

:040000 040000 a3572846e1afb9ccfa9c4a84b0135a0057ade66f bdb7b28725a4f1bffe79ee384a3603b3127d6fdb M      drivers
:040000 040000 f90c7f26fd8445afa48c6679ed68fed294b23d7f 52119c547a82b268b5c173d3df94e267cc1297a0 M      include
mroos@rx100s2:~/linux$ nice git bisect log
git bisect start# good: [29dcea88779c856c7dc92040a0c01233263101d4] Linux 4.17
git bisect good 29dcea88779c856c7dc92040a0c01233263101d4
# good: [e27c49291a7fe9dc415c9fcab5bd781ec82dfe04] x86: Convert x86_platform_ops to timespec64
git bisect good e27c49291a7fe9dc415c9fcab5bd781ec82dfe04
# bad: [1c8c5a9d38f607c0b6fd12c91cbe1a4418762a21] Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next
git bisect bad 1c8c5a9d38f607c0b6fd12c91cbe1a4418762a21
# bad: [1c8c5a9d38f607c0b6fd12c91cbe1a4418762a21] Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next
git bisect bad 1c8c5a9d38f607c0b6fd12c91cbe1a4418762a21
# good: [135c5504a600ff9b06e321694fbcac78a9530cd4] Merge tag 'drm-next-2018-06-06-1' of git://anongit.freedesktop.org/drm/drm
git bisect good 135c5504a600ff9b06e321694fbcac78a9530cd4
# bad: [ffbc9197b4721634dc6c0fefa9b31e565fa89cee] wcn36xx: improve debug and error messages for SMD
git bisect bad ffbc9197b4721634dc6c0fefa9b31e565fa89cee
# good: [3a443bd6dd7c43bf5763779309514bf3e7c1c3eb] net/9p: correct the variable name in v9fs_get_trans_by_name() comment
git bisect good 3a443bd6dd7c43bf5763779309514bf3e7c1c3eb
# bad: [93c65d13d8a0b7c272868d4a9779f96fc973df26] vmxnet3: Replace msleep(1) with usleep_range()
git bisect bad 93c65d13d8a0b7c272868d4a9779f96fc973df26
# good: [4bc871984f7cb5b2dec3ae64b570cb02f9ce2227] Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
git bisect good 4bc871984f7cb5b2dec3ae64b570cb02f9ce2227
# bad: [38aa51c134b56b7ea61bea79b428c5fbcd95f285] net/mlx5e: Support offloaded TC flows with no matches on headers
git bisect bad 38aa51c134b56b7ea61bea79b428c5fbcd95f285
# bad: [00483690552c5fb6aa30bf3acb75b0ee89b4c0fd] tcp: Add mark for TIMEWAIT sockets
git bisect bad 00483690552c5fb6aa30bf3acb75b0ee89b4c0fd
# bad: [3e50d2da5850dd126b3e6a6e4387620d55b71db4] microchip_t1: Add driver for Microchip LAN87XX T1 PHYs
git bisect bad 3e50d2da5850dd126b3e6a6e4387620d55b71db4
# bad: [dac0490718bd17df5e3995ffca14255e5f9ed22d] bnxt_en: Check unsupported speeds in bnxt_update_link() on PF only.
git bisect bad dac0490718bd17df5e3995ffca14255e5f9ed22d
# bad: [9d4927f0d3760d8f10727c3035121d2677108f44] Merge branch 'ipv6-misc'
git bisect bad 9d4927f0d3760d8f10727c3035121d2677108f44
# bad: [cac6f691546b9efd50c31c0db97fe50d0357104a] qed: Add support for Unified Fabric Port.
git bisect bad cac6f691546b9efd50c31c0db97fe50d0357104a
# bad: [27bf96e32c92599dc7523b36d6c761fc8312c8c0] qed: Remove unused data member 'is_mf_default'.
git bisect bad 27bf96e32c92599dc7523b36d6c761fc8312c8c0
# bad: [0bc5fe857274133ca028ebb15ff2e8549a369916] qed*: Refactor mf_mode to consist of bits.
git bisect bad 0bc5fe857274133ca028ebb15ff2e8549a369916
# first bad commit: [0bc5fe857274133ca028ebb15ff2e8549a369916] qed*: Refactor mf_mode to consist of bits.


-- 
Meelis Roos (mroos@linux.ee)
