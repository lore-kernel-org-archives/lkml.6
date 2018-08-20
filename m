Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B991FC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 02:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682F620C0C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 02:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="oqOM4cdI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 682F620C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbeHTGHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 02:07:52 -0400
Received: from imap.thunk.org ([74.207.234.97]:54798 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbeHTGHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 02:07:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=zVMnMhEWjRWIrh8dKXi55aKpvbi7h2HPMJ2pDYQBUrg=; b=oqOM4cdICW2zk0fCG7xPGLS7Y0
        j+f79e/7LWCx9XYTDsvMH+D3hhPjV0iwVfoVjDN0QfUGDafqBJsA9kZ3mL3qViteuLYRXGICleKoC
        GFYxUw6pxQdXZeBwd8RYi1EPr/pd7ltl9LQMSmtavU0FuB+qIL1i/213a4/OuwnEaJlw=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fraKM-0005NO-DF; Mon, 20 Aug 2018 02:53:58 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 107897A57A8; Sun, 19 Aug 2018 22:53:57 -0400 (EDT)
Date:   Sun, 19 Aug 2018 22:53:56 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warnings from Linus' tree
Message-ID: <20180820025356.GF19200@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Adam Borowski <kilobyte@angband.pl>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180820081323.23a47af3@canb.auug.org.au>
 <CA+55aFw4WcLcFJkoWoE2v--J3s2Hk8JBU92=Zh351FH7xY8zpw@mail.gmail.com>
 <20180820013319.slygmbleia55evtl@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180820013319.slygmbleia55evtl@angband.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 03:33:19AM +0200, Adam Borowski wrote:
> Valid uses of strncpy() do exist (such as SCSI structs), but those deal with
> fixed-width fields.  Thus, gcc is right for warning for at least some of
> misuse of strncpy() for C strings.  The function wasn't designed for them.

The problem is that the kernel has a goodly share of fixed-width
fields.  The ext4 superblock is one of them.  strncpy() is the most
convenient function to do what is needed.  If it's a valid use, then
we need to have a way to get gcc to shut up about them.

	   	   	      	 - Ted
