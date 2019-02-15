Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01869C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A2D20840
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RXMf1eOp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbfBOA0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:26:38 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:39462 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfBOA0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 19:26:37 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1F0NxWQ080444;
        Fri, 15 Feb 2019 00:26:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=x8efIcoM9twPEFd/Vw8XPz+PDVMcLou9Ii5COike/IU=;
 b=RXMf1eOp6+NThPx6AYbKVfqhCzDnqikhVHrdXls5myIqpk50omgS13HrMMG3zuXWQMTu
 AiEMP5lTsdGXlDYegBVVd479+K3S6BvE41XmxcCyTGc98BSH+gvO0moHofoHyaPCZtCj
 O9K/EjLQCUp5uuVTiwlqd2PaONkOAFw/i623NLe3YCYyE074eLPMYkxnibZtrkFhwkgn
 69prfKVioeADoprbSMcscV1YvJzw7XYrm4gEEexGwUcllS4CMZRkz7yVWP0I9VrN6vjh
 LKPcFO5nyoYqeUaKYmV6fzG3daOXLWf0+/3mG6UOS6D2QyvzK4WLpDC0Nq2pBGmmCnEX Sw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2qhreeb30f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Feb 2019 00:26:33 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1F0QXSE025133
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Feb 2019 00:26:33 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1F0QWVZ016811;
        Fri, 15 Feb 2019 00:26:32 GMT
Received: from localhost (/10.159.142.29)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Feb 2019 00:26:32 +0000
Date:   Thu, 14 Feb 2019 16:26:31 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matej Kupljen <matej.kupljen@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, hughd@google.com
Subject: Re: tmpfs inode leakage when opening file with O_TMP_FILE
Message-ID: <20190215002631.GB6474@magnolia>
References: <CAHMF36F4JN44Y-yMnxw36A8cO0yVUQhAkvJDcj_gbWbsuUAA5A@mail.gmail.com>
 <20190214154402.5d204ef2aa109502761ab7a0@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214154402.5d204ef2aa109502761ab7a0@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9167 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902150001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[cc the shmem maintainer and the mm list]

On Thu, Feb 14, 2019 at 03:44:02PM -0800, Andrew Morton wrote:
> (cc linux-fsdevel)
> 
> On Mon, 11 Feb 2019 15:18:11 +0100 Matej Kupljen <matej.kupljen@gmail.com> wrote:
> 
> > Hi,
> > 
> > it seems that when opening file on file system that is mounted on
> > tmpfs with the O_TMPFILE flag and using linkat call after that, it
> > uses 2 inodes instead of 1.
> > 
> > This is simple test case:
> > 
> > #include <sys/types.h>
> > #include <sys/stat.h>
> > #include <fcntl.h>
> > #include <unistd.h>
> > #include <string.h>
> > #include <stdio.h>
> > #include <stdlib.h>
> > #include <linux/limits.h>
> > #include <errno.h>
> > 
> > #define TEST_STRING     "Testing\n"
> > 
> > #define TMP_PATH        "/tmp/ping/"
> > #define TMP_FILE        "file.txt"
> > 
> > 
> > int main(int argc, char* argv[])
> > {
> >         char path[PATH_MAX];
> >         int fd;
> >         int rc;
> > 
> >         fd = open(TMP_PATH, __O_TMPFILE | O_RDWR,
> >                         S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP |
> > S_IROTH | S_IWOTH);
> > 
> >         rc = write(fd, TEST_STRING, strlen(TEST_STRING));
> > 
> >         snprintf(path, PATH_MAX,  "/proc/self/fd/%d", fd);
> >         linkat(AT_FDCWD, path, AT_FDCWD, TMP_PATH TMP_FILE, AT_SYMLINK_FOLLOW);
> >         close(fd);
> > 
> >         return 0;
> > }
> > 
> > I have checked indoes with "df -i" tool. The first inode is used when
> > the call to open is executed and the second one when the call to
> > linkat is executed.
> > It is not decreased when close is executed.
> > 
> > I have also tested this on an ext4 mounted fs and there only one inode is used.
> > 
> > I tested this on:
> > $ cat /etc/lsb-release
> > DISTRIB_ID=Ubuntu
> > DISTRIB_RELEASE=18.04
> > DISTRIB_CODENAME=bionic
> > DISTRIB_DESCRIPTION="Ubuntu 18.04.1 LTS"
> > 
> > $ uname -a
> > Linux Orion 4.15.0-43-generic #46-Ubuntu SMP Thu Dec 6 14:45:28 UTC
> > 2018 x86_64 x86_64 x86_64 GNU/Linux

Heh, tmpfs and its weird behavior where each new link counts as a new
inode because "each new link needs a new dentry, pinning lowmem, and
tmpfs dentries cannot be pruned until they are unlinked."

It seems to have this behavior on 5.0-rc6 too:

$ /bin/df -i /tmp ; ./c ; /bin/df -i /tmp
Filesystem      Inodes IUsed   IFree IUse% Mounted on
tmp            1019110    17 1019093    1% /tmp
Filesystem      Inodes IUsed   IFree IUse% Mounted on
tmp            1019110    19 1019091    1% /tmp

Probably because shmem_tmpfile -> shmem_get_inode -> shmem_reserve_inode
which decrements ifree when we create the tmpfile, and then the
d_tmpfile decrements i_nlink to zero.  Now we have iused=1, nlink=0,
assuming iused=itotal-ifree like usual.

Then the linkat call does:

shmem_link -> shmem_reserve_inode

which decrements ifree again and increments i_nlink to 1.  Now we have
iused=2, nlink=1.

The program exits, which closes the file.  /tmp/ping/file.txt still
exists and we haven't evicted inodes yet, so nothing much happens.

But then I added in rm -rf /tmp/ping/file.txt to see what happens.
shmem_unlink contains this:

	if (inode->i_nlink > 1 && !S_ISDIR(inode->i_mode))
		shmem_free_inode(inode->i_sb);

So shmem_iunlink *doesnt* decrement ifree but does drop the nlink, so
our state is now iused=2, nlink=0.

Now we evict the inode, which decrements ifree, so iused=1 and the inode
goes away.  Oops, we just leaked an ifree.

I /think/ the proper fix is to change shmem_link to decrement ifree only
if the inode has nonzero nlink, e.g.

	/*
	 * No ordinary (disk based) filesystem counts links as inodes;
	 * but each new link needs a new dentry, pinning lowmem, and
	 * tmpfs dentries cannot be pruned until they are unlinked.  If
	 * we're linking an O_TMPFILE file into the tmpfs we can skip
	 * this because there's still only one link to the inode.
	 */
	if (inode->i_nlink > 0) {
		ret = shmem_reserve_inode(inode->i_sb);
		if (ret)
			goto out;
	}

Says me who was crawling around poking at O_TMPFILE behavior all morning.
Not sure if that's right; what happens to the old dentry?

--D

> > If you need any more information, please let me know.
> > 
> > And please CC me when replying, I am not subscribed to the list.
> > 
> > Thanks and BR,
> > Matej
