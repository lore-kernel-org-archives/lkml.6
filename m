Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AF213F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 912FF20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 912FF20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbeG3LVu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 07:21:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37024 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726692AbeG3LVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 07:21:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2EE4E402347F;
        Mon, 30 Jul 2018 09:47:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BDA3E213ED6A;
        Mon, 30 Jul 2018 09:47:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <559c49b8-9d58-e242-20c2-fe1b491664dd@huawei.com>
References: <559c49b8-9d58-e242-20c2-fe1b491664dd@huawei.com> <20180730161622.3837cb15@canb.auug.org.au>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     dhowells@redhat.com, Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg KH <greg@kroah.com>, Al Viro <viro@ZenIV.linux.org.uk>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Miao Xie <miaoxie@huawei.com>, Chao Yu <yuchao0@huawei.com>
Subject: Re: linux-next: build failure after merge of the staging tree
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2377.1532944057.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Mon, 30 Jul 2018 10:47:37 +0100
Message-ID: <2379.1532944057@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 30 Jul 2018 09:47:39 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 30 Jul 2018 09:47:39 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gao Xiang <gaoxiang25@huawei.com> wrote:

> >   sb->s_flags |= MS_RDONLY | MS_NOATIME;

This should be using SB_* rather than MS_* for interaction with sb->s_flags.

> > drivers/staging/erofs/super.c: In function 'erofs_mount':
> > drivers/staging/erofs/super.c:501:10: warning: passing argument 5 of 'mount_bdev' makes integer from pointer without a cast [-Wint-conversion]
> >    &priv, erofs_fill_super);
> >           ^~~~~~~~~~~~~~~~
> > In file included from include/linux/buffer_head.h:12:0,
> >                  from drivers/staging/erofs/super.c:14:
> > include/linux/fs.h:2151:23: note: expected 'size_t {aka long unsigned int}' but argument is of type 'int (*)(struct super_block *, void *, int)'
> >  extern struct dentry *mount_bdev(struct file_system_type *fs_type,
> >                        ^~~~~~~~~~
> > drivers/staging/erofs/super.c:500:9: error: too few arguments to function 'mount_bdev'
> >   return mount_bdev(fs_type, flags, dev_name,
> >          ^~~~~~~~~~

There's a patch in Al Viro's tree that passes a size_t argument indicating the
size of the mount data from mount down into the filesystem and into the
helpers as the data may be on a kernel stack or in kernel .rodata rather than
in a full page of its own.

https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git

Currently this is commit 0a191e4505a4f255e6513b49426213da69bf0e80

vfs: Require specification of size of mount data for internal mounts

David

