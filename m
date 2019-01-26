Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A71C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 14:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B49920C01
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 14:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h7wS/n3Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfAZODx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 09:03:53 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:39487 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfAZODx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 09:03:53 -0500
Received: by mail-io1-f68.google.com with SMTP id k7so9958000iob.6
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jan 2019 06:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KI/P4q+lLegeJ+3CNSeoxeddGuY+u3PHqR2KdXlss0M=;
        b=h7wS/n3Zhh4DEH1HpK7X3XpEG6KzwQYWatrWAaIsF+AaUNx+R5YFDQayRveSMjkWs/
         03d/RiuD47NbZTflo/VyWaXQycBe4W0ojEmqtJUtliXH8y8CHIqOrSjO97unbWX1CB0M
         q8gvNJsn0+OHUg6WyGAzzY6VKsCGKdOhERIQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KI/P4q+lLegeJ+3CNSeoxeddGuY+u3PHqR2KdXlss0M=;
        b=AmN+5w7oEaH9GmdASO4oJuIEMJsP/xeORic3cqC/ZR/hTy0zByYQJnH4BRFYeRS9ag
         9zA+Ri5x0kex8yBQfkce1nRrWaP2s67GnRgn22Q30NCgE2MT9qC/YC1Px1FririZ3xKr
         adu+aym/xwUqOLBt5i3kH4hIEkKldxJc3ZNEIwzIOgRSVLrcf02UGx65PZLhSNgr+ocE
         Zf9PJi2oDoX0r/deaYCCOabPUaMDfCdC0YxfD50pod97I11I09EZ+akGqexvJDBgEDW3
         Dm6pAq2tJpPf6zYh3wO1ZFfjRqyCaaPLjoKrPLz8y9z3+6IxhHvcueoZPluiGXHfwXCV
         GvMw==
X-Gm-Message-State: AHQUAuZJXcEqEmJgH3dCNU1FYzUYvm6EYaev0Pz3bHLyeBOPkNRBs7eu
        KMYLKv9N8DYl3MpMkWWpEsZ5Wjgx9/dBYXizOgnVrA==
X-Google-Smtp-Source: AHgI3IYluTRRIVk13y0+JDeiNxYJ+WN0ldrgWbqU9xpJeffQLVkF7jILwOUCD3EAWHlIxMgZ7Go9l5wNZ+v3qMWX/mQ=
X-Received: by 2002:a6b:5d01:: with SMTP id r1mr8487716iob.170.1548511431748;
 Sat, 26 Jan 2019 06:03:51 -0800 (PST)
MIME-Version: 1.0
References: <20190109104541.25733-1-hedi.berriche@hpe.com> <20190109104541.25733-2-hedi.berriche@hpe.com>
In-Reply-To: <20190109104541.25733-2-hedi.berriche@hpe.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 26 Jan 2019 15:03:40 +0100
Message-ID: <CAKv+Gu97838CatqL_Y2Re=tqxT-XT3bBX5C_MOxZUECpN4oJaw@mail.gmail.com>
Subject: Re: [PATCH 1/3] efi/x86: turn EFI runtime semaphore into a global lock
To:     Hedi Berriche <hedi.berriche@hpe.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russ Anderson <rja@hpe.com>, Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Hedi,

On Wed, 9 Jan 2019 at 11:46, Hedi Berriche <hedi.berriche@hpe.com> wrote:
>
> Make efi_runtime_lock semaphore global so that it can be used by EFI
> runtime callers that may be defined outside efi/runtime-wrappers.c.
>
> The immediate motivation is to piggy-back it to serialise UV platform BIOS
> calls.
>
> No functional changes.
>
> Signed-off-by: Hedi Berriche <hedi.berriche@hpe.com>
> Reviewed-by: Russ Anderson <rja@hpe.com>
> Reviewed-by: Mike Travis <mike.travis@hpe.com>
> Reviewed-by: Dimitri Sivanich <sivanich@hpe.com>
> Reviewed-by: Steve Wahl <steve.wahl@hpe.com>

Please drop these reviewed-bys. They may be given on the mailing list,
but having a whole list of R-bs from your co-workers on a first
posting of a series doesn't make a lot of sense.


> ---
>  drivers/firmware/efi/runtime-wrappers.c |   60 ++++++++++++++++----------------
>  include/linux/efi.h                     |    3 +
>  2 files changed, 33 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
> index 8903b9ccfc2b..ec60d6227925 100644
> --- a/drivers/firmware/efi/runtime-wrappers.c
> +++ b/drivers/firmware/efi/runtime-wrappers.c
> @@ -53,7 +53,7 @@ struct efi_runtime_work efi_rts_work;
>   * @rts_arg<1-5>:      efi_runtime_service() function arguments
>   *
>   * Accesses to efi_runtime_services() are serialized by a binary
> - * semaphore (efi_runtime_lock) and caller waits until the work is
> + * semaphore (efi_runtime_sem) and caller waits until the work is
>   * finished, hence _only_ one work is queued at a time and the caller
>   * thread waits for completion.
>   */
> @@ -144,7 +144,7 @@ void efi_call_virt_check_flags(unsigned long flags, const char *call)
>   * none of the remaining functions are actually ever called at runtime.
>   * So let's just use a single lock to serialize all Runtime Services calls.
>   */
> -static DEFINE_SEMAPHORE(efi_runtime_lock);
> +DEFINE_SEMAPHORE(efi_runtime_sem);

Please don't rename the lock unless there is a good reason for doing so.

Your commit log does not even mention that the lock is renamed, so I
am going to assume there is no good reason for it.

>
>  /*
>   * Calls the appropriate efi_runtime_service() with the appropriate
> @@ -233,10 +233,10 @@ static efi_status_t virt_efi_get_time(efi_time_t *tm, efi_time_cap_t *tc)
>  {
>         efi_status_t status;
>
> -       if (down_interruptible(&efi_runtime_lock))
> +       if (down_interruptible(&efi_runtime_sem))
>                 return EFI_ABORTED;
>         status = efi_queue_work(GET_TIME, tm, tc, NULL, NULL, NULL);
> -       up(&efi_runtime_lock);
> +       up(&efi_runtime_sem);
>         return status;
>  }
>
> @@ -244,10 +244,10 @@ static efi_status_t virt_efi_set_time(efi_time_t *tm)
>  {
>         efi_status_t status;
>
> -       if (down_interruptible(&efi_runtime_lock))
> +       if (down_interruptible(&efi_runtime_sem))
>                 return EFI_ABORTED;
>         status = efi_queue_work(SET_TIME, tm, NULL, NULL, NULL, NULL);
> -       up(&efi_runtime_lock);
> +       up(&efi_runtime_sem);
>         return status;
>  }
>
> @@ -257,11 +257,11 @@ static efi_status_t virt_efi_get_wakeup_time(efi_bool_t *enabled,
>  {
>         efi_status_t status;
>
> -       if (down_interruptible(&efi_runtime_lock))
> +       if (down_interruptible(&efi_runtime_sem))
>                 return EFI_ABORTED;
>         status = efi_queue_work(GET_WAKEUP_TIME, enabled, pending, tm, NULL,
>                                 NULL);
> -       up(&efi_runtime_lock);
> +       up(&efi_runtime_sem);
>         return status;
>  }
>
> @@ -269,11 +269,11 @@ static efi_status_t virt_efi_set_wakeup_time(efi_bool_t enabled, efi_time_t *tm)
>  {
>         efi_status_t status;
>
> -       if (down_interruptible(&efi_runtime_lock))
> +       if (down_interruptible(&efi_runtime_sem))
>                 return EFI_ABORTED;
>         status = efi_queue_work(SET_WAKEUP_TIME, &enabled, tm, NULL, NULL,
>                                 NULL);
> -       up(&efi_runtime_lock);
> +       up(&efi_runtime_sem);
>         return status;
>  }
>
> @@ -285,11 +285,11 @@ static efi_status_t virt_efi_get_variable(efi_char16_t *name,
>  {
>         efi_status_t status;
>
> -       if (down_interruptible(&efi_runtime_lock))
> +       if (down_interruptible(&efi_runtime_sem))
>                 return EFI_ABORTED;
>         status = efi_queue_work(GET_VARIABLE, name, vendor, attr, data_size,
>                                 data);
> -       up(&efi_runtime_lock);
> +       up(&efi_runtime_sem);
>         return status;
>  }
>
> @@ -299,11 +299,11 @@ static efi_status_t virt_efi_get_next_variable(unsigned long *name_size,
>  {
>         efi_status_t status;
>
> -       if (down_interruptible(&efi_runtime_lock))
> +       if (down_interruptible(&efi_runtime_sem))
>                 return EFI_ABORTED;
>         status = efi_queue_work(GET_NEXT_VARIABLE, name_size, name, vendor,
>                                 NULL, NULL);
> -       up(&efi_runtime_lock);
> +       up(&efi_runtime_sem);
>         return status;
>  }
>
> @@ -315,11 +315,11 @@ static efi_status_t virt_efi_set_variable(efi_char16_t *name,
>  {
>         efi_status_t status;
>
> -       if (down_interruptible(&efi_runtime_lock))
> +       if (down_interruptible(&efi_runtime_sem))
>                 return EFI_ABORTED;
>         status = efi_queue_work(SET_VARIABLE, name, vendor, &attr, &data_size,
>                                 data);
> -       up(&efi_runtime_lock);
> +       up(&efi_runtime_sem);
>         return status;
>  }
>
> @@ -330,12 +330,12 @@ virt_efi_set_variable_nonblocking(efi_char16_t *name, efi_guid_t *vendor,
>  {
>         efi_status_t status;
>
> -       if (down_trylock(&efi_runtime_lock))
> +       if (down_trylock(&efi_runtime_sem))
>                 return EFI_NOT_READY;
>
>         status = efi_call_virt(set_variable, name, vendor, attr, data_size,
>                                data);
> -       up(&efi_runtime_lock);
> +       up(&efi_runtime_sem);
>         return status;
>  }
>
> @@ -350,11 +350,11 @@ static efi_status_t virt_efi_query_variable_info(u32 attr,
>         if (efi.runtime_version < EFI_2_00_SYSTEM_TABLE_REVISION)
>                 return EFI_UNSUPPORTED;
>
> -       if (down_interruptible(&efi_runtime_lock))
> +       if (down_interruptible(&efi_runtime_sem))
>                 return EFI_ABORTED;
>         status = efi_queue_work(QUERY_VARIABLE_INFO, &attr, storage_space,
>                                 remaining_space, max_variable_size, NULL);
> -       up(&efi_runtime_lock);
> +       up(&efi_runtime_sem);
>         return status;
>  }
>
> @@ -369,12 +369,12 @@ virt_efi_query_variable_info_nonblocking(u32 attr,
>         if (efi.runtime_version < EFI_2_00_SYSTEM_TABLE_REVISION)
>                 return EFI_UNSUPPORTED;
>
> -       if (down_trylock(&efi_runtime_lock))
> +       if (down_trylock(&efi_runtime_sem))
>                 return EFI_NOT_READY;
>
>         status = efi_call_virt(query_variable_info, attr, storage_space,
>                                remaining_space, max_variable_size);
> -       up(&efi_runtime_lock);
> +       up(&efi_runtime_sem);
>         return status;
>  }
>
> @@ -382,11 +382,11 @@ static efi_status_t virt_efi_get_next_high_mono_count(u32 *count)
>  {
>         efi_status_t status;
>
> -       if (down_interruptible(&efi_runtime_lock))
> +       if (down_interruptible(&efi_runtime_sem))
>                 return EFI_ABORTED;
>         status = efi_queue_work(GET_NEXT_HIGH_MONO_COUNT, count, NULL, NULL,
>                                 NULL, NULL);
> -       up(&efi_runtime_lock);
> +       up(&efi_runtime_sem);
>         return status;
>  }
>
> @@ -395,14 +395,14 @@ static void virt_efi_reset_system(int reset_type,
>                                   unsigned long data_size,
>                                   efi_char16_t *data)
>  {
> -       if (down_interruptible(&efi_runtime_lock)) {
> +       if (down_interruptible(&efi_runtime_sem)) {
>                 pr_warn("failed to invoke the reset_system() runtime service:\n"
>                         "could not get exclusive access to the firmware\n");
>                 return;
>         }
>         efi_rts_work.efi_rts_id = RESET_SYSTEM;
>         __efi_call_virt(reset_system, reset_type, status, data_size, data);
> -       up(&efi_runtime_lock);
> +       up(&efi_runtime_sem);
>  }
>
>  static efi_status_t virt_efi_update_capsule(efi_capsule_header_t **capsules,
> @@ -414,11 +414,11 @@ static efi_status_t virt_efi_update_capsule(efi_capsule_header_t **capsules,
>         if (efi.runtime_version < EFI_2_00_SYSTEM_TABLE_REVISION)
>                 return EFI_UNSUPPORTED;
>
> -       if (down_interruptible(&efi_runtime_lock))
> +       if (down_interruptible(&efi_runtime_sem))
>                 return EFI_ABORTED;
>         status = efi_queue_work(UPDATE_CAPSULE, capsules, &count, &sg_list,
>                                 NULL, NULL);
> -       up(&efi_runtime_lock);
> +       up(&efi_runtime_sem);
>         return status;
>  }
>
> @@ -432,11 +432,11 @@ static efi_status_t virt_efi_query_capsule_caps(efi_capsule_header_t **capsules,
>         if (efi.runtime_version < EFI_2_00_SYSTEM_TABLE_REVISION)
>                 return EFI_UNSUPPORTED;
>
> -       if (down_interruptible(&efi_runtime_lock))
> +       if (down_interruptible(&efi_runtime_sem))
>                 return EFI_ABORTED;
>         status = efi_queue_work(QUERY_CAPSULE_CAPS, capsules, &count,
>                                 max_size, reset_type, NULL);
> -       up(&efi_runtime_lock);
> +       up(&efi_runtime_sem);
>         return status;
>  }
>
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 45ff763fba76..930cd20842b8 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1745,6 +1745,9 @@ extern struct efi_runtime_work efi_rts_work;
>  /* Workqueue to queue EFI Runtime Services */
>  extern struct workqueue_struct *efi_rts_wq;
>
> +/* EFI runtime semaphore */
> +extern struct semaphore efi_runtime_sem;
> +
>  struct linux_efi_memreserve {
>         int             size;                   // allocated size of the array
>         atomic_t        count;                  // number of entries used
