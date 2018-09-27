Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8872C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 294342152A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="sW1h+Dc3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 294342152A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbeI0UqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:46:23 -0400
Received: from imap.thunk.org ([74.207.234.97]:55496 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727751AbeI0UqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:46:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ZYlrqMOhksGog2bsb0hkNk6SNq9XjE4g7z8zHlLl9ZY=; b=sW1h+Dc3eEkvqanxTbpIo5Uc4X
        AkUyVii2i6yN9XJTAsqVUoMHg79W2GlkdCKaz22uFNxl8ubgna5UI9D1rVT38/cKMykbbQXumlVEp
        rOt4mn0BvjOsnRYYQ0qPIaxpy/iK1eQhfTzZdd2y3+sHRLIVhcbQYIveksiLx983gHnM=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1g5XGW-00005h-CO; Thu, 27 Sep 2018 14:27:40 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 3E7D97A518E; Thu, 27 Sep 2018 10:27:38 -0400 (EDT)
Date:   Thu, 27 Sep 2018 10:27:38 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jeff Layton <jlayton@redhat.com>
Cc:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        =?utf-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: POSIX violation by writeback error
Message-ID: <20180927142738.GA27040@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jeff Layton <jlayton@redhat.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        =?utf-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Matthew Wilcox <willy@infradead.org>
References: <CAJDTihx2yaR-_-9Ks1PoFcrKNZgUOoLdN-wRTTMV76Jg_dCLrw@mail.gmail.com>
 <486f6105fd4076c1af67dae7fdfe6826019f7ff4.camel@redhat.com>
 <20180925003044.239531c7@alans-desktop>
 <0662a4c5d2e164d651a6a116d06da380f317100f.camel@redhat.com>
 <20180925154627.GC2933@thunk.org>
 <23cd68a665d27216415dc79367ffc3bee1b60b86.camel@redhat.com>
 <20180925223054.GH2933@thunk.org>
 <51b401b82356c2d8e124bb8701f310afd98e0838.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51b401b82356c2d8e124bb8701f310afd98e0838.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 08:43:10AM -0400, Jeff Layton wrote:
> 
> Basically, the problem (as I see it) is that we can end up evicting
> uncleanable data from the cache before you have a chance to call fsync,
> and that means that the results of a read after a write are not
> completely reliable.

Part of the problem is that people don't agree on what the problem is.  :-)

The original posting was from someone who claimed it was a "POSIX
violation" if a subsequent read returns *successfully*, but then the
writeback succeeds.

Other people are worried about this problem; yet others are worried
about the system wedging and OOM-killing itself, etc.

The problem is that in the face of I/O errors, it's impossible to keep
everyone happy.  (You could make the local storage device completely
reliable, with a multi-million dollar storage array with remote
replication, but then the CFO won't be happy; and other people were
talking about making things work with cheap USB thumb drives and
laptops.  This is the very definition of an over-constained problem.)

       	      	   	      	    		    - Ted
