Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A49C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ADF221783
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b="HuxskqOh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732352AbfAKOVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:21:36 -0500
Received: from mail-40130.protonmail.ch ([185.70.40.130]:53061 "EHLO
        mail-40130.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732674AbfAKOVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:21:34 -0500
Date:   Fri, 11 Jan 2019 14:21:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=default; t=1547216490;
        bh=DobqyVWU0IZGrSmxEAEnzqfjPmQW8Rg1N5FGBDHHEnk=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=HuxskqOhTWVyEZIYu19J26YdY/aLQQiZgVLCsOOcqI99lCtQZmMKS+M0CKwBcTSRz
         15ywY68M/8hkPJyI9s6XZLoiANF9rO5U1SZMetVgXiSJBKb+Wu+yKTQ0yqhvPSm/JJ
         CxBIKa0E8uiWo52q7o+L0f4/S1QlMBeccAfkjGvg=
To:     Peter Zijlstra <peterz@infradead.org>
From:   Esme <esploit@protonmail.ch>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        JJiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-To: Esme <esploit@protonmail.ch>
Subject: Re: PROBLEM: syzkaller found / reduced C repro for non-fatal unchecked MSR access error
Message-ID: <ApiQycofBryJsrwcFgVkYUPF9sryQP9s8J2V8nbBc2m2sEhhMLrLd8HJ6nB_27Pr1z3AkoVduGvPzrHrhzRg4oryTQwXPRaYL8phr79zBAU=@protonmail.ch>
In-Reply-To: <20190111135948.GA20688@hirez.programming.kicks-ass.net>
References: <z3BgwrH88cXG8bH06po3hzY6vkYpdvZWqzSGl4lLXojvzk-33tKzdK1NWsTL1Ta-CBG7GKAWYziBAfPKsGA2CV6MVkXT93Al3SUfArOnUQE=@protonmail.ch>
 <20190111100253.GO30894@hirez.programming.kicks-ass.net>
 <kiksO_ofcRQ-2X83SaK_UGN4kwBcC8iHvgwFsGGitzaibUCc8Biv_b7AB9zfpJnM0F0a6-CIE_GxrXpabaz0duQWYcPEjhAcYHKhPsIRimk=@protonmail.ch>
 <20190111135948.GA20688@hirez.programming.kicks-ass.net>
Feedback-ID: pQGzDYT_k6dzic_kf3kwsxmTXzjnqMJxtC9J3KGyZBepPHdXRBM0BHuwPfpm1pFdJLAMwtJT5KKNaGlRVnFRQw==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Friday, January 11, 2019 8:59 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:

> On Fri, Jan 11, 2019 at 01:37:50PM +0000, Esme wrote:
>
> > =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Origina=
l Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=
=90
> > On Friday, January 11, 2019 5:02 AM, Peter Zijlstra peterz@infradead.or=
g wrote:
> >
> > > On Thu, Jan 10, 2019 at 11:21:16PM +0000, Esme wrote:
> > >
> > > > Attached is a fairly small C repro I did not see any references to
> > > > this possible flaw (unchecked MSR access) in relation to
> > > > __NR_perf_event_open
> > > > Attached is the config directly extracted from proc. This is the ca=
ll
> > > > stack in relation to the MSR access error (5.0.0-rc1+), I get a ver=
y
> > > > similar stack running this test case on a stock Ubuntu
> > > > "4.18.0-11-generic" (pasted after this one).
> > >
> > > > -- Esme
> > > > [ 70.228744] unchecked MSR access error: WRMSR to 0xc0010000 (tried=
 to write 0x0000020000130076) at rIP: 0xffffffff812dde28 (native_write_msr+=
0x8/0x30)
> > >
> > > That's K7_EVNTSEL0. What kind of hardware are you running this on?
> >
> > QEMU emulator version 3.0.93 (v3.1.0-rc3-dirty)
> > [ 0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.=
0-0-ga698c8995f-prebuilt.qemu.org 04/01/2014
> > [ 0.000000] Linux version 4.18.0-11-generic (buildd@lcy01-amd64-027) (g=
cc version 8.2.0 (Ubuntu 8.2.0-7ubuntu1)) #12-Ubuntu SMP Tue Oct 23 19:22:3=
7 UTC 2018 (Ubuntu 4.18.0-11.12-generic 4.18.12)
> > [ 0.000000] Command line: BOOT_IMAGE=3D/boot/vmlinuz-4.18.0-11-generic =
root=3DUUID=3D3a43ccb9-a433-4296-8dc5-0443f2a32128 ro quiet splash vt.hando=
ff=3D1
> > [ 0.000000] KERNEL supported cpus:
> > [ 0.000000] Intel GenuineIntel
> > [ 0.000000] AMD AuthenticAMD
> > [ 0.000000] Centaur CentaurHauls
> > [ 0.000000] random: get_random_u32 called from bsp_init_amd+0x205/0x2a0=
 with crng_init=3D0
> > [ 0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating poin=
t registers'
> > [ 0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> > [ 0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> > [ 0.000000] x86/fpu: xstate_offset[2]: 576, xstate_sizes[2]: 256
> > [ 0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 b=
ytes, using 'standard' format.
>
> Feh, then you get to figure out how the heck it passes
> check_hw_exists().
>
> Stupid virt crap again.

I see, I'm busy most of the day, I do have some bare metal hosts I'm going =
to update with -current.

Do you have any suggested kernel flags to use for the build?

If it's specific to virt, I might just toss it into the cloud ;) and see wh=
at happens, later.
/Best Esme

