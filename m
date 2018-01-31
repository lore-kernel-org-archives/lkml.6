Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754210AbeAaXs0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 18:48:26 -0500
Received: from mail-ua0-f196.google.com ([209.85.217.196]:46759 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753481AbeAaXsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 18:48:24 -0500
X-Google-Smtp-Source: AH8x2251npTA+6F4fB55RKPBcViX3nNO7dmBb972RgnLbUtqiGEdy376BdfKjO82oomiY4xus4Zfcw==
Subject: Re: [RFC PATCH] rootfs: force mounting rootfs as tmpfs
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        initramfs <initramfs@vger.kernel.org>
Cc: Taras Kondratiuk <takondra@cisco.com>,
        Victor Kamensky <kamensky@cisco.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1517348777.3469.5.camel@linux.vnet.ibm.com>
 <1814af5c-170d-39c0-58fd-02eb7216e008@landley.net>
 <1517436423.3469.237.camel@linux.vnet.ibm.com>
From: Rob Landley <rob@landley.net>
Message-ID: <a538e55c-81ca-6d59-20cf-21b47387c3e2@landley.net>
Date: Wed, 31 Jan 2018 17:48:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1517436423.3469.237.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/31/2018 04:07 PM, Mimi Zohar wrote:
> On Wed, 2018-01-31 at 13:32 -0600, Rob Landley wrote:>> (The old "I configured in tmpfs and am using rootfs but I want that
rootfs
>> to be ramfs, not tmpfs" code doesn't seem to be a real-world concern, does
>> it?)
> 
> I must be missing something.  Which systems don't specify "root=" on
> the boot command line.

Any system using initrd or initramfs?

I have one at https://github.com/landley/mkroot that doesn't, for
example. It's 600 lines of bash that builds simple Linux systems for a
bunch of different architectures, each with a qemu wrapper to boot it to
a shell prompt. And yes, it's using tmpfs for its initramfs, you can
tell because "grep rootfs /proc/mounts" gives a size. That's also where
I tested the patch I sent you.

The root= option specifies the filesystem to mount OVER rootfs. I.E.
it's the fallback root filesystem to mount when initramfs doesn't
contain an executable /init that can become PID 1. If you DO have an
/init in rootfs which the kernel manages to launch as PID 1, the kernel
code never reaches the part that uses the root= argument.

(Look for the call to prepare_namespace() in init/main.c, notice how
it's only called if it can't _already_ find "/init".)

That's why the test I added for initramfs vs initmpfs was "did they
specify root=", because if they did it means they're telling the kernel
what to mount over rootfs, so they're not staying in rootfs. That's what
that argument MEANS. They're telling init/main.c what fallback
filesystem to mount over rootfs _after_ failing to find /init in rootfs,
therefore they're not keeping rootfs as their root filesystem for userspace.

That said, a lot of people don't understand how this works, and they set
root= to things like /dev/ram when using initrd because "we must set
this knob to something, this is something, therefore we must set this
knob to it". The fact setting root=/dev/random would have the exact same
effect doesn't seem to bother them, they had Done It and It Worked,
therefore it was the Right Thing To Do. QED.

The patch last message was me going "alright, if people can't NOT
twiddle the knob, even when doing it breaks things in an immediate and
obvious way, and a big DO NOT TOUCH sign won't dissuade them, just give
the knob an explicit 'off' setting that literally does the same thing as
not touching it at all would".

Your solution was to add a safety catch for the knob, which is edging
into Rube Goldberg territory if you ask me.

> If we want to include and restore xattrs,
> there needs to be a way of using tmpfs.

Yes, using tmpfs for initramfs is useful, that's why I submitted patches
to hook it up back in 2013.

(Personally I find "cat /dev/zero > /filename" _not_ hard locking your
system instantly the most compelling feature. Although I believe what
motivated my initmpfs patches way back when was somebody wanting to
install an rpm into intramfs and the installer failing because ramfs
hasn't got a size so "df" always returns zero.)

> Mimi

Rob
