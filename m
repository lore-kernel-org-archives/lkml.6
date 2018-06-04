Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751400AbeFDUp6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 16:45:58 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:43038 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750997AbeFDUpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 16:45:53 -0400
X-Google-Smtp-Source: ADUXVKJfkNermoT1gUwa0/Siiu+as5nA6YSt8DnWYS1kq2Wt2llViVwAWrKv/kkVblFf7+ZRKkA/uQavx5VGUwSUl7Q=
MIME-Version: 1.0
In-Reply-To: <472.1528139035@warthog.procyon.org.uk>
References: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
 <152720693123.9073.4511934790831409009.stgit@warthog.procyon.org.uk>
 <CAK8P3a0rO=F_n0pmsxUghRrF9hC_2+2Bd6RaVwC9H-=Xo6oQWA@mail.gmail.com>
 <21648.1528124488@warthog.procyon.org.uk> <CAK8P3a0wecxxkjgmW3bv5v8_rJ6H5RZQ0QTvVhR2+cx7sBwxcA@mail.gmail.com>
 <472.1528139035@warthog.procyon.org.uk>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 4 Jun 2018 22:45:50 +0200
X-Google-Sender-Auth: 2Q5lCd1TCqqWz2QSYtcAwBZth0g
Message-ID: <CAK8P3a0VdNKM4JCAqDXmc60Cw7hu8jg8p0qvQAbm9fshYx6pZA@mail.gmail.com>
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

On Mon, Jun 4, 2018 at 9:03 PM, David Howells <dhowells@redhat.com> wrote:
> Arnd Bergmann <arnd@arndb.de> wrote:
> The fsinfo() syscall truncates the reply buffer to the size the user requested
> if the user requested a smaller amount.  Take the fsinfo_supports struct for
> example:
>
>         struct fsinfo_supports {
>                 __u64   supported_stx_attributes;
>                 __u32   supported_stx_mask;
>                 __u32   supported_ioc_flags;
>         };
>
> Now imagine that in future we want to add another field, say the mask of the
> windows file attributes a filesystem supports.  We can extend the struct like
> so:
>
>         struct fsinfo_supports_v2 {
>                 __u64   supported_stx_attributes;
>                 __u32   supported_stx_mask;
>                 __u32   supported_ioc_flags;
>                 __u32   supported_win_file_atts;
>                 __u32   __reserved[1];
>         };

Looking at the code again, I realized my misunderstanding: I somehow
expected the system call to return multiple structures at once, which
would get really messy with groups of arrays of variable-sized
structures. Since we only really get back a single structure per call,
that is not an issue.

There is also no need to be concerned about the system call overhead,
right? Even if we query all data from all mounted file systems, I
suppose the total number of syscall roundtrips will be small enough
that there is no need for complicating the interface to make it
slightly faster.

> I can improve this such that if you asked for a fixed-length option and the
> kernel doesn't have enough data to fill the user buffer provided, then it
> clears the remainder of the buffer.  That way at least any unsupported fields
> will be initialised to 0.

Yes, I think that would make sense here. It's not quite a read() based
interface since the return value for a short read is still the size of the
whole buffer that could have been accessed. By zeroing the extra
data, the kernel always writes the amount of data that the user asks
for, and the return value always shows how much data would have
been available.

It might be necessary to limit the size of the buffer though, to prevent
bad things from happening when the user asks for e.g. -1ull bytes
of data.

>> In any case, it would be nice to have a trivial way to query which of
>> the four timestamp types are supported at all, and returning
>> them separately would be one way of doing that.
>
>         fsinfo_cap_has_atime    = 45,   /* fs supports access time */
>         fsinfo_cap_has_btime    = 46,   /* fs supports birth/creation time */
>         fsinfo_cap_has_ctime    = 47,   /* fs supports change time */
>         fsinfo_cap_has_mtime    = 48,   /* fs supports modification time */

Ok.

      Arnd
