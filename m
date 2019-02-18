Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B843C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 512A2218D3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550478733;
	bh=xcbZ4mZJ2i6BKfUux4N+EV9Ew+UyIAA5TqMqS8bceqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=am4m1jF9UjRTFRPe/IILftEm8O4EbjAMcEUtKigZpkRTXPqUuj+gvHmQ16fkv/htV
	 Cl9IVKenC/57QiyRvR1R5oYqur/gwS3JTyHtTffXvNMuIrwk57lOWET7Jy1YTom0B/
	 rVCOmcFyyjcb+JVu5YKk+g59kNNJDkoegYTCSA5g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbfBRIcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 03:32:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:59686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728342AbfBRIcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 03:32:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DF8A2184E;
        Mon, 18 Feb 2019 08:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550478731;
        bh=xcbZ4mZJ2i6BKfUux4N+EV9Ew+UyIAA5TqMqS8bceqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VDs6eSzm2rd8YvX5jWvQ3xEfrXMBMYpibdK7RdzZsIl/fHKfKxrJZz55UyutRkmUg
         FEsocLauBubIGHsiAQIvR4R0rhvPYmvmDYG+4CzK60050XQSwfHGBA1STyBrH0OlpK
         QfK8mjhHpBTdYfxmAi2rmEjImpU8vmv3WKHPnUg0=
Date:   Mon, 18 Feb 2019 09:32:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Todd Kjos <tkjos@google.com>,
        Martijn Coenen <maco@android.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>
Subject: Re: [PATCH] binder: reduce mmap_sem write-side lock
Message-ID: <20190218083208.GA20069@kroah.com>
References: <20190218081145.86633-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190218081145.86633-1-minchan@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 05:11:45PM +0900, Minchan Kim wrote:
> binder has used write-side mmap_sem semaphore to release memory
> mapped at address space of the process. However, right lock to
> release pages is down_read, not down_write because page table lock
> already protects the race for parallel freeing.
> 
> Please do not use mmap_sem write-side lock which is well known
> contented lock.
> 
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Martijn Coenen <maco@android.com>
> Cc: Arve Hjønnevåg <arve@android.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>  drivers/android/binder_alloc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Is this just needed for the recent binder changes that are in
linux-next, or for older kernels as well?

thanks,

greg k-h
