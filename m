Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753563AbeE3PGn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 11:06:43 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36138 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753137AbeE3PGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 11:06:41 -0400
X-Google-Smtp-Source: ADUXVKK9hAtxeuud4PU7JxbD4rpmtVr45ghiVvyXJhEkrOdmwT/oRtKpzmg4QIt/U+N5kvzb0gWbvnTirZnfJ7q/AT8=
MIME-Version: 1.0
In-Reply-To: <20180514225052.GA39419@beast>
References: <20180514225052.GA39419@beast>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 30 May 2018 17:06:39 +0200
X-Google-Sender-Auth: mPS90CbpTes1cvyXUvyORO_g048
Message-ID: <CAK8P3a3d=Jz36COfnGgUfbsp79RfSDOnjjc-N+iFGF-3aQM3vg@mail.gmail.com>
Subject: Re: [PATCH v2] pstore: Convert internal records to timespec64
To: Kees Cook <keescook@chromium.org>
Cc: Deepa Dinamani <deepa.kernel@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 12:50 AM, Kees Cook <keescook@chromium.org> wrote:
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index 49b2bc114868..69e893076ab7 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -38,6 +38,11 @@
>
>  #define RAMOOPS_KERNMSG_HDR "===="
>  #define MIN_MEM_SIZE 4096UL
> +#if __BITS_PER_LONG == 64
> +# define TVSEC_FMT "%ld"
> +#else
> +# define TVSEC_FMT "%lld"
> +#endif
>
>  static ulong record_size = MIN_MEM_SIZE;
>  module_param(record_size, ulong, 0400);

Unfortunately, this bit conflicts with my patch "timekeeping: Remove
timespec64 hack"
that Thomas queued in tip: https://lkml.org/lkml/2018/5/19/115, causing
a harmless but annoying build warning on 64-bit machines:

fs/pstore/ram.c: In function 'ramoops_read_kmsg_hdr':
fs/pstore/ram.c:39:29: error: format '%ld' expects argument of type
'long int *', but argument 3 has type 'time64_t *' {aka 'long long int
*'} [-Werror=format=]
 #define RAMOOPS_KERNMSG_HDR "===="
                             ^~~~~~
fs/pstore/ram.c:167:21: note: in expansion of macro 'RAMOOPS_KERNMSG_HDR'

The tip/timers/y2038 branch is currently not part of linux-next. It should be
easy to fix it up with a patch on top that open-codes TVSEC_FMT as %lld,
and adds a cast to 'long long' like every other such printk has at the moment
(allowing them the casts to be mass-removed after my patch is merged).

      Arnd
