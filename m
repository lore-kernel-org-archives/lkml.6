Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEDAC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF022087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546851148;
	bh=ndjcPIKIoRsAHa7bF8X/UlNyLNC6aQ5WOM/+q6rW6Ks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cfxqUWw7sL/SdQVudhs9cipTanUwt+IO4xA7Z4zwcqO4Rm/oJngyskMZK7JdlaJi9
	 UORFxWjlkxdkLFdJFFZuzYcPfTWJCCEIM/uRFnK+URjI3PNUNBidzAFAukANUUCYx4
	 ezN//O7wq+AMB0HMCW6dQx+vuO23HKeWRhkpIFZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfAGIw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 03:52:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:49424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbfAGIw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 03:52:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E416620859;
        Mon,  7 Jan 2019 08:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546851146;
        bh=ndjcPIKIoRsAHa7bF8X/UlNyLNC6aQ5WOM/+q6rW6Ks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2W7ebwCNLeUxNKKccUkJy6GgopCyBdLAorb4X4cC5YIM8sOmIOxY7agOkl2NMcFkk
         v1Dt1m6xOxXQQJ+jqYuhmPVdivUCdNDQ1YEj5B9zBnWSOtu6QOP2Wwodmug1f+Y21C
         fh3dIyGWOKcB+PjiYqJhwTl0qeDTYWAMEUxisb2k=
Date:   Mon, 7 Jan 2019 09:52:24 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     jslaby@suse.com, linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] tty: serial: mxs-auart: possible concurrency
 use-after-free bugs in mxs_auart_dma_exit_channel()
Message-ID: <20190107085224.GA26384@kroah.com>
References: <8da85649-f539-9c36-a97e-3582844e82fb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8da85649-f539-9c36-a97e-3582844e82fb@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 04:47:43PM +0800, Jia-Ju Bai wrote:
> The driver functions mxs_auart_settermios(), dma_rx_callback() and dma_tx_callback() can be concurrently executed.
> 
> In Linux 4.19:
> 
> mxs_auart_settermios
>   mxs_auart_dma_exit
>     mxs_auart_dma_exit_channel
>       line 918: kfree(s->tx_dma_buf);
>       line 919: kfree(s->rx_dma_buf);
> 
> dma_rx_callback
>   line 862: tty_insert_flip_string(port, s->rx_dma_buf, count);
>   mxs_auart_dma_prep_rx
>     line 890: sg_init_one(sgl, s->rx_dma_buf, UART_XMIT_SIZE);
> 
> dma_tx_callback
>   mxs_auart_tx_chars
>     line 590: void *buffer = s->tx_dma_buf;
>     mxs_auart_dma_tx
>       line 566: sg_init_one(sgl, s->tx_dma_buf, size);
> 
> Thus, possible concurrency use-after-free bugs may occur.
> 
> These possible bugs are found by a static analysis tool written by myself and my manual code review.

Care to send a patch to fix up this issue?

thanks,

greg k-h
