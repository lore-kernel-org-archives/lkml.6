Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8A6C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 23:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E13A72083D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 23:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="RkvRCjlW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E13A72083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936988AbeFRXdu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 19:33:50 -0400
Received: from imap.thunk.org ([74.207.234.97]:55322 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934857AbeFRXds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 19:33:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=WB4MUNLS/cFJJe67Dk201C72Mmo0oPeOGQpTMf/bOKc=; b=RkvRCjlW2tieXvAgaW2yqbqK2L
        xPr38QCh3wK5IfkB9mWd7+cYJJw/d1r3fEp21NqLTYW/zwgbb7akyC9MaWUC2YE422puRVQewM8mD
        kWPtTrMq8UQ9Vs3qbOGTlk5HQma53TwFq1OhYBYM9g205dW5i6tOqivSHdwQiLuGwE24=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fV3eY-0002y3-OA; Mon, 18 Jun 2018 23:33:42 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5A9657A60A4; Mon, 18 Jun 2018 19:33:41 -0400 (EDT)
Date:   Mon, 18 Jun 2018 19:33:41 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     David Howells <dhowells@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/32] VFS: Introduce filesystem context [ver #8]
Message-ID: <20180618233341.GA6931@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        David Howells <dhowells@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
References: <87in6kptqt.fsf@xmission.com>
 <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
 <3949.1529353850@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3949.1529353850@warthog.procyon.org.uk>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 09:30:50PM +0100, David Howells wrote:
> 
> The fscontext code *requires* you to parse the parameters *before* any attempt
> to access the superblock is made.  Note that this will actually be a problem
> for, say, ext4 which passes a text string stored in the superblock through the
> parser *before* parsing the mount syscall data.  Fun.
> 
> I'm intending to deal with that particular case by having ext4 create multiple
> private contexts, one filled in from the user data, and then a second one
> filled in from the superblock string.  These can then be validated one against
> the other before the super_block struct is published.

Yeah, what we're trying to do is let the options in the superblock act
as defaults which then can be overridden by what the user specifies on
the command line.

So when you parse the user-supplied data, will there be a way to
determine what was specified explicitly, versus what was implied by
the defaults?  I'll need that in order to be able to merge the two
contexts together.

						- Ted
