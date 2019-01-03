Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F54C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 08:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B7221479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 08:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730311AbfACIsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 03:48:16 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:48786 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfACIsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 03:48:16 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1geyfi-0002zp-9W; Thu, 03 Jan 2019 08:48:10 +0000
Date:   Thu, 3 Jan 2019 08:48:10 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Sahitya Tummala <stummala@codeaurora.org>
Cc:     Junxiao Bi <junxiao.bi@oracle.com>,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] configfs: Fix use-after-free when accessing sd->s_dentry
Message-ID: <20190103084810.GK2217@ZenIV.linux.org.uk>
References: <1546503064-12695-1-git-send-email-stummala@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546503064-12695-1-git-send-email-stummala@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 01:41:04PM +0530, Sahitya Tummala wrote:
> In the vfs_statx() context, during path lookup, the dentry gets
> added to sd->s_dentry via configfs_attach_attr(). In the end,
> vfs_statx() kills the dentry by calling path_put(), which invokes
> configfs_d_iput(). Ideally, this dentry must be removed from
> sd->s_dentry but it doesn't if the sd->s_count >= 3. As a result,
> sd->s_dentry is holding reference to a stale dentry pointer whose
> memory is already freed up. This results in use-after-free issue,
> when this stale sd->s_dentry is accessed later in
> configfs_readdir() path.
> 
> This issue can be easily reproduced, by running the LTP test case -
> sh fs_racer_file_list.sh /config
> (https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/fs/racer/fs_racer_file_list.sh)
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> ---
>  fs/configfs/dir.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
> index 39843fa..a5906c5 100644
> --- a/fs/configfs/dir.c
> +++ b/fs/configfs/dir.c
> @@ -66,7 +66,7 @@ static void configfs_d_iput(struct dentry * dentry,
>  		 * configfs_attach_attr and set sd->s_dentry to null
>  		 * even it's still in use.
>  		 */
> -		if (atomic_read(&sd->s_count) <= 2)
> +		if (sd->s_dentry == dentry)
>  			sd->s_dentry = NULL;
>  
>  		spin_unlock(&configfs_dirent_lock);

Please, update the comment above as well - it refers the increment of
sd->s_count, which becomes stale.  I agree that the problem is real
and the fix is sane (and that's what should've been done in the first
place, back in "configfs: fix race between dentry put and lookup",
which has introduced that logics).
