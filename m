Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752051AbeENSXI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 14:23:08 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:39805 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751515AbeENSXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 14:23:06 -0400
X-Google-Smtp-Source: AB8JxZoORbTZhj1uEk5q2+AoqcUHJIOLzjJ6HBuLUxXmfL6h4fWMI7bmEg/lwONeZSucQ1cAZG38gdTxFq+PVmlFQUw=
MIME-Version: 1.0
In-Reply-To: <CAGXu5jLdPMK_EN5wekwbusaKzYOwsFCsFmy7coOEqxB-sGv+JQ@mail.gmail.com>
References: <20180512045921.18311-1-deepa.kernel@gmail.com>
 <20180512045921.18311-7-deepa.kernel@gmail.com> <CAGXu5jLFHSE12La25QEvZawdBm84cLavtTD5LAA6MqeqBmbYuw@mail.gmail.com>
 <CABeXuvpi_dm6TE3pH_KGehgNwW177hJFBmR8u29w6KJH1aA1Kg@mail.gmail.com>
 <CAGXu5jJpO+z8k_=UuVY9WAeiEgABQg4gWE6nz82BX0_UhaPUWw@mail.gmail.com>
 <CABeXuvrO5XLD5QhBPui-v_G6JX=FgcaZLOL0C6B40f4oCyqOWg@mail.gmail.com> <CAGXu5jLdPMK_EN5wekwbusaKzYOwsFCsFmy7coOEqxB-sGv+JQ@mail.gmail.com>
From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Mon, 14 May 2018 11:23:04 -0700
Message-ID: <CABeXuvomY6EYxdPrbMymqBkw0fnYernvOhU0R9By0aKihHYTuA@mail.gmail.com>
Subject: Re: [PATCH 6/6] vfs: change inode times to use struct timespec64
To: Kees Cook <keescook@chromium.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>, anton@tuxera.com,
        Felipe Balbi <balbi@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        David Howells <dhowells@redhat.com>, David Sterba <dsterba@suse.com>,
        David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@lst.de>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Mike Marshall <hubcap@omnibond.com>, Jan Kara <jack@suse.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Harkes <jaharkes@cs.cmu.edu>,
        Jiri Slaby <jslaby@suse.com>, Mark Fasheh <mark@fasheh.com>,
        Miklos Szeredi <miklos@szeredi.hu>, Nicolas Pitre <nico@linaro.org>,
        reiserfs-devel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Sage Weil <sage@redhat.com>, Steve French <sfrench@samba.org>,
        Steven Whitehouse <swhiteho@redhat.com>, Tejun Heo <tj@kernel.org>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        "Ted Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 10:53 AM, Kees Cook <keescook@chromium.org> wrote:
> On Mon, May 14, 2018 at 10:25 AM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>> On Mon, May 14, 2018 at 9:30 AM, Kees Cook <keescook@chromium.org> wrote:
>>> On Sun, May 13, 2018 at 9:05 PM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>>>> Kees mentioned that he wants to merge a patch to pstore that changes
>>>> it to use timespec64 internally for 4.17:
>>>> https://lkml.org/lkml/2018/5/13/3
>>>
>>> I'm still working on a v2 for pstore. What is the correct
>>> cross-architecture format string for timespec64's tv_sec? In your
>>> other patches, you're using %lld and a (long long) cast. I'd really
>>> like to avoid the need for casts.
>>
>> We cannot really avoid it for now.
>> struct timespec64 is defined this way for now:
>>
>> struct timespec {
>> __kernel_time_t tv_sec; /* seconds */
>> long tv_nsec; /* nanoseconds */
>> };
>>
>> #if __BITS_PER_LONG == 64
>> /* this trick allows us to optimize out timespec64_to_timespec */
>> # define timespec64 timespec
>>
>> #else
>>
>> struct timespec64 {
>> time64_t tv_sec; /* seconds */
>> long tv_nsec; /* nanoseconds */
>> };
>>
>> #endif
>>
>> This will all lead to tv_sec being long on a 64 bit architecture and
>> long long on a 32 bit architecture.
>> So there is no way of avoiding the cast for now.
>>
>> We plan to get rid of this trick and to have a single definition for
>> timespec64. But, that cleanup is planned for later when we cleanup all
>> struct timespec uses internally.
>
> Can we do something like:
>
> #if __BITS_PER_LONG == 64
> # define TVSEC_FMT "%ld"
> #else
> # define TVSEC_FMT "%lld"
> #endif
>
> so we can do stuff like:  sprintf(buf, "seconds: " KTIME_FMT, time->tv_sec)
>
> ? It seems easier to clean up than casts.

We have already introduced these casts in many places now.
It would be easier to do the clean up if they all follow a similar
pattern. ( I could probably write a coccinelle script that is not very
long).
But, it would be not much trouble if you wanted to follow this for pstore.

We also contemplated adding a format specifier for time. But, I think
we deferred it until we have a uniform way of using time internally.

-Deepa
