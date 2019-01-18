Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30ACC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C442086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547802264;
	bh=eM3yXsodugHNLWe+amuJhIuD/bQ9Xs4TEN0G7xbJ+14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1e3Q5PHkkCJS+8DmFnu1yLmzmob93Z7D9EVLe3tHZvUmBQiknszH4W9RlvyxUQ+WJ
	 oRwxh3oBPAl38HvNczXBRN4DzcHSkg3axMgvDukN65miIqknc0d6bnMDEuFGiGT971
	 cCIwDn/rxTc6WkFOXHyyDSxCXvgNoV9DD+RhCvBU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfARJEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:04:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:55176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbfARJEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 04:04:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECE5D2086D;
        Fri, 18 Jan 2019 09:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547802261;
        bh=eM3yXsodugHNLWe+amuJhIuD/bQ9Xs4TEN0G7xbJ+14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KTMxi4AaoR6OmWeFI8xnzyJIx37nj7QLiqJ66CtYNxvM3LQIvE2fCJrxDTH1JInuN
         mo1kAFBD83YLMv4z1UP2yWEjGqTWz+CB9encDMN7KZ43AJhMja62a9V2+z4XS3aL6Z
         faRTyYSt5oo+xmTngIZ9YgncauJkSFamGzQ9dvyU=
Date:   Fri, 18 Jan 2019 10:04:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Li RongQing <lirongqing@baidu.com>
Cc:     jslaby@suse.com, linux-kernel@vger.kernel.org,
        gkohli@codeaurora.org
Subject: Re: [PATCH][v3] tty: fix race between flush_to_ldisc and tty_open
Message-ID: <20190118090419.GA1784@kroah.com>
References: <1547801764-13660-1-git-send-email-lirongqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547801764-13660-1-git-send-email-lirongqing@baidu.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 04:56:04PM +0800, Li RongQing wrote:
> There still is a race window after the commit b027e2298bd588
> ("tty: fix data race between tty_init_dev and flush of buf"),
> and we encountered this crash issue if receive_buf call comes
> before tty initialization completes in n_tty_open and
> tty->driver_data may be NULL.
> 
> CPU0                                    CPU1
> ----                                    ----
>                                  n_tty_open
>                                    tty_init_dev
>                                      tty_ldisc_unlock
>                                        schedule
> flush_to_ldisc
>  receive_buf
>   tty_port_default_receive_buf
>    tty_ldisc_receive_buf
>     n_tty_receive_buf_common
>       __receive_buf
>        uart_flush_chars
>         uart_start
>         /*tty->driver_data is NULL*/
>                                    tty->ops->open
>                                    /*init tty->driver_data*/
> 
> it can be fixed by extending ldisc semaphore lock in tty_init_dev
> to driver_data initialized completely after tty->ops->open(), but
> this will lead to put lock on one function and unlock in some other
> function, and hard to maintain, so fix this race only by checking
> tty->driver_data when receiving, and return if tty->driver_data
> is NULL
> 
> Signed-off-by: Wang Li <wangli39@baidu.com>
> Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/tty/tty_port.c | 3 +++
>  1 file changed, 3 insertions(+)

What changed in this version, from the other versions?  That is always
to be listed below the --- line, as the documentation states.

Please fix up and do a v4 with all of this information.

thanks,

greg k-h
