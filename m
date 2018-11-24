Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CEEC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 03:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75C1220868
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 03:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75C1220868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fieldses.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730945AbeKXOfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 09:35:43 -0500
Received: from fieldses.org ([173.255.197.46]:36688 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728450AbeKXOfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 09:35:43 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id 2111B2016; Fri, 23 Nov 2018 22:48:52 -0500 (EST)
Date:   Fri, 23 Nov 2018 22:48:52 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Pan Bian <bianpan2016@163.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] exportfs: do not read dentry after free
Message-ID: <20181124034852.GD7489@fieldses.org>
References: <1542959793-118334-1-git-send-email-bianpan2016@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542959793-118334-1-git-send-email-bianpan2016@163.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 03:56:33PM +0800, Pan Bian wrote:
> The function dentry_connected calls dput(dentry) to drop the previously
> acquired reference to dentry. In this case, dentry can be released.
> After that, IS_ROOT(dentry) checks the condition
> (dentry == dentry->d_parent), which may result in a use-after-free bug.
> This patch directly compares dentry with its parent obtained before
> dropping the reference.

Looks right to me, thanks.--b.

> 
> Fixes: a056cc8934c("exportfs: stop retrying once we race with
> rename/remove")
> 
> Signed-off-by: Pan Bian <bianpan2016@163.com>
> 
> ---
> V2: get rid of the comment
> 
> ---
>  fs/exportfs/expfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
> index 645158d..a69aaf5 100644
> --- a/fs/exportfs/expfs.c
> +++ b/fs/exportfs/expfs.c
> @@ -77,7 +77,7 @@ static bool dentry_connected(struct dentry *dentry)
>  		struct dentry *parent = dget_parent(dentry);
>  
>  		dput(dentry);
> -		if (IS_ROOT(dentry)) {
> +		if (dentry == parent) {
>  			dput(parent);
>  			return false;
>  		}
> -- 
> 2.7.4
> 
