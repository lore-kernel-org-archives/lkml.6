Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751314AbeCNUkI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 16:40:08 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35474 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751555AbeCNUkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 16:40:06 -0400
X-Google-Smtp-Source: AG47ELvv32nKuCUss1dBJBYFkaaYkwZmlGvPbh9dOYROLQttza4ODPtwEbYPk/fZuCFGLQE09aPRfNf4dHR1Qfy4OdY=
MIME-Version: 1.0
In-Reply-To: <20180314210417-mutt-send-email-mst@kernel.org>
References: <20180314172605.130483-1-sonnyrao@chromium.org> <20180314210417-mutt-send-email-mst@kernel.org>
From: Sonny Rao <sonnyrao@chromium.org>
Date: Wed, 14 Mar 2018 13:39:43 -0700
X-Google-Sender-Auth: 0aP3cRdkJrEYe3lpS6TkkdNCzf4
Message-ID: <CAPz6YkUrCq2nCOdsWhyJxwY0Mv=WnhRcfz8dsNZaxMhtw34-mA@mail.gmail.com>
Subject: Re: [PATCH] vhost: add vsock compat ioctl
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 12:05 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Wed, Mar 14, 2018 at 10:26:05AM -0700, Sonny Rao wrote:
>> This will allow usage of vsock from 32-bit binaries on a 64-bit
>> kernel.
>>
>> Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
>
> I think you need to convert the pointer argument though.
> Something along the lines of:
>
> #ifdef CONFIG_COMPAT
> static long vhost_vsock_dev_compat_ioctl(struct file *f, unsigned int ioctl,
>                                          unsigned long arg)
> {
>         return vhost_vsock_dev_ioctl(f, ioctl, (unsigned long)compat_ptr(arg));
> }
> #endif

Ok, thanks for pointing that out -- it has worked for me so far, but
I'll re-spin as you suggested.

>
>
>
>> ---
>>  drivers/vhost/vsock.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>> index 0d14e2ff19f16..d0e65e92110e5 100644
>> --- a/drivers/vhost/vsock.c
>> +++ b/drivers/vhost/vsock.c
>> @@ -705,6 +705,7 @@ static const struct file_operations vhost_vsock_fops = {
>>       .release        = vhost_vsock_dev_release,
>>       .llseek         = noop_llseek,
>>       .unlocked_ioctl = vhost_vsock_dev_ioctl,
>> +     .compat_ioctl   = vhost_vsock_dev_ioctl,
>>  };
>>
>>  static struct miscdevice vhost_vsock_misc = {
>> --
>> 2.13.5
