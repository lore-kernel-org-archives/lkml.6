Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A661ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5994D20661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5994D20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.ee
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbeGTVqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 17:46:42 -0400
Received: from smtp1.it.da.ut.ee ([193.40.5.66]:32786 "EHLO smtp1.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728132AbeGTVqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 17:46:42 -0400
Received: from math.ut.ee (unknown [IPv6:2001:bb8:2002:2400:5054:ff:fe3b:8db9])
        by smtp1.it.da.ut.ee (Postfix) with ESMTP id 6EC7D9006B;
        Fri, 20 Jul 2018 23:56:41 +0300 (EEST)
Received: by math.ut.ee (Postfix, from userid 1014)
        id 496EC220518; Fri, 20 Jul 2018 23:56:39 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
        by math.ut.ee (Postfix) with ESMTP id 29245220187;
        Fri, 20 Jul 2018 23:56:39 +0300 (EEST)
Date:   Fri, 20 Jul 2018 23:56:39 +0300 (EEST)
From:   Meelis Roos <mroos@linux.ee>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 4.18-rc* regression: x86-32 troubles (with timers?)
In-Reply-To: <alpine.LRH.2.21.1807162200180.27791@math.ut.ee>
Message-ID: <alpine.LRH.2.21.1807202339490.8506@math.ut.ee>
References: <alpine.LRH.2.21.1807041414080.3671@math.ut.ee> <CAK8P3a1RkNc_kShHBJ6QENrQheQi=C93DmnknC1S_uJDcTDqww@mail.gmail.com> <alpine.LRH.2.21.1807051254050.21817@math.ut.ee> <alpine.LRH.2.21.1807151803010.17406@math.ut.ee>
 <CAK8P3a2NtB_FmiSjrzZb=HoshEzo+MP2xwafC3QcMg79rffipg@mail.gmail.com> <alpine.LRH.2.21.1807161948380.27791@math.ut.ee> <alpine.LRH.2.21.1807162200180.27791@math.ut.ee>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Everything below here is is 'bad', which can be an indication that you
> > > misclassified one of
> > > the commits above as 'good' when it should have been 'bad'. The most likely
> > > explanations are that you either typed the 'git bisect good' by accident, or
> > > that the failure is not 100% reliable, and it sometimes works fine even on a
> > > broken kernel.
> > > 
> > > 0bc5fe857274133ca0 follows directly after 3a443bd6dd7c, "net/9p: correct the
> > > variable name in v9fs_get_trans_by_name() comment", which is marked "good",
> > > and can't really be good if 0bc5fe85727413 is bad and you are not using the
> > > 'qed' driver.
> > > 
> > > I'd retest 3a443bd6dd7c again to see if that should have been 'bad', and
> > > if it was, test v4.17-rc4, which is what the net-next tree was based on.
> > 
> > Yes, the same prebuilt 3a443bd6dd7c appeared to be bad when retesting 
> > it. Building v4.17-rc4 now.
> 
> v4.17-rc4 seems good after 2 reboots.

The new bisect seems to have also led me to a strange commit. This time 
I tried to be careful and tested most on two reboots before classifying 
as good.

However, f4e3ec0d573e was suspicious - it failed to autoload e1000 but 
had no other errors. On both boots with this kernel, modprobe e1000 and 
ifup -a made the system work so I assumed it was good, while it might 
not have been. Will try bisecting with f4e3ec0d573e marked bad.

mroos@rx100s2:~/linux$ nice git bisect bad
9816dd35ececc095f3e3be29d30d3adc755908d9 is the first bad commit
commit 9816dd35ececc095f3e3be29d30d3adc755908d9
Author: Jakub Kicinski <jakub.kicinski@netronome.com>
Date:   Thu May 3 18:37:12 2018 -0700

    nfp: bpf: perf event output helpers support
    
    Add support for the perf_event_output family of helpers.
    
    The implementation on the NFP will not match the host code exactly.
    The state of the host map and rings is unknown to the device, hence
    device can't return errors when rings are not installed.  The device
    simply packs the data into a firmware notification message and sends
    it over to the host, returning success to the program.
    
    There is no notion of a host CPU on the device when packets are being
    processed.  Device will only offload programs which set BPF_F_CURRENT_CPU.
    Still, if map index doesn't match CPU no error will be returned (see
    above).
    
    Dropped/lost firmware notification messages will not cause "lost
    events" event on the perf ring, they are only visible via device
    error counters.
    
    Firmware notification messages may also get reordered in respect
    to the packets which caused their generation.
    
    Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
    Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
    Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

:040000 040000 00caca934fcbf1d5740a46d71e4d08e1f3ab8c7a 
606c7bdd23e357f0902219630579c22a0ed0380c M      drivers
mroos@rx100s2:~/linux$ nice git bisect log
git bisect start
# bad: [3a443bd6dd7c43bf5763779309514bf3e7c1c3eb] net/9p: correct the variable name in v9fs_get_trans_by_name() comment
git bisect bad 3a443bd6dd7c43bf5763779309514bf3e7c1c3eb
# good: [75bc37fefc4471e718ba8e651aa74673d4e0a9eb] Linux 4.17-rc4
git bisect good 75bc37fefc4471e718ba8e651aa74673d4e0a9eb
# good: [1504269814263c9676b4605a6a91e14dc6ceac21] Merge tag 'linux-kselftest-4.17-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
git bisect good 1504269814263c9676b4605a6a91e14dc6ceac21
# skip: [c7d28c9df292a49904446dca15b2037ee8f874af] net: dsa: b53: Add support for reading PHY statistics
git bisect skip c7d28c9df292a49904446dca15b2037ee8f874af
# good: [173965fbfba596c02fa128966c2a33cb88afcd7f] tools/bpf: add a test for bpf_get_stack with raw tracepoint prog
git bisect good 173965fbfba596c02fa128966c2a33cb88afcd7f
# good: [795d8098d32b6bef3d0821588cb6e4b1f369a7a4] liquidio VF: indicate that disabling rx vlan offload is not allowed
git bisect good 795d8098d32b6bef3d0821588cb6e4b1f369a7a4
# good: [90278871d4b0da39c84fc9aa4929b0809dc7cf3c] Merge git://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf-next
git bisect good 90278871d4b0da39c84fc9aa4929b0809dc7cf3c
# good: [4e1ec56cdc59746943b2acfab3c171b930187bbe] bpf: add skb_load_bytes_relative helper
git bisect good 4e1ec56cdc59746943b2acfab3c171b930187bbe
# good: [f4e3ec0d573e238f383b3da365127002579a07d6] bpf: replace map pointer loads before calling into offloads
git bisect good f4e3ec0d573e238f383b3da365127002579a07d6
# bad: [e94fa1d93117e7f1eb783dc9cae6c70650944449] bpf, xskmap: fix crash in xsk_map_alloc error path handling
git bisect bad e94fa1d93117e7f1eb783dc9cae6c70650944449
# bad: [e64d52569f6e847495091db40ab58d2d379748ef] tools: bpftool: move get_possible_cpus() to common code
git bisect bad e64d52569f6e847495091db40ab58d2d379748ef
# bad: [b4264c96b5cbc00c4c07deb9fbab928d43dffcf9] nfp: bpf: rewrite map pointers with NFP TIDs
git bisect bad b4264c96b5cbc00c4c07deb9fbab928d43dffcf9
# bad: [9816dd35ececc095f3e3be29d30d3adc755908d9] nfp: bpf: perf event output helpers support
git bisect bad 9816dd35ececc095f3e3be29d30d3adc755908d9
# first bad commit: [9816dd35ececc095f3e3be29d30d3adc755908d9] nfp: bpf: perf event output helpers support


-- 
Meelis Roos (mroos@linux.ee)
