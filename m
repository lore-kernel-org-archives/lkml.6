Return-Path: <arve@android.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522288782; cv=none;
        d=google.com; s=arc-20160816;
        b=U8tlX0uCQRDBkYvhfe8hPFWVjTCyK7kfKMSsmzwAaKgXGGUb+oI9r2uimhFZi5Kl/g
         tR6De3V8TrjoOwbGP8EsnhTM7JPty6EYfnf39ZJq7+Kiu4WcgHl8L8jt2Vd9Eyh20jcb
         0k++vVi0alDlxx/RNYDgkNSUEOCqU6QcnFhbh26BiDCsmWi5aj7ln0LLhnJR11B1/Djb
         dtazOOxnTNnVJnrrPYYOPbFcg8Iyns6wy/hPx53n9aj/SSnxeeCW0NR6LDYLQP4fXsoj
         wbfWLIvXsgKOL1HIIKZ2cTQ8x+3aoXrGw42iOBPQGd0Nqqg1JKOxOGzuLNSekG+ZMQ8o
         MXYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature
         :arc-authentication-results;
        bh=M3e0aET+wVzPIQj9AAmfKHaB12WWlgb0FfWs/0WDLjk=;
        b=Q2z8Dgge/atgHtCSnIa9XX/Zq9ITcdTf2QkAGd0SUaoxMuCII6CHT1u1a0bA8Lumt/
         d3V1JE45UJGRuXm9sLywWE8n3vWRR1YsYCZ7YrNNdinSf59oA8/Vryw78W/R6KpTCL0y
         Vu+FsA+yrkSIjbuKBhCjUpMftAncoS1oLATdmfe/rmYgaOMVcoymW7oVYHPjcb6qOAgy
         KEM+UU2V3wwUanma8r7mQRl+2BJ5wcoi7ZPwN674EoqJRN/wQBjxPfOuX42Xwn0yU2wn
         2lrxHiE8AXZQS1BS14tOgvM2v37bnSol8/yDsyM0I/PDh3ir5P8gr1mf7HxRBOEe8zd3
         xvQw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@android.com header.s=20161025 header.b=K3WyedFo;
       spf=pass (google.com: domain of arve@android.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arve@android.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=android.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@android.com header.s=20161025 header.b=K3WyedFo;
       spf=pass (google.com: domain of arve@android.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arve@android.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=android.com
X-Google-Smtp-Source: AIpwx4+Vl5HHMrSi55NhkPAPuCdieuidpNluBcGDPqmfRKHoorBiWX8nDd0cgVJ60tcyYcE28mgR9x6IBPT7PNpzcIE=
MIME-Version: 1.0
In-Reply-To: <20180329010040.96760-1-minchan@kernel.org>
References: <20180329010040.96760-1-minchan@kernel.org>
From: =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>
Date: Wed, 28 Mar 2018 18:59:41 -0700
Message-ID: <CAMP5Xge2bFr2d9zss_Qi49RE7NsRTQpA0q7s_uwmMw4x3_ceug@mail.gmail.com>
Subject: Re: [PATCH v2] ANDROID: binder: change down_write to down_read
To: Minchan Kim <minchan@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Todd Kjos <tkjos@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Martijn Coenen <maco@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596231778699320743?=
X-GMAIL-MSGID: =?utf-8?q?1596235482531935498?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 6:00 PM, Minchan Kim <minchan@kernel.org> wrote:
> binder_update_page_range needs down_write of mmap_sem because
> vm_insert_page need to change vma->vm_flags to VM_MIXEDMAP unless
> it is set. However, when I profile binder working, it seems
> every binder buffers should be mapped in advance by binder_mmap.
> It means we could set VM_MIXEDMAP in bider_mmap time which is
> already hold a mmap_sem as down_write so binder_update_page_range
> doesn't need to hold a mmap_sem as down_write.
>
> Android suffers from mmap_sem contention so let's reduce mmap_sem
> down_write.
>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Martijn Coenen <maco@android.com>
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
> From v1:
>   * remove WARN_ON_ONCE - Greg
>   * add reviewed-by - Martijn
>
> Martijn, I took your LGTM of v1 as Reviewed-by. If you don't like it
> or want to change it to acked-by, please, tell me.
>
>  drivers/android/binder.c       | 2 +-
>  drivers/android/binder_alloc.c | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 764b63a5aade..9a14c6dd60c4 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -4722,7 +4722,7 @@ static int binder_mmap(struct file *filp, struct vm=
_area_struct *vma)
>                 failure_string =3D "bad vm_flags";
>                 goto err_bad_arg;
>         }
> -       vma->vm_flags =3D (vma->vm_flags | VM_DONTCOPY) & ~VM_MAYWRITE;
> +       vma->vm_flags |=3D (VM_DONTCOPY | VM_MIXEDMAP) & ~VM_MAYWRITE;

Why did you change this to |=3D? You are no longer clearing VM_MAYWRITE.

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



--=20
Arve Hj=C3=B8nnev=C3=A5g
