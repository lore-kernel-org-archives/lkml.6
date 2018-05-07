Return-Path: <joel@joelfernandes.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525714111; cv=none;
        d=google.com; s=arc-20160816;
        b=iW/ITyfm+Op+HyJgRpDB4mqytTat2gqP/MhjqwaQIDcsYlEBOWyeT6r2yKxhSVWzFo
         tmCQhw8u76lGDaLx0YbIwlVDr8GjpcPQ5oTv7xkRyGzi1tsz2fYPRFKS0mHPnVQGIDey
         NgRg2nxIll9AC2qcZ/ETa0JjqjEF6tq25EnRzdEDymmvqAjp+nG4WP1OVLU16eQS6rpN
         m4qaKWTRl23xWpMB8BhvgYrinrsebbqwYUiavLcdGYYeaEW/0agJ/viubWadTObN6a4k
         5IBBzKeknrnfwoTf3LNmKwDEBbmxqV6T4d8DNcNZ3jiAglAnwFuDPA/IGDRA9Gk+l6au
         gBww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=Y41PRU7Q9HRGUiur9BnwHZ6cqOn3i+qi5Fj72ftjwFU=;
        b=CV/mRVNGkn1A8LOkbXvSWbwrAOgy+IwepSE5ePf2CjdLu6dgkRnKWIjOop4g/sJM0T
         mTT6bOcNtJZQKeGJ2f3MH9oVhsOE9L/nk9he2wunM21kUh95J3Cwha52CbSKRLUxNlrJ
         mO4J9v5FxnrQY1XOIZobZ8K4u6XN9vRISywRMQsY4/cRvnKDcUYQIw5hrexe7Ac3x2dE
         HVtdWmagDTueeM2HjYRkSNhjs9qgL9Cj5P5SUdb/ge7n+to1EjZCjDlGOoz1kyXih+5t
         3EU8Jl9yT2leYWJNiD8wv8wUcIMSxT6zHZCSGNEs8rrrh9qBJKrE6RKHbKjzhw0smFeG
         0DJw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@joelfernandes-org.20150623.gappssmtp.com header.s=20150623 header.b=eIj4h7l2;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of joel@joelfernandes.org) smtp.mailfrom=joel@joelfernandes.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@joelfernandes-org.20150623.gappssmtp.com header.s=20150623 header.b=eIj4h7l2;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of joel@joelfernandes.org) smtp.mailfrom=joel@joelfernandes.org
X-Google-Smtp-Source: AB8JxZrAh64C5SZLfbc+LckXA6W6RWO2x4Nn/CJWjCFmuYielsJFC/YMphG2BZSyHHgVcVXX9d7LAQ==
Date: Mon, 7 May 2018 10:28:29 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: Minchan Kim <minchan@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Ganesh Mahendran <opensource.ganesh@gmail.com>,
	Joe Perches <joe@perches.com>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Martijn Coenen <maco@android.com>
Subject: Re: [PATCH v6] ANDROID: binder: change down_write to down_read
Message-ID: <20180507172829.GA66161@joelaf.mtv.corp.google.com>
References: <20180507141537.4855-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180507141537.4855-1-minchan@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599815073448562806?=
X-GMAIL-MSGID: =?utf-8?q?1599827199854038577?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 07, 2018 at 11:15:37PM +0900, Minchan Kim wrote:
> binder_update_page_range needs down_write of mmap_sem because
> vm_insert_page need to change vma->vm_flags to VM_MIXEDMAP unless
> it is set. However, when I profile binder working, it seems
> every binder buffers should be mapped in advance by binder_mmap.
> It means we could set VM_MIXEDMAP in binder_mmap time which is
> already hold a mmap_sem as down_write so binder_update_page_range
> doesn't need to hold a mmap_sem as down_write.
> Please use proper API down_read. It would help mmap_sem contention
> problem as well as fixing down_write abuse.
> 
> Ganesh Mahendran tested app launching and binder throughput test
> and he said he couldn't find any problem and I did binder latency
> test per Greg KH request(Thanks Martijn to teach me how I can do)
> I cannot find any problem, too.
> 
> Cc: Ganesh Mahendran <opensource.ganesh@gmail.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: Arve Hjønnevåg <arve@android.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Martijn Coenen <maco@android.com>
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>  drivers/android/binder.c       | 4 +++-
>  drivers/android/binder_alloc.c | 6 +++---
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 4eab5be3d00f..7b8e96f60719 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -4730,7 +4730,9 @@ static int binder_mmap(struct file *filp, struct vm_area_struct *vma)
>  		failure_string = "bad vm_flags";
>  		goto err_bad_arg;
>  	}
> -	vma->vm_flags = (vma->vm_flags | VM_DONTCOPY) & ~VM_MAYWRITE;
> +	vma->vm_flags |= VM_DONTCOPY | VM_MIXEDMAP;
> +	vma->vm_flags &= ~VM_MAYWRITE;
> +
>  	vma->vm_ops = &binder_vm_ops;
>  	vma->vm_private_data = proc;
>  
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index 5a426c877dfb..4f382d51def1 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -219,7 +219,7 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
>  		mm = alloc->vma_vm_mm;
>  
>  	if (mm) {
> -		down_write(&mm->mmap_sem);
> +		down_read(&mm->mmap_sem);


Nice. Is there a need to hold the reader-lock at all here? Just curious what
else is it protecting (here or in vm_insert_page).

Otherwise looks good to me:
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

- Joel
