Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20203C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 22:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE172442A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 22:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="n8S7nMm9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDE172442A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967454AbeF1W7H (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 18:59:07 -0400
Received: from imap.thunk.org ([74.207.234.97]:38266 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966992AbeF1W7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 18:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=iVDme/GCjfCxcBU4mkvrUdc4aot7Ors2C8p49qn6Ng8=; b=n8S7nMm9Km/QkPgbRNqnXJEynG
        EToAmSG4UH0CZwgEYJ2wAT8NRZSe+jk4b7+jSvJCk6Ly9O2JDPLKUWnqaHQ6j703F0t7sh66uyK5x
        b3YBxWGzH/lJmeJC0LvFSX8KxZ5e4n4tslfEVbsGkMPtKmcvWwSXrKAlfHdGfADtIbP8=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fYfsQ-000362-6I; Thu, 28 Jun 2018 22:58:58 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5CE087A4480; Thu, 28 Jun 2018 18:58:57 -0400 (EDT)
Date:   Thu, 28 Jun 2018 18:58:57 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Steve French <smfrench@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        CIFS <linux-cifs@vger.kernel.org>
Subject: Re: config files and how to have persistent Linux kernel Driver/File
 System configuration info saved
Message-ID: <20180628225857.GB1231@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Steve French <smfrench@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        CIFS <linux-cifs@vger.kernel.org>
References: <CAH2r5msV1hBAGgqtMFh6P=OGPV3RKjVAER=5bg-6Y+vW5BEJwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5msV1hBAGgqtMFh6P=OGPV3RKjVAER=5bg-6Y+vW5BEJwQ@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 05:37:15PM -0500, Steve French wrote:
> Ronnie brought up an interesting point about the problems consistently
> configuring file systems (or any Linux module for that matter) so that
> reboot doesn't wipe away security or performance tuning changes.

In general it's considered best practice to make the file system
auto-tune itself as much as possible, because the sad fact is that
99.9999% of the customers aren't going to bother to add any tuning
parameters.  So there hasn't been a push to try to create something
more complex, because it's generally not needed.

Settings via /sys/fs/ext4 are generally for developers as they try to
understand how things work, so they can improve the file systems
defaults / auto-tuning algorithms.

						- Ted
