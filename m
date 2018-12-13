Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA07C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB5A32080F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:58:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB5A32080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbeLMG6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 01:58:38 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:40516 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbeLMG6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 01:58:37 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gXKx0-0006KL-8m; Thu, 13 Dec 2018 06:58:26 +0000
Date:   Thu, 13 Dec 2018 06:58:26 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ivan Delalande <colona@arista.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc/sysctl: don't return ENOMEM on lookup when a table
 is unregistering
Message-ID: <20181213065826.GL2217@ZenIV.linux.org.uk>
References: <20181213015742.GA28776@visor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213015742.GA28776@visor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 05:57:43PM -0800, Ivan Delalande wrote:
> proc_sys_lookup can fail with ENOMEM instead of ENOENT when the
> corresponding sysctl table is being unregistered. In our case we see
> this upon opening /proc/sys/net/*/conf files while network interfaces
> are being removed, which confuses our configuration daemon.
> 
> The problem was successfully reproduced and this fix tested on v4.9.122
> and v4.20-rc6.
> 
> Fixes: ace0c791e6c3 ("proc/sysctl: Don't grab i_lock under sysctl_lock.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ivan Delalande <colona@arista.com>
> ---
>  fs/proc/proc_sysctl.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index 89921a0d2ebb..834be5bc3d07 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -474,7 +474,7 @@ static struct inode *proc_sys_make_inode(struct super_block *sb,
>  	if (unlikely(head->unregistering)) {
>  		spin_unlock(&sysctl_lock);
>  		iput(inode);
> -		inode = NULL;
> +		inode = ERR_PTR(-ENOENT);
>  		goto out;
>  	}
>  	ei->sysctl = head;
> @@ -549,10 +549,11 @@ static struct dentry *proc_sys_lookup(struct inode *dir, struct dentry *dentry,
>  			goto out;
>  	}
>  
> -	err = ERR_PTR(-ENOMEM);
>  	inode = proc_sys_make_inode(dir->i_sb, h ? h : head, p);
> -	if (!inode)
> +	if (IS_ERR_OR_NULL(inode)) {
> +		err = inode ? ERR_CAST(inode) : ERR_PTR(-ENOMEM);

*gags*

If you want to return specific errors, do just that and for pity sake,
do *NOT* invent such hybrids.  "Pointer to object on success,
ERR_PTR(-E...) on failure, NULL means ERR_PTR(-ENOMEM)" is a bitch to
reason about and prone to breakage.

"Return NULL on error" and "return ERR_PTR() on error" do not mix.
Just make proc_sys_make_inode() return ERR_PTR(-ENOMEM) on allocation
failures and update the callers (as you have to, anyway).

IS_ERR_OR_NULL() is usually a sign of bad calling conventions and it
certainly is just that in this case.

Just do
        inode = new_inode(sb);
        if (!inode)
                return ERR_PTR(-ENOMEM);
in there, in addition to your return of ERR_PTR(-ENOENT), and lose those
IS_ERR_OR_NULL() things.  Make those IS_ERR() and turn the assignment
to err into straight ERR_CAST().  All there is to it...

