Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BEC68C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 15:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70582208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 15:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="kQM+MO7e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70582208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965941AbeFOPdZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 11:33:25 -0400
Received: from imap.thunk.org ([74.207.234.97]:45090 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965916AbeFOPdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 11:33:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=6+NPZoCS+Cop4Lk1tFy401a86GS0pL8QGfGEixMZdVo=; b=kQM+MO7eR8A+bhBdSck+6dxFcL
        kOG2ID+V0+EowVaXqHMfTKtws7iEt4teIPLxdaQopRyGcYsu9CLSQlYbENK+MuPsfgxMfPk1sU3f0
        XN0y+nnVLFv+sp22+5heZ+39yfQ2T9+0WLfa0jwnQQQH7eC+WGmMKFZWW1Naox3FOTP8=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fTqix-0000Jo-F7; Fri, 15 Jun 2018 15:33:15 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A07EA7A4477; Fri, 15 Jun 2018 11:33:14 -0400 (EDT)
Date:   Fri, 15 Jun 2018 11:33:14 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Sig Shen <sigshen@synology.com>
Cc:     Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: Support FALLOC_FL_NO_HIDE_STALE flag with fallocate
Message-ID: <20180615153314.GA19476@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Sig Shen <sigshen@synology.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <1529059871-11971-1-git-send-email-sigshen@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529059871-11971-1-git-send-email-sigshen@synology.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 06:51:08PM +0800, Sig Shen wrote:
> FALLOC_FL_NO_HIDE_STALE flag must be set if user want to issue
> a discard request for block devices. But vfs_fallocate() will
> return with an error -EOPNOTSUPP indicating lack of support
> if this flag is set.
> 
> fix it by allowing FALLOC_FL_NO_HIDE_STALE flag in vfs_fallocate
> 
> Fixes: 25f4c41415e5 ("block: implement (some of) fallocate for block devices")
> Signed-off-by: Sig Shen <sigshen@synology.com>

The commit description is not quite correct.  What the NO_HIDE_STALE
flag does is allow a discard request for those block devices which do
not have the DISCARD_ZEROES_DATA flag.

I will note that the FALLOC_FL_NO_HIDE_STALE flag is a bit
controversial in linux-fsdevel.  I have a similar patch in the VFS in
Google's internal data center kernel, as well as an internal patch
which implements support for this flag in ext4.  However, the patches
are out of tree, because pretty much all of the file system developers
who work for enterpise distributions were against this functionality.

I know of one other major cloud provider (in China) using the
functionality as an out-of-tree patch, but with no one else speaking
in favor of it, and everyone else NAK'ing the patch and enterprise
distro's saying they would revert the patch in their distro kernels,
the compromise we came to was that the code point for NO_HIDE_STALE_FL
would be reserved so that users of the out-of-tree patches wouldn't
collide with future fallocate flags; and I would stop trying to push
the patches upstream.

I have no idea how Darrick was able to get commit 25f4c41415e5
upstream, but I guess it was less controversial for block devices than
for file systems.

So I'm certainly in favor of this patch landing in mainline, but you
should be aware that there may be some opposition to it.

Cheers,

					- Ted
