Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEF6C67863
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 00:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0113920838
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 00:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0113920838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbeJUIwu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 04:52:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54418 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbeJUIwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 04:52:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4FA1E8667B;
        Sun, 21 Oct 2018 00:40:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-113.rdu2.redhat.com [10.10.120.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE4A1780D9;
        Sun, 21 Oct 2018 00:40:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <209e8c35-d26e-0a29-84d7-b8b1d0ecbebc@gmail.com>
References: <209e8c35-d26e-0a29-84d7-b8b1d0ecbebc@gmail.com> <97872123-70be-2833-ea7a-a463ce204b53@gmail.com> <862e36a2-2a6f-4e26-3228-8cab4b4cf230@gmail.com> <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk> <153754743491.17872.12115848333103740766.stgit@warthog.procyon.org.uk> <de050902-f3d0-b2db-2627-983a36c87b3c@gmail.com> <6518.1539956277@warthog.procyon.org.uk> <29902.1539988579@warthog.procyon.org.uk>
To:     Alan Jenkins <alan.christopher.jenkins@gmail.com>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
Subject: Re: [PATCH 03/34] teach move_mount(2) to work with OPEN_TREE_CLONE [ver #12]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <16586.1540082426.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Sun, 21 Oct 2018 01:40:26 +0100
Message-ID: <16587.1540082426@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Sun, 21 Oct 2018 00:40:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Jenkins <alan.christopher.jenkins@gmail.com> wrote:

> diff --git a/fs/namespace.c b/fs/namespace.c
> index 4dfe7e23b7ee..e8d61d5f581d 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -1763,7 +1763,7 @@ void dissolve_on_fput(struct vfsmount *mnt)
>  {
>  	namespace_lock();
>  	lock_mount_hash();
> -	if (!real_mount(mnt)->mnt_ns) {
> +	if (!real_mount(mnt)->mnt_ns && !(mnt->mnt_flags & MNT_UMOUNT)) {
>  		mntget(mnt);
>  		umount_tree(real_mount(mnt), UMOUNT_CONNECTED);
>  	}
> @@ -2469,7 +2469,7 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
>  	if (old->mnt_ns && !attached)
>  		goto out1;
>  
> -	if (old->mnt.mnt_flags & MNT_LOCKED)
> +	if (old->mnt.mnt_flags & (MNT_LOCKED | MNT_UMOUNT))
>  		goto out1;
>  
>  	if (old_path->dentry != old_path->mnt->mnt_root)

I've already got one of these; I'll fold in the other also.

David
