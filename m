Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C01C43610
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77DF620817
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="omg4cESm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77DF620817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbeKJCYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:24:06 -0500
Received: from imap.thunk.org ([74.207.234.97]:32900 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727955AbeKJCYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 21:24:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=y5pInCLpLDHmDsQnlssfB8+twnXggmsrUgpF5Lk7/94=; b=omg4cESmmccWVBmy/SkVGjsNYH
        cyQ/L0NitVYZR5fPx7gcbpTwv6f3n4Fne1tO7wEHkkALC8hDgMqZ43uimaCXcBmGdjjAafaLvrA7j
        XgLUDNnCOA/So8GH6DhJU+Dc1CTpHXM9QjjwmHrD179Z/aFbLuK4qNiKOZ7oZvDsC+Do=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gL9rn-0005wE-K7; Fri, 09 Nov 2018 16:42:43 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C4F517A00B7; Fri,  9 Nov 2018 11:42:42 -0500 (EST)
Date:   Fri, 9 Nov 2018 11:42:42 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ext4: missing !bh check in ext4_xattr_inode_write()
Message-ID: <20181109164242.GA21078@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Vasily Averin <vvs@virtuozzo.com>, linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org
References: <20181108145429.GE22459@thunk.org>
 <55574e0e-01a9-3cad-34ab-251e340fb78e@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55574e0e-01a9-3cad-34ab-251e340fb78e@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 08:49:48AM +0300, Vasily Averin wrote:
> According to Ted Ts'o ext4_getblk() called in ext4_xattr_inode_write()
> should not return bh = NULL
> 
> The only time that bh could be NULL, then, would be in the case of
> something really going wrong; a programming error elsewhere (perhaps a
> wild pointer dereference) or I/O error causing on-disk file system
> corruption (although that would be highly unlikely given that we had
> *just* allocated the blocks and so the metadata blocks in question
> probably would still be in the cache).
> 
> Fixes e50e5129f384 ("ext4: xattr-in-inode support")
> Cc: stable@kernel.org # 4.13
> 
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Thanks, applied.

						- Ted
