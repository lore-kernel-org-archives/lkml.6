Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89776C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 377842154B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="ctxBLxGy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 377842154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbeI0EEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:04:15 -0400
Received: from imap.thunk.org ([74.207.234.97]:52292 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbeI0EEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=GRZprxFXcbKqU+L2n25Xv70Vwzf3X9am1NryaUTfL7k=; b=ctxBLxGyHq17Yso3B2vhMjBoyu
        zJX2WjuRkuKnkRuUJcmn+R6CXOEdT6bUv76F28BNXhfqM46aFXn69ujTdN3vC5zS4Aaeoe7vcgyLu
        28XT5Y9CeX/r39P0areMr3KdBYyaxXxoivq4v4I3hReNh8e+wRZHJq5VfVLoCDqbUlgA=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1g5HgE-00042a-43; Wed, 26 Sep 2018 21:49:10 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5D3227A5186; Wed, 26 Sep 2018 17:49:09 -0400 (EDT)
Date:   Wed, 26 Sep 2018 17:49:09 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     Jeff Layton <jlayton@redhat.com>,
        =?utf-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>
Subject: Re: POSIX violation by writeback error
Message-ID: <20180926214909.GD3688@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jeff Layton <jlayton@redhat.com>,
        =?utf-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>
References: <CAJDTihx2yaR-_-9Ks1PoFcrKNZgUOoLdN-wRTTMV76Jg_dCLrw@mail.gmail.com>
 <486f6105fd4076c1af67dae7fdfe6826019f7ff4.camel@redhat.com>
 <20180925003044.239531c7@alans-desktop>
 <0662a4c5d2e164d651a6a116d06da380f317100f.camel@redhat.com>
 <20180925154627.GC2933@thunk.org>
 <23cd68a665d27216415dc79367ffc3bee1b60b86.camel@redhat.com>
 <20180925223054.GH2933@thunk.org>
 <20180926191055.6fc1514f@alans-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926191055.6fc1514f@alans-desktop>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 07:10:55PM +0100, Alan Cox wrote:
> In almost all cases you don't care so you wouldn't use it. In those cases
> where it might matter it's almost always the case that a reader won't
> consume it before it hits the media.
> 
> That's why I suggested having an fbarrier() so you can explicitly say 'in
> the even that case does happen then stall and write it'. It's kind of
> lazy fsync. That can be used with almost no cost by things like mail
> daemons.

How could mail daemons use it?  They *have* to do an fsync() before
they send a 2xx SMTP return code.

There are plenty of other dependencies besides read --- for example,
if you write a mp3 file, and then write the playlist.m3u file, maybe
the barrier requirement is "if playlist.m3u survives after the crash,
all of the mp3 files mentioned in it must completely written out to
disk".  So I'm not sure how useful a fbarrier(2) would be in practice.

> Another way given that this only really makes sense with locks
> is to add that fbarrier notion as a file locking optional semantic so you
> can 'unlock with barrier' and 'lock with barrier honoured'

I'm not sure what you're suggesting?

						- Ted
