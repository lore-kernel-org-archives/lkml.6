Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA344C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA12120872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jnkz4S8t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732965AbfAKN7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 08:59:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51004 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbfAKN7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 08:59:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vYokSj6HZdpVhgmsR5UYVRLNZuwSppMV4z0K7GJ9z1w=; b=jnkz4S8tu3lU+r+ywDhPiydWZQ
        aHhOxNg25NnKFYxGWR1KdwBx7azgolMUsJE65NnC7vrObpane5uygP7Upt/qaS0H6bpmIIZD1xzMA
        b1kVBHt9v0A/obRSuegJCyhoPTisCMP3WJUuCJ/BvThys6Lo8pmVCrysqd+JEy20R37mIn1Lv/e45
        m2JLgN1hLt0bl2xGahQhHZOB749pfN87cTXb8s75DOo4dc3w4jdtsZUc0/Le+/WD5ieCeZKoOIkuV
        pxGM3/F6ftzofK0wPM55t6vQvXFftXYIzvTwn1mBTqHes7TXWGRqjLF9AHt3dnpMfS2JpBsOoixz5
        MSa4e8GA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ghxLi-0002mT-5f; Fri, 11 Jan 2019 13:59:50 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 56BB520194963; Fri, 11 Jan 2019 14:59:48 +0100 (CET)
Date:   Fri, 11 Jan 2019 14:59:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Esme <esploit@protonmail.ch>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        JJiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: syzkaller found / reduced C repro for non-fatal
 unchecked MSR access error
Message-ID: <20190111135948.GA20688@hirez.programming.kicks-ass.net>
References: <z3BgwrH88cXG8bH06po3hzY6vkYpdvZWqzSGl4lLXojvzk-33tKzdK1NWsTL1Ta-CBG7GKAWYziBAfPKsGA2CV6MVkXT93Al3SUfArOnUQE=@protonmail.ch>
 <20190111100253.GO30894@hirez.programming.kicks-ass.net>
 <kiksO_ofcRQ-2X83SaK_UGN4kwBcC8iHvgwFsGGitzaibUCc8Biv_b7AB9zfpJnM0F0a6-CIE_GxrXpabaz0duQWYcPEjhAcYHKhPsIRimk=@protonmail.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <kiksO_ofcRQ-2X83SaK_UGN4kwBcC8iHvgwFsGGitzaibUCc8Biv_b7AB9zfpJnM0F0a6-CIE_GxrXpabaz0duQWYcPEjhAcYHKhPsIRimk=@protonmail.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 01:37:50PM +0000, Esme wrote:
> ‐‐‐‐‐‐‐ Original Message ‐‐‐‐‐‐‐
> On Friday, January 11, 2019 5:02 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Thu, Jan 10, 2019 at 11:21:16PM +0000, Esme wrote:
> >
> > > Attached is a fairly small C repro I did not see any references to
> > > this possible flaw (unchecked MSR access) in relation to
> > > __NR_perf_event_open
> > > Attached is the config directly extracted from proc. This is the call
> > > stack in relation to the MSR access error (5.0.0-rc1+), I get a very
> > > similar stack running this test case on a stock Ubuntu
> > > "4.18.0-11-generic" (pasted after this one).
> >
> > > -- Esme
> > > [ 70.228744] unchecked MSR access error: WRMSR to 0xc0010000 (tried to write 0x0000020000130076) at rIP: 0xffffffff812dde28 (native_write_msr+0x8/0x30)
> >
> > That's K7_EVNTSEL0. What kind of hardware are you running this on?
> 
> QEMU emulator version 3.0.93 (v3.1.0-rc3-dirty)
> [    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c8995f-prebuilt.qemu.org 04/01/2014
> 
> 
> [    0.000000] Linux version 4.18.0-11-generic (buildd@lcy01-amd64-027) (gcc version 8.2.0 (Ubuntu 8.2.0-7ubuntu1)) #12-Ubuntu SMP Tue Oct 23 19:22:37 UTC 2018 (Ubuntu 4.18.0-11.12-generic 4.18.12)
> [    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-4.18.0-11-generic root=UUID=3a43ccb9-a433-4296-8dc5-0443f2a32128 ro quiet splash vt.handoff=1
> [    0.000000] KERNEL supported cpus:
> [    0.000000]   Intel GenuineIntel
> [    0.000000]   AMD AuthenticAMD
> [    0.000000]   Centaur CentaurHauls
> [    0.000000] random: get_random_u32 called from bsp_init_amd+0x205/0x2a0 with crng_init=0
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> [    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> [    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.

Feh, then you get to figure out how the heck it passes
check_hw_exists().

Stupid virt crap _again_.
