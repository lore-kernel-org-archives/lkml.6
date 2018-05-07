Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751890AbeEGG1b (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 02:27:31 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:55804 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbeEGG13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 02:27:29 -0400
X-Google-Smtp-Source: AB8JxZrKE/dJtsf8pFahLjLH61b+qXTQwSHsZ6q3B6XF95e9yOf81pgjHOW1ogtOm/NL3Ou26f/gS2PWfxn0kCLUPzA=
MIME-Version: 1.0
In-Reply-To: <1525493850-6952-1-git-send-email-wang6495@umn.edu>
References: <1525493850-6952-1-git-send-email-wang6495@umn.edu>
From: David Herrmann <dh.herrmann@gmail.com>
Date: Mon, 7 May 2018 08:27:27 +0200
Message-ID: <CANq1E4RuTszxgVzhYAvh9K=zD-QQ=ixUoefi+rusB8OEph33QA@mail.gmail.com>
Subject: Re: [PATCH] HID: uhid: fix a missing-check bug
To: Wenwen Wang <wang6495@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>, David Herrmann <dh.herrmann@googlemail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "open list:UHID USERSPACE HID IO DRIVER:"
        <linux-input@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey

On Sat, May 5, 2018 at 6:17 AM, Wenwen Wang <wang6495@umn.edu> wrote:
> In uhid_event_from_user(), if it is in_compat_syscall(), the 'type' of the
> event is first fetched from the 'buffer' in userspace and checked. If the
> 'type' is UHID_CREATE, it is a messed up request with compat pointer, which
> could be more than 256 bytes, so it is better allocated from the heap, as
> mentioned in the comment. Its fields are then prepared one by one instead
> of using a whole copy. For all other cases, the event object is copied
> directly from user space. In other words, based on the 'type', the memory
> size and structure of the event object vary.
>
> Given that the 'buffer' resides in userspace, a malicious userspace process
> can race to change the 'type' between the two copies, which will cause
> inconsistency issues, potentially security issues. Plus, various operations
> such as uhid_dev_destroy() and uhid_dev_input() are performed based on
> 'type' in function uhid_char_write(). If 'type' is modified by user, there
> could be some issues such as uninitialized uses.
>
> To fix this problem, we need to recheck the type after the second fetch to
> make sure it is not UHID_CREATE.
>
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> ---
>  drivers/hid/uhid.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
> index 3c55073..0220385 100644
> --- a/drivers/hid/uhid.c
> +++ b/drivers/hid/uhid.c
> @@ -447,11 +447,17 @@ static int uhid_event_from_user(const char __user *buffer, size_t len,
>                         event->u.create.country = compat->country;
>
>                         kfree(compat);
> -                       return 0;
> +               } else {
> +                       if (copy_from_user(event, buffer,
> +                                       min(len, sizeof(*event))))
> +                               return -EFAULT;
> +                       if (event->type == UHID_CREATE)
> +                               return -EINVAL;

You are correct, the race against malicious/buggy user-space exists.
However, it is harmless. Lets assume user-space rewrites the input,
all that happens is that we end up with garbage in the kernel.
However, input-validation is done *after* this function, hence
everything will work just fine. If user-space rewrites input-buffers,
they better be aware that this might mean random garbage is pushed
into the kernel.

IOW, this race simply allows user-space to circumvent the "compat
conversion". But if user-space wants that... let them. No point in
protecting them from doing something stupid.

Thanks
David

>                 }
> -               /* All others can be copied directly */
> +               return 0;
>         }
>
> +       /* Others can be copied directly */
>         if (copy_from_user(event, buffer, min(len, sizeof(*event))))
>                 return -EFAULT;
>
> --
> 2.7.4
>
