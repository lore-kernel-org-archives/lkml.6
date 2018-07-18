Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DBCECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8067D20850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="i5taOsfp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8067D20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731195AbeGRQDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:03:14 -0400
Received: from imap.thunk.org ([74.207.234.97]:57386 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730342AbeGRQDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Kbm6SiPKFoQE0bgWp6a/CkD7zw/w98IgbaL126dzdDA=; b=i5taOsfpHfkn4cjEKG7D0gwxoR
        nGusXf3mrsyzo1nyGFrCYaCuURy0r767lZg/ESG63ae38MQreJ+mHfnW1jS6Jd4pqqRSibNorwauP
        wbCdfaFQGUZoQ8sSVR52jahYuMMItQmQPCfizZ2/KmA3p+w0mxc6tpzQ0LRZnKXJ8SSw=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1ffoJr-0003oQ-2Q; Wed, 18 Jul 2018 15:24:47 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7816F7A6403; Wed, 18 Jul 2018 11:24:44 -0400 (EDT)
Date:   Wed, 18 Jul 2018 11:24:44 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Constantine Shulyupin <const@MakeLinux.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers/char/random.c: fix uninitialized value warning
Message-ID: <20180718152444.GB30706@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Constantine Shulyupin <const@MakeLinux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20180718071152.13265-1-const@MakeLinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180718071152.13265-1-const@MakeLinux.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 10:11:52AM +0300, Constantine Shulyupin wrote:
> Local variable t should be initialized by arch_get_random_int.
> Actually on failure of arch_get_random_int, value is not used.
> So, just keep the build clean with less warnings.
> 
> warning:
> drivers/char/random.c: In function ‘write_pool.constprop’:
> drivers/char/random.c:1912:11: warning: ‘t’ may be used uninitialized in this function [-Wmaybe-uninitialized]
> 
> Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>

There was a more significant problem which Arnd pointed out, which is
I had reversed the sense of the test in arch_get_random_int().  I've
since fixed this, and the current random tree is clean of warnings.

						- Ted
