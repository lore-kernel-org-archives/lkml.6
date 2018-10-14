Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E870C28CF8
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 01:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE552077C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 01:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f5BA+0VY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE552077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbeJNIz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 04:55:59 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:44018 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725732AbeJNIz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 04:55:59 -0400
Received: by mail-yb1-f195.google.com with SMTP id w80-v6so6267389ybe.10
        for <linux-kernel@vger.kernel.org>; Sat, 13 Oct 2018 18:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ceSVmu7zw57zcnfjGOadjSWahnGe1cDiIHo7bkrQ7gE=;
        b=f5BA+0VY9wglOkJPrNrPkyr4WaalOo5b62RGf7m0uUltlONorWfRkph42HxxdG9L4r
         JginP2yxrTVj4vBKiL+4oV2w07N9jLySDZhyqxrj+GT5P0E2JNiOzg8+yOpm00XP+a9y
         ENGEK32Quj2l6E0ymbfn7s6/oeNlZlY8xap2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ceSVmu7zw57zcnfjGOadjSWahnGe1cDiIHo7bkrQ7gE=;
        b=XwKSfTiX8WumGw41ppgwg4ezCgh8vk9yzsRFV7L2yMpBbw1wKgAY/sU6aUNgchP5ae
         /oNQYZZlptktJt4K7UfqLOhsa1Z1dMr/me+Ew8I3i51Bvno+8u4AqNzIYZZyOKkuY585
         cW/5Y463th1xFuOgTgPJODuaDHtGB/NJsxeTULeoDPw/suuZc1CtUI+lPAsSd0ZjR+4a
         YNDca9L6lPEvGIKHd7df8GkaO7nmDfcqnFJYYoUPn7hf8npDzeKqlSzoW3wzgIGHtazh
         vbkS6uY1OHCJn3z/1kRT0W/3S7GrdpOkC23yLd2w5NXMk8BbRQ55PhHSRx2LUwX63A4r
         WN3Q==
X-Gm-Message-State: ABuFfoj2z+BS3fCMOdUPCQXQYv+KlZLzzpcv3mvic8ziIAwCM7ttuuhe
        xrxG4sC5p7qhA7ONfx6ITuo/SrR4yos=
X-Google-Smtp-Source: ACcGV62DWurL8kaLOr4YvhAN0zdPdW8erVyOxz0ETvT/lQzbpnXvtY7bNis4r4VJpK/zkIrNv9fn4w==
X-Received: by 2002:a25:2404:: with SMTP id k4-v6mr6256228ybk.373.1539479807870;
        Sat, 13 Oct 2018 18:16:47 -0700 (PDT)
Received: from mail-yw1-f45.google.com (mail-yw1-f45.google.com. [209.85.161.45])
        by smtp.gmail.com with ESMTPSA id q2-v6sm1494611ywg.87.2018.10.13.18.16.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Oct 2018 18:16:46 -0700 (PDT)
Received: by mail-yw1-f45.google.com with SMTP id m129-v6so6360401ywc.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Oct 2018 18:16:45 -0700 (PDT)
X-Received: by 2002:a81:2908:: with SMTP id p8-v6mr6796961ywp.407.1539479805479;
 Sat, 13 Oct 2018 18:16:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Sat, 13 Oct 2018 18:16:44
 -0700 (PDT)
In-Reply-To: <20181013133929.28653-1-mpe@ellerman.id.au>
References: <20181013133929.28653-1-mpe@ellerman.id.au>
From:   Kees Cook <keescook@chromium.org>
Date:   Sat, 13 Oct 2018 18:16:44 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJ9_viWyBo8zzOjF7enAqz7e=xYS38Jq3gn6=6bEz8auw@mail.gmail.com>
Message-ID: <CAGXu5jJ9_viWyBo8zzOjF7enAqz7e=xYS38Jq3gn6=6bEz8auw@mail.gmail.com>
Subject: Re: [PATCH] selftests/vm: Add a test for MAP_FIXED_NOREPLACE
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>, Michal Hocko <mhocko@suse.com>,
        Linux-MM <linux-mm@kvack.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
        Joel Stanley <joel@jms.id.au>, Jason Evans <jasone@google.com>,
        David Goldblatt <davidtgoldblatt@gmail.com>,
        =?UTF-8?Q?Edward_Tomasz_Napiera=C5=82a?= <trasz@freebsd.org>,
        Daniel Micay <danielmicay@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 6:39 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Add a test for MAP_FIXED_NOREPLACE, based on some code originally by
> Jann Horn. This would have caught the overlap bug reported by Daniel Micay.
>
> I originally suggested to Michal that we create MAP_FIXED_NOREPLACE, but
> instead of writing a selftest I spent my time bike-shedding whether it
> should be called MAP_FIXED_SAFE/NOCLOBBER/WEAK/NEW .. mea culpa.

LOL. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  tools/testing/selftests/vm/.gitignore         |   1 +
>  tools/testing/selftests/vm/Makefile           |   1 +
>  .../selftests/vm/map_fixed_noreplace.c        | 206 ++++++++++++++++++
>  3 files changed, 208 insertions(+)
>  create mode 100644 tools/testing/selftests/vm/map_fixed_noreplace.c
>
> diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftests/vm/.gitignore
> index af5ff83f6d7f..31b3c98b6d34 100644
> --- a/tools/testing/selftests/vm/.gitignore
> +++ b/tools/testing/selftests/vm/.gitignore
> @@ -13,3 +13,4 @@ mlock-random-test
>  virtual_address_range
>  gup_benchmark
>  va_128TBswitch
> +map_fixed_noreplace
> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
> index e94b7b14bcb2..6e67e726e5a5 100644
> --- a/tools/testing/selftests/vm/Makefile
> +++ b/tools/testing/selftests/vm/Makefile
> @@ -12,6 +12,7 @@ TEST_GEN_FILES += gup_benchmark
>  TEST_GEN_FILES += hugepage-mmap
>  TEST_GEN_FILES += hugepage-shm
>  TEST_GEN_FILES += map_hugetlb
> +TEST_GEN_FILES += map_fixed_noreplace
>  TEST_GEN_FILES += map_populate
>  TEST_GEN_FILES += mlock-random-test
>  TEST_GEN_FILES += mlock2-tests
> diff --git a/tools/testing/selftests/vm/map_fixed_noreplace.c b/tools/testing/selftests/vm/map_fixed_noreplace.c
> new file mode 100644
> index 000000000000..d91bde511268
> --- /dev/null
> +++ b/tools/testing/selftests/vm/map_fixed_noreplace.c
> @@ -0,0 +1,206 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Test that MAP_FIXED_NOREPLACE works.
> + *
> + * Copyright 2018, Jann Horn <jannh@google.com>
> + * Copyright 2018, Michael Ellerman, IBM Corporation.
> + */
> +
> +#include <sys/mman.h>
> +#include <errno.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +
> +#ifndef MAP_FIXED_NOREPLACE
> +#define MAP_FIXED_NOREPLACE 0x100000
> +#endif
> +
> +#define BASE_ADDRESS   (256ul * 1024 * 1024)
> +
> +
> +static void dump_maps(void)
> +{
> +       char cmd[32];
> +
> +       snprintf(cmd, sizeof(cmd), "cat /proc/%d/maps", getpid());
> +       system(cmd);
> +}
> +
> +int main(void)
> +{
> +       unsigned long flags, addr, size, page_size;
> +       char *p;
> +
> +       page_size = sysconf(_SC_PAGE_SIZE);
> +
> +       flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED_NOREPLACE;
> +
> +       // Check we can map all the areas we need below
> +       errno = 0;
> +       addr = BASE_ADDRESS;
> +       size = 5 * page_size;
> +       p = mmap((void *)addr, size, PROT_NONE, flags, -1, 0);
> +
> +       printf("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
> +
> +       if (p == MAP_FAILED) {
> +               dump_maps();
> +               printf("Error: couldn't map the space we need for the test\n");
> +               return 1;
> +       }
> +
> +       errno = 0;
> +       if (munmap((void *)addr, 5 * page_size) != 0) {
> +               dump_maps();
> +               printf("Error: munmap failed!?\n");
> +               return 1;
> +       }
> +       printf("unmap() successful\n");
> +
> +       errno = 0;
> +       addr = BASE_ADDRESS + page_size;
> +       size = 3 * page_size;
> +       p = mmap((void *)addr, size, PROT_NONE, flags, -1, 0);
> +       printf("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
> +
> +       if (p == MAP_FAILED) {
> +               dump_maps();
> +               printf("Error: first mmap() failed unexpectedly\n");
> +               return 1;
> +       }
> +
> +       /*
> +        * Exact same mapping again:
> +        *   base |  free  | new
> +        *     +1 | mapped | new
> +        *     +2 | mapped | new
> +        *     +3 | mapped | new
> +        *     +4 |  free  | new
> +        */
> +       errno = 0;
> +       addr = BASE_ADDRESS;
> +       size = 5 * page_size;
> +       p = mmap((void *)addr, size, PROT_NONE, flags, -1, 0);
> +       printf("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
> +
> +       if (p != MAP_FAILED) {
> +               dump_maps();
> +               printf("Error:1: mmap() succeeded when it shouldn't have\n");
> +               return 1;
> +       }
> +
> +       /*
> +        * Second mapping contained within first:
> +        *
> +        *   base |  free  |
> +        *     +1 | mapped |
> +        *     +2 | mapped | new
> +        *     +3 | mapped |
> +        *     +4 |  free  |
> +        */
> +       errno = 0;
> +       addr = BASE_ADDRESS + (2 * page_size);
> +       size = page_size;
> +       p = mmap((void *)addr, size, PROT_NONE, flags, -1, 0);
> +       printf("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
> +
> +       if (p != MAP_FAILED) {
> +               dump_maps();
> +               printf("Error:2: mmap() succeeded when it shouldn't have\n");
> +               return 1;
> +       }
> +
> +       /*
> +        * Overlap end of existing mapping:
> +        *   base |  free  |
> +        *     +1 | mapped |
> +        *     +2 | mapped |
> +        *     +3 | mapped | new
> +        *     +4 |  free  | new
> +        */
> +       errno = 0;
> +       addr = BASE_ADDRESS + (3 * page_size);
> +       size = 2 * page_size;
> +       p = mmap((void *)addr, size, PROT_NONE, flags, -1, 0);
> +       printf("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
> +
> +       if (p != MAP_FAILED) {
> +               dump_maps();
> +               printf("Error:3: mmap() succeeded when it shouldn't have\n");
> +               return 1;
> +       }
> +
> +       /*
> +        * Overlap start of existing mapping:
> +        *   base |  free  | new
> +        *     +1 | mapped | new
> +        *     +2 | mapped |
> +        *     +3 | mapped |
> +        *     +4 |  free  |
> +        */
> +       errno = 0;
> +       addr = BASE_ADDRESS;
> +       size = 2 * page_size;
> +       p = mmap((void *)addr, size, PROT_NONE, flags, -1, 0);
> +       printf("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
> +
> +       if (p != MAP_FAILED) {
> +               dump_maps();
> +               printf("Error:4: mmap() succeeded when it shouldn't have\n");
> +               return 1;
> +       }
> +
> +       /*
> +        * Adjacent to start of existing mapping:
> +        *   base |  free  | new
> +        *     +1 | mapped |
> +        *     +2 | mapped |
> +        *     +3 | mapped |
> +        *     +4 |  free  |
> +        */
> +       errno = 0;
> +       addr = BASE_ADDRESS;
> +       size = page_size;
> +       p = mmap((void *)addr, size, PROT_NONE, flags, -1, 0);
> +       printf("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
> +
> +       if (p == MAP_FAILED) {
> +               dump_maps();
> +               printf("Error:5: mmap() failed when it shouldn't have\n");
> +               return 1;
> +       }
> +
> +       /*
> +        * Adjacent to end of existing mapping:
> +        *   base |  free  |
> +        *     +1 | mapped |
> +        *     +2 | mapped |
> +        *     +3 | mapped |
> +        *     +4 |  free  |  new
> +        */
> +       errno = 0;
> +       addr = BASE_ADDRESS + (4 * page_size);
> +       size = page_size;
> +       p = mmap((void *)addr, size, PROT_NONE, flags, -1, 0);
> +       printf("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
> +
> +       if (p == MAP_FAILED) {
> +               dump_maps();
> +               printf("Error:6: mmap() failed when it shouldn't have\n");
> +               return 1;
> +       }
> +
> +       addr = BASE_ADDRESS;
> +       size = 5 * page_size;
> +       if (munmap((void *)addr, size) != 0) {
> +               dump_maps();
> +               printf("Error: munmap failed!?\n");
> +               return 1;
> +       }
> +       printf("unmap() successful\n");
> +
> +       printf("OK\n");
> +       return 0;
> +}
> --
> 2.17.1
>



-- 
Kees Cook
Pixel Security
