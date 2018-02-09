Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751341AbeBIM5r (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 07:57:47 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:35553 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751053AbeBIM5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 07:57:46 -0500
X-Google-Smtp-Source: AH8x226ffCkdZiMgNkgdpRs6JxVxrNFIZrcbT+YL7mdvv0H9gBWJlD3jJTXLGArl7uSbok0sgjWEY3h/OkpsWEE+/Xc=
MIME-Version: 1.0
In-Reply-To: <67d8f0f1-0846-876d-d36a-c8a9f9366243@citrix.com>
References: <20180205150340.328921-1-arnd@arndb.de> <67d8f0f1-0846-876d-d36a-c8a9f9366243@citrix.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 9 Feb 2018 13:57:44 +0100
X-Google-Sender-Auth: 7qVoKc_dq92aq7SKedkZvZ_WJSI
Message-ID: <CAK8P3a36O-NbrKkt-DEEZE2A2JQ5Gu9GZ98j0BjoFET4kgTaWw@mail.gmail.com>
Subject: Re: [Xen-devel] [PATCH] [v2] xen: hypercall: fix out-of-bounds memcpy
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        David Laight <David.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 4:14 PM, Andrew Cooper <andrew.cooper3@citrix.com> wrote:
> On 05/02/18 15:03, Arnd Bergmann wrote:
>
> Snipping deleted code to make things clearer:
>
>> +     if (cmd > ARRAY_SIZE(physdevop_len))
>> +             return -ENOSYS;
>>
>> +     len = physdevop_len[cmd];
>> +     memcpy(&op.u, arg, len);
>
> You'll want an array_nospec() or whatever its called these days.  This
> code is SP1-leaky.

Maybe the best solution would be to remove the file completely. From
looking at the Xen git history, we only need this to run on Xen 3.0.2
or earlier, those early Xen releases (according to Wikipedia) never
even supported running modern kernel versions anyway, so the code
appears to be completely pointless here.

However, aside from this driver, I wonder if we should be worried about
Spectre type 1 attacks on similar code, when gcc-8 turns a switch/case
statement into an array lookup behind our back, e.g. in an ioctl handler.
Has anybody got this on their radar?

       Arnd
