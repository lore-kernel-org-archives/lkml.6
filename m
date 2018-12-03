Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB72C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 06:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 217A12145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 06:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xzgo/Y0Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 217A12145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbeLCGrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 01:47:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:56740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbeLCGrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 01:47:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48AFD20834;
        Mon,  3 Dec 2018 06:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543819670;
        bh=1RRt7eL5xZRkwjBYKxIzkOWc+l2oi+GNHN2lHiM0CyU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xzgo/Y0YzhxOGjlBAyVkuXw/xEv2aDWc/ehWV5Z7CksLDtp9nRRLGHTAtyWpozi7z
         YXHE4yiZXdXZGUVTPSJyrrRcvUpbeAyjwFd0D/BOm43AbDWIzT01hdsCVPgxnfv2eF
         ypO4o8Tx6iJf19jWQbwIYcr0HFcosr2wWgGv5dAE=
Date:   Mon, 3 Dec 2018 07:47:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tigran Aivazian <aivazian.tigran@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+71c6b5d68e91149fc8a4@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH 4.19.6] BFS: static inode bitmap and extra sanity checking
Message-ID: <20181203064748.GA29882@kroah.com>
References: <20181129135921.231283053@linuxfoundation.org>
 <20181129135922.602882966@linuxfoundation.org>
 <CAK+_RLmVyVzL3G6++xOxfyEqEHL=bfZZx_Yj-TFNf5a7_oUoXw@mail.gmail.com>
 <20181129160722.GA31919@kroah.com>
 <CAK+_RLnbpu+nYsr8sVpHBVUcATDbqQoeH=+tu=tK1EKTHk6L9A@mail.gmail.com>
 <20181129171038.GA4651@kroah.com>
 <CAK+_RLk4cxamNasZyvLRunR23CTR-fASvF3=Ryt9WGeFoBVtqQ@mail.gmail.com>
 <CAK+_RLmt0ba_ARo+SrOGJph-SPn3kBRybRqncki=Oqz1TcF21Q@mail.gmail.com>
 <20181202201335.GB4314@kroah.com>
 <CAK+_RLnaPCXoBBpmCajui_U4_R6zMTNHFC3nLMsGCkY4hrHdkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK+_RLnaPCXoBBpmCajui_U4_R6zMTNHFC3nLMsGCkY4hrHdkA@mail.gmail.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 02, 2018 at 08:21:30PM +0000, Tigran Aivazian wrote:
> On Sun, 2 Dec 2018 at 20:13, Greg KH <gregkh@linuxfoundation.org> wrote:
> > What is the git commit id of this patch in Linus's tree?
> 
> In linux-next the commit id is
> d2e6681167c634cfc3558991b59a6f614a31d226 , but it is not in Linus'
> tree (i.e. at github.com/torvalds/linux) yet. It went into Andrew
> Morton's "-mm" tree and then into "linux-next" tree.

Please take a look at:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to get a patch into the stable tree.  The patch needs to be in
Linus's tree first, linux-next does not count, sorry.

thanks,

greg k-h
