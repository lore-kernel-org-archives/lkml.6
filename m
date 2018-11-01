Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D4DC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 582AB2084C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="xGE+YTyx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 582AB2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbeKBIz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 04:55:57 -0400
Received: from imap.thunk.org ([74.207.234.97]:55680 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728058AbeKBIz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 04:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9JZUDOmaw8q76+J+82l+ju5vPoUbzcVEjdTGtZ/hT5k=; b=xGE+YTyxBEZk90SOlo8vJ5pvrz
        0Eu7gBaMjiOpFjkdOLMaK3ZyD/TL6zGsR+AxPmb+kbv+TEBk0265oosDo8GT9GSj+5YXxw/TgqtXR
        vMJFqjz/9JBn1ixdunbm+sgaV7zx++z6VaPBcUyMNd9bh6/Y0/+N8v0Tjy8ygDDUhMZs=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gIMjU-0006vn-6y; Thu, 01 Nov 2018 23:50:36 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 748FF7A7770; Thu,  1 Nov 2018 19:50:35 -0400 (EDT)
Date:   Thu, 1 Nov 2018 19:50:35 -0400
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
Message-ID: <20181101235035.GC25621@thunk.org>
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
 <20181030141544.GE15839@thunk.org>
 <20181030183723.GI10011@roeckx.be>
 <20181030205136.GB6236@thunk.org>
 <6BBD7CF1-696B-4B5E-ABD8-A30C2F15E5C5@breakpoint.cc>
 <20181031224106.GD6236@thunk.org>
 <20181101221813.qfglqvmzk47m53yx@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181101221813.qfglqvmzk47m53yx@breakpoint.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 11:18:14PM +0100, Sebastian Andrzej Siewior wrote:
> Okay. So you wrote what can be done for a system with HW-RNG/kvm. On
> bare metal with nothing fancy I have:
> [    3.544985] systemd[1]: systemd 239 running in system mode. (+PAM…
> [   10.363377] r8169 0000:05:00.0 eth0: link up
> [   41.966375] random: crng init done
> 
> which means I have to wait about half a minute until I can ssh into. And
> there is no way to speed it up?

So that surprises me.  Can you tell me more about the hardware?  Is it
something like a Rasberry Pi?  Or is it an x86 server or desktop?  In
my experience for most x86 platforms this isn't an issue.

The main reason why I've talked about VM system is because this is
where it where most of the problems that people ahve reported to me.

Here's the problem: if we "speed it up" inappropriately, you're
risking the security of the ssh.  If people who are making a print
server or Wifi Rounter who screw it up, they're the ones who are at
fault.  (And this isn't hypothetical.  See https://factorable.net)

So if I make a blanket recommendation, and it causes Debian to ship
some kind of default that causes Debian users to be insecure, I'm
going to be feel really bad.  This is why I'm very cautious about what
I say.  If you want to do whatever you want on your own system, hey
consulting adults can do whatever they want.  :-)

> You did not oppose RNDADDTOENTCNT/RNDADDENTROPY but you wanted to make
> it configureable and not default, correct?

I'd want to see a full design doc, or a git repository, or set of
changes before I give it an unqualified endorsement, but there *are*
configurations where such a thing would be sane.

That's the problem with security recommendations.  It's much like a
lawyer giving legal advice.  They're very careful about doing that in
an unstructured circumstances.  If it gets taken in the wrong way,
they could be legally liable and people might blame/sue them.

And then on top of that, there are the political considerations.
Suppose I told you, "just use RDRAND and be happy".  Some people who
sure that RDRAND has been backdoored would claim that I'm in the
pocket of the NSA and/or Intel.  That's why all I'm going to say is,
"I'm comfortable turning RDRAND on my own systems; you can do what you
want."

Cheers,

						- Ted

P.S.  Although if I were going to generate a high-value key, I *would*
plug in my handy-dandy Chaos Key[1] first.  Keith gave a
presentation[2] about it at Debconf 16.

[1] https://keithp.com/blogs/chaoskey/
[2] https://debconf16.debconf.org/talks/94/

And certainly if you were doing something where you had millions of
dollars at risk, or where the EU might fine you into oblivion for
millions of Euros due to some privacy exposure of your users, I
certainly would recommend that you spend the $40 USD to get a Chaos
Key and just be *done* with it.
