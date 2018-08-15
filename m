Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F812C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 14:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C163215F1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 14:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShUcL+or"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C163215F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbeHORLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 13:11:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728957AbeHORLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 13:11:42 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93B2D215B2;
        Wed, 15 Aug 2018 14:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534342761;
        bh=5EG1NaIeQ2ThZWf5QNeGF/GEBvTXE3nWH+qUaatrQf0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ShUcL+or8zjobSU0URucAPa4Sg/OnZRSo8mFPnirNfOQWrNjivA84pZ8OsfsyHvQ3
         rLFo9jB9GPKb2a3CWd+ke/dxytKoi3ZrjrtRbATEIJujBsjljBNZT27wn/v30kIj32
         6NP/CFqHSzClj1xsYvxdejYI9eCuucbYNGnnLVyo=
Message-ID: <8acb99be800a1842278f754986a17d6fc93af409.camel@kernel.org>
Subject: Re: [BUG][BISECT] NFSv4 root failures after "fs/locks: allow a lock
 request to block other requests."
From:   Jeff Layton <jlayton@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>, NeilBrown <neilb@suse.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Date:   Wed, 15 Aug 2018 10:19:18 -0400
In-Reply-To: <CAJKOXPc2cb1OK3tmRCO2p+docdXY=PoU1MEBa-VDyEM4mG1eSw@mail.gmail.com>
References: <CAJKOXPc2cb1OK3tmRCO2p+docdXY=PoU1MEBa-VDyEM4mG1eSw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-15 at 14:28 +0200, Krzysztof Kozlowski wrote:
> Hi,
> 
> Bisect pointed commit ce3147990450a68b3f549088b30f087742a08b5d
> ("fs/locks: allow a lock request to block other requests.") to failure
> boot of NFSv4 with root on several boards.
> 
> Log is here:
> https://krzk.eu/#/builders/21/builds/836/steps/12/logs/serial0
> 
> With several errors:
> kernel BUG at ../fs/locks.c:336!
> Unable to handle kernel NULL pointer dereference at virtual address 00000004
> 
> Configuration:
> 1. exynos_defconfig
> 2. Arch ARM Linux
> 3. Boards:
> a. Odroid family (ARMv7, octa-core (Cortex-A7+A15), Exynos5422 SoC)
> b. Toradex Colibri VF50 (ARMv7, UP, Cortex-A5)
> 4. Systemd: v236, 238
> 5. All boards boot from TFTP with NFS root (NFSv4)
> 
> On Colibri VF50 I got slightly different errors:
> [   11.663204] Internal error: Oops - undefined instruction: 0 [#1] ARM
> [   12.455273] Unable to handle kernel NULL pointer dereference at
> virtual address 00000004
> and only with some specific GCC (v6.3) or with other conditions which
> I did not bisect yet. Maybe Colibri's failure is unrelated to that
> commit.
> 
> Best regards,
> Krzysztof

The BUG is due to a lock being freed when the fl_blocked list wasn't
empty (implying that there were still blocked locks waiting on it).

There are a number of calls to locks_delete_lock_ctx in posix_lock_inode
and I don't think the fl_blocked list is being handled properly with all
of them. It only transplants the blocked locks to a new lock when there
are surviving locks on the list, and that may not be the case when the
whole file is being unlocked.

-- 
Jeff Layton <jlayton@kernel.org>

