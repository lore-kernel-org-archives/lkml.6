Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031255AbeBNVRE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 16:17:04 -0500
Received: from mail-ua0-f194.google.com ([209.85.217.194]:34385 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030501AbeBNVRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 16:17:02 -0500
X-Google-Smtp-Source: AH8x227YrB+6UAe7maaMqO7Br4BoRHvOXyzPU6wuL6MjpsM7V7vgjEdjlCJsIJhrqsZDbjmjzhZQ0iykXbIj4qzdWEk=
MIME-Version: 1.0
In-Reply-To: <dfdca2f9-bf75-cdd3-e149-f3a30944d4ae@redhat.com>
References: <20180207194439.32680-1-malat@debian.org> <dfdca2f9-bf75-cdd3-e149-f3a30944d4ae@redhat.com>
From: Mathieu Malaterre <malat@debian.org>
Date: Wed, 14 Feb 2018 22:16:41 +0100
X-Google-Sender-Auth: iaPuJsfXXCgIwf62gcM-2B7XkSU
Message-ID: <CA+7wUsxBmw6WToqxpecZZ8vgz6yET5ATTVYkfqv0VLb_SDTWFQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc/via-pmu: Fix section mismatch warning
To: Laurent Vivier <lvivier@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 7:54 PM, Laurent Vivier <lvivier@redhat.com> wrote:
> On 07/02/2018 20:44, Mathieu Malaterre wrote:
>> Remove the __init annotation from pmu_init() to avoid the
>> following warning.
>>
>> WARNING: vmlinux.o(.data+0x4739c): Section mismatch in reference from the variable via_pmu_driver to the function .init.text:pmu_init()
>> The variable via_pmu_driver references
>> the function __init pmu_init()
>> If the reference is valid then annotate the
>> variable with __init* or __refdata (see linux/init.h) or name the variable:
>> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
>>
>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>> ---
>>  drivers/macintosh/via-pmu.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
>> index 08849e33c567..5f378272d5b2 100644
>> --- a/drivers/macintosh/via-pmu.c
>> +++ b/drivers/macintosh/via-pmu.c
>> @@ -378,7 +378,7 @@ static int pmu_probe(void)
>>       return vias == NULL? -ENODEV: 0;
>>  }
>>
>> -static int __init pmu_init(void)
>> +static int pmu_init(void)
>>  {
>>       if (vias == NULL)
>>               return -ENODEV;
>>
>
> pmu_init() is really an init function only called by another init
> function (adb_init()).
>
> So I think it could be good to let the __init marker.
>
> Did you try:
>
> --- a/drivers/macintosh/via-pmu.c
> +++ b/drivers/macintosh/via-pmu.c
> @@ -198,7 +198,7 @@ static const struct file_operations
> pmu_battery_proc_fops;
>  static const struct file_operations pmu_options_proc_fops;
>
>  #ifdef CONFIG_ADB
> -struct adb_driver via_pmu_driver = {
> +const struct adb_driver via_pmu_driver = {
>         "PMU",
>         pmu_probe,
>         pmu_init,
>
>

Indeed much better !

Thanks
