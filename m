Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEC1C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8908020859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547579149;
	bh=EWiksaM1KpDhaDom+Sn/r582wwm/tnUf+9+LijV+rGc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GXM2OlttKuaDcU4p+qCv94DCNyqthtbduVDJFiN8wO8Sr0m/I2drp0oPFvXMoog+E
	 X+9VuDr+fzCbDKi/08/LC/X8Vtn+/u2+5g5KyitVZ1f7h8IU0zNvobWvS9TZ60eF0o
	 7Xs6DjxMIGJWImfbUBmFzFFxG2mdc2OeCHr2EGxE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388581AbfAOTFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 14:05:47 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44535 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731444AbfAOTFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 14:05:47 -0500
Received: by mail-ot1-f65.google.com with SMTP id f18so3497979otl.11;
        Tue, 15 Jan 2019 11:05:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7zpbsyQ1kgppmLVRcom+7fCsw6r/WP4aCKpm+NAMDG4=;
        b=ML4yZgsKZNhKBOoV9v9GeUd11F+gq9GOlMqAI6B2S4fcpfyi1Ixr18V1FgfWXUMsQ9
         ImZwLkQvvRo6q7/mAGY1USvuRrRpB40/I0qBmViXU2QsVr6wN+ZyHsYGyNeB9xmu4nJH
         W0KIXCW8faDAplMViCJhUduzWnc63H9kgaN7O2rE7SFy9QY6aK9BS2VUx6nfId619A14
         DlXpzq/woOYi0HsKJ94M/+dnTWB91Js2t1ZVGOysoLQ9WDQpHNrvKVuCgmRB1D1fXkVw
         TI21SWcee0I6Zd3SclAJMKSdbM5Pbl3ViSHjcw4rHSP6Dw/fbdKsL3jlgIOKvbutonVh
         aoTQ==
X-Gm-Message-State: AJcUukf0Eoj2sgx3f83wlWCCAeyWuV9CUzn8LQ+EWfxduuAz9IHIwaVY
        LFjxGy+9FAyYgQflgK3Wpmsw+czVOTUPohYLdM98HQ==
X-Google-Smtp-Source: ALg8bN7oFssVDtERqt2f4lxxu9gzIehOgfNNXvHtxNYwqBttcEE+bvwSdS7rsfclL0bHgrnHBdBM42Pa94pCBbMks3Q=
X-Received: by 2002:a9d:60b:: with SMTP id 11mr3105017otn.200.1547579146142;
 Tue, 15 Jan 2019 11:05:46 -0800 (PST)
MIME-Version: 1.0
References: <20181225214633.69973-1-kjlu@umn.edu> <20190109081423.10781-1-kjlu@umn.edu>
 <CAJZ5v0iR9WrW6GafCmKR8oHagg3vqGMKEuXmJ58Ewp_cOB5uew@mail.gmail.com> <CAK8KejpGipqLpR93=ZnRze9FU7q5ZhJrGQV33czZwuxqSs0AyQ@mail.gmail.com>
In-Reply-To: <CAK8KejpGipqLpR93=ZnRze9FU7q5ZhJrGQV33czZwuxqSs0AyQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 15 Jan 2019 20:05:35 +0100
Message-ID: <CAJZ5v0gDQWeWhuq0-4=H6NxGO99Q9o5heT3NDf0DCtseanO5AA@mail.gmail.com>
Subject: Re: [PATCH v2] acpi: fix a potential inconsistency caused by double-fetch
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Aditya Pakki <pakki001@umn.edu>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 7:05 AM Kangjie Lu <kjlu@umn.edu> wrote:
>
>
>
> On Mon, Jan 14, 2019 at 5:15 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Wed, Jan 9, 2019 at 9:14 AM Kangjie Lu <kjlu@umn.edu> wrote:
>> >
>> > "user_buf->length" is in user space, and copied in twice. The second
>> > copy is after it passes the security check. If a user program races to
>> > change user_buf->length in user space, the data fetched in the second
>> > copy may invalidate the security check. The fix avoids the double-fetch
>> > issue by using the value passing the security check.
>>
>> AFAICS the patch really does two things: it avoids the issue described
>> above and avoids using the (redundant) 'table' local variable on the
>> stack.  Arguably, you could fix the issue without getting rid of the
>> redundant variable.
>>
>> >
>> > Signed-off-by: Kangjie Lu <kjlu@umn.edu>
>> > ---
>> >  drivers/acpi/custom_method.c | 10 ++++++----
>> >  1 file changed, 6 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
>> > index 4451877f83b6..f10ee0519033 100644
>> > --- a/drivers/acpi/custom_method.c
>> > +++ b/drivers/acpi/custom_method.c
>> > @@ -26,17 +26,16 @@ static ssize_t cm_write(struct file *file, const char __user * user_buf,
>> >         static u32 max_size;
>> >         static u32 uncopied_bytes;
>> >
>> > -       struct acpi_table_header table;
>> >         acpi_status status;
>> >
>> >         if (!(*ppos)) {
>> >                 /* parse the table header to get the table length */
>> >                 if (count <= sizeof(struct acpi_table_header))
>> >                         return -EINVAL;
>> > -               if (copy_from_user(&table, user_buf,
>> > -                                  sizeof(struct acpi_table_header)))
>> > +               if (get_user(max_size,
>> > +                                       &((struct acpi_table_header *)user_buf)->length))
>> >                         return -EFAULT;
>> > -               uncopied_bytes = max_size = table.length;
>> > +               uncopied_bytes = max_size;
>> >                 buf = kzalloc(max_size, GFP_KERNEL);
>> >                 if (!buf)
>> >                         return -ENOMEM;
>> > @@ -57,6 +56,9 @@ static ssize_t cm_write(struct file *file, const char __user * user_buf,
>> >                 return -EFAULT;
>> >         }
>> >
>> > +       /* Ensure table length is not changed in the second copy */
>> > +       ((struct acpi_table_header *)(buf + (*ppos)))->length = max_size;
>>
>> Why don't you return -EFAULT if max_size is different from ->length?
>> Surely, the table should not be used at all in that case.
>
>
> We could do either, but I didn't see one is clearly better than the other.

As I said, why would you use any inconsistent data instead of
returning an error?

>>
>> Moreover, wouldn't it be even better to compare the entire header with
>> the one read previously and return -EFAULT if they don't match?
>
>
> If other fields are not critical and thus not checked, we don't have to compare
> the entire header for better performance reasons.

If you really care about consistency, performance doesn't matter that much.

Thanks,
Rafael
