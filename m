Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DF6C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2EFF223FE
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:05:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2EFF223FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbeHJQfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 12:35:48 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:59438 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727209AbeHJQfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 12:35:48 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fo82t-0000WJ-CF; Fri, 10 Aug 2018 08:05:39 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fo82s-0003iQ-KM; Fri, 10 Aug 2018 08:05:39 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk,
        John Johansen <john.johansen@canonical.com>,
        Tejun Heo <tj@kernel.org>, selinux@tycho.nsa.gov,
        Paul Moore <paul@paul-moore.com>,
        Li Zefan <lizefan@huawei.com>, linux-api@vger.kernel.org,
        apparmor@lists.ubuntu.com,
        Casey Schaufler <casey@schaufler-ca.com>, fenghua.yu@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-security-module@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        tomoyo-dev-en@lists.sourceforge.jp, cgroups@vger.kernel.org,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Miklos Szeredi <miklos@szeredi.hu>
References: <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
Date:   Fri, 10 Aug 2018 09:05:22 -0500
In-Reply-To: <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
        (David Howells's message of "Wed, 01 Aug 2018 16:23:56 +0100")
Message-ID: <87d0uqpba5.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fo82s-0003iQ-KM;;;mid=<87d0uqpba5.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+56a5RGWuqSbdDITYOIfsW1/M5QV9eOGs=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: BUG: Mount ignores mount options
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


There is a serious problem with mount options today that fsopen does not
address.  The problem is that mount options are ignored for block based
filesystems, and any other type of filesystem that follows the same
pattern.

The script below demonstrates this bug.  Showing this bug can cause the
ext4 "acl" "quota" and "user_xattr" options to be silently ignored.

fsopen has my nack until it addresses this issue.

I don't know if we can fix this in the context of sys_mount.  But we if
we are redoing the option parsing of how we mount filesystems this needs
to be fixed before we start worrying about bug compatibility.

Hopefully this report is simple and clear enough that we can at least
agree on the problem.

Eric

# cat ~/bin/bdev-loop0.sh
#!/bin/sh
set -x
set -e

LOOP=loop0

dd if=/dev/zero bs=1024 count=1048576 of=$LOOP-file
losetup /dev/$LOOP $LOOP-file
mkfs.ext4 /dev/$LOOP

mkdir $LOOP-noacl-noquota-nouser_xattr
mount -t ext4 /dev/$LOOP -o "noacl,noquota,nouser_xattr" $LOOP-noacl-noquota-nouser_xattr

mkdir $LOOP-acl-quota-user_xattr
mount -t ext4 /dev/$LOOP  -o "acl,quota,user_xattr" $LOOP-acl-quota-user_xattr

cat /proc/mounts | grep loop0


root@finagle:~# ~/bin/bdev-loop0.sh
+ set -e
+ LOOP=loop0
+ dd if=/dev/zero bs=1024 count=1048576 of=loop0-file
1048576+0 records in
1048576+0 records out
1073741824 bytes (1.1 GB) copied, 4.37645 s, 245 MB/s
+ losetup /dev/loop0 loop0-file
+ mkfs.ext4 /dev/loop0
mke2fs 1.41.12 (17-May-2010)
Filesystem label=
OS type: Linux
Block size=4096 (log=2)
Fragment size=4096 (log=2)
Stride=0 blocks, Stripe width=0 blocks
65536 inodes, 262144 blocks
13107 blocks (5.00%) reserved for the super user
First data block=0
Maximum filesystem blocks=268435456
8 block groups
32768 blocks per group, 32768 fragments per group
8192 inodes per group
Superblock backups stored on blocks: 
        32768, 98304, 163840, 229376

Writing inode tables: done                            
Creating journal (8192 blocks): done
Writing superblocks and filesystem accounting information: done

This filesystem will be automatically checked every 29 mounts or
180 days, whichever comes first.  Use tune2fs -c or -i to override.
+ mkdir loop0-noacl-noquota-nouser_xattr
+ mount -t ext4 /dev/loop0 -o noacl,noquota,nouser_xattr loop0-noacl-noquota-nouser_xattr
+ mkdir loop0-acl-quota-user_xattr
+ mount -t ext4 /dev/loop0 -o acl,quota,user_xattr loop0-acl-quota-user_xattr
+ + grep loop0
cat /proc/mounts
/dev/loop0 /root/loop0-noacl-noquota-nouser_xattr ext4 rw,relatime,nouser_xattr,noacl 0 0
/dev/loop0 /root/loop0-acl-quota-user_xattr ext4 rw,relatime,nouser_xattr,noacl 0 0
