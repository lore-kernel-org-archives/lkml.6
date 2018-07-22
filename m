Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B3EECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 18:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 352222086A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 18:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="a4BBsu1/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 352222086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730831AbeGVTwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 15:52:51 -0400
Received: from imap.thunk.org ([74.207.234.97]:43392 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730437AbeGVTwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 15:52:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=+Q7WRaMOzASmWmUVVbI+t8zRtXVUUNi4ziRNcwZYzAI=; b=a4BBsu1/5IzK9lbInsIgbGOW0d
        ku5HkZFDwxf7QvX1T8TNZYS1foA+B0rJfhsAQ8PCYZYf4DsRgsfW4w2pmn+a0xM1KM/gegsA/HRcz
        yNPwQFirWTtY907Wi+di61bWF9WyWkOAJFevubDx8evC/Qm4WKIvBl3fXJZiw316iK5k=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fhJVe-0003zX-J2; Sun, 22 Jul 2018 18:55:10 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 34D8C7A44CC; Sun, 22 Jul 2018 14:55:07 -0400 (EDT)
Date:   Sun, 22 Jul 2018 14:55:07 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     adilger.kernel@dilger.ca, jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, sirmy15@gmail.com,
        stable@vger.kernel.org, tgnottingham@gmail.com,
        y2038@lists.linaro.org
Subject: Re: [PATCH v2 6/6] ext4: super: extend timestamps to 40 bits
Message-ID: <20180722185507.GG6685@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Arnd Bergmann <arnd@arndb.de>, adilger.kernel@dilger.ca,
        jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, sirmy15@gmail.com,
        stable@vger.kernel.org, tgnottingham@gmail.com,
        y2038@lists.linaro.org
References: <20180711091414.1494843-1-arnd@arndb.de>
 <20180711091414.1494843-6-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711091414.1494843-6-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 11:14:14AM +0200, Arnd Bergmann wrote:
> The inode timestamps use 34 bits in ext4, but the various timestamps in
> the superblock are limited to 32 bits. If every user accesses these as
> 'unsigned', then this is good until year 2106, but it seems better to
> extend this a bit further in the process of removing the deprecated
> get_seconds() function.
> 
> This adds another byte for each timestamp in the superblock, making
> them long enough to store timestamps beyond what is in the inodes,
> which seems good enough here (in ocfs2, they are already 64-bit wide,
> which is appropriate for a new layout).
> 
> I did not modify e2fsprogs, which obviously needs the same change to
> actually interpret future timestamps correctly.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, applied.

					- Ted
