Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E1FC46464
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9937320862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="Af8sauTZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9937320862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730806AbeKGHb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:31:57 -0500
Received: from imap.thunk.org ([74.207.234.97]:46112 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbeKGHb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:31:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=d40P+8HSx4cdpppxbcKMcJCiPYf6zaozDj5RvfsIW58=; b=Af8sauTZ407iIieDZFUhsZzK7/
        gl+aHUVMZ7bQUcFleIC/KLm3ifbmYdD/owmZF9W5pGAehACuDzm0aXJcRfuH0nZPjXXY+7VcccnaE
        9NvT0gzMtczUBuyUtIBNsdFCAG0/rWDP0Q4VCqe9Ny0DINV2q0HYFORCtRUOgvo09mOY=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gK9Sc-00067L-Dh; Tue, 06 Nov 2018 22:04:34 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6D8567A7C2C; Tue,  6 Nov 2018 17:04:33 -0500 (EST)
Date:   Tue, 6 Nov 2018 17:04:33 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org, Dmitry Monakhov <dmonakhov@gmail.com>
Subject: Re: [PATCH v2 08/11] ext4: lost brelse in ext4_orphan_add()
Message-ID: <20181106220433.GG2570@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Vasily Averin <vvs@virtuozzo.com>, linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org, Dmitry Monakhov <dmonakhov@gmail.com>
References: <cover.1540935522.git.vvs@virtuozzo.com>
 <c747413b-f5e1-d3e0-650b-e3749a98d59d@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c747413b-f5e1-d3e0-650b-e3749a98d59d@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 12:58:31AM +0300, Vasily Averin wrote:
> iloc.bh os taken in ext4_reserve_inode_write().
> If (dirty == true) it is released in ext4_mark_iloc_dirty(),
> however it is not released in (dirty == false) case.
> 
> Fixes d745a8c20c1f ("ext4: reduce contention on s_orphan_lock")
> however iloc.bh count balance was broken earlier by
> Fixes 6e3617e579e0 ("ext4: Handle non empty on-disk orphan link") #2.6.34
> 
> cc: Dmitry Monakhov <dmonakhov@gmail.com>
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Thanks, applied.  I fixed up the commit description and Fixes/Cc
trailers.  I used the one-line description:

    ext4: avoid buffer leak in ext4_orphan_add() after prior errors

  	       	       			       - Ted
