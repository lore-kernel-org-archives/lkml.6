Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753941AbeDTAPW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 20:15:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55988 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753703AbeDTAPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 20:15:21 -0400
Date: Thu, 19 Apr 2018 17:15:20 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] proc: simpler iterations for /proc/*/cmdline
Message-Id: <20180419171520.444c0e9736b6a020fb6b3b7f@linux-foundation.org>
In-Reply-To: <20180221193009.GA28678@avx2>
References: <20180221192339.GA28548@avx2>
        <20180221192605.GB28548@avx2>
        <20180221192751.GC28548@avx2>
        <20180221193009.GA28678@avx2>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Feb 2018 22:30:09 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> "rv" variable is used both as a counter of bytes transferred and
> an error value holder but it can be reduced solely to error values
> if original start of userspace buffer is stashed and used at the very
> end.
> 
> ...
>
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
>
> ...
>
> @@ -371,12 +365,16 @@ static ssize_t proc_pid_cmdline_read(struct file *file, char __user *buf,
>  		}
>  	}
>  
> +end:
> +	free_page((unsigned long)page);
> +	mmput(mm);
> +	*pos += buf - buf0;
> +	return buf - buf0;
> +
>  out_free_page:
>  	free_page((unsigned long)page);
>  out_mmput:
>  	mmput(mm);
> -	if (rv > 0)
> -		*pos += rv;
>  	return rv;
>  }

(scratches head).  Why not do this?

--- a/fs/proc/base.c~proc-simpler-iterations-for-proc-cmdline-fix
+++ a/fs/proc/base.c
@@ -363,11 +363,8 @@ static ssize_t proc_pid_cmdline_read(str
 	}
 
 end:
-	free_page((unsigned long)page);
-	mmput(mm);
 	*pos += buf - buf0;
-	return buf - buf0;
-
+	rv = buf - buf0;
 out_free_page:
 	free_page((unsigned long)page);
 out_mmput:

(and maybe rv should be ssize_t)
