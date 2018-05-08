Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932249AbeEHJim (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 05:38:42 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36213 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754291AbeEHJik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 05:38:40 -0400
X-Google-Smtp-Source: AB8JxZoJ7TLQbv7EDKMWQjfk5nq4PIFlYbpKagog4IFT2U0NY3IT/VgHfWF80BfICVhzS23DACPChxYxZTvUp99LhjY=
MIME-Version: 1.0
In-Reply-To: <20180417085936.19512-1-anders.roxell@linaro.org>
References: <20180417085936.19512-1-anders.roxell@linaro.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Tue, 8 May 2018 11:38:39 +0200
Message-ID: <CADYN=9L47uYKQqZVz91EDHNd0aWXrTPc_tbdAZHBeWLKTHgcTA@mail.gmail.com>
Subject: Re: [PATCH] selftests/memfd: move common code into common.c
To: Shuah Khan <shuah@kernel.org>, David Herrmann <dh.herrmann@gmail.com>
Cc: linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 April 2018 at 10:59, Anders Roxell <anders.roxell@linaro.org> wrote:
> Remove code duplication, in the current code, we move common code for
> memfd to common.c.
>
> The duplicate functions got added in commit 87b2d44026e0 ("selftests:
> add memfd/sealing page-pinning tests")
>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  tools/testing/selftests/memfd/common.c     | 37 +++++++++++++++++++
>  tools/testing/selftests/memfd/common.h     |  4 ++
>  tools/testing/selftests/memfd/fuse_test.c  | 43 +---------------------
>  tools/testing/selftests/memfd/memfd_test.c | 37 -------------------
>  4 files changed, 43 insertions(+), 78 deletions(-)
>
> diff --git a/tools/testing/selftests/memfd/common.c b/tools/testing/selftests/memfd/common.c
> index 8eb3d75f6e60..fee1f07828a3 100644
> --- a/tools/testing/selftests/memfd/common.c
> +++ b/tools/testing/selftests/memfd/common.c
> @@ -44,3 +44,40 @@ int sys_memfd_create(const char *name, unsigned int flags)
>
>         return syscall(__NR_memfd_create, name, flags);
>  }
> +
> +unsigned int mfd_assert_get_seals(int fd)
> +{
> +       int r;
> +
> +       r = fcntl(fd, F_GET_SEALS);
> +       if (r < 0) {
> +               printf("GET_SEALS(%d) failed: %m\n", fd);
> +               abort();
> +       }
> +
> +       return (unsigned int)r;
> +}
> +
> +void mfd_assert_add_seals(int fd, unsigned int seals)
> +{
> +       int r;
> +       unsigned int s;
> +
> +       s = mfd_assert_get_seals(fd);
> +       r = fcntl(fd, F_ADD_SEALS, seals);
> +       if (r < 0) {
> +               printf("ADD_SEALS(%d, %u -> %u) failed: %m\n", fd, s, seals);
> +               abort();
> +       }
> +}
> +
> +void mfd_assert_has_seals(int fd, unsigned int seals)
> +{
> +       unsigned int s;
> +
> +       s = mfd_assert_get_seals(fd);
> +       if (s != seals) {
> +               printf("%u != %u = GET_SEALS(%d)\n", seals, s, fd);
> +               abort();
> +       }
> +}
> diff --git a/tools/testing/selftests/memfd/common.h b/tools/testing/selftests/memfd/common.h
> index 522d2c630bd8..5c778d15e8c7 100644
> --- a/tools/testing/selftests/memfd/common.h
> +++ b/tools/testing/selftests/memfd/common.h
> @@ -6,4 +6,8 @@ extern int hugetlbfs_test;
>  unsigned long default_huge_page_size(void);
>  int sys_memfd_create(const char *name, unsigned int flags);
>
> +void mfd_assert_add_seals(int fd, unsigned int seals);
> +void mfd_assert_has_seals(int fd, unsigned int seals);
> +unsigned int mfd_assert_get_seals(int fd);
> +
>  #endif
> diff --git a/tools/testing/selftests/memfd/fuse_test.c b/tools/testing/selftests/memfd/fuse_test.c
> index b018e835737d..231714615861 100644
> --- a/tools/testing/selftests/memfd/fuse_test.c
> +++ b/tools/testing/selftests/memfd/fuse_test.c
> @@ -60,49 +60,10 @@ static int mfd_assert_new(const char *name, loff_t sz, unsigned int flags)
>         return fd;
>  }
>
> -static __u64 mfd_assert_get_seals(int fd)
> +static int mfd_busy_add_seals(int fd, unsigned int seals)
>  {
>         long r;
> -
> -       r = fcntl(fd, F_GET_SEALS);
> -       if (r < 0) {
> -               printf("GET_SEALS(%d) failed: %m\n", fd);
> -               abort();
> -       }
> -
> -       return r;
> -}
> -
> -static void mfd_assert_has_seals(int fd, __u64 seals)
> -{
> -       __u64 s;
> -
> -       s = mfd_assert_get_seals(fd);
> -       if (s != seals) {
> -               printf("%llu != %llu = GET_SEALS(%d)\n",
> -                      (unsigned long long)seals, (unsigned long long)s, fd);
> -               abort();
> -       }
> -}
> -
> -static void mfd_assert_add_seals(int fd, __u64 seals)
> -{
> -       long r;
> -       __u64 s;
> -
> -       s = mfd_assert_get_seals(fd);
> -       r = fcntl(fd, F_ADD_SEALS, seals);
> -       if (r < 0) {
> -               printf("ADD_SEALS(%d, %llu -> %llu) failed: %m\n",
> -                      fd, (unsigned long long)s, (unsigned long long)seals);
> -               abort();
> -       }
> -}
> -
> -static int mfd_busy_add_seals(int fd, __u64 seals)
> -{
> -       long r;
> -       __u64 s;
> +       unsigned int s;
>
>         r = fcntl(fd, F_GET_SEALS);
>         if (r < 0)
> diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
> index 10baa1652fc2..527789de69b5 100644
> --- a/tools/testing/selftests/memfd/memfd_test.c
> +++ b/tools/testing/selftests/memfd/memfd_test.c
> @@ -67,43 +67,6 @@ static void mfd_fail_new(const char *name, unsigned int flags)
>         }
>  }
>
> -static unsigned int mfd_assert_get_seals(int fd)
> -{
> -       int r;
> -
> -       r = fcntl(fd, F_GET_SEALS);
> -       if (r < 0) {
> -               printf("GET_SEALS(%d) failed: %m\n", fd);
> -               abort();
> -       }
> -
> -       return (unsigned int)r;
> -}
> -
> -static void mfd_assert_has_seals(int fd, unsigned int seals)
> -{
> -       unsigned int s;
> -
> -       s = mfd_assert_get_seals(fd);
> -       if (s != seals) {
> -               printf("%u != %u = GET_SEALS(%d)\n", seals, s, fd);
> -               abort();
> -       }
> -}
> -
> -static void mfd_assert_add_seals(int fd, unsigned int seals)
> -{
> -       int r;
> -       unsigned int s;
> -
> -       s = mfd_assert_get_seals(fd);
> -       r = fcntl(fd, F_ADD_SEALS, seals);
> -       if (r < 0) {
> -               printf("ADD_SEALS(%d, %u -> %u) failed: %m\n", fd, s, seals);
> -               abort();
> -       }
> -}
> -
>  static void mfd_fail_add_seals(int fd, unsigned int seals)
>  {
>         int r;
> --
> 2.17.0
>

Ping.
