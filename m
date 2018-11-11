Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838E2C0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 13:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45490208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 13:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="dqbmcLEu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45490208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbeKKXbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 18:31:35 -0500
Received: from imap.thunk.org ([74.207.234.97]:38936 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727594AbeKKXbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 18:31:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=04dekhnTbmwiCS+1qUlx//1gYJMD4lDBJ9KNb65T4vM=; b=dqbmcLEuWBUUJGo/aYOfZqDG7Y
        CR8qUD2PeIa1DThY8oynxlBuVRGE1SaWeFllbFehIFSw5bkAJa3Eb9ze+F+TXcQLUvtQQKfw5wBVm
        F8WnGkh86DYpPXvsVBbUHg+a7mFdeGor1+doeXSzcDTdp1dfqZ5LRPpJz1Zk59l/FNsQ=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gLq0i-0000F2-GE; Sun, 11 Nov 2018 13:42:44 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1F2697A0471; Sun, 11 Nov 2018 08:42:42 -0500 (EST)
Date:   Sun, 11 Nov 2018 08:42:42 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH 0/3] SG_IO command filtering via sysfs
Message-ID: <20181111134241.GA2447@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Christoph Hellwig <hch@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
References: <1541867733-7836-1-git-send-email-pbonzini@redhat.com>
 <20181111131445.GB25441@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181111131445.GB25441@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 05:14:45AM -0800, Christoph Hellwig wrote:
> I think this goes in the wrong way.  There isn't really any point
> in filtering at all if we have access to the whole device by the
> file persmissions, and we generally should not allow any access for
> partitions.

It really depends on the security model being used on a particular
system.  I can easily imagine scenarios where userspace is allowed
full access to the device with respect to read/write/open, but the
security model doesn't want to allow access to various SCSI commands
such as firmware upload commands, TCG commads, the
soon-to-be-standardized Zone Activation Commands (which allow dynamic
conversion of HDD recording modes between CMR and SMR), etc.

And this is before we get to crazy container / namespace scenarios.
And *no*, let's not have a SG_IO namespace!  :-)

> I think we need to simplify the selection, not add crazy amounts of
> special case code.

I have the opposite opinions in terms of wanting more complex
filtering rules, but I also agree that special case C code is not the
answer --- and why I suggested that eBPF filtering rules is the right
way to go.

					- Ted
