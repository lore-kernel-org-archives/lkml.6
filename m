Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5114C00449
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 02:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C82E2086D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 02:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="tXWq1Fvq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C82E2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbeJIJhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 05:37:23 -0400
Received: from imap.thunk.org ([74.207.234.97]:54284 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbeJIJhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 05:37:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=jnvoCjz6a6qViKGOG3dAb2r4nAaNA+7Ez8KM7xPbbvo=; b=tXWq1FvqJUy3iIn59Aedqd+3bQ
        vdle1y2O7xfEh4H7/oE56p6QFcgvR8XXxL7qj/VM2NhbBx/mDVn7lDeksjm7hGiYbnq3cuZE/a6Gx
        hwT6x9DCGaBbcxQsoYLMyYx0C18LzrcTCAM1cyp87qfM9WVdOitxZ2E7G9/JQR0yNqx4=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1g9hfY-0001X6-Ou; Tue, 09 Oct 2018 02:22:44 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5F08E7A7900; Mon,  8 Oct 2018 22:22:43 -0400 (EDT)
Date:   Mon, 8 Oct 2018 22:22:43 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     valdis.kletnieks@vt.edu
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [BUG] ext4 null pointer crash in linux-next
Message-ID: <20181009022243.GD3369@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        valdis.kletnieks@vt.edu, Andreas Dilger <adilger.kernel@dilger.ca>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org
References: <36243.1539028475@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36243.1539028475@turing-police.cc.vt.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 03:54:35PM -0400, valdis.kletnieks@vt.edu wrote:
> I'm seeing a fairly replicable crash/hang with a traceback implicating ext4 (or
> possibly the block layer). next-20180918 seemed stable, but next-20180926 and
> -next-20181005 have a habit of crashing while dnf is updating software (so far,
> I've hit it 6 times with identical tracebacks while attempting to update software
> 
> This ringing any bells, or did I just buy myself another git bisect? Google says
> that ext4_mpage_readpages from the traceback hasn't been referenced in the
> last 2 months...

I'm afraid you're going to have to do a git bisect.  I've been doing
full regression tests of ext4.git and nothing like this has turned up.

Instead of doing a full bisect, maybe try doing the ext4.git tree by
itself, and the block.git tree by itself, and maybe those two trees
merged together?

						- Ted
