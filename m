Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1A3C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 05:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B4521470
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 05:25:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B4521470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbeJTNeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 09:34:22 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46278 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbeJTNeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 09:34:22 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gDjl3-0006jD-Nu; Sat, 20 Oct 2018 05:25:05 +0000
Date:   Sat, 20 Oct 2018 06:25:05 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     Alan Jenkins <alan.christopher.jenkins@gmail.com>,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
Subject: Re: [PATCH 03/34] teach move_mount(2) to work with OPEN_TREE_CLONE
 [ver #12]
Message-ID: <20181020052505.GK32577@ZenIV.linux.org.uk>
References: <97872123-70be-2833-ea7a-a463ce204b53@gmail.com>
 <862e36a2-2a6f-4e26-3228-8cab4b4cf230@gmail.com>
 <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
 <153754743491.17872.12115848333103740766.stgit@warthog.procyon.org.uk>
 <de050902-f3d0-b2db-2627-983a36c87b3c@gmail.com>
 <6518.1539956277@warthog.procyon.org.uk>
 <29902.1539988579@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29902.1539988579@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 11:36:19PM +0100, David Howells wrote:
> Alan Jenkins <alan.christopher.jenkins@gmail.com> wrote:
> 
> > # open_tree_clone 3</mnt 3 sh
> > # cd /proc/self/fd/3
> > # mount --move . /mnt
> > [   41.747831] mnt_flags=1020 umount=0
> > # cd /
> > # umount /mnt
> > umount: /mnt: target is busy
> > 
> > ^ a newly introduced bug? I do not remember having this problem before.
> 
> The reason EBUSY is returned is because propagate_mount_busy() is called by
> do_umount() with refcnt == 2, but mnt_count == 3:
> 
>           umount-3577  M=f8898a34 u=3 0x555 sp=__x64_sys_umount+0x12/0x15
> 
> the trace line being added here:
> 
> 		if (!propagate_mount_busy(mnt, 2)) {
> 			if (!list_empty(&mnt->mnt_list))
> 				umount_tree(mnt, UMOUNT_PROPAGATE|UMOUNT_SYNC);
> 			retval = 0;
> 		} else {
> 			trace_mnt_count(mnt, mnt->mnt_id,
> 					atomic_read(&mnt->mnt_count),
> 					0x555, __builtin_return_address(0));
> 		}
> 
> The busy evaluation is a result of this check:
> 
> 	if (!list_empty(&mnt->mnt_mounts) || do_refcount_check(mnt, refcnt))
> 
> in propagate_mount_busy().
> 
> 
> The problem apparently being that mnt_count counts both refs from mountings
> and refs from other sources, such as file descriptors or pathwalk.

As it bloody well should.  Once the tree has been attached, that open_ctree()
descriptor is refering to vfsmount of /mnt (what else could it be?)

IOW, it *is* genuinely busy.  The livelock on umount -l you've mentioned is
a different story - that's definitely a bug, but this -EBUSY is correct.
