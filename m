Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752116AbeBIQUp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 11:20:45 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:39592 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751145AbeBIQUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 11:20:44 -0500
X-Google-Smtp-Source: AH8x226HT/+W9GDivlu4I1Un7/vSx+7cOJ9GFr4xEZsnqzHWzK6U7BzK87oOcgD6jUX84mya3NDPFajbJsyXdAHWTJ4=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0EVW-shM0JNz0fsMWx19Z+BT3kvB6McwotSLGtThhAdA@mail.gmail.com>
References: <20180205150340.328921-1-arnd@arndb.de> <67d8f0f1-0846-876d-d36a-c8a9f9366243@citrix.com>
 <CAK8P3a36O-NbrKkt-DEEZE2A2JQ5Gu9GZ98j0BjoFET4kgTaWw@mail.gmail.com>
 <42258ad55dac4191813d258e43a44e0e@AcuMS.aculab.com> <CAK8P3a0EVW-shM0JNz0fsMWx19Z+BT3kvB6McwotSLGtThhAdA@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 9 Feb 2018 08:20:43 -0800
Message-ID: <CAPcyv4jE0LghCXEMbAyLwXV3xK_K63V_yi_y+YA5LSQHDuHzLQ@mail.gmail.com>
Subject: Re: [Xen-devel] [PATCH] [v2] xen: hypercall: fix out-of-bounds memcpy
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Laight <David.Laight@aculab.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>, David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 9, 2018 at 6:21 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Feb 9, 2018 at 3:13 PM, David Laight <David.Laight@aculab.com> wrote:
>> From: Arnd Bergmann
>>> Sent: 09 February 2018 12:58
>> ...
>>> However, aside from this driver, I wonder if we should be worried about
>>> Spectre type 1 attacks on similar code, when gcc-8 turns a switch/case
>>> statement into an array lookup behind our back, e.g. in an ioctl handler.
>>> Has anybody got this on their radar?
>>
>> The canonical code for a switch statement is to jump indirect on an array
>> of code pointers.
>> ioctl handlers probably use a series of compares because the values are
>> sparse.
>
> The majority of ioctl handlers is sparse enough that a table lookup wouldn't
> work, but there are still subsystems that never fully adopted the _IOC()
> macros, e.g. tty or socket ioctls are just consecutive numbers.
>
>> Also remember that gcc-8 will convert dense switch statements that just
>> load a value into a data array lookup.
>
> Right, that's the case I'm interested in here. I don't know how many of
> those exist in the kernel, as this would again be a small subset of the
> switch()/case statements that use consecutive numbers.
>
>> I guess both those jump tables are potential attack vectors.
>> Not quite sure how they might be used to leak info though.
>
> When I tested the xen fallback code with gcc-7.3, I noticed a retpoline
> getting generated for pointer array, so that should be safe.

The retpoline would protect the indirect call itself, but not the
lookup into the array. So this needs the same protection as the
syscall table where we sanitize the lookup index in addition to the
retpoline on the actual call.
