Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B22DC65C31
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 13:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF912084D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 13:14:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADF912084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbeJFURd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 16:17:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:17180 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727511AbeJFURd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 16:17:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Oct 2018 06:14:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,348,1534834800"; 
   d="scan'208";a="270046058"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 06 Oct 2018 06:14:15 -0700
Received: from [10.252.5.181] (abudanko-mobl.ccr.corp.intel.com [10.252.5.181])
        by linux.intel.com (Postfix) with ESMTP id 90A6A5802E1;
        Sat,  6 Oct 2018 06:14:12 -0700 (PDT)
Subject: Re: [PATCH v3] perf record: encode -k clockid frequency into Perf
 trace
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <4f558425-b420-d99c-ff19-8f91e8ed5302@linux.intel.com>
 <20181004123657.GD32371@krava> <20181006115151.GJ20250@kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <8ad9dfac-e42f-3828-910f-e8ea8f3bfcbc@linux.intel.com>
Date:   Sat, 6 Oct 2018 16:14:11 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181006115151.GJ20250@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.10.2018 14:51, Arnaldo Carvalho de Melo wrote:
> Em Thu, Oct 04, 2018 at 02:36:57PM +0200, Jiri Olsa escreveu:
>> On Wed, Oct 03, 2018 at 07:57:12PM +0300, Alexey Budankov wrote:
>>>
>>> Store -k clockid frequency into Perf trace to enable timestamps 
>>> derived metrics conversion into wall clock time on reporting stage.
>>>
>>> Below is the example of perf report output:
>>>
>>> tools/perf/perf record -k raw -- ../../matrix/linux/matrix.gcc
>>> ...
>>> [ perf record: Captured and wrote 31.222 MB perf.data (818054 samples) ]
>>>
>>> tools/perf/perf report --header
>>> # ========
>>> ...
>>> # event : name = cycles:ppp, , size = 112, { sample_period, sample_freq } = 4000, sample_type = IP|TID|TIME|PERIOD, disabled = 1, inherit = 1, mmap = 1, comm = 1, freq = 1, enable_on_exec = 1, task = 1, precise_ip = 3, sample_id_all = 1, exclude_guest = 1, mmap2 = 1, comm_exec = 1, use_clockid = 1, clockid = 4
>>> ...
>>> # clockid frequency: 1000 MHz
>>> ...
>>> # ========
>>>
>>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> Reviewed-by: Jiri Olsa <jolsa@kernel.org>
> 
> 
> 
>   CC       /tmp/build/perf/builtin-script.o
>   CC       /tmp/build/perf/util/header.o
> util/header.c: In function 'print_clockid':
> util/header.c:1520:38: error: format '%ld' expects argument of type 'long int', but argument 3 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
>   fprintf(fp, "# clockid frequency: %ld MHz\n",
>                                     ~~^
>                                     %d
>    ff->ph->env.clockid_res_ns * 1000);
>    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~   
> util/header.c: In function 'process_clockid':
> util/header.c:2552:22: error: passing argument 2 of 'do_read_u64' from incompatible pointer type [-Werror=incompatible-pointer-types]
>   if (do_read_u64(ff, &clockid_res_ns))
>                       ^~~~~~~~~~~~~~~
> util/header.c:229:49: note: expected 'u64 *' {aka 'long long unsigned int *'} but argument is of type 'size_t *' {aka 'unsigned int *'}
>  static int do_read_u64(struct feat_fd *ff, u64 *addr)
>                                             ~~~~~^~~~
> In file included from /usr/mips-linux-gnu/include/string.h:494,
>                  from util/string2.h:7,
>                  from util/header.c:5:
> In function 'memcpy',
>     inlined from '__do_read_buf' at util/header.c:202:2,
>     inlined from '__do_read' at util/header.c:213:9,
>     inlined from 'do_read_u64' at util/header.c:233:8,
>     inlined from 'process_clockid' at util/header.c:2552:6:
> /usr/mips-linux-gnu/include/bits/string_fortified.h:34:10: error: '__builtin___memcpy_chk' forming offset [5, 8] is out of the bounds [0, 4] of object 'clockid_res_ns' with type 'size_t' {aka 'unsigned int'} [-Werror=array-bounds]
>    return __builtin___memcpy_chk (__dest, __src, __len, __bos0 (__dest));
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> util/header.c: In function 'process_clockid':
> util/header.c:2550:9: note: 'clockid_res_ns' declared here
>   size_t clockid_res_ns;
>          ^~~~~~~~~~~~~~
>   MKDIR    /tmp/build/perf/scripts/
>   LD       /tmp/build/perf/scripts/libperf-in.o
>   CC       /tmp/build/perf/builtin-kmem.o
>   CC       /tmp/build/perf/builtin-lock.o
>   CC       /tmp/build/perf/ui/browsers/map.o
>   CC       /tmp/build/perf/builtin-kvm.o
> cc1: all warnings being treated as errors
> mv: cannot stat '/tmp/build/perf/util/.header.o.tmp': No such file or directory
> make[4]: *** [/git/linux/tools/build/Makefile.build:97: /tmp/build/perf/util/header.o] Error 1
> make[3]: *** [/git/linux/tools/build/Makefile.build:139: util] Error 2
> make[3]: *** Waiting for unfinished jobs....
> 

Hope this helps.

---
tools/perf/util/header.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 4ce5339158f7..afaebbb53035 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1517,7 +1517,7 @@ static void print_cpu_topology(struct feat_fd *ff, FILE *fp)
 
 static void print_clockid(struct feat_fd *ff, FILE *fp)
 {
-       fprintf(fp, "# clockid frequency: %ld MHz\n",
+       fprintf(fp, "# clockid frequency: %zd MHz\n",
                ff->ph->env.clockid_res_ns * 1000);
 }
 
@@ -2549,7 +2549,7 @@ static int process_clockid(struct feat_fd *ff,
 {
        size_t clockid_res_ns;
 
-       if (do_read_u64(ff, &clockid_res_ns))
+       if (__do_read(ff, &clockid_res_ns, sizeof(clockid_res_ns)))
                return -1;
 
        ff->ph->env.clockid_res_ns = clockid_res_ns;
---

Thanks,
Alexey

> In a series of cross compiling environments:
> 
>   20    22.19 debian:experimental-x-mips    : FAIL mips-linux-gnu-gcc (Debian 8.1.0-12) 8.1.0
>   21    47.76 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 8.1.0-12) 8.1.0
>   22    19.27 debian:experimental-x-mipsel  : FAIL mipsel-linux-gnu-gcc (Debian 8.1.0-12) 8.1.0
>   23    51.27 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
>   24    44.45 fedora:21                     : Ok   gcc (GCC) 4.9.2 20150212 (Red Hat 4.9.2-6)
>   25    43.60 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
>   26    51.07 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
>   27    49.89 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1)
>   28    19.38 fedora:24-x-ARC-uClibc        : FAIL arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
>   29   138.25 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
>   30   145.14 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2)
>   31   163.94 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6)
>   32   166.77 fedora:28                     : Ok   gcc (GCC) 8.1.1 20180712 (Red Hat 8.1.1-5)
>   33   157.20 fedora:rawhide                : Ok   gcc (GCC) 8.2.1 20180905 (Red Hat 8.2.1-3)
>   34    40.37 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 7.3.0-r3 p1.4) 7.3.0
>   35    46.41 mageia:5                      : Ok   gcc (GCC) 4.9.2
>   36    44.33 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0
>   37    41.12 opensuse:13.2                 : Ok   gcc (SUSE Linux) 4.8.3 20140627 [gcc-4_8-branch revision 212064]
>   38    43.96 opensuse:42.1                 : Ok   gcc (SUSE Linux) 4.8.5
>   39    43.83 opensuse:42.2                 : Ok   gcc (SUSE Linux) 4.8.5
>   40    44.45 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5
>   41   141.53 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 7.3.1 20180323 [gcc-7-branch revision 258812]
>   42    35.29 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23.0.1)
>   43    41.76 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28.0.1)
>   44    32.06 ubuntu:12.04.5                : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
>   45    39.26 ubuntu:14.04.4                : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.3) 4.8.4
>   46    35.33 ubuntu:14.04.4-x-linaro-arm64 : Ok   aarch64-linux-gnu-gcc (Linaro GCC 5.5-2017.10) 5.5.0
>   47    95.94 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.10) 5.4.0 20160609
>   48    13.76 ubuntu:16.04-x-arm            : FAIL arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
>   49    34.59 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
>   50    13.59 ubuntu:16.04-x-powerpc        : FAIL powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
>   51    34.39 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
>   52    35.60 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
>   53    32.96 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
>   54   100.88 ubuntu:16.10                  : Ok   gcc (Ubuntu 6.2.0-5ubuntu12) 6.2.0 20161005
>   55   111.23 ubuntu:17.10                  : Ok   gcc (Ubuntu 7.2.0-8ubuntu3.2) 7.2.0
>   56   114.81 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
>   57    15.12 ubuntu:18.04-x-arm            : FAIL arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.3.0-16ubuntu3) 7.3.0
>   58    36.84 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.3.0-16ubuntu3) 7.3.0
>   59    11.27 ubuntu:18.04-x-m68k           : FAIL m68k-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
>   60    14.18 ubuntu:18.04-x-powerpc        : FAIL powerpc-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
>   61    39.74 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
>   62    40.19 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
>   63    70.67 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
>   64    32.72 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
>   65    14.43 ubuntu:18.04-x-sh4            : FAIL sh4-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
> 
> 
