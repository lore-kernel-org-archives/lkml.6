Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756271AbeDXGRG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 02:17:06 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35433 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755165AbeDXGRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 02:17:04 -0400
X-Google-Smtp-Source: AB8JxZoQvz7Ddkco6f33mT/gTITJZ3SR0gk2Z13AcnlZTl1M3s03BI/RSS9btZ3fumUCV2YEk4Lv1g==
Date: Tue, 24 Apr 2018 09:17:00 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: jeffm@suse.com
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC] [PATCH 0/5] procfs: reduce duplication by using symlinks
Message-ID: <20180424061700.GA3689@avx2>
References: <20180424022106.16952-1-jeffm@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180424022106.16952-1-jeffm@suse.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 10:21:01PM -0400, jeffm@suse.com wrote:
> Memory pressure isn't really an issue on this machine, so we
> end up using well over 100GB for proc files.

Text files at scale!

> With these patches applied, running the same testcase, the proc_inode
> cache only gets to about 600k objects, which is about 99.7% fewer.  I
> get that procfs isn't supposed to be scalable, but this is kind of
> extreme. :)

Easy stuff:
* all ->get_link hooks are broken in RCU lookup (use GFP_KERNEL),
* "%.*s" for dentry names is probably unnecessary,
  they're always NUL terminated
* kasprintf() does printing twice, since we're kind of care about /proc
  performance, allocate for the worst case.

* "int nlinks = nlink_tgid;"
  Unsigned police.

* (inode->i_mode & S_IFLNK)
	this is sketchy, S_ISLNK exists.
