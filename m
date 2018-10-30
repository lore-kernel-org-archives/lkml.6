Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CE0C0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 00:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DFBF2082B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 00:18:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DFBF2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=breakpoint.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbeJ3JJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 05:09:24 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:37372 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725853AbeJ3JJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 05:09:24 -0400
Received: from bigeasy by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <sebastian@breakpoint.cc>)
        id 1gHHjU-00066m-En; Tue, 30 Oct 2018 01:18:08 +0100
Date:   Tue, 30 Oct 2018 01:18:08 +0100
From:   Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To:     Kurt Roeckx <kurt@roeckx.be>, 912087@bugs.debian.org,
        "Package Development List for OpenSSL packages." 
        <pkg-openssl-devel@alioth-lists.debian.net>,
        Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org
Cc:     Bernhard =?utf-8?Q?=C3=9Cbelacker?= <bernhardu@mailbox.org>,
        pkg-systemd-maintainers@lists.alioth.debian.org,
        debian-ssh@lists.debian.org, 912087-submitter@bugs.debian.org
Subject: Re: Bug#912087: openssh-server: Slow startup after the upgrade to
 7.9p1
Message-ID: <20181030001807.7wailpm37mlinsli@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181029223334.GH10011@roeckx.be>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-29 23:33:34 [+0100], Kurt Roeckx wrote:
> On Mon, Oct 29, 2018 at 09:58:20PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2018-10-29 18:22:08 [+0100], Kurt Roeckx wrote:
> > > So I believe this is not an openssl issue, but something in the
> > > order that the kernel's RNG is initialized and openssh is started.
> > > Potentionally the RNG isn't initialized at all and you actually
> > > have to wait for the kernel to get it's random data from the slow
> > > way.
> > > 
> > > So I'm reassigning this to systemd and openssh-server, I have no
> > > idea where the problem really is.
> > 
> > I see it, too. So during boot someone invokes "sshd -t" which invokes
> 
> That's:
> ExecStartPre=/usr/sbin/sshd -t
> 
> > 	getrandom(, 32, 0)
> > and this blocks.
> 
> And did systemd-random-seed.service get run before that?

Yes, but it does not matter from what I can see in the code. On my
system this writes 512 to /dev/urandom at timestamp 11.670639. But sshd
does this:

  sshd-2638  [004] .......    22.445819: __x64_sys_getrandom: 1| 32 0
sshd asks for 32 bytes (flags = 0)

  sshd-2638  [004] .......    22.445824: __x64_sys_getrandom: 2
-> crng_ready() is not true so we wait_for_random_bytes()

  sshd-3164  [004] .......   117.577454: __x64_sys_getrandom: 3
-> "crng init done", sshd's getrandom() resumed.

The problem is that the entropy is added but the entropy count is not
increased. So we wait.

Using ioctl(/dev/urandom, RNDADDENTROPY, ) instead writting to
/dev/urandom would do the trick. Or using RNDADDTOENTCNT to increment
the entropy count after it was written. Those two are documented in
random(4). Or RNDRESEEDCRNG could be used to force crng to be reseeded.
It does also the job, too.

Ted, is there any best practise what to do with the seed which as
extrected from /dev/urandom on system shutdown? Using RNDADDTOENTCNT to
speed up init or just write to back to urandom and issue RNDRESEEDCRNG?

> Kurt

Sebastian
