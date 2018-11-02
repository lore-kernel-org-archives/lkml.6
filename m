Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441D4C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0919D2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:14:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0919D2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbeKCBWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 21:22:16 -0400
Received: from mga01.intel.com ([192.55.52.88]:28937 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbeKCBWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 21:22:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Nov 2018 09:14:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,456,1534834800"; 
   d="scan'208";a="97176436"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 02 Nov 2018 09:14:07 -0700
Received: from [10.252.30.191] (abudanko-mobl.ccr.corp.intel.com [10.252.30.191])
        by linux.intel.com (Postfix) with ESMTP id 205255802E4;
        Fri,  2 Nov 2018 09:14:03 -0700 (PDT)
Subject: Re: [PATCH v14 1/3]: perf util: map data buffer for preserving
 collected data
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com,
        open list <linux-kernel@vger.kernel.org>
References: <d6bd3626-8c7c-ca12-8adf-31fe15726446@linux.intel.com>
 <dccb0cfc-c0db-d32c-d4ec-03c8674aeaa9@linux.intel.com>
 <CAPhsuW41FUczTCPau1pqPq7pcvVF2vvxeAkB5j3EV3G5my9WOQ@mail.gmail.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <a2d25394-d5c6-d5b3-1923-4016f3229dd2@linux.intel.com>
Date:   Fri, 2 Nov 2018 19:14:02 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPhsuW41FUczTCPau1pqPq7pcvVF2vvxeAkB5j3EV3G5my9WOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 01.11.2018 21:47, Song Liu wrote:
> On Sun, Oct 14, 2018 at 11:44 PM Alexey Budankov
> <alexey.budankov@linux.intel.com> wrote:
>>
>>
>> The map->data buffer is used to preserve map->base profiling data
>> for writing to disk. AIO map->cblock is used to queue corresponding
>> map->data buffer for asynchronous writing.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> 
> Acked-by: Song Liu <songliubraving@fb.com>

Thanks for review!

> 
> Shall we add libaio to tools/build/Makefile.feature? It will be great to see
> whether aio is enabled in "Auto-detecting system features:".

Yes. This makes sense. There are targeted libc implementations that 
currently lack Posix AIO API support required for this patch kit.

Thanks,
Alexey

> 
> Thanks for implementing this!
> 
> Song
> 
>> ---
>> Changes in v13:
>>  - grouped aio functions under single #ifdef HAVE_AIO_SUPPORT
>> Changes in v12:
>>  - applied stub functions design for the whole patch kit
>>  - grouped AIO related data into a struct under struct perf_mmap
>> Changes in v10:
>>  - moved specific code to perf_mmap__aio_mmap(), perf_mmap__aio_munmap()
>>  - adjusted error reporting by using %m
>> Changes in v9:
>>   - implemented NO_AIO and HAVE_AIO_SUPPORT defines to cover cases of
>>     libc implementations without Posix AIO API support
>> Changes in v7:
>>   - implemented handling record.aio setting from perfconfig file
>>  Changes in v6:
>>   - adjusted setting of priorities for cblocks;
>>  Changes in v5:
>>   - reshaped layout of data structures;
>>   - implemented --aio option;
>>  Changes in v4:
>>   - converted mmap()/munmap() to malloc()/free() for mmap->data buffer management
>>  Changes in v2:
>>   - converted zalloc() to calloc() for allocation of mmap_aio array,
>>   - cleared typo and adjusted fallback branch code;
>> ---
>>  tools/perf/Makefile.config |  5 +++++
>>  tools/perf/Makefile.perf   |  7 ++++++-
>>  tools/perf/util/evlist.c   |  2 +-
>>  tools/perf/util/mmap.c     | 49 +++++++++++++++++++++++++++++++++++++++++++++-
>>  tools/perf/util/mmap.h     | 11 ++++++++++-
>>  5 files changed, 70 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
>> index f6d1a03c7523..2e90f4ce9214 100644
>> --- a/tools/perf/Makefile.config
>> +++ b/tools/perf/Makefile.config
>> @@ -355,6 +355,11 @@ endif # NO_LIBELF
>>
>>  ifeq ($(feature-glibc), 1)
>>    CFLAGS += -DHAVE_GLIBC_SUPPORT
>> +  ifndef NO_AIO
>> +    ifndef BIONIC
>> +        CFLAGS += -DHAVE_AIO_SUPPORT
>> +    endif
>> +  endif
>>  endif
>>
>>  ifdef NO_DWARF
>> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
>> index 92514fb3689f..7becc6a72cf2 100644
>> --- a/tools/perf/Makefile.perf
>> +++ b/tools/perf/Makefile.perf
>> @@ -97,8 +97,13 @@ include ../scripts/utilities.mak
>>  # Define LIBCLANGLLVM if you DO want builtin clang and llvm support.
>>  # When selected, pass LLVM_CONFIG=/path/to/llvm-config to `make' if
>>  # llvm-config is not in $PATH.
>> -
>> +#
>>  # Define NO_CORESIGHT if you do not want support for CoreSight trace decoding.
>> +#
>> +# Define NO_AIO if you do not want support of Posix AIO based trace
>> +# streaming for record mode. Currently Posix AIO trace streaming is
>> +# supported only when linking with glibc.
>> +#
>>
>>  # As per kernel Makefile, avoid funny character set dependencies
>>  unexport LC_ALL
>> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
>> index be440df29615..1a83bf2c069c 100644
>> --- a/tools/perf/util/evlist.c
>> +++ b/tools/perf/util/evlist.c
>> @@ -1028,7 +1028,7 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
>>          * Its value is decided by evsel's write_backward.
>>          * So &mp should not be passed through const pointer.
>>          */
>> -       struct mmap_params mp;
>> +       struct mmap_params mp = { .nr_cblocks = 0 };
>>
>>         if (!evlist->mmap)
>>                 evlist->mmap = perf_evlist__alloc_mmap(evlist, false);
>> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
>> index cdb95b3a1213..47cdc3ad6546 100644
>> --- a/tools/perf/util/mmap.c
>> +++ b/tools/perf/util/mmap.c
>> @@ -153,8 +153,55 @@ void __weak auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp __mayb
>>  {
>>  }
>>
>> +#ifdef HAVE_AIO_SUPPORT
>> +static int perf_mmap__aio_mmap(struct perf_mmap *map, struct mmap_params *mp)
>> +{
>> +       int delta_max;
>> +
>> +       if (mp->nr_cblocks) {
>> +               map->aio.data = malloc(perf_mmap__mmap_len(map));
>> +               if (!map->aio.data) {
>> +                       pr_debug2("failed to allocate data buffer, error %m\n");
>> +                       return -1;
>> +               }
>> +               /*
>> +                * Use cblock.aio_fildes value different from -1
>> +                * to denote started aio write operation on the
>> +                * cblock so it requires explicit record__aio_sync()
>> +                * call prior the cblock may be reused again.
>> +                */
>> +               map->aio.cblock.aio_fildes = -1;
>> +               /*
>> +                * Allocate cblock with max priority delta to
>> +                * have faster aio write system calls.
>> +                */
>> +               delta_max = sysconf(_SC_AIO_PRIO_DELTA_MAX);
>> +               map->aio.cblock.aio_reqprio = delta_max;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static void perf_mmap__aio_munmap(struct perf_mmap *map)
>> +{
>> +       if (map->aio.data)
>> +               zfree(&map->aio.data);
>> +}
>> +#else
>> +static int perf_mmap__aio_mmap(struct perf_mmap *map __maybe_unused,
>> +                              struct mmap_params *mp __maybe_unused)
>> +{
>> +       return 0;
>> +}
>> +
>> +static void perf_mmap__aio_munmap(struct perf_mmap *map __maybe_unused)
>> +{
>> +}
>> +#endif
>> +
>>  void perf_mmap__munmap(struct perf_mmap *map)
>>  {
>> +       perf_mmap__aio_munmap(map);
>>         if (map->base != NULL) {
>>                 munmap(map->base, perf_mmap__mmap_len(map));
>>                 map->base = NULL;
>> @@ -197,7 +244,7 @@ int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int c
>>                                 &mp->auxtrace_mp, map->base, fd))
>>                 return -1;
>>
>> -       return 0;
>> +       return perf_mmap__aio_mmap(map, mp);
>>  }
>>
>>  static int overwrite_rb_find_range(void *buf, int mask, u64 *start, u64 *end)
>> diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
>> index e603314dc792..a46dbdcdcc8a 100644
>> --- a/tools/perf/util/mmap.h
>> +++ b/tools/perf/util/mmap.h
>> @@ -6,6 +6,9 @@
>>  #include <linux/types.h>
>>  #include <asm/barrier.h>
>>  #include <stdbool.h>
>> +#ifdef HAVE_AIO_SUPPORT
>> +#include <aio.h>
>> +#endif
>>  #include "auxtrace.h"
>>  #include "event.h"
>>
>> @@ -26,6 +29,12 @@ struct perf_mmap {
>>         bool             overwrite;
>>         struct auxtrace_mmap auxtrace_mmap;
>>         char             event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
>> +#ifdef HAVE_AIO_SUPPORT
>> +       struct {
>> +               void             *data;
>> +               struct aiocb     cblock;
>> +       } aio;
>> +#endif
>>  };
>>
>>  /*
>> @@ -57,7 +66,7 @@ enum bkw_mmap_state {
>>  };
>>
>>  struct mmap_params {
>> -       int                         prot, mask;
>> +       int                         prot, mask, nr_cblocks;
>>         struct auxtrace_mmap_params auxtrace_mp;
>>  };
>>
> 
