Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4A8C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C5F208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9mOuB7B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3C5F208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730472AbeK0VJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:09:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:57518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730295AbeK0VJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 16:09:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CEA92086B;
        Tue, 27 Nov 2018 10:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543313498;
        bh=JNdGem/T1QP+a7tc9O9rXdoxyYdSyHTwkHvh2tp3FNI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W9mOuB7BocF2/gthMGEcFGdJimAwMmdS2purhkp7yu6c+lEmpVHKPmnj2yvzX70aX
         o5HTa4wcWUlAdRtZftZ/+/dnO7bgtJeEDBna7OiI2Ou3q/2wmIwf0TxsBYJoNqHdfM
         YnSeg8tj6cq/migdAtn+I8/mIrogiV8RdY3SNrFo=
Date:   Tue, 27 Nov 2018 11:11:35 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] tty/sysrq: Do not call sync directly from
 sysrq_do_reset()
Message-ID: <20181127101135.GA15856@kroah.com>
References: <20181126205723.14478-1-mark.tomlinson@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126205723.14478-1-mark.tomlinson@alliedtelesis.co.nz>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 09:57:23AM +1300, Mark Tomlinson wrote:
> sysrq_do_reset() is called in softirq context, so it cannot call
> sync() directly. Instead, call orderly_reboot(), which creates a work
> item to run /sbin/reboot, or do emergency_sync and restart if the
> command fails.
> 
> Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
> ---
>  drivers/tty/sysrq.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> index ad1ee5d01b53..f2ca32c1ad7c 100644
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -660,8 +660,7 @@ static void sysrq_do_reset(struct timer_list *t)
>  
>  	state->reset_requested = true;
>  
> -	ksys_sync();
> -	kernel_restart(NULL);
> +	orderly_reboot();

Is this something new?  Why haven't we had reports of this failing in
the past?  Or has something changed recently to cause this to now be
needed?

thanks,

greg k-h
