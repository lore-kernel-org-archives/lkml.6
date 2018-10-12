Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DC3C67872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD492098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROSBVH0z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FD492098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbeJLXKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:10:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728900AbeJLXKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:10:23 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07BE920645;
        Fri, 12 Oct 2018 15:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539358641;
        bh=siObsr5mCKegZ5LESZm2MGT5vMrvQLqRJnBFWyj+Vd8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ROSBVH0zjc/i1hXig0RcT0omEaDtu8WGoCYzII6QrbBfY1YMyu4UeirOy0WCE4/fe
         W3Aho0XqIAEFjH06+MalOrmDrQYEGKA7cox2re2456tjX5MXC9CyGl7Ac5yVvQ922A
         DDlAXJJmzHNXoVjKQVjhgb0rz7GsSIKUtl1tkMUI=
Date:   Fri, 12 Oct 2018 17:37:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] afs: Fix afs_server struct leak
Message-ID: <20181012153719.GA25689@kroah.com>
References: <153934925704.24054.3222195700321846862.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153934925704.24054.3222195700321846862.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 02:00:57PM +0100, David Howells wrote:
> Fix a leak of afs_server structs.  The routine that installs them in the
> various lookup lists and trees gets a ref on leaving the function, whether
> it added the server or a server already exists.  It shouldn't increment
> the refcount if it added the server.
> 
> The effect of this that "rmmod kafs" will hang waiting for the leaked
> server to become unused.
> 
> Fixes: d2ddc776a458 ("afs: Overhaul volume and server record caching and fileserver rotation")
> Signed-off-by: David Howells <dhowells@redhat.com>

Now applied, thanks.

greg k-h
