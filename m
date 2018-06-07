Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 1fMgBXCZGVt1DQAAmS7hNA
	; Thu, 07 Jun 2018 20:45:36 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 04D506074D; Thu,  7 Jun 2018 20:45:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7F5086063F;
	Thu,  7 Jun 2018 20:45:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7F5086063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932536AbeFGUpd (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 16:45:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47468 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750914AbeFGUpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 16:45:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 95A6610D441;
        Thu,  7 Jun 2018 20:45:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-245.rdu2.redhat.com [10.10.121.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8E6772166BB2;
        Thu,  7 Jun 2018 20:45:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1917614e-97dc-c911-c2d1-cc5d002d2071@suse.de>
References: <1917614e-97dc-c911-c2d1-cc5d002d2071@suse.de> <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk> <152720689245.9073.17300569813645143102.stgit@warthog.procyon.org.uk>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 26/32] afs: Use fs_context to pass parameters over automount [ver #8]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <14466.1528404329.1@warthog.procyon.org.uk>
Date: Thu, 07 Jun 2018 21:45:29 +0100
Message-ID: <14467.1528404329@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 07 Jun 2018 20:45:31 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 07 Jun 2018 20:45:31 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Goldwyn Rodrigues <rgoldwyn@suse.de> wrote:

Goldwyn Rodrigues <rgoldwyn@suse.de> wrote:

> > +static struct vfsmount *afs_mntpt_do_automount(struct dentry *mntpt)
> > +{
> > +	struct fs_context *fc;
> > +	struct vfsmount *mnt;
> > +	int ret;
> > +
> > +	BUG_ON(!d_inode(mntpt));
> > +
> > +	fc = vfs_new_fs_context(&afs_fs_type, mntpt, 0,
> > +				FS_CONTEXT_FOR_SUBMOUNT);
> > +	if (IS_ERR(fc))
> > +		return ERR_CAST(fc);
> > +
> > +	ret = afs_mntpt_set_params(fc, mntpt);
> > +	if (ret < 0)
> > +		goto error_fc;
> > +
> > +	ret = vfs_get_tree(fc);
> > +	if (ret < 0)
> > +		goto error_fc;
> > +
> > +	mnt = vfs_create_mount(fc, 0);
> > +	if (IS_ERR(mnt)) {
> > +		ret = PTR_ERR(mnt);
> > +		goto error_fc;
> > +	}
> >  
> > -	free_page((unsigned long) devname);
> > -	free_page((unsigned long) options);
> > -	_leave(" = %p", mnt);
> > +	put_fs_context(fc);
> >  	return mnt;
> >  
> Why are you performing a put_fs_context(fc) in the success code path? Do
> we not need a reference of fc anymore?

No.  This is the ->d_automount() hook.  The context is created at the top of
the function, configuration is done, the superblock is obtained, a mount
object is created (for which we get a ref returned).  After that point, we
don't need the context any more and no one else is going to clean it up for
us.

David
