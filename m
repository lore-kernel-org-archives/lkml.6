Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id F51FA3mnHFt7egAAmS7hNA
	; Sun, 10 Jun 2018 05:25:32 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5E39C60791; Sun, 10 Jun 2018 05:25:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DD2DF600D0;
	Sun, 10 Jun 2018 05:25:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DD2DF600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753708AbeFJFZ1 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 01:25:27 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:54080 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753539AbeFJFZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 01:25:26 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fRsqZ-0003S7-G0; Sun, 10 Jun 2018 05:25:06 +0000
Date: Sun, 10 Jun 2018 06:24:59 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/39] ovl: add ovl_mmap()
Message-ID: <20180610052447.GN30522@ZenIV.linux.org.uk>
References: <20180529144339.16538-1-mszeredi@redhat.com>
 <20180529144339.16538-20-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529144339.16538-20-mszeredi@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 04:43:19PM +0200, Miklos Szeredi wrote:
> Implement stacked mmap.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/overlayfs/file.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index 7b47dce4b072..4057bbf2e141 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -255,6 +255,33 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
>  	return ret;
>  }
>  
> +static int ovl_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +	struct fd real;
> +	const struct cred *old_cred;
> +	int ret;
> +
> +	ret = ovl_real_fdget(file, &real);
> +	if (ret)
> +		return ret;
> +
> +	/* transfer ref: */
> +	fput(vma->vm_file);
> +	vma->vm_file = get_file(real.file);
> +	fdput(real);
> +
> +	if (!vma->vm_file->f_op->mmap)
> +		return -ENODEV;

That's broken.  ->mmap() failure will fput(file), not fput(vma->vm_file).
What's more, _here_ your "corner case" is a huge DoS - open file r/o,
then have somebody else trigger copyup, then do tons of MAP_PRIVATE
mmaps on the r/o descriptor.  *EACH* *OF* *THEM* will open a separate
struct file and stash into into new vmas.

NAK with extreme prejudice, sensu PTerry...
