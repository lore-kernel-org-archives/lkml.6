Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751637AbeFDQAb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 12:00:31 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33094 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751385AbeFDQAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 12:00:30 -0400
X-Google-Smtp-Source: ADUXVKIVLdB3ZM2Tcxk68xCZ/yKSIyUHiT4za2Lf6mEEXacLbypOdIpYC31+cSjRgzeN434thagjMh6xZCOneWOmxgk=
MIME-Version: 1.0
In-Reply-To: <21648.1528124488@warthog.procyon.org.uk>
References: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
 <152720693123.9073.4511934790831409009.stgit@warthog.procyon.org.uk>
 <CAK8P3a0rO=F_n0pmsxUghRrF9hC_2+2Bd6RaVwC9H-=Xo6oQWA@mail.gmail.com> <21648.1528124488@warthog.procyon.org.uk>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 4 Jun 2018 18:00:27 +0200
X-Google-Sender-Auth: NT5EhOlX6bxl-8ISlcp5d2GUMFE
Message-ID: <CAK8P3a0wecxxkjgmW3bv5v8_rJ6H5RZQ0QTvVhR2+cx7sBwxcA@mail.gmail.com>
Subject: Re: [PATCH 32/32] [RFC] fsinfo: Add a system call to allow querying
 of filesystem information [ver #8]
To: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-afs@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 4, 2018 at 5:01 PM, David Howells <dhowells@redhat.com> wrote:
> Arnd Bergmann <arnd@arndb.de> wrote:
>
>> ntfs has sb->s_time_gran=100, and vfat should really have
>> sb->s_time_gran=2000000000 but that doesn't seem to be set right
>> at the moment.
>
> (V)FAT actually has a different granularity on each timestamp.

Ah, right. I guess I missed the fact that the file system can override it,
so FAT doesn't actually have to do it this way.

>> > +struct fsinfo_capabilities {
>> > +       __u64   supported_stx_attributes;       /* What statx::stx_attributes are supported */
>> > +       __u32   supported_stx_mask;             /* What statx::stx_mask bits are supported */
>> > +       __u32   supported_ioc_flags;            /* What FS_IOC_* flags are supported */
>> > +       __u8    capabilities[(fsinfo_cap__nr + 7) / 8];
>> > +};
>>
>> This looks a bit odd: with the 44 capabilities, you end up having a six-byte
>> array followed by two bytes of implicit padding. If the number of
>> capabilities grows beyond 64, you have a nine byte array with more padding
>> to the next alignof(__u64). Is that intentional?
>
> I've split the capabilities out into their own thing.  I've attached the
> revised patch below.

I'm still not completely clear on how variable-length structures are supposed to
be handled by the fsinfo syscall. It seems like a possible source of
bugs to return
a structure from the kernel that has a different size in kernel and user space
depending on the fsinfo_cap__nr value at compile time. How does one
e.g. guarantee there is no out of bounds access when you run new user space on
an older kernel that has a smaller structure?

>> > +struct fsinfo_timestamp_info {
>> > +       __s64   minimum_timestamp;      /* Minimum timestamp value in seconds */
>> > +       __s64   maximum_timestamp;      /* Maximum timestamp value in seconds */
>> > +       __u16   atime_gran_mantissa;    /* Granularity(secs) = mant * 10^exp */
>> > +       __u16   btime_gran_mantissa;
>> > +       __u16   ctime_gran_mantissa;
>> > +       __u16   mtime_gran_mantissa;
>> > +       __s8    atime_gran_exponent;
>> > +       __s8    btime_gran_exponent;
>> > +       __s8    ctime_gran_exponent;
>> > +       __s8    mtime_gran_exponent;
>> > +};
>>
>> This structure has a slightly inconsistent amount of padding at the end:
>> on x86-32 it has no padding, everywhere else it has 32 bits of padding
>> to make it 64-bit aligned. Maybe add a __u32 reserved field?
>
> It occurs to me that the min and max may be different for each timestamp.
> Maybe I should have:
>
>         struct fsinfo_timestamp_info {
>                 char    name[7 + 1];
>                 __s64   minimum_timestamp;
>                 __s64   maximum_timestamp;
>                 __u16   granularity_mantissa;
>                 __s8    granularity_exponent;
>                 __u8    __reserved[5];
>         };
>

I don't particularly like having a string in there, that seems to add
unnecessary complexity compared to using an integer. Having four
min/max values would make it more generic but I don't think we have
a need for that at the moment with any of the file systems we support.

In any case, it would be nice to have a trivial way to query which of
the four timestamp types are supported at all, and returning
them separately would be one way of doing that.

> and then you iterate through them by setting Nth.  I could just put a:
>
>                 __u64   granularity;
>
> field, expressed in nS, rather than mantissa and exponent, but doing it this
> way allows me to express granularities less that 1nS very simply (something
> Dave Chinner was talking about).
>
> It might also be worth putting minimum_timestamp and maximum_timestamp in
> terms of granularity rather than nS.

Expressing the granularity in nanoseconds (or something smaller) would seem
more natural to me, but I don't really care much either way.

          Arnd
