Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B68BC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03CE72146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTYbVJKp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03CE72146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbeISAyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 20:54:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:58940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727563AbeISAym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 20:54:42 -0400
Received: from localhost (unknown [209.121.128.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 753D9206B7;
        Tue, 18 Sep 2018 19:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537298441;
        bh=zTOgawwPQTJz4UAjacjt5a3J4oTLz+G3ilqeJVXk0GE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GTYbVJKpZs2jcPAit/iQOZFmZTD+6ci1TDnuiJCfmueAmdRuD2U7+vxYTnGlJrZfU
         JJ+YAe1gINQuhdG+oXkOLyoszayoTv/VIUbRuS8hGQe6FGxM+jd9XS+SiZ5EBj+S9n
         KTqfh8eMnLVPqNobGArP+CKQSC1xZJL3npDZuxiQ=
Date:   Tue, 18 Sep 2018 12:20:41 -0700
From:   Vinod <vkoul@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] driver/dma/ioat: Call del_timer_sync() without holding
 prep_lock
Message-ID: <20180918192041.GG2613@vkoul-mobl>
References: <1536951212-18050-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536951212-18050-1-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-09-18, 14:53, Waiman Long wrote:
> The following lockdep splat was observed:
> 
> [ 1222.241750] ======================================================
> [ 1222.271301] WARNING: possible circular locking dependency detected
> [ 1222.301060] 4.16.0-10.el8+5.x86_64+debug #1 Not tainted
> [ 1222.326659] ------------------------------------------------------
> [ 1222.356565] systemd-shutdow/1 is trying to acquire lock:
> [ 1222.382660]  ((&ioat_chan->timer)){+.-.}, at: [<00000000f71e1a28>] del_timer_sync+0x5/0xf0
> [ 1222.422928]
> [ 1222.422928] but task is already holding lock:
> [ 1222.451743]  (&(&ioat_chan->prep_lock)->rlock){+.-.}, at: [<000000008ea98b12>] ioat_shutdown+0x86/0x100 [ioatdma]
>    :
> [ 1223.524987] Chain exists of:
> [ 1223.524987]   (&ioat_chan->timer) --> &(&ioat_chan->cleanup_lock)->rlock --> &(&ioat_chan->prep_lock)->rlock
> [ 1223.524987]
> [ 1223.594082]  Possible unsafe locking scenario:
> [ 1223.594082]
> [ 1223.622630]        CPU0                    CPU1
> [ 1223.645080]        ----                    ----
> [ 1223.667404]   lock(&(&ioat_chan->prep_lock)->rlock);
> [ 1223.691535]                                lock(&(&ioat_chan->cleanup_lock)->rlock);
> [ 1223.728657]                                lock(&(&ioat_chan->prep_lock)->rlock);
> [ 1223.765122]   lock((&ioat_chan->timer));
> [ 1223.784095]
> [ 1223.784095]  *** DEADLOCK ***
> [ 1223.784095]
> [ 1223.813492] 4 locks held by systemd-shutdow/1:
> [ 1223.834677]  #0:  (reboot_mutex){+.+.}, at: [<0000000056d33456>] SYSC_reboot+0x10f/0x300
> [ 1223.873310]  #1:  (&dev->mutex){....}, at: [<00000000258dfdd7>] device_shutdown+0x1c8/0x660
> [ 1223.913604]  #2:  (&dev->mutex){....}, at: [<0000000068331147>] device_shutdown+0x1d6/0x660
> [ 1223.954000]  #3:  (&(&ioat_chan->prep_lock)->rlock){+.-.}, at: [<000000008ea98b12>] ioat_shutdown+0x86/0x100 [ioatdma]
> 
> In the ioat_shutdown() function:
> 
> 	spin_lock_bh(&ioat_chan->prep_lock);
> 	set_bit(IOAT_CHAN_DOWN, &ioat_chan->state);
> 	del_timer_sync(&ioat_chan->timer);
> 	spin_unlock_bh(&ioat_chan->prep_lock);
> 
> According to the synchronization rule for the del_timer_sync() function,
> the caller must not hold locks which would prevent completion of the
> timer's handler.
> 
> The timer structure has its own lock that manages its synchronization.
> Setting the IOAT_CHAN_DOWN bit should prevent other CPUs from
> trying to use that device anyway, there is probably no need to call
> del_timer_sync() while holding the prep_lock. So the del_timer_sync()
> call is now moved outside of the prep_lock critical section to prevent
> the circular lock dependency.

Applied, thanks

-- 
~Vinod
