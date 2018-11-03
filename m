Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D292C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 20:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFD0320843
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 20:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="t978Mllx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD0320843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbeKDGHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 01:07:32 -0500
Received: from imap.thunk.org ([74.207.234.97]:33654 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726904AbeKDGHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 01:07:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=uAMOdWmyqooDNBhAPGNA8vpkyzlv72iv1NAH1qSCGnQ=; b=t978MllxyYWA7lUNJnyOK4vgzK
        ets7WlO2zwuujp61hx6LsguC0Qp9Bz3bcTelhjwz8+u8hqik1ME+PrCFyIHc4cYV2UrokyMC5LddD
        L5yyBpisdbhjEwcWf6q5mABEZChNz9mqY/BvHbw82Ap2JfzDs3sSYoOWK2te6jzJhA84=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gJ2wg-0008AN-D7; Sat, 03 Nov 2018 20:55:02 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E3CB37A7A7E; Sat,  3 Nov 2018 16:55:00 -0400 (EDT)
Date:   Sat, 3 Nov 2018 16:55:00 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org,
        Yongqiang Yang <xiaoqiangnk@gmail.com>,
        Yongqiang Yang <yangyongqiang01@baidu.com>
Subject: Re: [PATCH v2 03/11] ext4 resize: brelse() cleanup in
 add_new_gdb_meta_bg()
Message-ID: <20181103205500.GG28850@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Vasily Averin <vvs@virtuozzo.com>, linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org,
        Yongqiang Yang <xiaoqiangnk@gmail.com>,
        Yongqiang Yang <yangyongqiang01@baidu.com>
References: <cover.1540935522.git.vvs@virtuozzo.com>
 <34d94824-834c-fb72-2f93-01e9036e9b38@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34d94824-834c-fb72-2f93-01e9036e9b38@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 12:57:55AM +0300, Vasily Averin wrote:
> gdb_bh must be released in case of errors before update of s_group_desc
> but it must not be released after update of group descriptors
> because in this case bh can be used later.
> 
> Fixes 01f795f9e0d6 ("ext4: add online resizing support for meta_bg ...") # 3.7
> 
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Thanks, applied.  The commit description is not accurate (I suspect it
was obsoleted when your patch for RHEL was forward ported) do I
dropped it.

I adjusted the patch summary to be:

    ext4: add missing brelse() add_new_gdb_meta_bg()'s error path

The commments for the Fixes and Cc: stable@kernel.org also apply.

							- Ted
								
