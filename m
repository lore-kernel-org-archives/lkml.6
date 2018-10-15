Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CF6C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 974C52083C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxlGoIY7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 974C52083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbeJOVsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 17:48:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:53922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbeJOVsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 17:48:23 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75C3220652;
        Mon, 15 Oct 2018 14:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539612178;
        bh=eGcfEcYNIdpGnz670Qxd9ffA2o+pWyCd5RUjWu3ve0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MxlGoIY7L8isuyIcol4IPPdfd936smGYUI+v0xhEKBKxu96c0q3ws1DbQumnNDcjK
         ++hvUUYJZpa4L6xz6smcYxyWORnANSmTA814HryyP6Iq69wLBHYiGIWYxF8nrsZ9+H
         WVuavhM6qnN9ginjLpnfpXdIv7pNEHfNlx+DHqmE=
Date:   Mon, 15 Oct 2018 16:02:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] afs: Fix clearance of reply
Message-ID: <20181015140255.GA3510@kroah.com>
References: <153960378222.7221.8576360303007809015.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153960378222.7221.8576360303007809015.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 12:43:02PM +0100, David Howells wrote:
> The recent patch to fix the afs_server struct leak didn't actually fix the
> bug, but rather fixed some of the symptoms.  The problem is that an
> asynchronous call that holds a resource pointed to by call->reply[0] will
> find the pointer cleared in the call destructor, thereby preventing the
> resource from being cleaned up.
> 
> In the case of the server record leak, the afs_fs_get_capabilities()
> function in devel code sets up a call with reply[0] pointing at the server
> record that should be altered when the result is obtained, but this was
> being cleared before the destructor was called, so the put in the
> destructor does nothing and the record is leaked.
> 
> Commit f014ffb025c1 removed the additional ref obtained by
> afs_install_server(), but the removal of this ref is actually used by the
> garbage collector to mark a server record as being defunct after the record
> has expired through lack of use.
> 
> The offending clearance of call->reply[0] upon completion in
> afs_process_async_call() has been there from the origin of the code, but
> none of the asynchronous calls actually use that pointer currently, so it
> should be safe to remove (note that synchronous calls don't involve this
> function).
> 
> Fix this by the following means:
> 
>  (1) Revert commit f014ffb025c1.
> 
>  (2) Remove the clearance of reply[0] from afs_process_async_call().
> 
> Without this, afs_manage_servers() will suffer an assertion failure if it
> sees a server record that didn't get used because the usage count is not 1.
> 
> Fixes: f014ffb025c1 ("afs: Fix afs_server struct leak")
> Fixes: 08e0e7c82eea ("[AF_RXRPC]: Make the in-kernel AFS filesystem use AF_RXRPC.")
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---

Now applied, thanks.

greg k-h
