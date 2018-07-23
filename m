Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC48ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 19:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F9DD20671
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 19:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="EsgC6p99"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F9DD20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388202AbeGWUOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 16:14:00 -0400
Received: from imap.thunk.org ([74.207.234.97]:47496 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388068AbeGWUN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 16:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=8XPFS6+3JMVO3zmiIAtRufchlGU8lNKR8CJ5DG1D4Dg=; b=EsgC6p99LicvKi76kUH/QVr/e4
        89FLMTeBn3BrhGp+TPROOmQ5Fk871m2eZ6MGUM70KKpHxnIc9sycBTgRgzblvgsWWczwzJw7BlWnv
        SNQYatkDiCnWKCocT5FmMZLO5JZQQoH+ATq9+rSg0bYoAXRi4X9rWGwrCkLC34vnzZR0=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fhgEr-0003pJ-UL; Mon, 23 Jul 2018 19:11:22 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 9E39F7A04D1; Mon, 23 Jul 2018 15:11:20 -0400 (EDT)
Date:   Mon, 23 Jul 2018 15:11:20 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Ken Moffat <zarniwhoop73@googlemail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Does /dev/urandom now block until initialised ?
Message-ID: <20180723191120.GA3670@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jeffrey Walton <noloader@gmail.com>,
        Ken Moffat <zarniwhoop73@googlemail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <CANVEwpbaU5=wMT_iSh9XrkmbLvqKjx4+v6PDizamaY0gWvk-mg@mail.gmail.com>
 <20180723151608.GE3358@thunk.org>
 <CAH8yC8kT=OBjxX8ye9GYec5Hs2NORtPtf8e6DPxP8JiUH9BNyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH8yC8kT=OBjxX8ye9GYec5Hs2NORtPtf8e6DPxP8JiUH9BNyg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 12:11:12PM -0400, Jeffrey Walton wrote:
> 
> I believe Stephan Mueller wrote up the weakness a couple of years ago.
> He's the one who explained the interactions to me. Mueller was even
> cited at https://github.com/systemd/systemd/issues/4167.

Stephan had a lot of complaints about the existing random driver.
That's because he has a replacement driver that he has been pushing,
and instead of giving explicit complaints with specific patches to fix
those specific issues, he have a generalized blast of complaints, plus
a "big bang rewrite".

I've reviewed his lrng doc, and this specific issue was not among his
complaints.  Quite a while ago, I had gone through his document, and
had specifically addressed each of his complaints.  As far as I have
been able determine, all of the specific technical complaints (as
opposed to personal preference issues) have been addressed.

His complaint is a text book complaint about how *not* to file a bug
report.  That being said, we try to take bug reports from as many
sources as possible even if they aren't well formed or submitted in
the ideal place.

(I'm reminded of Linux's networking scalability limitations which
Microsoft filed in the Wall Street Journal 15+ years ago --- and which
only applied if you had 4 CPU's and four 10 megabit networking cards;
if you had four CPU's and a 100 megabit networking card, Linux would
grind Microsoft into the dust; still it was a bug, and we appreciated
the report and we fixed it, even if it wasn't filed in the ideal
forum.  :-)

> It is too bad he Mueller not receive credit for it in the CVE database.

As near as I can tell, he doesn't deserve it for this particular
issue.  It's all Jann Horn and Google's Project Zero.  (And his
writeup is a textbook example of how to report this sort of issue with
great specifity and analysis.)

						- Ted
