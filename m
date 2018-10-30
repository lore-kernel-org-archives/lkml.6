Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED2AC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A56D20823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:47:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A56D20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeckx.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbeJaDlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 23:41:46 -0400
Received: from excelsior.roeckx.be ([195.234.45.115]:35489 "EHLO
        excelsior.roeckx.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727465AbeJaDlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 23:41:46 -0400
X-Greylist: delayed 583 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Oct 2018 23:41:45 EDT
Received: from intrepid.roeckx.be (localhost [127.0.0.1])
        by excelsior.roeckx.be (Postfix) with ESMTP id 91501A8A0BE6;
        Tue, 30 Oct 2018 18:37:24 +0000 (UTC)
Received: by intrepid.roeckx.be (Postfix, from userid 1000)
        id EA12F1FE0AA2; Tue, 30 Oct 2018 19:37:23 +0100 (CET)
Date:   Tue, 30 Oct 2018 19:37:23 +0100
From:   Kurt Roeckx <kurt@roeckx.be>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
        912087@bugs.debian.org,
        "Package Development List for OpenSSL packages." 
        <pkg-openssl-devel@alioth-lists.debian.net>,
        linux-kernel@vger.kernel.org,
        Bernhard =?iso-8859-1?Q?=DCbelacker?= <bernhardu@mailbox.org>,
        pkg-systemd-maintainers@lists.alioth.debian.org,
        debian-ssh@lists.debian.org, 912087-submitter@bugs.debian.org
Subject: Re: Bug#912087: openssh-server: Slow startup after the upgrade to
 7.9p1
Message-ID: <20181030183723.GI10011@roeckx.be>
References: <20181029223334.GH10011@roeckx.be>
 <20181030001807.7wailpm37mlinsli@breakpoint.cc>
 <20181030141544.GE15839@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030141544.GE15839@thunk.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 10:15:44AM -0400, Theodore Y. Ts'o wrote:
> On Tue, Oct 30, 2018 at 01:18:08AM +0100, Sebastian Andrzej Siewior wrote:
> > Using ioctl(/dev/urandom, RNDADDENTROPY, ) instead writting to
> > /dev/urandom would do the trick. Or using RNDADDTOENTCNT to increment
> > the entropy count after it was written. Those two are documented in
> > random(4). Or RNDRESEEDCRNG could be used to force crng to be reseeded.
> > It does also the job, too.
> > 
> > Ted, is there any best practise what to do with the seed which as
> > extrected from /dev/urandom on system shutdown? Using RNDADDTOENTCNT to
> > speed up init or just write to back to urandom and issue RNDRESEEDCRNG?
> 
> The reason why writing to /dev/[u]random via something like:
> 
>     cat /var/lib/random/seed > /dev/random
> 
> Dosn't bump the the entropy counter is because it's possible that an
> attacker could read /var/lib/random/seed.  Even if the seed file is
> refreshed on shutdown, (a) the attacker could have read the file while
> the system is down, or (b) the system could have crashed so the seed
> file was not refreshed and the attacker could have read the file
> before the crash.

So are you saying that the /var/lib/random/seed is untrusted, and
should never be used, and we should always wait for fresh entropy?

Anyway, I think if an attacker somehow has access to that file,
you have much more serious problems.


Kurt

