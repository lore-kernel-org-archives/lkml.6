Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00323C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2AA52087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546851221;
	bh=VveK8BhUx69XcWOGo0zRooYTUXCqPr+A2+V7SonDI0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cc+D3zfqXkfJYpwHL/33znYXfimhfa5AVS1PC80xSeYcUDyTut7s4lnqUApxolTp1
	 wMA9zHQxP91fu9F7Rqq6JEODwheSlcIfnl8+zZPAc/2Qal4fUJqtsK5izbwRUvTN2M
	 pkCjeF5STdGsG7A6fPQkLfh2t36DKbLf+s85PwPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfAGIxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 03:53:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:50472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726572AbfAGIxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 03:53:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B44620859;
        Mon,  7 Jan 2019 08:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546851219;
        bh=VveK8BhUx69XcWOGo0zRooYTUXCqPr+A2+V7SonDI0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h1Px17ccykUmlUwNbOVgI6yCmJYBrpwNapPOLkQ0ld7grfy2TBw4z9sal10ZJ1KSH
         Cb39ll/0sip+MUmwTlNU06yIx0dtc/2pq1THayBufFctHiu9/jgKNDEqXj0xqGvqVy
         JlnHAQzsTh9/YGEt8aUxRFVpQGtAyNRLJ4TUQvhM=
Date:   Mon, 7 Jan 2019 09:53:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     arnd@arndb.de, viro@zeniv.linux.org.uk,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] char: pcmcia: a possible concurrency double-free bug in
 rx_alloc_buffers()
Message-ID: <20190107085337.GB26384@kroah.com>
References: <76309f04-b1e1-11d3-b77f-962bf50c5be2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76309f04-b1e1-11d3-b77f-962bf50c5be2@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 04:12:22PM +0800, Jia-Ju Bai wrote:
> In drivers/char/pcmcia/synclink_cs.c, the functions mgslpc_open() and hdlcdev_open() can be concurrently executed.
> 
> hdlcdev_open
>   startup
>     claim_resources
>       rx_alloc_buffers
>         line 2641: kfree(info->rx_buf)
> 
> mgslpc_open
>   startup
>     claim_resources
>       rx_alloc_buffers
>         line 2641: kfree(info->rx_buf)
> 
> Thus, a possible concurrency double-free bug may occur.
> 
> This possible bug is found by a static analysis tool written by myself and my manual code review.

Care to send a patch to fix up this potential issue?

thanks,

greg k-h
