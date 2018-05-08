Return-Path: <wang6495@umn.edu>
X-Google-Smtp-Source: AB8JxZqHToCOk9MDrJWYWDgZsN2IZhX0OM5+S2orNKwqoXYtg57JVke7Uh1kQNi9Do0fmzcENNIT
ARC-Seal: i=1; a=rsa-sha256; t=1525784019; cv=none;
        d=google.com; s=arc-20160816;
        b=Q8FbGge/Ts5hJPoszdxqJVXxZHQRWdiV+sjhT5sIZQ2QnlTaHHJLNW3aHTCYJTQGGh
         ag50aPlhg60K+DERlq6ntykBMZkKyM3CR3dbFnSKE8cBCpJmqYgOmHTCC1I/FY8Sxxxg
         X9lEc9C46MetOhrN/oug00v8CdX3XfUJfX78KvJoz69GRvggrXN6uD+7NvuaAOOVEDxF
         PQw7miG+CvU5Yx8wIYfX4VJZz+pNINfETthsTAGWEygN2y4TPSsoESvbNcOVQ/f2odtw
         av/kp3NGUWIazDsV29jQZBSKmd2+SsFfJcMlWVabmIQcMZle1QvU4EWv3uWFYg36vqIJ
         lx3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=IJ6NPJAn4Mq4+S2pM0BJfDGOL6rQDJkAAbkpN+wGyLQ=;
        b=xl6Yh97nI8L6F0Fdl3S8x9YeFiCUI5ZMyFY/PZstTc5QjoUeJY2Ks2w1fz0rbUenRL
         wTxxSil+mhn/CpN0SneLMZhKaqC23x4DqKQE0XFwy2NlngKVBE2e6niEyJBbD9By7x/B
         IZTySJvIuCzRuFBtCgdPxCs2cWEEp7CJi8VpK82cLpXbMNDNEelG2J0llXSHfpfCDX82
         hojxpmsl9BrWA2bzpHUVIo/3rh53Y0e/B2GQ9rL6RavbBpJPitb8ERMseQydkrKFUB6K
         o6viZ2YuFDUsfiAzaSA8gsWU1W6BpiW/Po8QvHyDk1bB1Rz0FO6LikW+gUpYvyBbBRrs
         rnXA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@umn.edu header.s=20160920 header.b=DuOE/z9q;
       spf=pass (google.com: domain of wang6495@umn.edu designates 134.84.196.203 as permitted sender) smtp.mailfrom=wang6495@umn.edu;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=umn.edu
Authentication-Results: mx.google.com;
       dkim=pass header.i=@umn.edu header.s=20160920 header.b=DuOE/z9q;
       spf=pass (google.com: domain of wang6495@umn.edu designates 134.84.196.203 as permitted sender) smtp.mailfrom=wang6495@umn.edu;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=umn.edu
MIME-Version: 1.0
In-Reply-To: <8db08d8e-c618-d806-b824-0b8990ef0785@redhat.com>
References: <1525577448-16071-1-git-send-email-wang6495@umn.edu> <8db08d8e-c618-d806-b824-0b8990ef0785@redhat.com>
From: Wenwen Wang <wang6495@umn.edu>
Date: Tue, 8 May 2018 07:52:57 -0500
X-Gmail-Original-Message-ID: <CAAa=b7fkdwTF7tU1si-J3k00kcRze54QJfdrWX45wTWgYAXzmg@mail.gmail.com>
Message-ID: <CAAa=b7fkdwTF7tU1si-J3k00kcRze54QJfdrWX45wTWgYAXzmg@mail.gmail.com>
Subject: Re: [PATCH] virt: vbox: fix a missing-check bug
To: Hans de Goede <hdegoede@redhat.com>
Cc: Kangjie Lu <kjlu@umn.edu>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>,
	Wenwen Wang <wang6495@umn.edu>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599683912395513650?=
X-GMAIL-MSGID: =?utf-8?q?1599900503928496535?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 8, 2018 at 6:46 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi Wenwen,
>
> On 06-05-18 05:30, Wenwen Wang wrote:
>>
>> In vbg_misc_device_ioctl(), the header of the ioctl argument is copied
>> from
>> the userspace pointer 'arg' and saved to the kernel object 'hdr'. Then the
>> 'version', 'size_in', and 'size_out' fields of 'hdr' are verified. For
>> example, if 'hdr.version' is not VBG_IOCTL_HDR_VERSION, an error code
>> -EINVAL will be returned. If 'hdr' can pass all verifications, the whole
>> structure of the ioctl argument is copied once again from 'arg' and saved
>> to 'buf'. Then the function vbg_core_ioctl() is invoked to execute the
>> ioctl command. Given that the 'arg' pointer resides in userspace, a
>> malicious userspace process can race to change the data pointed to by
>> 'arg'
>> between the two copies. By doing so, the user can bypass the verifications
>> on the ioctl argument, which can cause vbg_core_ioctl() to work on
>> unsecure
>> data because it assumes the 'version', 'size_in', and 'size_out' have been
>> verified by vbg_misc_device_ioctl(), as mentioned in the comment in
>> vbg_core_ioctl():
>>
>>          /*
>>           * hdr->version and hdr->size_in / hdr->size_out minimum size are
>>           * already checked by vbg_misc_device_ioctl().
>>           */
>>
>> This patch adds checks after the second copy to ensure the consistency
>> between the data obtained in the two copies. In case an inconsistency is
>> detected, an error code -EINVAL will be returned.
>>
>> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
>
>
> Thank you for finding this. I don't think that doing a second check is
> a good solution, by copy and pasting the checks we run the risk that
> any future additional checks are omitted from one copy of the checks.
>
> Instead I think we should simply avoid the 2nd copy of the header, like
> this:
>
> From 0c50b0dce3cf25a0ee9794c5816d9a0232d29e0a Mon Sep 17 00:00:00 2001
> From: Hans de Goede <hdegoede@redhat.com>
> Date: Tue, 8 May 2018 13:23:01 +0200
> Subject: [PATCH 3/3] virt: vbox: Only copy_from_user the request-header once
>
> In vbg_misc_device_ioctl(), the header of the ioctl argument is copied from
> the userspace pointer 'arg' and saved to the kernel object 'hdr'. Then the
> 'version', 'size_in', and 'size_out' fields of 'hdr' are verified.
>
> Before this commit, after the checks a buffer for the entire request would
> be allocated and then all data including the verified header would be
> copied from the userspace 'arg' pointer again.
>
> Given that the 'arg' pointer resides in userspace, a malicious userspace
> process can race to change the data pointed to by 'arg' between the two
> copies. By doing so, the user can bypass the verifications on the ioctl
> argument.
>
> This commit fixes this by using the already checked copy of the header
> to fill the header part of the allocated buffer and only copying the
> remainder of the data from userspace.
>
> Reported-by: Wenwen Wang <wang6495@umn.edu>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/virt/vboxguest/vboxguest_linux.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/virt/vboxguest/vboxguest_linux.c
> b/drivers/virt/vboxguest/vboxguest_linux.c
> index 398d22693234..6e2a9619192d 100644
> --- a/drivers/virt/vboxguest/vboxguest_linux.c
> +++ b/drivers/virt/vboxguest/vboxguest_linux.c
> @@ -121,7 +121,9 @@ static long vbg_misc_device_ioctl(struct file *filp,
> unsigned int req,
>         if (!buf)
>                 return -ENOMEM;
>
> -       if (copy_from_user(buf, (void *)arg, hdr.size_in)) {
> +       *((struct vbg_ioctl_hdr *)buf) = hdr;
> +       if (copy_from_user(buf + sizeof(hdr), (void *)arg + sizeof(hdr),
> +                          hdr.size_in - sizeof(hdr))) {
>                 ret = -EFAULT;
>                 goto out;
>         }
>
> Do you agree that this would also fix the race window you found?

Thanks for your response. Yes, this fix also works.

Wenwen
