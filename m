Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F15ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 22:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B506D2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 22:36:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B506D2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbeJTGoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 02:44:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36338 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbeJTGoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 02:44:21 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A598281F0C;
        Fri, 19 Oct 2018 22:36:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0CC351001914;
        Fri, 19 Oct 2018 22:36:19 +0000 (UTC)
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
Content-Type: text/plain; charset="us-ascii"
Content-ID: <29901.1539988579.1@warthog.procyon.org.uk>
Date:   Fri, 19 Oct 2018 23:36:19 +0100
Message-ID: <29902.1539988579@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 19 Oct 2018 22:36:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Jenkins <alan.christopher.jenkins@gmail.com> wrote:

> # open_tree_clone 3</mnt 3 sh
> # cd /proc/self/fd/3
> # mount --move . /mnt
> [   41.747831] mnt_flags=1020 umount=0
> # cd /
> # umount /mnt
> umount: /mnt: target is busy
> 
> ^ a newly introduced bug? I do not remember having this problem before.

The reason EBUSY is returned is because propagate_mount_busy() is called by
do_umount() with refcnt == 2, but mnt_count == 3:

          umount-3577  M=f8898a34 u=3 0x555 sp=__x64_sys_umount+0x12/0x15

the trace line being added here:

		if (!propagate_mount_busy(mnt, 2)) {
			if (!list_empty(&mnt->mnt_list))
				umount_tree(mnt, UMOUNT_PROPAGATE|UMOUNT_SYNC);
			retval = 0;
		} else {
			trace_mnt_count(mnt, mnt->mnt_id,
					atomic_read(&mnt->mnt_count),
					0x555, __builtin_return_address(0));
		}

The busy evaluation is a result of this check:

	if (!list_empty(&mnt->mnt_mounts) || do_refcount_check(mnt, refcnt))

in propagate_mount_busy().


The problem apparently being that mnt_count counts both refs from mountings
and refs from other sources, such as file descriptors or pathwalk.

David
