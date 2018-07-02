Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51665C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E54BD2075E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="DdKCYJdR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E54BD2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932268AbeGBWus (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 18:50:48 -0400
Received: from imap.thunk.org ([74.207.234.97]:52294 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753491AbeGBWuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 18:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=thdfvkBfO0rndQtMZvWQlDX9PB2B4/kCovVJ9Pb0B44=; b=DdKCYJdRz17SEO17zKJxquzSt8
        3MiMp2RIAnektLnbS34Pusv2enCkuJZDTHT9RJ88iTvp7+ZZwRsMQqS3WRohEkZLxTPzJDQ+mZx+u
        2iQb2FdwTYZbttIooEveIhvoLg4nWCiLho1h6Cz/aZEeatw5RcZI57kMquNYNos84+LM=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fa7ed-0007EY-Lx; Mon, 02 Jul 2018 22:50:43 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id DA6097A015F; Mon,  2 Jul 2018 18:50:42 -0400 (EDT)
Date:   Mon, 2 Jul 2018 18:50:42 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Check superblock mapped prior to committing
Message-ID: <20180702225042.GF30481@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jon Derrick <jonathan.derrick@intel.com>,
        linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org
References: <1530300995-25583-1-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530300995-25583-1-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 01:36:35PM -0600, Jon Derrick wrote:
> This patch attempts to close a hole leading to a BUG seen with hot
> removals during writes [1].
> 
> A block device (NVME namespace in this test case) is formatted to EXT4
> without partitions. It's mounted and write I/O is run to a file, then
> the device is hot removed from the slot. The superblock attempts to be
> written to the drive which is no longer present.
> 
> The typical chain of events leading to the BUG:
> ext4_commit_super()
>   __sync_dirty_buffer()
>     submit_bh()
>       submit_bh_wbc()
>         BUG_ON(!buffer_mapped(bh));
> 
> This fix checks for the superblock's buffer head being mapped prior to
> syncing.
> 
> [1] https://www.spinics.net/lists/linux-ext4/msg56527.html
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>

Thanks, applied.

				- Ted
