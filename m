Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E923ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7BA20856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="U5rFTcsd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD7BA20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388364AbeGWQ1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:27:07 -0400
Received: from imap.thunk.org ([74.207.234.97]:46624 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387922AbeGWQ1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:27:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=njuViQgJbuMT22iLANf0Cu4rfvzTmCjNGIkyyL0icGo=; b=U5rFTcsdM8GwpcXdVN+2vxL5Hb
        Hc1qbQ6h1Kp/LsxYY/knAzQ0ql1ZRAa/pT5HrWSKHshXP43Az3mplzoC4Qg0SvbAhh7g/ThzkKRul
        ChhCJRi3bl/MV6ut2Poy9MMfi9lCjxTtOaP7Iy4nVMsuR8CFeW+wuejxGTLNUAu5wcQg=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fhciA-0001ue-ER; Mon, 23 Jul 2018 15:25:22 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id AE9B07A6463; Mon, 23 Jul 2018 11:16:08 -0400 (EDT)
Date:   Mon, 23 Jul 2018 11:16:08 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ken Moffat <zarniwhoop73@googlemail.com>
Cc:     linux-crypto@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Does /dev/urandom now block until initialised ?
Message-ID: <20180723151608.GE3358@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ken Moffat <zarniwhoop73@googlemail.com>,
        linux-crypto@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
References: <CANVEwpbaU5=wMT_iSh9XrkmbLvqKjx4+v6PDizamaY0gWvk-mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANVEwpbaU5=wMT_iSh9XrkmbLvqKjx4+v6PDizamaY0gWvk-mg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 04:43:01AM +0100, Ken Moffat wrote:
> Ted,
> 
> last week you proposed an rfc patch to gather entropy from the CPU's
> hwrng, and I was pleased - until I discovered one of my stalling
> desktop machines does not have a hwrng.  At that point I thought that
> the problem was only from reading /dev/random, so I went away to look
> at persuading the immediate consumer (unbound) to use /dev/urandom.
> 
> Did that, no change.  Ran strace from the bootscript, confirmed that
> only /dev/urandom was being used, and that it seemed to be blocking.
> Thought maybe this was the olnl problematic bootscript, tried moving
> it to later, but hit the same problem on chronyd (again, seems to use
> urandom). And yes, I probably should have started chronyd first
> anyway, but that's irrelevant to this problem.

Nope, /dev/urandom still doesn't block.  Are you sure it isn't caused
by something calling getrandom(2) --- which *will* block?

We intentionally left /dev/urandom non-blocking, because of backwards
compatibility.

> BUT: I'm not sure if I've correctly understood what is happening.
> It seems to me that the fix for CVE-2018-1108 (4.17-rc1, 4.16.4)
> means /dev/urandom will now block until fully initialised.
> 
> Is that correct and intentional ?

No, that's not right.  What the fix does is more accurately account
for the entropy accounting before getrandom(2) would become
non-blocking.  There were a bunch of things we were doing wrong,
including assuming that 100% of the bytes being sent via
add_device_entropy() were random --- when some of the things that were
feeding into it was the (fixed) information you would get from running
dmidecode (e.g., the fixed results from the BIOS configuration data).

Some of those bytes might not be known to an external adversary (such
as your CPU mainboard's serial number), but it's not exactly *Secret*.

> If so, to get the affected desktop machines to boot I seem to have
> some choices...

Well, this probably isn't going to be popular, but the other thing
that might help is you could switch distro's.  I'm guessing you run a
Red Hat distro, probably Fedora, right?

The problem which most people are seeing turns out to be a terrible
interaction between dracut-fips, systemd and a Red Hat specific patch
to libgcrypt for FIPS/FEDRAMP compliance:

https://src.fedoraproject.org/rpms/libgcrypt/blob/master/f/libgcrypt-1.6.2-fips-ctor.patch#_23

Uninstalling dracut-fips and recreating the initramfs might also help.

One of the reasons why I didn't see the problem when I was developing
the remediation patch for CVE-2018-1108 is because I run Debian
testing, which doesn't have this particular Red Hat patch.

> The latter certainly lets it boot in a reasonable time, but people
> who understand this seem to regard it as untrustworthy.  For users
> of /dev/urandom that is no big deal, but does it not mean that the
> values from /dev/random will be similarly untrustworthy and
> therefore I should not use this machine for generating long-lived
> secure keys ?

This really depends on how paranoid / careful you are.  Remember, your
keyboard controller was almost certainly built in Shenzhen, China, and
Matt Blaze published a paper on the Jitterbug in 2006:

	http://www.crypto.com/papers/jbug-Usenix06-final.pdf

In practice, after 30 minutes of operation, especially if you are
using the keyboard, the entropy pool *will* be sufficiently
randomized, whether or not it was sufficientl randomized at boot.  The
real danger of CVE-2018-1108 was always long-term keys generated at
first boot.  That was the problem that was discussed in the "Mining
your p's and q's: Detection of Widespread Weak Keys in Network
Devices" (see https://factorable.net).

So generating long-lived keys means (a) you need to be sure you trust
all of the software on the system --- some very paranoid people such
as Bruce Schneier used a freshly installed machine from CD-ROM that
was never attached to the network before examining materials from
Edward Snowden, and (b) making sure the entropy pool is initialized.

Remember we are constantly feeding input from the hardware sources
into the entropy pool; it doesn't stop the moment we think the entropy
pool is initialized.  And you can always mix extra "stuff" into the
entropy pool by echoing the results of say, taking series of dice
rolls, aond sending it via the "cat" or "echo" command into
/dev/urhandom.

So it should be possible to use the machine for generated long lived
keys; you might just need to be a bit more careful before you do it.
It's really keys generated automatically at boot that are most at risk
--- and you can always regenerate the host SSH keys after a fresh
install.  In fact, what I have done in the past when I first login to
a freshly created Cloud VM system is to run command like "dd
if=/dev/urandom count=1 bs=256 | od -x", then login to VM, and then
run "cat > /dev/urandom", and cut and paste the results of the od -x
output into the guest VM, to better initialize the entropy pool on the
VM before regenerating the host SSH keys.

Cheers,

					- Ted
