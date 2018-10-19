Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBAFECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 21:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C71082083A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 21:35:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C71082083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbeJTFnC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 01:43:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbeJTFnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 01:43:02 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5E7115D67E;
        Fri, 19 Oct 2018 21:35:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D8C319483;
        Fri, 19 Oct 2018 21:35:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <97872123-70be-2833-ea7a-a463ce204b53@gmail.com>
References: <97872123-70be-2833-ea7a-a463ce204b53@gmail.com> <862e36a2-2a6f-4e26-3228-8cab4b4cf230@gmail.com> <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk> <153754743491.17872.12115848333103740766.stgit@warthog.procyon.org.uk> <de050902-f3d0-b2db-2627-983a36c87b3c@gmail.com> <6518.1539956277@warthog.procyon.org.uk>
To:     Alan Jenkins <alan.christopher.jenkins@gmail.com>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
Subject: Re: [PATCH 03/34] teach move_mount(2) to work with OPEN_TREE_CLONE [ver #12]
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Date:   Fri, 19 Oct 2018 22:35:09 +0100
Message-ID: <10117.1539984909@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 19 Oct 2018 21:35:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Jenkins <alan.christopher.jenkins@gmail.com> wrote:

> And the first sequence I mentioned - close the FD, then mount+unmount - 
> seems to be unchanged.

Unchanged in what sense?  Still breaks?  I thought I'd fixed that - or are we
talking about a different first sequence?

Sorry, I'm losing track of how many different ways of breaking open_tree() and
move_mount() you've posted.  I don't suppose you could post a checklist?

> I guess this tries to fix the second of the two sequences I mentioned - 
> mount+unmount, then close the FD.  It doesn't seem to work.
> 
> # open_tree_clone 3</mnt 3 sh
> # cd /proc/self/fd/3
> # mount --move . /mnt
> [   41.747831] mnt_flags=1020 umount=0
> # cd /
> # umount /mnt
> umount: /mnt: target is busy
> 
> ^ a newly introduced bug? I do not remember having this problem before.
> 
> # umount -l /mnt

Sigh, so I see.  I have the attached trace from this sequence.

David
----
Command "open_tree_clone 3</mnt 3 sh"

              sh-3614  M=421a9872 u=1 ALC sp=clone_mnt+0x31/0x30a
              sh-3614  M=421a9872 u=2 GET sp=do_dentry_open+0x24/0x2d3
              sh-3614  M=421a9872 u=1 PUT sp=__se_sys_open_tree+0x195/0x1da
              sh-3614  M=421a9872 u=2 GET sp=proc_fd_link+0x106/0x124
              sh-3614  M=421a9872 u=1 PUT sp=vfs_statx+0x95/0xcc

Command "cd /proc/self/fd/3":

              sh-3614  M=421a9872 u=2 GET sp=proc_fd_link+0x106/0x124
              sh-3614  M=421a9872 u=3 GET sp=set_fs_pwd+0x37/0xdb
              sh-3614  M=421a9872 u=2 PUT sp=ksys_chdir+0x88/0xbd

              sh-3614  M=421a9872 u=3 GET sp=legitimize_path.isra.7+0x16/0x50
              sh-3614  M=421a9872 u=2 PUT sp=vfs_statx+0x95/0xcc

Command "mount --move . /mnt":

              sh-3614  M=421a9872 u=3 GET sp=copy_fs_struct+0xcc/0xde
           mount-3615  M=421a9872 u=4 GET sp=legitimize_path.isra.7+0x16/0x50
           mount-3615  M=421a9872 u=3 PUT sp=vfs_statx+0x95/0xcc
           mount-3615  M=421a9872 u=4 GET sp=legitimize_path.isra.7+0x16/0x50
           mount-3615  M=421a9872 u=5 GET sp=do_dentry_open+0x24/0x2d3
           mount-3615  M=421a9872 u=4 PUT sp=terminate_walk+0x20/0xda
           mount-3615  M=421a9872 u=5 GET sp=legitimize_path.isra.7+0x16/0x50
           mount-3615  M=421a9872 u=4 PUT sp=vfs_statx+0x95/0xcc
           mount-3615  M=421a9872 u=3 PUT sp=__fput+0x180/0x1c1
           mount-3615  M=421a9872 u=4 GET sp=legitimize_path.isra.7+0x16/0x50
           mount-3615  M=421a9872 u=4 0x4e sp=          (null)
           mount-3615  M=421a9872 u=5 GET sp=do_move_mount+0x216/0x298
           mount-3615  M=421a9872 u=4 PUT sp=do_mount+0x715/0x929
           mount-3615  M=421a9872 u=3 PUT sp=free_fs_struct+0x1e/0x2e

Command "cd /":

              sh-3614  M=421a9872 u=2 PUT sp=set_fs_pwd+0xb8/0xdb

Command "umount /mnt":

          umount-3616  M=421a9872 u=3 GET sp=legitimize_path.isra.7+0x16/0x50
          umount-3616  M=421a9872 u=2 PUT sp=vfs_statx+0x95/0xcc
          umount-3616  M=421a9872 u=3 GET sp=legitimize_path.isra.7+0x16/0x50
          umount-3616  M=421a9872 u=2 PUT sp=vfs_statx+0x95/0xcc
          umount-3616  M=421a9872 u=3 GET sp=legitimize_path.isra.7+0x16/0x50
          umount-3616  M=421a9872 u=2 PUT sp=user_statfs+0x61/0x98
          umount-3616  M=421a9872 u=3 GET sp=legitimize_mnt+0x12/0x108
          umount-3616  M=421a9872 u=2 PUT sp=ksys_umount+0x3e8/0x40e

(Fails, -EBUSY).

Command "umount -l /mnt":

          umount-3617  M=421a9872 u=3 GET sp=legitimize_mnt+0x12/0x108
          umount-3617  M=421a9872 u=2 PUT sp=pin_kill+0x11c/0x325
          umount-3617  M=421a9872 u=1 PUT sp=ksys_umount+0x3e8/0x40e

Command "exec 3<&-":

(Goes weird: bash still responds, but trying to run a command locks up that
shell; can still log in with ssh, but can't then run commands).

David
