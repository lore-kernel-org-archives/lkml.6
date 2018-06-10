Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 8Au8H+m3HFt6RAAAmS7hNA
	; Sun, 10 Jun 2018 05:32:25 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5ECD660795; Sun, 10 Jun 2018 05:32:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id ECA826074D;
	Sun, 10 Jun 2018 05:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ECA826074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753750AbeFJFcW (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 01:32:22 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:54174 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753484AbeFJFcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 01:32:20 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fRsx4-0003eW-AM; Sun, 10 Jun 2018 05:31:58 +0000
Date: Sun, 10 Jun 2018 06:31:42 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 23/39] ovl: add O_DIRECT support
Message-ID: <20180610053128.GO30522@ZenIV.linux.org.uk>
References: <20180529144339.16538-1-mszeredi@redhat.com>
 <20180529144339.16538-24-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529144339.16538-24-mszeredi@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 04:43:23PM +0200, Miklos Szeredi wrote:
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/overlayfs/file.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index 3f610a5b38e4..e5e7ccaaf9ec 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -110,6 +110,9 @@ static int ovl_open(struct inode *inode, struct file *file)
>  	if (IS_ERR(realfile))
>  		return PTR_ERR(realfile);
>  
> +	/* For O_DIRECT dentry_open() checks f_mapping->a_ops->direct_IO */
> +	file->f_mapping = realfile->f_mapping;

Umm...  What happens if upper layer doesn't allow O_DIRECT, while the lower one does?
