Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A5EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F16002084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731799AbeLQI2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 03:28:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:55858 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726692AbeLQI2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 03:28:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7197EAF03;
        Mon, 17 Dec 2018 08:28:02 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E7D341E1475; Mon, 17 Dec 2018 09:28:00 +0100 (CET)
Date:   Mon, 17 Dec 2018 09:28:00 +0100
From:   Jan Kara <jack@suse.cz>
To:     Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Horst Schirmeier <horst.schirmeier@tu-dortmund.de>
Subject: Re: [PATCH] Abort file_remove_privs() for non-reg. files
Message-ID: <20181217082800.GA28270@quack2.suse.cz>
References: <4903939e-d3d6-b0c2-9c33-0fea0a61213c@tu-dortmund.de>
 <20181207175811.GZ2217@ZenIV.linux.org.uk>
 <5c86e85f-0ad4-935a-3021-7046551f361f@tu-dortmund.de>
 <20181208004944.GA2217@ZenIV.linux.org.uk>
 <20181210094722.GB29289@quack2.suse.cz>
 <cbdc8071-de76-bb0a-6890-15ef21023a70@tu-dortmund.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbdc8071-de76-bb0a-6890-15ef21023a70@tu-dortmund.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 14-12-18 11:55:52, Alexander Lochmann wrote:
> 
> file_remove_privs() might be called for non-regular files, e.g.
> blkdev inode. There is no reason to do its job on things
> like blkdev inodes, pipes, or cdevs. Hence, abort if
> file does not refer to a regular inode.
> The following stacktrace shows how to get there:
> 13: entry_SYSENTER_32:460
> 12: do_fast_syscall_32:410
> 11: _static_cpu_has:146
> 10: do_syscall_32_irqs_on:322
> 09: SyS_pwrite64:636
> 08: SYSC_pwrite64:650
> 07: fdput:38
> 06: vfs_write:560
> 05: __vfs_write:512
> 04: new_sync_write:500
> 03: blkdev_write_iter:1977
> 02: __generic_file_write_iter:2897
> 01: file_remove_privs:1818
> 00: inode_has_no_xattr:3163
> 
> Found by LockDoc (Alexander Lochmann, Horst Schirmeier and Olaf
> Spinczyk)
> 
> Signed-off-by: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
> Signed-off-by: Horst Schirmeier <horst.schirmeier@tu-dortmund.de>

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/inode.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 35d2108d567c..682088190413 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1820,8 +1820,13 @@ int file_remove_privs(struct file *file)
>  	int kill;
>  	int error = 0;
> 
> -	/* Fast path for nothing security related */
> -	if (IS_NOSEC(inode))
> +	/*
> +	 * Fast path for nothing security related.
> +	 * As well for non-regular files, e.g. blkdev inodes.
> +	 * For example, blkdev_write_iter() might get here
> +	 * trying to remove privs which it is not allowed to.
> +	 */
> +	if (IS_NOSEC(inode) || !S_ISREG(inode->i_mode))
>  		return 0;
> 
>  	kill = dentry_needs_remove_privs(dentry);
> -- 
> 2.19.2
> 



-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
