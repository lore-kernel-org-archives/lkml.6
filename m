Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932487AbeE3Vhm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 17:37:42 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:45374 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932222AbeE3Vhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 17:37:38 -0400
X-Google-Smtp-Source: ADUXVKI63/6qgPl/ShJxL5CXRafpZzXQ5JKtfVQUOhRhexxTi6hSBIk9GKII421a59jmw790q6cH9MXKwce+e1d9s6Q=
MIME-Version: 1.0
In-Reply-To: <20180530203024.2792802-1-arnd@arndb.de>
References: <20180530203024.2792802-1-arnd@arndb.de>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 30 May 2018 14:37:37 -0700
X-Google-Sender-Auth: uLWPmiDIDHW9raEIB6oIJ3aPFfE
Message-ID: <CAGXu5jL2bN9K2N1kvNDTc8zUAPWQeShk4YAMRcLRyU=ZMGMgyA@mail.gmail.com>
Subject: Re: [PATCH] pstore: Remove bogus format string definition
To: Arnd Bergmann <arnd@arndb.de>
Cc: y2038 Mailman List <y2038@lists.linaro.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, Geliang Tang <geliangtang@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 1:30 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> The pstore conversion to timespec64 introduces its own method of passing
> seconds into sscanf() and sprintf() type functions to work around the
> timespec64 definition on 64-bit systems that redefine it to 'timespec'.
>
> That hack is now finally getting removed, but that means we get a (harmless)
> warning once both patches are merged:
>
> fs/pstore/ram.c: In function 'ramoops_read_kmsg_hdr':
> fs/pstore/ram.c:39:29: error: format '%ld' expects argument of type 'long int *', but argument 3 has type 'time64_t *' {aka 'long long int *'} [-Werror=format=]
>  #define RAMOOPS_KERNMSG_HDR "===="
>                              ^~~~~~
> fs/pstore/ram.c:167:21: note: in expansion of macro 'RAMOOPS_KERNMSG_HDR'
>
> This removes the pstore specific workaround and uses the same method that
> we have in place for all other functions that print a timespec64.
>
> Related to this, I found that the kasprintf() output contains an incorrect
> nanosecond values for any number starting with zeroes, and I adapt the
> format string accordingly.
>
> Link: https://lkml.org/lkml/2018/5/19/115
> Link: https://lkml.org/lkml/2018/5/16/1080
> Fixes: 0f0d83b99ef7 ("pstore: Convert internal records to timespec64")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Kees Cook <keescook@chromium.org>

Please feel free to carry this patch in which ever series/tree it is needed. :P

-Kees

> ---
>  fs/pstore/ram.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
>
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index 69e893076ab7..bbd1e357c23d 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -38,11 +38,6 @@
>
>  #define RAMOOPS_KERNMSG_HDR "===="
>  #define MIN_MEM_SIZE 4096UL
> -#if __BITS_PER_LONG == 64
> -# define TVSEC_FMT "%ld"
> -#else
> -# define TVSEC_FMT "%lld"
> -#endif
>
>  static ulong record_size = MIN_MEM_SIZE;
>  module_param(record_size, ulong, 0400);
> @@ -164,15 +159,15 @@ static int ramoops_read_kmsg_hdr(char *buffer, struct timespec64 *time,
>         char data_type;
>         int header_length = 0;
>
> -       if (sscanf(buffer, RAMOOPS_KERNMSG_HDR TVSEC_FMT ".%lu-%c\n%n",
> -                  &time->tv_sec, &time->tv_nsec, &data_type,
> +       if (sscanf(buffer, RAMOOPS_KERNMSG_HDR "%lld.%lu-%c\n%n",
> +                  (time64_t *)&time->tv_sec, &time->tv_nsec, &data_type,
>                    &header_length) == 3) {
>                 if (data_type == 'C')
>                         *compressed = true;
>                 else
>                         *compressed = false;
> -       } else if (sscanf(buffer, RAMOOPS_KERNMSG_HDR TVSEC_FMT ".%lu\n%n",
> -                         &time->tv_sec, &time->tv_nsec,
> +       } else if (sscanf(buffer, RAMOOPS_KERNMSG_HDR "%lld.%lu\n%n",
> +                         (time64_t *)&time->tv_sec, &time->tv_nsec,
>                           &header_length) == 2) {
>                 *compressed = false;
>         } else {
> @@ -367,8 +362,8 @@ static size_t ramoops_write_kmsg_hdr(struct persistent_ram_zone *prz,
>         char *hdr;
>         size_t len;
>
> -       hdr = kasprintf(GFP_ATOMIC, RAMOOPS_KERNMSG_HDR TVSEC_FMT ".%lu-%c\n",
> -               record->time.tv_sec,
> +       hdr = kasprintf(GFP_ATOMIC, RAMOOPS_KERNMSG_HDR "%lld.%06lu-%c\n",
> +               (time64_t)record->time.tv_sec,
>                 record->time.tv_nsec / 1000,
>                 record->compressed ? 'C' : 'D');
>         WARN_ON_ONCE(!hdr);
> --
> 2.9.0
>



-- 
Kees Cook
Pixel Security
