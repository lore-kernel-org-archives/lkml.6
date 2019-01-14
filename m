Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84839C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FEEA2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547464515;
	bh=AKUfcvb1oP3bceup12KpQVmWIBqVe1pvnyDZpmopS7c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kZ+En/kzgPswF2XObVyy2e8wdo+D8Qct6gwk+Qflecdxguz2+Szjd4s182jZRK8J8
	 J+BL943OXSZfXysc2FQqB/tzH4TVSV/xkO12RYYRyw9RJjw+YBwIdQvZ6+MUBvKmRh
	 LUw8G+2OerYRt8UMC+7IolwgMrmedQKt+csS2h8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfANLPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:15:13 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37205 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbfANLPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 06:15:13 -0500
Received: by mail-ot1-f65.google.com with SMTP id s13so10447088otq.4;
        Mon, 14 Jan 2019 03:15:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h07snCg4mhguPzg7MbkBZ9iRM7ECYWu3+0tvrSZ6k/k=;
        b=cPtCd0eyvQs69WlyT9hrUdeJ2EZAmgRtjak3QRWYBU6EM2unZeHGrF0pobIB2PpAnY
         W3L/eOEdgxt+aaw3X7y0FZSz2QyH6JyM6e+7NrFWXdPcaB0mrtW8md+qTGtN062INsm5
         1oG23l3KIn8kzhu8rh6SzwZRWiFQHhBtYtxvoQxQ9w/f6ysAkbPX4/vL99tU0fRZC/xT
         kGmeIaWlvy9/64gU8TcDFVbhYjZIrkc5HHpxp+XlK7JxvtW1al2wPrSwrhzqie9DHDze
         ExLCZeN1kbNZgFs0n9tcCqxb5KwGunmWIiNPBianoNTeTkz6gXq5mIV4Xo5xfNZ7jF5e
         bYzA==
X-Gm-Message-State: AJcUuke7hBZDCZ1RWjnQLxZlbxX+mFYm7Og4OvwfH+1Esspq7p5dAC4X
        CF1saL2wgwuVY/K4go41gfYGqW1HaW1/M0aGg0c=
X-Google-Smtp-Source: ALg8bN4BaPaewcCozhCfJxLbfBhqsfW9Gscu+TpYqpht34ZGZsvTfi0UBqISz3YkPXAKzEFS4PGwgieoFaDbbtQV9i0=
X-Received: by 2002:a9d:7f0d:: with SMTP id j13mr15577847otq.119.1547464512012;
 Mon, 14 Jan 2019 03:15:12 -0800 (PST)
MIME-Version: 1.0
References: <20181225214633.69973-1-kjlu@umn.edu> <20190109081423.10781-1-kjlu@umn.edu>
In-Reply-To: <20190109081423.10781-1-kjlu@umn.edu>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 14 Jan 2019 12:15:00 +0100
Message-ID: <CAJZ5v0iR9WrW6GafCmKR8oHagg3vqGMKEuXmJ58Ewp_cOB5uew@mail.gmail.com>
Subject: Re: [PATCH v2] acpi: fix a potential inconsistency caused by double-fetch
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 9:14 AM Kangjie Lu <kjlu@umn.edu> wrote:
>
> "user_buf->length" is in user space, and copied in twice. The second
> copy is after it passes the security check. If a user program races to
> change user_buf->length in user space, the data fetched in the second
> copy may invalidate the security check. The fix avoids the double-fetch
> issue by using the value passing the security check.

AFAICS the patch really does two things: it avoids the issue described
above and avoids using the (redundant) 'table' local variable on the
stack.  Arguably, you could fix the issue without getting rid of the
redundant variable.

>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/acpi/custom_method.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
> index 4451877f83b6..f10ee0519033 100644
> --- a/drivers/acpi/custom_method.c
> +++ b/drivers/acpi/custom_method.c
> @@ -26,17 +26,16 @@ static ssize_t cm_write(struct file *file, const char __user * user_buf,
>         static u32 max_size;
>         static u32 uncopied_bytes;
>
> -       struct acpi_table_header table;
>         acpi_status status;
>
>         if (!(*ppos)) {
>                 /* parse the table header to get the table length */
>                 if (count <= sizeof(struct acpi_table_header))
>                         return -EINVAL;
> -               if (copy_from_user(&table, user_buf,
> -                                  sizeof(struct acpi_table_header)))
> +               if (get_user(max_size,
> +                                       &((struct acpi_table_header *)user_buf)->length))
>                         return -EFAULT;
> -               uncopied_bytes = max_size = table.length;
> +               uncopied_bytes = max_size;
>                 buf = kzalloc(max_size, GFP_KERNEL);
>                 if (!buf)
>                         return -ENOMEM;
> @@ -57,6 +56,9 @@ static ssize_t cm_write(struct file *file, const char __user * user_buf,
>                 return -EFAULT;
>         }
>
> +       /* Ensure table length is not changed in the second copy */
> +       ((struct acpi_table_header *)(buf + (*ppos)))->length = max_size;

Why don't you return -EFAULT if max_size is different from ->length?
Surely, the table should not be used at all in that case.

Moreover, wouldn't it be even better to compare the entire header with
the one read previously and return -EFAULT if they don't match?

> +
>         uncopied_bytes -= count;
>         *ppos += count;
>
> --
