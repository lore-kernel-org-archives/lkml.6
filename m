Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751993AbeBDOSM (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 09:18:12 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:41401 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750868AbeBDOSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 09:18:04 -0500
X-Google-Smtp-Source: AH8x227IiJVQBM1AqmAVTvviMzUNKHVor1ogqjiL2a/Lp6ZezQrX1Ic1IKOQMrJ+mdv7LwQu90wXNiG2EIJ/rTNU56c=
MIME-Version: 1.0
In-Reply-To: <CA+7wUsyy+g5evf0SQ+AWZdUzHR9uh1dBWYJm6z+c13XvVtyerw@mail.gmail.com>
References: <20180130203042.4797-1-peter.malone@gmail.com> <20180131145755.26109-1-peter.malone@gmail.com>
 <CA+7wUsyy+g5evf0SQ+AWZdUzHR9uh1dBWYJm6z+c13XvVtyerw@mail.gmail.com>
From: Peter Malone <peter.malone@gmail.com>
Date: Sun, 4 Feb 2018 09:18:03 -0500
Message-ID: <CALGb=fQFwgn6=JLq0_5WkwkTpASCXzO_sGPR0BzT3cuF58nzBg@mail.gmail.com>
Subject: Re: [PATCH v2] Fixing arbitrary kernel leak in case FBIOGETCMAP_SPARC
 in sbusfb_ioctl_helper().
To: Mathieu Malaterre <malat@debian.org>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

CVE-2018-6412 has been created for this. Is it possible for you to add
a note indicating the CVE number when merging the patch?

I received the CVE number after the patch was created and ack'd, which
is why I didn't include it in the commit message.

On Wed, Jan 31, 2018 at 10:49 AM, Mathieu Malaterre <malat@debian.org> wrote:
> Hi Peter,
>
> On Wed, Jan 31, 2018 at 3:57 PM, Peter Malone <peter.malone@gmail.com> wrote:
>> Fixing arbitrary kernel leak in case FBIOGETCMAP_SPARC in
>> sbusfb_ioctl_helper().
>>
>> 'index' is defined as an int in sbusfb_ioctl_helper().
>> We retrieve this from the user:
>> if (get_user(index, &c->index) ||
>>     __get_user(count, &c->count) ||
>>     __get_user(ured, &c->red) ||
>>     __get_user(ugreen, &c->green) ||
>>     __get_user(ublue, &c->blue))
>>        return -EFAULT;
>>
>> and then we use 'index' in the following way:
>> red = cmap->red[index + i] >> 8;
>> green = cmap->green[index + i] >> 8;
>> blue = cmap->blue[index + i] >> 8;
>>
>> This is a classic information leak vulnerability. 'index' should be
>> an unsigned int, given its usage above.
>>
>> This patch is straight-forward; it changes 'index' to unsigned int
>> in two switch-cases: FBIOGETCMAP_SPARC && FBIOPUTCMAP_SPARC.
>>
>> Signed-off-by: Peter Malone <peter.malone@gmail.com>
>> ---
>
> much better :)
>
>> v2: fixed formatting
>>
>>  drivers/video/fbdev/sbuslib.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/video/fbdev/sbuslib.c b/drivers/video/fbdev/sbuslib.c
>> index af6fc97f4ba4..a436d44f1b7f 100644
>> --- a/drivers/video/fbdev/sbuslib.c
>> +++ b/drivers/video/fbdev/sbuslib.c
>> @@ -122,7 +122,7 @@ int sbusfb_ioctl_helper(unsigned long cmd, unsigned long arg,
>>                 unsigned char __user *ured;
>>                 unsigned char __user *ugreen;
>>                 unsigned char __user *ublue;
>> -               int index, count, i;
>> +               unsigned int index, count, i;
>>
>>                 if (get_user(index, &c->index) ||
>>                     __get_user(count, &c->count) ||
>> @@ -161,7 +161,7 @@ int sbusfb_ioctl_helper(unsigned long cmd, unsigned long arg,
>>                 unsigned char __user *ugreen;
>>                 unsigned char __user *ublue;
>>                 struct fb_cmap *cmap = &info->cmap;
>> -               int index, count, i;
>> +               unsigned int index, count, i;
>>                 u8 red, green, blue;
>>
>>                 if (get_user(index, &c->index) ||
>> --
>> 2.14.3
>>
>
> By just looking at the code and commit message:
>
> Acked-by: Mathieu Malaterre <malat@debian.org>



-- 
Regards,
Peter.
