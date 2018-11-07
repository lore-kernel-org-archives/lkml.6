Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EB9C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D2DD20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="sGwN18Z6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D2DD20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731341AbeKHBmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:42:38 -0500
Received: from imap.thunk.org ([74.207.234.97]:49418 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727372AbeKHBmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 20:42:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=p4X6lJ1QgKG5EvkX8u41cgHfZ29ZjnouJUxxoGxovdE=; b=sGwN18Z6qbBHj2p+TjJDjBKIow
        qNt+FVS0l68VBe097Q1lg3SMPVkcFTSFSwUgOJ1rFrYouW0HPa9gjkDcsluMI3rgCDuOzPnGbvi2B
        OvRbQtoPjQi+WFSUoWIO93Tz/LtmRM20P0ZA8Qxh28O6q01d+ipYQMWLnKUMnVYk+4ps=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gKQQW-0000Yo-Jc; Wed, 07 Nov 2018 16:11:32 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id CAE087A7D14; Wed,  7 Nov 2018 11:11:31 -0500 (EST)
Date:   Wed, 7 Nov 2018 11:11:31 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Vasily Averin <vvs@virtuozzo.com>, linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org, Kalpak Shah <kalpak@clusterfs.com>
Subject: Re: [PATCH 6/7] ext4: lost brelse in ext4_xattr_move_to_block()
Message-ID: <20181107161131.GG9919@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>, Vasily Averin <vvs@virtuozzo.com>,
        linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org, Kalpak Shah <kalpak@clusterfs.com>
References: <cover.1541011937.git.vvs@virtuozzo.com>
 <76da5ae3-274d-efa4-58bb-6cd280763a37@virtuozzo.com>
 <20181107135016.GE25758@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107135016.GE25758@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 02:50:16PM +0100, Jan Kara wrote:
> On Wed 31-10-18 22:13:00, Vasily Averin wrote:
> > Fixes 3f2571c1f91f ("ext4: factor out xattr moving")
> > cc: Jan Kara <jack@suse.cz>
> > however issue was present in original ext4_expand_extra_isize_ea()
> > Fixes 6dd4ee7cab7e ("ext4: Expand extra_inodes space per ...") # 2.6.23
> > cc: Kalpak Shah <kalpak@clusterfs.com>
> > 
> > Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> 
> Good catch. Thanks for the fix. The patch looks good. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks, applied.  I used the commit description:

    ext4: fix buffer leak in ext4_xattr_move_to_block() on error path

    	      	     	     - Ted
