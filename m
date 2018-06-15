Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2207EC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C486D20864
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="VEZoJCE7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C486D20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966016AbeFOVfS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 17:35:18 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:48576 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756235AbeFOVfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 17:35:16 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D723B8EE26F;
        Fri, 15 Jun 2018 14:35:15 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wBuDVIvWgkMX; Fri, 15 Jun 2018 14:35:15 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 558618EE055;
        Fri, 15 Jun 2018 14:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1529098515;
        bh=kd/gryg6ZnL4BPvz7IZf0hAXcPdYQLtRFQFSadSlUpo=;
        h=Subject:From:To:Date:From;
        b=VEZoJCE7htvsvrEn1OlqPz6zd0YNb5jJHFZ0uyNI4n8W0rWjF3qceSYT4NKGZPxHW
         5aJOBjEGZVR/+u/CK9cuwvolM2rs5adkBMKSjiFCiHEteR36QxPcVqq+lpJCTfKTKx
         s7D+UFYZii9i4c1pfOJOqMemU8tYuB9KucIKLp+8=
Message-ID: <1529098514.4048.41.camel@HansenPartnership.com>
Subject: [PATCH v3 0/1] shiftfs: uid/gid shifting filesystem
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        containers@lists.linux-foundation.org,
        Phil Estes <estesp@gmail.com>
Date:   Fri, 15 Jun 2018 14:35:14 -0700
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a repost of the v2 patch updated for the d_real changes

For those who want to test it out, there's a git tree here

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/binfmt_misc.git

on the shiftfs-v3 branch

v2:

This is a rewrite of the original shiftfs code to make use of super
block user namespaces.  I've also removed the mappings passed in as
mount options in favour of using the mappings in s_user_ns.  The upshot
is that it probably needs retesting for all the bugs people found,
since there's a lot of new code, and the use case has changed.  Now, to
use it, you have to mark the filesystems you want to be mountable
inside a user namespace as root:

mount -t shiftfs -o mark <origin> <mark location>

The origin should be inaccessible to the unprivileged user, and the
access to the <mark location> can be controlled by the usual filesystem
permissions.  Once this is done, any user who can get access to the
<mark location> can do (as the local user namespace root):

mount -t shiftfs <mark location> <somewhere in my local mount ns>

And they will be able to write at their user namespace shifts, but have
the interior view of the uid/gid be what appears on the <origin>

In using the s_user_ns, a lot of the code actually simplified, because
now our credential shifting code simply becomes use the <origin>
s_user_ns and the shifted uid/gid.  The updated d_real() code from
overlayfs is also used, so shiftfs now no-longer needs its own file
operations.

---
[original blurb]

My use case for this is that I run a lot of unprivileged architectural
emulation containers on my system using user namespaces.  Details here:

http://blog.hansenpartnership.com/unprivileged-build-containers/

They're mostly for building non-x86 stuff (like aarch64 and arm secure
boot and mips images).  For builds, I have all the environments in my
home directory with downshifted uids; however, sometimes I need to use
them to administer real images that run on systems, meaning the uids
are the usual privileged ones not the downshifted ones.  The only
current choice I have is to start the emulation as root so the uid/gids
match.  The reason for this filesystem is to use my standard
unprivileged containers to maintain these images.  The way I do this is
crack the image with a loop and then shift the uids before bringing up
the container.  I usually loop mount into /var/tmp/images/, so it's
owned by real root there:

jarvis:~ # ls -l /var/tmp/images/mips|head -4
total 0
drwxr-xr-x 1 root root 8192 May 12 08:33 bin
drwxr-xr-x 1 root root    6 May 12 08:33 boot
drwxr-xr-x 1 root root  167 May 12 08:33 dev

And I usually run my build containers with a uid_map of 

         0     100000       1000
      1000       1000          1
     65534     101000          1

(maps 0-999 shifted, then shifts nobody to 1000 and keeps my uid [1000]
fixed so I can mount my home directory into the namespace) and
something similar with gid_map. So I shift mount the mips image with

mount -t shiftfs -o
idmap=0:100000:1000,uidmap=65534:101000:1,gidmap=0:100000:100,gidmap=10
1:100101:899,gidmap=65533:101000:2 /var/tmp/images/mips
/home/jejb/containers/mips

and I now see it as

jejb@jarvis:~> ls -l containers/mips|head -4
total 0
drwxr-xr-x 1 100000 100000 8192 May 12 08:33 bin/
drwxr-xr-x 1 100000 100000    6 May 12 08:33 boot/
drwxr-xr-x 1 100000 100000  167 May 12 08:33 dev/

Like my usual unprivileged build roots and I can now use an
unprivileged container to enter and administer the image.

It seems like a lot of container systems need to do something similar
when they try and provide unprivileged access to standard images. 
 Right at the moment, the security mechanism only allows root in the
host to use this, but it's not impossible to come up with a scheme for
marking trees that can safely be shift mounted by unprivileged user
namespaces.

James

---


James Bottomley (1):
  shiftfs: uid/gid shifting bind mount

 fs/Kconfig                 |   8 +
 fs/Makefile                |   1 +
 fs/shiftfs.c               | 783 +++++++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/magic.h |   2 +
 4 files changed, 794 insertions(+)
 create mode 100644 fs/shiftfs.c

-- 
2.13.7

