Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C725EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 23:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 945E320824
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 23:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 945E320824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbeKXKPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 05:15:37 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:42850 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbeKXKPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 05:15:37 -0500
Received: from localhost.localdomain (c-24-6-170-16.hsd1.ca.comcast.net [24.6.170.16])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4146C723;
        Fri, 23 Nov 2018 23:29:23 +0000 (UTC)
Date:   Fri, 23 Nov 2018 15:29:22 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ian Kent <raven@themaw.net>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] autofs - improve ioctl sbi checks
Message-Id: <20181123152922.de3ed41c5b97ac84eaa22846@linux-foundation.org>
In-Reply-To: <154296970987.9889.1597442413573683096.stgit@pluto-themaw-net>
References: <154296962626.9889.644199825100770992.stgit@pluto-themaw-net>
        <154296970987.9889.1597442413573683096.stgit@pluto-themaw-net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Nov 2018 18:41:50 +0800 Ian Kent <raven@themaw.net> wrote:

> Al Viro made some suggestions to improve the implementation
> of commit 0633da48f0 "fix autofs_sbi() does not check super
> block type".
> 
> The check is unnessesary in all cases except for ioctl usage
> so placing the check in the super block accessor function
> adds a small overhead to the common case where it isn't
> needed.
> 
> So it's sufficient to do this in the ioctl code only.
> 
> Also the check in the ioctl code is needlessly complex.
>
> ...
>
> --- a/fs/autofs/dev-ioctl.c
> +++ b/fs/autofs/dev-ioctl.c
> @@ -14,6 +14,8 @@
>  
>  #include "autofs_i.h"
>  
> +extern struct file_system_type autofs_fs_type;
> +
>  /*
>   * This module implements an interface for routing autofs ioctl control
>   * commands via a miscellaneous device file.

It's naughty to declare externs in C files, for various reasons.  Is
this OK?

--- a/fs/autofs/autofs_i.h~autofs-improve-ioctl-sbi-checks-fix
+++ a/fs/autofs/autofs_i.h
@@ -42,6 +42,8 @@
 #endif
 #define pr_fmt(fmt) KBUILD_MODNAME ":pid:%d:%s: " fmt, current->pid, __func__
 
+extern struct file_system_type autofs_fs_type;
+
 /*
  * Unified info structure.  This is pointed to by both the dentry and
  * inode structures.  Each file in the filesystem has an instance of this
--- a/fs/autofs/dev-ioctl.c~autofs-improve-ioctl-sbi-checks-fix
+++ a/fs/autofs/dev-ioctl.c
@@ -14,8 +14,6 @@
 
 #include "autofs_i.h"
 
-extern struct file_system_type autofs_fs_type;
-
 /*
  * This module implements an interface for routing autofs ioctl control
  * commands via a miscellaneous device file.
_

