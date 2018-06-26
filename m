Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83903C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4724826A66
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4724826A66
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935260AbeFZMU4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 08:20:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49218 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933823AbeFZMUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 08:20:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3D91430820F4;
        Tue, 26 Jun 2018 12:20:53 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F5FB7EE7C;
        Tue, 26 Jun 2018 12:20:53 +0000 (UTC)
Received: from zmail23.collab.prod.int.phx2.redhat.com (zmail23.collab.prod.int.phx2.redhat.com [10.5.83.28])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id A552C4BB78;
        Tue, 26 Jun 2018 12:20:52 +0000 (UTC)
Date:   Tue, 26 Jun 2018 08:20:52 -0400 (EDT)
From:   Chunyu Hu <chuhu@redhat.com>
Reply-To: Chunyu Hu <chuhu@redhat.com>
To:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org
Message-ID: <1113263100.13594710.1530015652549.JavaMail.zimbra@redhat.com>
In-Reply-To: <20180611062354.GA32641@lst.de>
References: <1528573884-9133-1-git-send-email-chuhu@redhat.com> <20180611062354.GA32641@lst.de>
Subject: Re: [PATCH] proc: add proc_seq_release
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.68.5.41, 10.4.195.29]
Thread-Topic: proc: add proc_seq_release
Thread-Index: vbxOw6lDQSrIXGETAu5l3gKdnHGdHQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 26 Jun 2018 12:20:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- Original Message -----
> From: "Christoph Hellwig" <hch@lst.de>
> To: "Chunyu Hu" <chuhu@redhat.com>
> Cc: viro@zeniv.linux.org.uk, hch@lst.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
> Sent: Monday, June 11, 2018 2:23:54 PM
> Subject: Re: [PATCH] proc: add proc_seq_release
> 
> On Sun, Jun 10, 2018 at 03:51:24AM +0800, Chunyu Hu wrote:
> > kmemleak reported some memory leak on reading proc files. After adding
> > some debug lines, find that proc_seq_fops is using seq_release as
> > release handler, which won't handle the free of 'private' field of
> > seq_file, while in fact the open handler proc_seq_open could create
> > the private data with __seq_open_private when state_size is greater
> > than zero. So after reading files created with proc_create_seq_private,
> > such as /proc/timer_list and /proc/vmallocinfo, the private mem of a
> > seq_file is not freed. Fix it by adding the paired proc_seq_release
> > as the default release handler of proc_seq_ops instead of seq_release.
> 
> Indeed, thanks for the patch.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 

What's our plan for this issue? We can still see the leaking in 4.18-RC2. 

1) Run 'cat /proc/timer_list' then
2) echo scan > /sys/kernel/debug/kmemleak
3) cat /sys/kernel/debug/kmemleak

each time, it leaks 16 bytes.

unreferenced object 0xffff880017525120 (size 16):
  comm "cat", pid 4682, jiffies 4294964743 (age 46.880s)
  hex dump (first 16 bytes):
    04 00 00 00 01 00 00 00 42 00 96 e7 3f 00 00 00  ........B...?...
  backtrace:
    [<000000006f6b5d90>] seq_open_private+0x25/0x40
    [<00000000d94d91aa>] proc_seq_open+0xca/0x120
    [<00000000d5609077>] proc_reg_open+0x1d4/0x5b0
    [<0000000036a3d49c>] do_dentry_open+0x7d6/0x1010
    [<00000000d4fb0a82>] vfs_open+0x170/0x2b0
    [<00000000f3bf21b4>] path_openat+0x760/0x3750
    [<00000000b0d4e66c>] do_filp_open+0x1bb/0x2c0
    [<0000000063b53236>] do_sys_open+0x2b2/0x490
    [<00000000a5249c62>] do_syscall_64+0xd3/0x6e0
    [<000000006f9f8436>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
    [<000000001d702cb2>] 0xffffffffffffffff


-- 
Regards,
Chunyu Hu

