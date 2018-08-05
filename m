Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4906BC4646F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 00:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA817217CE
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 00:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="MZd7WZ4g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA817217CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbeHEC1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 22:27:54 -0400
Received: from imap.thunk.org ([74.207.234.97]:38146 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbeHEC1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 22:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Q8ozgmkh9c8xVgW7uiByxVshDeymBAogAUyM2T9RMvg=; b=MZd7WZ4gLYBwE9bvRdk/4EMUig
        eCgC7fkuGGcGf8DXs7o0AjIpqBQh79JUQ6ciZe9OyTw4ocPqGHb5kdivE0r3MOgov+qV3AsFHIGrv
        EUreLU11s95yMGPYDK6taNYWbjtdbz7KRN38K3ZX5ePZ6+CW0R3OXiRBS04fSTWuYXZw=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fm6rD-0003Op-9Y; Sun, 05 Aug 2018 00:25:15 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 59ED07A64C9; Sat,  4 Aug 2018 20:25:14 -0400 (EDT)
Date:   Sat, 4 Aug 2018 20:25:14 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Yann Droneaud <ydroneaud@opteya.com>, linux-crypto@vger.kernel.org,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        labbott@redhat.com
Subject: Re: [PATCH] random: add a config option to trust the CPU's hwrng
Message-ID: <20180805002514.GF4461@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Pavel Machek <pavel@ucw.cz>, Yann Droneaud <ydroneaud@opteya.com>,
        linux-crypto@vger.kernel.org,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        labbott@redhat.com
References: <20180718014344.1309-1-tytso@mit.edu>
 <37046662f2b38f98854abfa1b5868a27c3fa0888.camel@opteya.com>
 <20180718142625.GA5942@thunk.org>
 <20180804215209.GA3201@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180804215209.GA3201@localhost>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 04, 2018 at 11:52:10PM +0200, Pavel Machek wrote:
> > However, enabling config option means that the CRNG will be
> > initialized with potentially information available to the CPU
> > manufacturer and/or Nation States, and this persists *after*
> > initialization / early boot.  So to say, "we're perfectly safe after
> > we leave initialization / early boot" is not true.
> 
> This should really be explained in the help text.
> 
> I assume that after 10 seconds of moving mouse, user is safe even when
> rdrand is backoored?

You'll hate this answer, but "it depends".  Suppose someone is using
an init script which generates ssh keys upon first boot if they are
missing.  If this is the case, *and* RDRAND is backdoored, then the
keys will be generated in such a way that they *might* be succeptible
to being guessed by a nation state.  Moving your mouse around for 1000
or 10,000 seconds won't help if the host's ssh keys has already been
generated.

Depending on your hardware, no mouse motion might be necessary at all.
On my laptop (a Dell XPS 13 model 9370) using an dm-crypt protected
root disk, and running a Debian testing userspace, with a 4.18-rc6
based kernel, the "CRNG is initialized" message is printed *before*
the root file system is mounted.

On other systems, where the hardware does not issue as many
interrupts, the mouse motion might be extremely important in order to
get the "CRNG is initialized" message.

> (Plus, I'd say this should be kernel command line option, not config
> option...?)

Agreed, there should be a command line option as well.  I just haven't
gotten around to it yet, and in the meantime, having a config option
is better than nothing.   Patches gratefully accepted...  :-)

   	       		  	  	     		  - Ted
