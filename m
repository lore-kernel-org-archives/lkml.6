Return-Path: <opensource.ganesh@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522372916; cv=none;
        d=google.com; s=arc-20160816;
        b=dViGcr3XGepfEZm8RTtvCsA6uZkUC/OEWrjtB8zNIZX9fkwNwxX+F48NlA/TvhefUJ
         t26Ehbvm84sIXnpgD8nbJJl0SkojcujAe41pvMzIYq1JVN/N0eESmMqY66RwNLsZsCEf
         WLa45o+kMu9GY6i+ZYnVnwVdkXdrzoj9/iFTwfUvZBxLvVaxYU/tDbXkkV2bz6BIxhle
         dCUCqnbJGcOLmJZl7qcW3onLd7739TYBzWqo6GCvL8LObpGQaZk/4ADFOMuK3UGv04pU
         F0r+TFgTma7v23hifEKJlmjPm2APWS1WDSblfJoHWgS1/7muyky4pr2hwHmFanLfMzqH
         Kcaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature
         :arc-authentication-results;
        bh=DfDwSFT92W0uDHRkSOpHnaHbYPu2+zy8XVfW+rnmczo=;
        b=KHphfwhrBBtV6U3DFHUTJayoT76mkE16B1UCHfKMBamLLBHLCZUoWqa/z9zfB3m3Co
         SDiti9YzGIV7jx3LHMap5etEUrKbY+JZj9l4P8AGxhm6M8ZvRXjsxW+0Q3/SV5OZqfIl
         5Njpoq3afDSyIJRAnLv4rNcal9V7+xaK4Edhh2WToL6YgY5vID9i5FU3hKsXf+zeoYJT
         wGXqXSN8KkST1DnelC1XCqxqI91jaGqssiIRBcRWnRY6iKRiNVm3EDH/WudCswHApb9s
         pSHBNakcrOVzS4Ef6dXr6OCxK0CL2a+GFpn3LDcIOF0vLekREdEijsBH/TsurzGg5jSg
         1Aog==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=iChwHZ/P;
       spf=pass (google.com: domain of opensource.ganesh@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=opensource.ganesh@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=iChwHZ/P;
       spf=pass (google.com: domain of opensource.ganesh@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=opensource.ganesh@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx48UBzTz3VIKfwGaE/yMT4piFt2++eoAYLqYW0MsLq3ki15AzR2h+x9WGBwa4c8kMvFvTkWLxS7szLDEMIpIkYM=
MIME-Version: 1.0
In-Reply-To: <20180329065424.203172-1-minchan@kernel.org>
References: <20180329065424.203172-1-minchan@kernel.org>
From: Ganesh Mahendran <opensource.ganesh@gmail.com>
Date: Fri, 30 Mar 2018 09:21:55 +0800
Message-ID: <CADAEsF8Y2CJsuom=9au0-uvZAALvrLTdTnrkxrGjW9C9F6hTVg@mail.gmail.com>
Subject: Re: [PATCH v5] ANDROID: binder: change down_write to down_read
To: Minchan Kim <minchan@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Joe Perches <joe@perches.com>,
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
	Todd Kjos <tkjos@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Martijn Coenen <maco@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596254032587353794?=
X-GMAIL-MSGID: =?utf-8?q?1596323703352773024?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-03-29 14:54 GMT+08:00 Minchan Kim <minchan@kernel.org>:
> binder_update_page_range needs down_write of mmap_sem because
> vm_insert_page need to change vma->vm_flags to VM_MIXEDMAP unless
> it is set. However, when I profile binder working, it seems
> every binder buffers should be mapped in advance by binder_mmap.
> It means we could set VM_MIXEDMAP in binder_mmap time which is
> already hold a mmap_sem as down_write so binder_update_page_range
> doesn't need to hold a mmap_sem as down_write.
>
> Android suffers from mmap_sem contention so let's reduce mmap_sem
> down_write.

Hi, Minchan:

It seems there is performance regression of this patch.

Do you have some test result of android app launch time or binderThroughput=
?

Thanks.
>
> Cc: Joe Perches <joe@perches.com>
> Cc: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Martijn Coenen <maco@android.com>
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
> From v4:
>   * Fix typo and VM flags clear handling - Joe
>
> From v3:
>   * Fix typo
>
> From v2:
>   * Fix vma->flag setting - Arve
>
> From v1:
>   * remove WARN_ON_ONCE - Greg
>   * add reviewed-by - Martijn
>
> Martijn, I took your LGTM of v1 as Reviewed-by. If you don't like it
> or want to change it to acked-by, please, tell me.
>
>  drivers/android/binder.c       | 4 +++-
>  drivers/android/binder_alloc.c | 6 +++---
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 764b63a5aade..bb63e3b54e0c 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -4722,7 +4722,9 @@ static int binder_mmap(struct file *filp, struct vm=
_area_struct *vma)
>                 failure_string =3D "bad vm_flags";
>                 goto err_bad_arg;
>         }
> -       vma->vm_flags =3D (vma->vm_flags | VM_DONTCOPY) & ~VM_MAYWRITE;
> +       vma->vm_flags |=3D VM_DONTCOPY | VM_MIXEDMAP;
> +       vma->vm_flags &=3D ~VM_MAYWRITE;
> +
>         vma->vm_ops =3D &binder_vm_ops;
>         vma->vm_private_data =3D proc;
>
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_allo=
c.c
> index 5a426c877dfb..4f382d51def1 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -219,7 +219,7 @@ static int binder_update_page_range(struct binder_all=
oc *alloc, int allocate,
>                 mm =3D alloc->vma_vm_mm;
>
>         if (mm) {
> -               down_write(&mm->mmap_sem);
> +               down_read(&mm->mmap_sem);
>                 vma =3D alloc->vma;
>         }
>
> @@ -288,7 +288,7 @@ static int binder_update_page_range(struct binder_all=
oc *alloc, int allocate,
>                 /* vm_insert_page does not seem to increment the refcount=
 */
>         }
>         if (mm) {
> -               up_write(&mm->mmap_sem);
> +               up_read(&mm->mmap_sem);
>                 mmput(mm);
>         }
>         return 0;
> @@ -321,7 +321,7 @@ static int binder_update_page_range(struct binder_all=
oc *alloc, int allocate,
>         }
>  err_no_vma:
>         if (mm) {
> -               up_write(&mm->mmap_sem);
> +               up_read(&mm->mmap_sem);
>                 mmput(mm);
>         }
>         return vma ? -ENOMEM : -ESRCH;
> --
> 2.17.0.rc1.321.gba9d0f2565-goog
>
