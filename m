Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753149AbeFDNKX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 09:10:23 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:32929 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752432AbeFDNKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 09:10:21 -0400
X-Google-Smtp-Source: ADUXVKL02Nq9+MTHc1s2R9Eop8QKY9JKSnxRvkxxWnwiRhXrLmX/TeLTGhbGyrLRh8Nlubn0Zq8a3FTW8zbzaQZ4LVw=
MIME-Version: 1.0
In-Reply-To: <152720693123.9073.4511934790831409009.stgit@warthog.procyon.org.uk>
References: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
 <152720693123.9073.4511934790831409009.stgit@warthog.procyon.org.uk>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 4 Jun 2018 15:10:18 +0200
X-Google-Sender-Auth: qWKm6LOe9g4WRieWum_xrD6EMo0
Message-ID: <CAK8P3a0rO=F_n0pmsxUghRrF9hC_2+2Bd6RaVwC9H-=Xo6oQWA@mail.gmail.com>
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

On Fri, May 25, 2018 at 2:08 AM, David Howells <dhowells@redhat.com> wrote:

> +
> +static int fsinfo_generic_timestamp_info(struct dentry *dentry,
> +                                        struct fsinfo_timestamp_info *ts)
> +{
> +       struct super_block *sb = dentry->d_sb;
> +
> +       /* If unset, assume 1s granularity */
> +       u16 mantissa = 1;
> +       s8 exponent = 0;
> +
> +       ts->minimum_timestamp = S64_MIN;
> +       ts->maximum_timestamp = S64_MAX;
> +       if (sb->s_time_gran < 1000000000) {
> +               if (sb->s_time_gran < 1000)
> +                       exponent = -9;
> +               else if (sb->s_time_gran < 1000000)
> +                       exponent = -6;
> +               else
> +                       exponent = -3;
> +       }

ntfs has sb->s_time_gran=100, and vfat should really have
sb->s_time_gran=2000000000 but that doesn't seem to be set right
at the moment.

> +/*
> + * Optional fsinfo() parameter structure.
> + *
> + * If this is not given, it is assumed that fsinfo_attr_statfs instance 0 is
> + * desired.
> + */
> +struct fsinfo_params {
> +       enum fsinfo_attribute   request;        /* What is being asking for */
> +       __u32                   Nth;            /* Instance of it (some may have multiple) */
> +       __u32                   at_flags;       /* AT_SYMLINK_NOFOLLOW and similar flags */
> +       __u32                   __spare[6];     /* Spare params; all must be 0 */
> +};

I fear the 'enum' in the uapi structure may have a different size depending
on the architecture. Maybe turn that into a __u32 as well?

> +struct fsinfo_capabilities {
> +       __u64   supported_stx_attributes;       /* What statx::stx_attributes are supported */
> +       __u32   supported_stx_mask;             /* What statx::stx_mask bits are supported */
> +       __u32   supported_ioc_flags;            /* What FS_IOC_* flags are supported */
> +       __u8    capabilities[(fsinfo_cap__nr + 7) / 8];
> +};

This looks a bit odd: with the 44 capabilities, you end up having a
six-byte array
followed by two bytes of implicit padding. If the number of
capabilities grows beyond
64, you have a nine byte array with more padding to the next alignof(__u64). Is
that intentional?

How about making it a fixed size with either 64 or 128 capability bits?

> +/*
> + * Information struct for fsinfo(fsinfo_attr_timestamp_info).
> + */
> +struct fsinfo_timestamp_info {
> +       __s64   minimum_timestamp;      /* Minimum timestamp value in seconds */
> +       __s64   maximum_timestamp;      /* Maximum timestamp value in seconds */
> +       __u16   atime_gran_mantissa;    /* Granularity(secs) = mant * 10^exp */
> +       __u16   btime_gran_mantissa;
> +       __u16   ctime_gran_mantissa;
> +       __u16   mtime_gran_mantissa;
> +       __s8    atime_gran_exponent;
> +       __s8    btime_gran_exponent;
> +       __s8    ctime_gran_exponent;
> +       __s8    mtime_gran_exponent;
> +};

This structure has a slightly inconsistent amount of padding at the end:
on x86-32 it has no padding, everywhere else it has 32 bits of padding
to make it 64-bit aligned. Maybe add a __u32 reserved field?

> +
> +#define __NR_fsinfo 326

Hardcoding the syscall number in the example makes it architecture specific.
Could you include <asm/unistd.h> to get the real number?

      Arnd
