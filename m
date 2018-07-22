Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3375C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B53C20854
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="qwEiRcvt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B53C20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730928AbeGVXG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 19:06:58 -0400
Received: from imap.thunk.org ([74.207.234.97]:43620 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730611AbeGVXG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 19:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=qVT9DsJUy3tWv6r2oWR9UxkTK51n9zJmFQaz3VqN2js=; b=qwEiRcvttzAxm6ip0psZj18ksE
        9mJW+FPHr1BZy2FknJNayu+bwBgUcRI6b4Da6qVk6AyPDBpMpwGyaxtnF2ME1lFG750qGLwvBCgUs
        Nem4yNrBmFgdHxPxtTcSshli+pHzEt2nCTrvOF5btruhbQwGQ2/QhKNcxh5XOoOtI5P0=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fhMWy-0005Sb-Uc; Sun, 22 Jul 2018 22:08:45 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id AF7AB7A6463; Sun, 22 Jul 2018 18:08:41 -0400 (EDT)
Date:   Sun, 22 Jul 2018 18:08:41 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Junil Lee <junil0814.lee@lge.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, junil0814.lee@MIT.EDU
Subject: Re: [PATCH] ext4: remove abnormal set for I_DATA_SEM subclass
Message-ID: <20180722220841.GA3358@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Junil Lee <junil0814.lee@lge.com>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        junil0814.lee@MIT.EDU
References: <1531123108-45918-1-git-send-email-junil0814.lee@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531123108-45918-1-git-send-email-junil0814.lee@lge.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 04:58:28PM +0900, Junil Lee wrote:
> The -EBUSY return value of dquot_enable() function means that just
> want to update flags. If some users make a duplicate request to update
> flags, lockdep could catch the false positive casued by needing to
> allocate a quota block from inside ext4_map_blocks(), while holding
> i_data_sem for a data inode. This results in this complaint:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(&s->s_dquot.dqio_mutex);
>                                lock(&ei->i_data_sem);
>                                lock(&s->s_dquot.dqio_mutex);
>   lock(&ei->i_data_sem);

How does this happen in practice?  The function ext4_quota_enable() is
only called by ext4_enable_quotas(), and I don't see the code path
where this would happen.  And if it does it would be resulting an
EXT4-fs warning message getting printing indicating that a failure to
enable quotas with an error of EBUSY.  So how does this happen that
"users would make a duplicate request to update flags"?

       	     	    	      	      	 	- Ted
