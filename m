Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43110C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 06:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F347B248E2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 06:59:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F347B248E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753303AbeF0G7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 02:59:38 -0400
Received: from verein.lst.de ([213.95.11.211]:49083 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752460AbeF0G7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 02:59:37 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id B962A68E45; Wed, 27 Jun 2018 09:09:40 +0200 (CEST)
Date:   Wed, 27 Jun 2018 09:09:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     viro@zeniv.linux.org.uk, Chunyu Hu <chuhu@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: add proc_seq_release
Message-ID: <20180627070940.GA9790@lst.de>
References: <1528573884-9133-1-git-send-email-chuhu@redhat.com> <20180611062354.GA32641@lst.de> <1113263100.13594710.1530015652549.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113263100.13594710.1530015652549.JavaMail.zimbra@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al, can you pick up this fix from Chunyu?

On Tue, Jun 26, 2018 at 08:20:52AM -0400, Chunyu Hu wrote:
> 
> 
> ----- Original Message -----
> > From: "Christoph Hellwig" <hch@lst.de>
> > To: "Chunyu Hu" <chuhu@redhat.com>
> > Cc: viro@zeniv.linux.org.uk, hch@lst.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
> > Sent: Monday, June 11, 2018 2:23:54 PM
> > Subject: Re: [PATCH] proc: add proc_seq_release
> > 
> > On Sun, Jun 10, 2018 at 03:51:24AM +0800, Chunyu Hu wrote:
> > > kmemleak reported some memory leak on reading proc files. After adding
> > > some debug lines, find that proc_seq_fops is using seq_release as
> > > release handler, which won't handle the free of 'private' field of
> > > seq_file, while in fact the open handler proc_seq_open could create
> > > the private data with __seq_open_private when state_size is greater
> > > than zero. So after reading files created with proc_create_seq_private,
> > > such as /proc/timer_list and /proc/vmallocinfo, the private mem of a
> > > seq_file is not freed. Fix it by adding the paired proc_seq_release
> > > as the default release handler of proc_seq_ops instead of seq_release.
> > 
> > Indeed, thanks for the patch.
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > 
> 
> What's our plan for this issue? We can still see the leaking in 4.18-RC2. 
> 
> 1) Run 'cat /proc/timer_list' then
> 2) echo scan > /sys/kernel/debug/kmemleak
> 3) cat /sys/kernel/debug/kmemleak
> 
> each time, it leaks 16 bytes.
> 
> unreferenced object 0xffff880017525120 (size 16):
>   comm "cat", pid 4682, jiffies 4294964743 (age 46.880s)
>   hex dump (first 16 bytes):
>     04 00 00 00 01 00 00 00 42 00 96 e7 3f 00 00 00  ........B...?...
>   backtrace:
>     [<000000006f6b5d90>] seq_open_private+0x25/0x40
>     [<00000000d94d91aa>] proc_seq_open+0xca/0x120
>     [<00000000d5609077>] proc_reg_open+0x1d4/0x5b0
>     [<0000000036a3d49c>] do_dentry_open+0x7d6/0x1010
>     [<00000000d4fb0a82>] vfs_open+0x170/0x2b0
>     [<00000000f3bf21b4>] path_openat+0x760/0x3750
>     [<00000000b0d4e66c>] do_filp_open+0x1bb/0x2c0
>     [<0000000063b53236>] do_sys_open+0x2b2/0x490
>     [<00000000a5249c62>] do_syscall_64+0xd3/0x6e0
>     [<000000006f9f8436>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
>     [<000000001d702cb2>] 0xffffffffffffffff
> 
> 
> -- 
> Regards,
> Chunyu Hu
---end quoted text---
