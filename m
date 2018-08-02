Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F331C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0301621580
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:29:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0301621580
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732400AbeHBXW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 19:22:27 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:41672 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbeHBXW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 19:22:26 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1flL9v-0000bS-Kq; Thu, 02 Aug 2018 21:29:23 +0000
Date:   Thu, 2 Aug 2018 22:29:23 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Alan Jenkins <alan.christopher.jenkins@gmail.com>
Cc:     David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/33] vfs: syscall: Add open_tree(2) to reference or
 clone a mount [ver #11]
Message-ID: <20180802212923.GA30522@ZenIV.linux.org.uk>
References: <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
 <153313705165.13253.4602180607294286849.stgit@warthog.procyon.org.uk>
 <7a292a44-7e17-572b-2d1e-0085ef400010@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a292a44-7e17-572b-2d1e-0085ef400010@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 06:31:06PM +0100, Alan Jenkins wrote:
> Hi
> 
> I found this interesting, though I don't entirely follow the kernel
> mount/unmount code.  I had one puzzle about the code, and two questions
> which I was largely able to answer.
> 
> On 01/08/18 16:24, David Howells wrote:
> > +void dissolve_on_fput(struct vfsmount *mnt)
> > +{
> > +	namespace_lock();
> > +	lock_mount_hash();
> > +	mntget(mnt);
> > +	umount_tree(real_mount(mnt), UMOUNT_SYNC);
> > +	unlock_mount_hash();
> > +	namespace_unlock();
> > +}
> 
> Can I ask why  UMOUNT_SYNC is used here?  I feel like I must have missed
> something, but doesn't it skip the IS_MNT_LOCKED() check in
> disconnect_mount() ?
> 
> UMOUNT_SYNC seems used for non-lazy unmounts, and in internal cleanups where
> userspace wouldn't be able to see.  But I think userspace can keep watching
> in this case, e.g. by `fd2 = openat(fd, ".", O_PATH)` (or `fd2 =
> open_tree(fd, ".", 0)` ?).  I would think this function should avoid using
> UMOUNT_SYNC, like lazy unmount avoids it.

FWIW, I suspect that UMOUNT_CONNECTED might be the right thing here...
