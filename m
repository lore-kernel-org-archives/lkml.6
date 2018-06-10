Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id nv8bIJmnHFtOeQAAmS7hNA
	; Sun, 10 Jun 2018 04:41:35 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9C75360795; Sun, 10 Jun 2018 04:41:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 32E636074D;
	Sun, 10 Jun 2018 04:41:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 32E636074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753672AbeFJEld (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 00:41:33 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53596 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751292AbeFJElc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 00:41:32 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fRsA7-0002Vu-OX; Sun, 10 Jun 2018 04:41:16 +0000
Date: Sun, 10 Jun 2018 05:41:07 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/39] vfs: optionally don't account file in nr_files
Message-ID: <20180610044050.GL30522@ZenIV.linux.org.uk>
References: <20180529144339.16538-1-mszeredi@redhat.com>
 <20180529144339.16538-6-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529144339.16538-6-mszeredi@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 04:43:05PM +0200, Miklos Szeredi wrote:
> +++ b/fs/open.c
> @@ -732,8 +732,8 @@ static int do_dentry_open(struct file *f,
>  	static const struct file_operations empty_fops = {};
>  	int error;
>  
> -	f->f_mode = OPEN_FMODE(f->f_flags) | FMODE_LSEEK |
> -				FMODE_PREAD | FMODE_PWRITE;
> +	f->f_mode = (f->f_mode & FMODE_NOACCOUNT) | OPEN_FMODE(f->f_flags) |
> +		FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE;

Why bother with this complexity?  I mean, why not simply
	f->f_mode |= OPEN_FMODE(f->f_flags) | FMODE_LSEEK |
				FMODE_PREAD | FMODE_PWRITE;

and be done with that...

> @@ -743,7 +743,7 @@ static int do_dentry_open(struct file *f,
>  	f->f_wb_err = filemap_sample_wb_err(f->f_mapping);
>  
>  	if (unlikely(f->f_flags & O_PATH)) {
> -		f->f_mode = FMODE_PATH;
> +		f->f_mode = (f->f_mode & FMODE_NOACCOUNT) | FMODE_PATH;

That makes no sense at all.  What would ever pass O_PATH opens
from "noaccount" call site?
