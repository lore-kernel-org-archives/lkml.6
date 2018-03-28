Return-Path: <maco@android.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522221481; cv=none;
        d=google.com; s=arc-20160816;
        b=ngrXwNMHQk4mU6yhHi607jmJGVHWKuSd8YXKHlz0DG6Vt2hKkdQHEVIwxkGCEYJWh8
         DC0zBdHQ6sJu2Ug/jzl1SLxvML+EgDtyVwOFQBe6K5rALUwYyjFqeh4f+8fKFsK4wPI2
         wQqwcREqGQZ/a3zaq144I6oxmzfvsDMAY0/ymgnwKEMcXPWY39iKH+xj/vxxVGvQ3eOQ
         rCpV9mIWMgqvm7GYEZHnuG1rY4feqrU6xOBcAUywszd9wXdJ8y+M7FnqX9czktrS2QGz
         kutneOHNZo+as5aQjLY14rYfO1sxhpX99J/JcMG9x1o5kgOeP40rU2eduW1g2gXPY4+A
         SHKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=PR1zUnMAZ9ubfc/7/efNDsXwr1cM9GJAMOLlu2r0w2w=;
        b=mmvD9U2DqaR163Sz+l6zpytYRLLPa4G6uCrpge0YNXxzcykw+LS2EnBP7sM+JfegyA
         leKIfNoPq9IGzr4ZsvO0gUbpIRWBTSFW0jSFmRIac40e+pbrdpcEguWj5JCRj60blbnL
         RkfuneheX+L/VNCmQ9jiAnZk8lZPEcq1EYYHSfmDjoCejwCU3+0MdF5eAacCT1orY2K4
         PMF4fqRtMPzvZ5f8tXzuhTWx7aDiXECnww6lvzJX/BuN/59Z2Ip21xIP71lB9tkdgsjT
         44FvM2PcEBflIfJiJGBV8pO7jEpmIn5k1zQNET/s0JOtR4tBAlO7952DDOHZNacaM/u9
         1TKw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@android.com header.s=20161025 header.b=GrbEZVYK;
       spf=pass (google.com: domain of maco@android.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=maco@android.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=android.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@android.com header.s=20161025 header.b=GrbEZVYK;
       spf=pass (google.com: domain of maco@android.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=maco@android.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=android.com
X-Google-Smtp-Source: AIpwx49sE7iuZo/DtjeKMuMQUnnWRuiyR8A+tjy4QytLOwJcVdzSbjH5E8mG4jnWGBBPv19HUA0yQl9sFQJN5j0DCvE=
MIME-Version: 1.0
In-Reply-To: <20180328024231.239725-1-minchan@kernel.org>
References: <20180328024231.239725-1-minchan@kernel.org>
From: Martijn Coenen <maco@android.com>
Date: Wed, 28 Mar 2018 09:18:00 +0200
Message-ID: <CAB0TPYGHASQcW7-yXBPNCtG7_t244npqCATvx1q=f_T0fJFdkw@mail.gmail.com>
Subject: Re: [PATCH] ANDROID: binder: change down_write to down_read
To: Minchan Kim <minchan@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Todd Kjos <tkjos@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596147613657109396?=
X-GMAIL-MSGID: =?utf-8?q?1596164912397908282?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 4:42 AM, Minchan Kim <minchan@kernel.org> wrote:
> binder_update_page_range needs down_write of mmap_sem because
> vm_insert_page need to change vma->vm_flags to VM_MIXEDMAP unless
> it is set. However, when I profile binder working, it seems
> every binder buffers should be mapped in advance by binder_mmap.

Yeah this is correct - before doing any binder transactions
binder_mmap() must be called, and we do fail transactions if that
hasn't been done yet. LGTM once you're removed the WARN_ON.

Martijn

> It means we could set VM_MIXEDMAP in bider_mmap time which is
> already hold a mmap_sem as down_write so binder_update_page_range
> doesn't need to hold a mmap_sem as down_write.
>
> Android suffers from mmap_sem contention so let's reduce mmap_sem
> down_write.
>
> Cc: Martijn Coenen <maco@android.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>  drivers/android/binder.c       | 2 +-
>  drivers/android/binder_alloc.c | 8 +++++---
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 764b63a5aade..9a14c6dd60c4 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -4722,7 +4722,7 @@ static int binder_mmap(struct file *filp, struct vm_area_struct *vma)
>                 failure_string = "bad vm_flags";
>                 goto err_bad_arg;
>         }
> -       vma->vm_flags = (vma->vm_flags | VM_DONTCOPY) & ~VM_MAYWRITE;
> +       vma->vm_flags |= (VM_DONTCOPY | VM_MIXEDMAP) & ~VM_MAYWRITE;
>         vma->vm_ops = &binder_vm_ops;
>         vma->vm_private_data = proc;
>
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index 5a426c877dfb..a184bf12eb15 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -219,7 +219,7 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
>                 mm = alloc->vma_vm_mm;
>
>         if (mm) {
> -               down_write(&mm->mmap_sem);
> +               down_read(&mm->mmap_sem);
>                 vma = alloc->vma;
>         }
>
> @@ -229,6 +229,8 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
>                 goto err_no_vma;
>         }
>
> +       WARN_ON_ONCE(vma && !(vma->vm_flags & VM_MIXEDMAP));
> +
>         for (page_addr = start; page_addr < end; page_addr += PAGE_SIZE) {
>                 int ret;
>                 bool on_lru;
> @@ -288,7 +290,7 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
>                 /* vm_insert_page does not seem to increment the refcount */
>         }
>         if (mm) {
> -               up_write(&mm->mmap_sem);
> +               up_read(&mm->mmap_sem);
>                 mmput(mm);
>         }
>         return 0;
> @@ -321,7 +323,7 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
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
