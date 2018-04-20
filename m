Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752658AbeDTTqd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 15:46:33 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33861 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750985AbeDTTqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 15:46:32 -0400
X-Google-Smtp-Source: AIpwx495QwV0k3eKxgs1+GVU8EpB33v0BkWx+0YFen2hSDh7O76a4I1Aoq9W+Va0FYVV6hrU2x4LWQ==
Date: Fri, 20 Apr 2018 22:46:28 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] proc: simpler iterations for /proc/*/cmdline
Message-ID: <20180420194628.GB3003@avx2>
References: <20180221192339.GA28548@avx2>
 <20180221192605.GB28548@avx2>
 <20180221192751.GC28548@avx2>
 <20180221193009.GA28678@avx2>
 <20180419171520.444c0e9736b6a020fb6b3b7f@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180419171520.444c0e9736b6a020fb6b3b7f@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 05:15:20PM -0700, Andrew Morton wrote:
> On Wed, 21 Feb 2018 22:30:09 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > "rv" variable is used both as a counter of bytes transferred and
> > an error value holder but it can be reduced solely to error values
> > if original start of userspace buffer is stashed and used at the very
> > end.
> > 
> > ...
> >
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> >
> > ...
> >
> > @@ -371,12 +365,16 @@ static ssize_t proc_pid_cmdline_read(struct file *file, char __user *buf,
> >  		}
> >  	}
> >  
> > +end:
> > +	free_page((unsigned long)page);
> > +	mmput(mm);
> > +	*pos += buf - buf0;
> > +	return buf - buf0;
> > +
> >  out_free_page:
> >  	free_page((unsigned long)page);
> >  out_mmput:
> >  	mmput(mm);
> > -	if (rv > 0)
> > -		*pos += rv;
> >  	return rv;
> >  }
> 
> (scratches head).  Why not do this?
> 
> --- a/fs/proc/base.c~proc-simpler-iterations-for-proc-cmdline-fix
> +++ a/fs/proc/base.c
> @@ -363,11 +363,8 @@ static ssize_t proc_pid_cmdline_read(str
>  	}
>  
>  end:
> -	free_page((unsigned long)page);
> -	mmput(mm);
>  	*pos += buf - buf0;
> -	return buf - buf0;
> -
> +	rv = buf - buf0;
>  out_free_page:
>  	free_page((unsigned long)page);
>  out_mmput:
> 
> (and maybe rv should be ssize_t)

It should as cmdline area can be set to arbitrary values.

I hate ssize_t and it's bloat.

	$ ./scripts/bloat-o-meter ../vmlinux-000 ../obj/vmlinux
	add/remove: 0/0 grow/shrink: 1/0 up/down: 11/0 (11)
	Function                                     old     new   delta
	proc_pid_cmdline_read                        867     878     +11
