Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195D7C0044C
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 00:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB322082A
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 00:18:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAB322082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=breakpoint.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbeKDJbO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 04:31:14 -0500
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:58286 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728757AbeKDJbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 04:31:14 -0500
Received: from bigeasy by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <sebastian@breakpoint.cc>)
        id 1gJ67H-0003Ke-Cg; Sun, 04 Nov 2018 01:18:11 +0100
Date:   Sun, 4 Nov 2018 01:18:11 +0100
From:   Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, Kurt Roeckx <kurt@roeckx.be>,
        912087@bugs.debian.org,
        "Package Development List for OpenSSL packages." 
        <pkg-openssl-devel@alioth-lists.debian.net>,
        linux-kernel@vger.kernel.org,
        Bernhard =?utf-8?Q?=C3=9Cbelacker?= <bernhardu@mailbox.org>,
        pkg-systemd-maintainers@lists.alioth.debian.org,
        debian-ssh@lists.debian.org, 912087-submitter@bugs.debian.org
Subject: Re: Bug#912087: openssh-server: Slow startup after the upgrade to
 7.9p1
Message-ID: <20181104001810.q42mbemjqydnrb42@breakpoint.cc>
References: <20181029223334.GH10011@roeckx.be>
 <20181030001807.7wailpm37mlinsli@breakpoint.cc>
 <20181030141544.GE15839@thunk.org>
 <20181030183723.GI10011@roeckx.be>
 <20181030205136.GB6236@thunk.org>
 <6BBD7CF1-696B-4B5E-ABD8-A30C2F15E5C5@breakpoint.cc>
 <20181031224106.GD6236@thunk.org>
 <20181101221813.qfglqvmzk47m53yx@breakpoint.cc>
 <20181101235035.GC25621@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20181101235035.GC25621@thunk.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-01 19:50:35 [-0400], Theodore Y. Ts'o wrote:
> On Thu, Nov 01, 2018 at 11:18:14PM +0100, Sebastian Andrzej Siewior wrote:
> > Okay. So you wrote what can be done for a system with HW-RNG/kvm. On
> > bare metal with nothing fancy I have:
> > [    3.544985] systemd[1]: systemd 239 running in system mode. (+PAM…
> > [   10.363377] r8169 0000:05:00.0 eth0: link up
> > [   41.966375] random: crng init done
> > 
> > which means I have to wait about half a minute until I can ssh into. And
> > there is no way to speed it up?
> 
> So that surprises me.  Can you tell me more about the hardware?  Is it
> something like a Rasberry Pi?  Or is it an x86 server or desktop?  In
> my experience for most x86 platforms this isn't an issue.

another boot on the same box:
|  dmesg |grep -i random
| [    0.000000] random: get_random_bytes called from start_kernel+0x94/0x52e with crng_init=0
| [    1.774332] random: fast init done
| [    7.318640] random: systemd: uninitialized urandom read (16 bytes read)
| [    7.318925] random: systemd: uninitialized urandom read (16 bytes read)
| [    7.338074] random: systemd: uninitialized urandom read (16 bytes read)
| [   68.791389] random: crng init done
| [   68.791397] random: 7 urandom warning(s) missed due to ratelimiting

This is a headless i7-Sandy Bridge. A small rootfs partition and there
are hardly any daemons comming up. It waits for a remote login. Running
Debian unstable (incl. kernel).

> The main reason why I've talked about VM system is because this is
> where it where most of the problems that people ahve reported to me.
Yes. Thanks for that. I have another box which I use as a desktop
machine (basically a terminal). It is older than the i7 but I unlock the
crypted root disk as part of the boot process and I assume that due to
this it initializes in less than 10secs. Same goes for my notebook.  But
the i7 has just two cables…

> So if I make a blanket recommendation, and it causes Debian to ship
> some kind of default that causes Debian users to be insecure, I'm
> going to be feel really bad.  This is why I'm very cautious about what
> I say.  If you want to do whatever you want on your own system, hey
> consulting adults can do whatever they want.  :-)

I have a few other headless boxes but those are newer and support
RDRAND. I assume that this makes a difference because otherwise I don't
see a difference (and they don't take long to init).

> > You did not oppose RNDADDTOENTCNT/RNDADDENTROPY but you wanted to make
> > it configureable and not default, correct?
> 
> I'd want to see a full design doc, or a git repository, or set of
> changes before I give it an unqualified endorsement, but there *are*
> configurations where such a thing would be sane.
> 
> That's the problem with security recommendations.  It's much like a
> lawyer giving legal advice.  They're very careful about doing that in
> an unstructured circumstances.  If it gets taken in the wrong way,
> they could be legally liable and people might blame/sue them.
> 
> And then on top of that, there are the political considerations.
> Suppose I told you, "just use RDRAND and be happy".  Some people who
> sure that RDRAND has been backdoored would claim that I'm in the
> pocket of the NSA and/or Intel.  That's why all I'm going to say is,
> "I'm comfortable turning RDRAND on my own systems; you can do what you
> want."

Okay, okay. Let sum that up:
- openssh uses openssl's random number generator which now uses
  getrandom().
- getrandom() blocks until the random pool is initializes. Can be
  checked in dmesg:
  [  TIME.STAMP] random: crng init done
  This wasn't the case earlier where /dev/urandom was used.
- random entropy like interrupts or HW random support (<ad> chaos
  key</ad>) will speed the initalisation process up.
- emulated hardware / KVM can take long to init but it helps if a hw-rnd
  device is added as part of qemu setup.
- it is possible to manually increase the entropy count and/or tell the
  random pool to init asap but it shouldn't be done because it will
  probably lead to weak random pool and probably used in wrong setups.

> Cheers,
> 
> 						- Ted
> 
> P.S…
> I
> certainly would recommend that you spend the $40 USD to get a Chaos
> Key and just be *done* with it.

I do own a Nitrokey which can create random. That is not the problem. I
just have one devel box which requires me to wait a minute before I can
login and I have to figure out how to deal with it.

Sebastian
