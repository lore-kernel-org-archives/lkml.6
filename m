Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEDAC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA5120835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA5120835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbeJKQn5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 12:43:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56644 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbeJKQn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 12:43:57 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1D378308338F;
        Thu, 11 Oct 2018 09:17:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6719F60472;
        Thu, 11 Oct 2018 09:17:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <5c6f3d62-4cec-2aea-4693-62928611c526@gmail.com>
References: <5c6f3d62-4cec-2aea-4693-62928611c526@gmail.com> <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk> <153754743491.17872.12115848333103740766.stgit@warthog.procyon.org.uk> <de050902-f3d0-b2db-2627-983a36c87b3c@gmail.com> <862e36a2-2a6f-4e26-3228-8cab4b4cf230@gmail.com>
To:     Alan Jenkins <alan.christopher.jenkins@gmail.com>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
Subject: Re: [PATCH 03/34] teach move_mount(2) to work with OPEN_TREE_CLONE [ver #12]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <16206.1539249451.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Thu, 11 Oct 2018 10:17:31 +0100
Message-ID: <16207.1539249451@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 11 Oct 2018 09:17:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Jenkins <alan.christopher.jenkins@gmail.com> wrote:

> # unshare --mount=private_mnt/child_ns --propagation=shared ls -l /proc/self/ns/mnt

I think the problem is that the mount of the nsfs object done by unshare here
pins the new mount namespace - but doesn't add the namespace's contents into
the mount tree, so the mount struct cycle-detection code is bypassed.

I think it's fine for all other namespaces, just not the mount namespace.

It looks like this bug might theoretically exist upstream also, though I don't
think there's any way to actually effect it given that mount() doesn't take a
dirfd argument.

The reason that you can do this with open_tree()/move_mount() is that it
allows you to create a mount tree (OPEN_TREE_CLONE) that has no namespace
assignment, pass it through the namespace switch and then attach it inside the
child namespace.  The cross-namespace checks in do_move_mount() are bypassed
because the root of the newly-cloned mount tree doesn't have one.

Unfortunately, just searching the newly-cloned mount tree for a conflicting
nsfs mount doesn't help because the potential loop could be hidden several
levels deep.

I think the simplest solution is to either reject a request for
open_tree(OPEN_TREE_CLONE) if there are any nsfs objects in the source tree,
or to just not copy said objects.

David
---

Test script:

	mount -t tmpfs none /a
	mount --make-shared /a
	cd /a
	mkdir private_mnt
	mount -t tmpfs xxx private_mnt
	mount --make-private private_mnt
	touch private_mnt/child_ns
	unshare --mount=private_mnt/child_ns --propagation=shared \
	    ls -l /proc/self/ns/mnt
	findmnt

	~/open_tree 3</a/private_mnt 3 \
	    nsenter --mount=/a/private_mnt/child_ns \
	    sh -c '~/move_mount 4</mnt'

	grep Shmem: /proc/meminfo
	dd if=/dev/zero of=/a/private_mnt/bigfile bs=1M count=10

	umount -l /a/private_mnt/
	grep Shmem: /proc/meminfo
