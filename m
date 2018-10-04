Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E18C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E0CC2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E0CC2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbeJDVDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 17:03:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49990 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727355AbeJDVDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 17:03:51 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6F5A512F8E4;
        Thu,  4 Oct 2018 14:10:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 622B41084288;
        Thu,  4 Oct 2018 14:10:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <153861496327.30373.10501882399296347125.stgit@noble>
References: <153861496327.30373.10501882399296347125.stgit@noble> <153861471803.30373.6184444014227748848.stgit@noble>
To:     NeilBrown <neilb@suse.com>
Cc:     dhowells@redhat.com, "J. Bruce Fields" <bfields@fieldses.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>, linux-nfs@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
        linux-afs@lists.infradead.org, coda@cs.cmu.edu,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/3] VFS: introduce MAY_ACT_AS_OWNER
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <28762.1538662213.1@warthog.procyon.org.uk>
Date:   Thu, 04 Oct 2018 15:10:13 +0100
Message-ID: <28763.1538662213@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 04 Oct 2018 14:10:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NeilBrown <neilb@suse.com> wrote:

> diff --git a/fs/afs/security.c b/fs/afs/security.c
> index 81dfedb7879f..ac2e39de8bff 100644
> --- a/fs/afs/security.c
> +++ b/fs/afs/security.c
> @@ -349,6 +349,16 @@ int afs_permission(struct inode *inode, int mask)
>  	if (mask & MAY_NOT_BLOCK)
>  		return -ECHILD;
>  
> +	/* Short-circuit for owner */
> +	if (mask & MAY_ACT_AS_OWNER) {
> +		if (inode_owner_or_capable(inode))

You don't know that inode->i_uid in meaningful.  You may have noticed that
afs_permission() ignores i_uid and i_gid entirely.  It queries the server (if
this information is not otherwise cached) to ask what permits the user is
granted - where the user identity is defined by the key returned from
afs_request_key()[*].

So, NAK for the afs piece.

David

[*] If there's no appropriate key, anonymous permits will be used.
