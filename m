Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDF5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 05:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A3E217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 05:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfBSFsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 00:48:13 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:58718 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfBSFsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 00:48:13 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gvyGG-00086D-0y; Tue, 19 Feb 2019 05:48:08 +0000
Date:   Tue, 19 Feb 2019 05:48:07 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Matej Kupljen <matej.kupljen@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] tmpfs: fix link accounting when a tmpfile is linked in
Message-ID: <20190219054807.GX2217@ZenIV.linux.org.uk>
References: <alpine.LSU.2.11.1902182134370.7035@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.1902182134370.7035@eggly.anvils>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 09:37:52PM -0800, Hugh Dickins wrote:
> From: "Darrick J. Wong" <darrick.wong@oracle.com>
> 
> tmpfs has a peculiarity of accounting hard links as if they were separate
> inodes: so that when the number of inodes is limited, as it is by default,
> a user cannot soak up an unlimited amount of unreclaimable dcache memory
> just by repeatedly linking a file.
> 
> But when v3.11 added O_TMPFILE, and the ability to use linkat() on the fd,
> we missed accommodating this new case in tmpfs: "df -i" shows that an
> extra "inode" remains accounted after the file is unlinked and the fd
> closed and the actual inode evicted.  If a user repeatedly links tmpfiles
> into a tmpfs, the limit will be hit (ENOSPC) even after they are deleted.
> 
> Just skip the extra reservation from shmem_link() in this case: there's
> a sense in which this first link of a tmpfile is then cheaper than a
> hard link of another file, but the accounting works out, and there's
> still good limiting, so no need to do anything more complicated.
> 
> Fixes: f4e0c30c191 ("allow the temp files created by open() to be linked to")
> Reported-by: Matej Kupljen <matej.kupljen@gmail.com>
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> Signed-off-by: Hugh Dickins <hughd@google.com>

FWIW, Acked-by: Al Viro <viro@zeniv.linux.org.uk>

Or I can drop it into vfs.git - up to you.
