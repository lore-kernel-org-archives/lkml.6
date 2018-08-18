Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3F2C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 16:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635A4215EB
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 16:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 635A4215EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbeHRTJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 15:09:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50812 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbeHRTJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 15:09:16 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 49011BD8;
        Sat, 18 Aug 2018 16:01:04 +0000 (UTC)
Date:   Sat, 18 Aug 2018 18:01:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Rajat Jain <rajatja@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Driver core patches for 4.19-rc1
Message-ID: <20180818160101.GB22720@kroah.com>
References: <20180818155758.GA22665@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180818155758.GA22665@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 18, 2018 at 05:57:58PM +0200, Greg KH wrote:
> The following changes since commit acb1872577b346bd15ab3a3f8dff780d6cca4b70:
> 
>   Linux 4.18-rc7 (2018-07-29 14:44:52 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-4.19-rc1
> 
> for you to fetch changes up to d2fc88a61b4ea99f574bde16e92718e22f312136:
> 
>   Merge 4.18-rc7 into driver-core-next (2018-07-30 10:08:09 +0200)
> 
> ----------------------------------------------------------------
> Driver core patches for 4.19-rc1
> 
> Here are all of the driver core and related patches for 4.19-rc1.
> 
> ZNothing huge here, just a number of small cleanups and the ability to
> now stop the deferred probing after init happens.
> 
> All of these have been in linux-next for a while with only a merge issue
> reported.  That merge issue is in fs/sysfs/group.c and Stephen has
> posted the diff of what it should be to resolve this.  I'll follow up
> with that diff to this pull request.

Here's Stephen's email with the merge resolution that Rajat verified is
correct:

------------
Date: Mon, 23 Jul 2018 15:12:24 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>, David Miller <davem@davemloft.net>, Networking
        <netdev@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing
        List <linux-kernel@vger.kernel.org>, Dmitry Torokhov
        <dmitry.torokhov@gmail.com>, Rajat Jain <rajatja@google.com>
Subject: linux-next: manual merge of the driver-core tree with the net-next
        tree

Hi Greg,

Today's linux-next merge of the driver-core tree got a conflict in:

  fs/sysfs/group.c

between commit:

  5f81880d5204 ("sysfs, kobject: allow creating kobject belonging to arbitrary users")

from the net-next tree and commit:

  c855cf2759d2 ("sysfs: Fix internal_create_group() for named group updates")

from the driver-core tree.

I fixed it up (I think - see below) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc fs/sysfs/group.c
index c7a716c4acc9,38240410f831..000000000000
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@@ -122,15 -118,23 +122,24 @@@ static int internal_create_group(struc
  			kobj->name, grp->name ?: "");
  		return -EINVAL;
  	}
 +	kobject_get_ownership(kobj, &uid, &gid);
  	if (grp->name) {
- 		kn = kernfs_create_dir_ns(kobj->sd, grp->name,
- 					  S_IRWXU | S_IRUGO | S_IXUGO,
- 					  uid, gid, kobj, NULL);
- 		if (IS_ERR(kn)) {
- 			if (PTR_ERR(kn) == -EEXIST)
- 				sysfs_warn_dup(kobj->sd, grp->name);
- 			return PTR_ERR(kn);
+ 		if (update) {
+ 			kn = kernfs_find_and_get(kobj->sd, grp->name);
+ 			if (!kn) {
+ 				pr_warn("Can't update unknown attr grp name: %s/%s\n",
+ 					kobj->name, grp->name);
+ 				return -EINVAL;
+ 			}
+ 		} else {
 -			kn = kernfs_create_dir(kobj->sd, grp->name,
 -					       S_IRWXU | S_IRUGO | S_IXUGO,
 -					       kobj);
++			kn = kernfs_create_dir_ns(kobj->sd, grp->name,
++						  S_IRWXU | S_IRUGO | S_IXUGO,
++						  uid, gid, kobj, NULL);
+ 			if (IS_ERR(kn)) {
+ 				if (PTR_ERR(kn) == -EEXIST)
+ 					sysfs_warn_dup(kobj->sd, grp->name);
+ 				return PTR_ERR(kn);
+ 			}
  		}
  	} else
  		kn = kobj->sd;
