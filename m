Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84CDC0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 20:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75E8820843
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 20:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="xXBM+BcC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75E8820843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbeKDFc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 01:32:29 -0400
Received: from imap.thunk.org ([74.207.234.97]:33594 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbeKDFc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 01:32:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=04otD9+1wMF2MBh2/HAu5rZZcBxbR3P6w0Rx5h2Fcsw=; b=xXBM+BcCCXPbBaNFeBPe2VURrP
        I4EOCQHwIVVojAuIXiJuyBnmhwrR38X1zvXn+LteKQeyd9QiNOoNqiS1slZvuB/BO5HbNNtmrlBUz
        lTaCJYtcLvbdv1BbcojDVgDqUElO945s6LX2q0p/hFCX5uKcheDegYShEWM6bXeh8WqA=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gJ2Op-00086V-Mx; Sat, 03 Nov 2018 20:20:03 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 8189D7A7A7E; Sat,  3 Nov 2018 16:20:02 -0400 (EDT)
Date:   Sat, 3 Nov 2018 16:20:02 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org,
        Yongqiang Yang <xiaoqiangnk@gmail.com>,
        Yongqiang Yang <yangyongqiang01@baidu.com>
Subject: Re: [PATCH v2 01/11] ext4 resise: extra brelse in
 setup_new_flex_group_blocks()
Message-ID: <20181103202002.GE28850@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Vasily Averin <vvs@virtuozzo.com>, linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org,
        Yongqiang Yang <xiaoqiangnk@gmail.com>,
        Yongqiang Yang <yangyongqiang01@baidu.com>
References: <cover.1540935522.git.vvs@virtuozzo.com>
 <37de5906-2d76-461a-ff92-b6fcc775b408@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37de5906-2d76-461a-ff92-b6fcc775b408@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 12:57:37AM +0300, Vasily Averin wrote:
> currently bh is set to NULL only during first iteration of for cycle,
> then this pointer is not cleared after end of using.
> Therefore rollback after errors can lead to extra brelse(bh) call,
> decrements bh counter and later trigger an unexpected warning in __brelse()
> 
> Patch moves brelse() calls in body of cycle to exclude requirement of
> brelse() call in rollback.
> 
> Fixes 33afdcc5402d ("ext4: add a function which sets up group blocks ...") # 3.3+
> 
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Thanks, applied.  I addjusted the patch summary to read:

    ext4: avoid potential extra brelse in setup_new_flex_group_blocks()

(Note that resise should have been spelled as "resize", by the way.)


						- Ted
