Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B83BC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5CB32098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBRC0+VE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5CB32098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbeJLTDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 15:03:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:44612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728131AbeJLTDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 15:03:36 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED2CE2086A;
        Fri, 12 Oct 2018 11:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539343896;
        bh=2K8UX5xri9WFt3zuq6OR6aDcQQolkHbzoPVwC+EKtWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CBRC0+VEPT8Ch6WuYgJRlzMAhlfZnr0MvVowYhsPJp4kU0haJ4hl+jvFzA+jmwYug
         HIxUZZnzuJjlunJxNOyjoLGh9U2fXhxd3qRDnLpWw6tHBG+dzdRIxZGabRjnSNt+11
         BFNGzKVz+8KLCi5Cmh3xoVOY4Gdi5xKWsdAXkirg=
Date:   Fri, 12 Oct 2018 13:31:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: Fix cell proc list
Message-ID: <20181012113134.GA22324@kroah.com>
References: <153929434917.24725.5423867421481211888.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153929434917.24725.5423867421481211888.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 10:45:49PM +0100, David Howells wrote:
> Access to the list of cells by /proc/net/afs/cells has a couple of
> problems:
> 
>  (1) It should be checking against SEQ_START_TOKEN for the keying the
>      header line.
> 
>  (2) It's only holding the RCU read lock, so it can't just walk over the
>      list without following the proper RCU methods.
> 
> Fix these by using an hlist instead of an ordinary list and using the
> appropriate accessor functions to follow it with RCU.
> 
> Since the code that adds a cell to the list must also necessarily change,
> sort the list on insertion whilst we're at it.
> 
> Fixes: 989782dcdc91 ("afs: Overhaul cell database management")
> Signed-off-by: David Howells <dhowells@redhat.com>

Now applied, thanks.

greg k-h
