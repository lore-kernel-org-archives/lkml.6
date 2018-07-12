Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49191ECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 22:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 027DC208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 22:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kqC/Z9FO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 027DC208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387551AbeGLXHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 19:07:02 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:39964 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387452AbeGLXHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 19:07:01 -0400
Received: by mail-oi0-f53.google.com with SMTP id w126-v6so58857142oie.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 15:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=u4bQOMtbraI9l0OiIweTvgfc43WKn8u99eS7ay4tZNs=;
        b=kqC/Z9FOvBXC/IqJ+fv5r8uLyofJbcx45CgOK+/LEy4UtWY6/X/GTiWwTSl4ZbEKCL
         eFHr5UHJjoUuroxGeG9fR4WyYQ6f4HLVzCE1HzrdgKiMSHmvhk9Fi4bHPJJj0sxUqEhM
         3plYY03h4MGAddayrDj5bRWdZ8FFmDEuYyXJYp1ihTs3ZsNGKVmLhRbQXXczTCAUSy/M
         b4S4yE46wNHtvLddIU3l+9QVa41YyW1QvBMa0G4iBRszeJ44aGvKAFc8pozYzn9e4x3Q
         WTQm+SDs3+7yuZb7Hv8rlgUnxVZHpxn0lATDrNKI4Bkyr6yjad4SqC8gYSdop1e314FK
         NcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=u4bQOMtbraI9l0OiIweTvgfc43WKn8u99eS7ay4tZNs=;
        b=Zs9Rv9aXE/OSjJyIK5OjS8JKUwWhJ9gwRwDkVYAOM8J9GRE3/GJ1LZQ+yBb6nGVO9A
         eQZNfdRomGKfSer0HbKe0c/XIWUm/wZD56xcEDMJDAufaLV8wivUF8w5QRPXHX8y86Ul
         z83OFo5ctlWm9zocyGhjtm2GRNldzXUd2aUO58oEuRt5MkcWrNiu4ZlNAO7dLvgyYfKd
         kPTCDSV7oi4V9U8xlMTXQNbjDqbvLU0CITQa6iB7lIfjGeOk2LLD8Mx3YZKUeCoz2Oir
         3zkA6MdnoOTRF5vOkX4rqGnT9+aLPj1WE6onJxCRVaVcG1xteyBnXoeIzE7gYkUGLMiK
         Nisw==
X-Gm-Message-State: AOUpUlEPSrAa7ApKQ2cc3dCW/WHKGbauJUSeD+4TUl4PZ2DUzsa+/d0k
        huLS/DWTs9qiwsfrRQXXKUwDEu5ILIZRt9Fj1sR3bN+lOAI=
X-Google-Smtp-Source: AAOMgpfsiDC1pc/lNvNW3l/O7mISat1NTbN6GxknW6r+g7c17aS4M5sQRQHnC4ICwKnbdaxaju0xzrM3y8b7/Q1bH70=
X-Received: by 2002:aca:6044:: with SMTP id u65-v6mr90143oib.323.1531436118971;
 Thu, 12 Jul 2018 15:55:18 -0700 (PDT)
MIME-Version: 1.0
From:   Jann Horn <jannh@google.com>
Date:   Thu, 12 Jul 2018 15:54:52 -0700
Message-ID: <CAG48ez0srRLS07oiL6x61eRzoD+LpLgT_=74hCJGRFqfYd00Pg@mail.gmail.com>
Subject: readdir() and directory names containing slashes
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The kernel doesn't seem to filter slashes out of directory names
coming from the disk (with the exception of a few specific
filesystems, like FUSE):

# touch fatimg
# truncate --size=40M fatimg
# mkfs.fat fatimg
mkfs.fat 4.1 (2017-01-24)
# mkdir mount
# mount fatimg mount
# touch mount/FOOBAR
# umount mount
# sed -i 's|FOOBAR|FO/BAR|' fatimg
# mount fatimg mount
# strace -v -e trace=getdents,lstat ls -l mount
lstat("mount", {st_dev=makedev(7, 0), st_ino=1, st_mode=S_IFDIR|0755,
st_nlink=2, st_uid=0, st_gid=0, st_blksize=2048, st_blocks=32,
st_size=16384, st_atime=0, st_atime_nsec=0, st_mtime=0,
st_mtime_nsec=0, st_ctime=0, st_ctime_nsec=0}) = 0
getdents(3, [{d_ino=1, d_off=1, d_reclen=24, d_name=".",
d_type=DT_DIR}, {d_ino=1, d_off=2, d_reclen=24, d_name="..",
d_type=DT_DIR}, {d_ino=267, d_off=16384, d_reclen=32, d_name="FO/BAR",
d_type=DT_REG}], 32768) = 80
lstat("mount/FO/BAR", 0x5603c71ee1a8)   = -1 ENOENT (No such file or directory)
ls: cannot access 'mount/FO/BAR': No such file or directory
getdents(3, [], 32768)                  = 0
total 0
-????????? ? ? ? ?            ? FO/BAR
+++ exited with 1 +++

I think it would be reasonable for the VFS layer to block this - if
someone puts something like "../../etc" in a filename, userspace could
get pretty confused.

AFAICS the simple way to deal with this would be to patch dir_emit()
to do something like this:

if (WARN_ON_ONCE(memchr(name, '/', namelen))) return true;

... but then readdir() won't indicate to userspace that the kernel
omitted a (bad) directory entry. A cleaner way might be to patch all
the ->actor handlers to do the check and propagate the error
appropriately, but then the checks would have to be placed in more
places... which also doesn't seem very clean.

Al, you probably have opinions on this?
