Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F377C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 20:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D13A120843
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 20:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="yB82nUED"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D13A120843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbeKDFkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 01:40:31 -0400
Received: from imap.thunk.org ([74.207.234.97]:33626 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbeKDFkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 01:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=qZz+NXc+T0OdqetvdeNj6LwnEs8v2IFDQ+MpGCNc8mg=; b=yB82nUEDLeRySOlHVYyCL/pylZ
        70gdX98oBztinmJc6XwYRkqRmvoMR5/Z9JcgqipsuQjZvJiuU3wPhXu7J5J3vca2dIAWr3sCjsFlR
        Q1gizBHXq3qThAGiKg1DcEPMyc0qVRrSf21see3F0APwVDZzgOwC8atRkb2Rfo4gU+4Q=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gJ2Wd-00087v-FT; Sat, 03 Nov 2018 20:28:07 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 477927A7A7E; Sat,  3 Nov 2018 16:28:06 -0400 (EDT)
Date:   Sat, 3 Nov 2018 16:28:06 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org,
        Yongqiang Yang <xiaoqiangnk@gmail.com>,
        Yongqiang Yang <yangyongqiang01@baidu.com>
Subject: Re: [PATCH v2 02/11] ext4 resize: missing brelse() after errors in
 set_flexbg_block_bitmap()
Message-ID: <20181103202806.GF28850@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Vasily Averin <vvs@virtuozzo.com>, linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org,
        Yongqiang Yang <xiaoqiangnk@gmail.com>,
        Yongqiang Yang <yangyongqiang01@baidu.com>
References: <cover.1540935522.git.vvs@virtuozzo.com>
 <de9191d6-1cb1-6725-f378-b886c9cd06d0@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de9191d6-1cb1-6725-f378-b886c9cd06d0@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 12:57:45AM +0300, Vasily Averin wrote:
> Fixes 33afdcc5402d ("ext4: add a function which sets up group blocks ...") # 3.3
> 
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Thanks, applied.  I adjusted the patch summary:

    ext4: add missing brelse() in set_flexbg_block_bitmap()'s error path

Also please note that properly Fixes should have a colon, and to add
Cc: stable@kernel.org to trailer to make sure they get backported:
    
    Fixes: 33afdcc5402d ("ext4: add a function which sets up group blocks ...")
    Cc: stable@kernel.org # 3.3

						- Ted
