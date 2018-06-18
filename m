Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70811C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD6B20836
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:43:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD6B20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936864AbeFRTns (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 15:43:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33146 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S936040AbeFRTnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 15:43:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 539B7402333A;
        Mon, 18 Jun 2018 19:43:46 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 104BF20389E0;
        Mon, 18 Jun 2018 19:43:46 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id C560C2209E9; Mon, 18 Jun 2018 15:43:45 -0400 (EDT)
Date:   Mon, 18 Jun 2018 15:43:45 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     linux-kernel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-unionfs@vger.kernel.org, linux-doc@vger.kernel.org,
        Daniel Walsh <dwalsh@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: overlayfs: caller_credentials option bypass creator_cred
Message-ID: <20180618194345.GA15973@redhat.com>
References: <20180618154222.19279-1-salyzyn@android.com>
 <20180618185448.GA8749@redhat.com>
 <f141f883-0dbd-10ea-83b9-a1b38119b0c5@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f141f883-0dbd-10ea-83b9-a1b38119b0c5@android.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 18 Jun 2018 19:43:46 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 18 Jun 2018 19:43:46 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vgoyal@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 12:18:25PM -0700, Mark Salyzyn wrote:
> On 06/18/2018 11:54 AM, Vivek Goyal wrote:
> > On Mon, Jun 18, 2018 at 08:42:15AM -0700, Mark Salyzyn wrote:
> > > All accesses to the lower filesystems reference the creator (mount)
> > > and not the source context.  This is a security issue.
> > Can you elaborate with an example that how this is a security issue.
> > mounter's check is in addition to caller's check. So we have two
> > checks in ovl_permission(). overlay inode gets the credentials from
> > underlying inode and we first check if caller is allowed to the
> > operation and if that's allowed, then we check if mounter is allowed
> > to do the operation.
> init which does the mount and represents the creator_cred which is granted a
> restricted MAC to do just what it needs to do, eg mount, but not be able to
> access the files. The caller comes in and is rejected because init domain is
> not allowed, even though the caller's domain is. MAC does not require
> overlap in privileges between the creator and the user.

[ CC dan walsh, stephen smalley ]

Ok. So this is not about security risk as such. It is more about that
it does not work in particular configuration where caller is allowed to
something but the mounter is not allowed to do that operation, so
operation fails.

(IIUC, recently this was raised as an issue if NFS is lower layer and
server is doing root squashing. Then root on client can do mount but might
not have access to a file while caller does have).

Will it be acceptable to write security policies in such a way so that
mounter has access as well.

Current model does assume that mounter has privileges on underlying files.

I think this works reasonably well with SELinux model of doing context
mounts. So if a "context=foo_label" mount is done, that changes labels
on overlay inodes (and ignore lables on disk). Mounter is the one allowing
this overriding. Now if we mounter allows this, then mounter should have
atleast access to underlying files. Otherwise this becomes equivalent
of that as long as mounter can do mount then it is providing access to
all files on disk/dir (with context mount). And mounter itself might not
be able to do those operations.

Core idea is, trying to make sure mounter of overlay does not provide
more priviliges to caller through a mount point if mounter itself does
not have privilege to do certain operations.

Another place it works well is that one does not have to provide
read/write labels on lower file. So in case of containers, SELinux can
just provide read labels to files in shared image dir, and as long
as mounter has read permission, it can copy up file and provide a writable
copy to the client. If we don't do mounter's check, that means caller
needs to have write permission to lower layer as well. And if caller
breaks out of container, it could directly write lower layer and attcking
another containers. So this was another use case in mind while coming
up with this model.

I am not saying that current model is the best way of doing things. Just
giving some context about why we thought it is a good idea.

Thanks
Vivek
