Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80663C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4829F2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="Oqz1dG0b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4829F2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbeJ3XJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 19:09:57 -0400
Received: from imap.thunk.org ([74.207.234.97]:44006 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728033AbeJ3XJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 19:09:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=wqnl0Byl/Ja8fcv0nyZPDb2TwWsmDZPb4XrYgH6Yr28=; b=Oqz1dG0bZsj8bPR3Nwku/KSjZa
        sPTZpZ5Z6Fwe65xsOqnWE99otK5F42AjGjRJwA2NNAgtR2VjzQXs4Ni/NDJXJxiOPIPiYJRUKsvQN
        MDM2A9HUTwZE97paaJV5oQWmcU29UAPN6XZPUK34BzgM5WgSZylRABX51lS3BtuXe5Bo=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gHUo5-0007Jr-0T; Tue, 30 Oct 2018 14:15:45 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 40EC27A45B5; Tue, 30 Oct 2018 10:15:44 -0400 (EDT)
Date:   Tue, 30 Oct 2018 10:15:44 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc:     Kurt Roeckx <kurt@roeckx.be>, 912087@bugs.debian.org,
        "Package Development List for OpenSSL packages." 
        <pkg-openssl-devel@alioth-lists.debian.net>,
        linux-kernel@vger.kernel.org,
        Bernhard =?iso-8859-1?Q?=DCbelacker?= <bernhardu@mailbox.org>,
        pkg-systemd-maintainers@lists.alioth.debian.org,
        debian-ssh@lists.debian.org, 912087-submitter@bugs.debian.org
Subject: Re: Bug#912087: openssh-server: Slow startup after the upgrade to
 7.9p1
Message-ID: <20181030141544.GE15839@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
        Kurt Roeckx <kurt@roeckx.be>, 912087@bugs.debian.org,
        "Package Development List for OpenSSL packages." <pkg-openssl-devel@alioth-lists.debian.net>,
        linux-kernel@vger.kernel.org,
        Bernhard =?iso-8859-1?Q?=DCbelacker?= <bernhardu@mailbox.org>,
        pkg-systemd-maintainers@lists.alioth.debian.org,
        debian-ssh@lists.debian.org, 912087-submitter@bugs.debian.org
References: <20181029223334.GH10011@roeckx.be>
 <20181030001807.7wailpm37mlinsli@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030001807.7wailpm37mlinsli@breakpoint.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 01:18:08AM +0100, Sebastian Andrzej Siewior wrote:
> Using ioctl(/dev/urandom, RNDADDENTROPY, ) instead writting to
> /dev/urandom would do the trick. Or using RNDADDTOENTCNT to increment
> the entropy count after it was written. Those two are documented in
> random(4). Or RNDRESEEDCRNG could be used to force crng to be reseeded.
> It does also the job, too.
> 
> Ted, is there any best practise what to do with the seed which as
> extrected from /dev/urandom on system shutdown? Using RNDADDTOENTCNT to
> speed up init or just write to back to urandom and issue RNDRESEEDCRNG?

The reason why writing to /dev/[u]random via something like:

    cat /var/lib/random/seed > /dev/random

Dosn't bump the the entropy counter is because it's possible that an
attacker could read /var/lib/random/seed.  Even if the seed file is
refreshed on shutdown, (a) the attacker could have read the file while
the system is down, or (b) the system could have crashed so the seed
file was not refreshed and the attacker could have read the file
before the crash.

If you are using a VM, if the host has virtio-rng, using a kernel that
has virtio-rng support will solve the problem.  For qemu, this means
you can enable via something like this:

         -object rng-random,filename=/dev/urandom,id=rng0 \
	 -device virtio-rng-pci,rng=rng0

If you are using Google Compute Engine, I can't comment about future
product features, but I would encourage you to file a feature request
bug with Google requesting virtio-rng support ASAP.

On any VM (cloud or on-prem), since you have to trust the host
*anyway*, with v4.19, you can add random.trust_cpu=on to the boot
command-line, or build the kernel with CONFIG_RANDOM_TRUST_CPU.

For the Debian 4.18 kernel, this can be backported via commits
39a8883a2b98 and 9b25436662d5.

					- Ted
