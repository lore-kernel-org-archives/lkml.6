Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E63DC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C0BB2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJd5J8Vw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C0BB2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbeJIAuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 20:50:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbeJIAuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 20:50:06 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55AF5213A2;
        Mon,  8 Oct 2018 17:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539020237;
        bh=VuwWaYyrzAJK5joLGq+3rkUEEEI9mJmA5rYkG4ooUY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EJd5J8VwGggNs2L3PVPv9wKzHB50ll0N85RV642u3d5DxOPu5eszOZM0CUl8DIl4w
         O+5XTn86iq01jFZmKyFhV64Fk80nQPy7823CJ2IPjFnKFjqC2DN0bsgCaUxDB9te/n
         Wguz83rVUBKytANq40t4ote82Rb+EU6u0JmGh3pg=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id CD35B141DDC; Mon,  8 Oct 2018 14:37:13 -0300 (-03)
Date:   Mon, 8 Oct 2018 14:37:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] perf record: encode -k clockid frequency into Perf
 trace
Message-ID: <20181008173713.GQ3541@kernel.org>
References: <4f558425-b420-d99c-ff19-8f91e8ed5302@linux.intel.com>
 <20181004123657.GD32371@krava>
 <20181006115151.GJ20250@kernel.org>
 <8ad9dfac-e42f-3828-910f-e8ea8f3bfcbc@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ad9dfac-e42f-3828-910f-e8ea8f3bfcbc@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Oct 06, 2018 at 04:14:11PM +0300, Alexey Budankov escreveu:
> On 06.10.2018 14:51, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Oct 04, 2018 at 02:36:57PM +0200, Jiri Olsa escreveu:
> >> On Wed, Oct 03, 2018 at 07:57:12PM +0300, Alexey Budankov wrote:
> >>>
> >>> Store -k clockid frequency into Perf trace to enable timestamps 
> >>> derived metrics conversion into wall clock time on reporting stage.
> >>>
> >>> Below is the example of perf report output:
> >>>
> >>> tools/perf/perf record -k raw -- ../../matrix/linux/matrix.gcc
> >>> ...
> >>> [ perf record: Captured and wrote 31.222 MB perf.data (818054 samples) ]
> >>>
> >>> tools/perf/perf report --header
> >>> # ========
> >>> ...
> >>> # event : name = cycles:ppp, , size = 112, { sample_period, sample_freq } = 4000, sample_type = IP|TID|TIME|PERIOD, disabled = 1, inherit = 1, mmap = 1, comm = 1, freq = 1, enable_on_exec = 1, task = 1, precise_ip = 3, sample_id_all = 1, exclude_guest = 1, mmap2 = 1, comm_exec = 1, use_clockid = 1, clockid = 4
> >>> ...
> >>> # clockid frequency: 1000 MHz
> >>> ...
> >>> # ========
> >>>
> >>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> >> Reviewed-by: Jiri Olsa <jolsa@kernel.org>
> > 
> > 
> > 
> >   CC       /tmp/build/perf/builtin-script.o
> >   CC       /tmp/build/perf/util/header.o
> > util/header.c: In function 'print_clockid':
> > util/header.c:1520:38: error: format '%ld' expects argument of type 'long int', but argument 3 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
> >   fprintf(fp, "# clockid frequency: %ld MHz\n",
> >                                     ~~^
> >                                     %d
> >    ff->ph->env.clockid_res_ns * 1000);
> >    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~   
> > util/header.c: In function 'process_clockid':
> > util/header.c:2552:22: error: passing argument 2 of 'do_read_u64' from incompatible pointer type [-Werror=incompatible-pointer-types]
> >   if (do_read_u64(ff, &clockid_res_ns))
> >                       ^~~~~~~~~~~~~~~
> > util/header.c:229:49: note: expected 'u64 *' {aka 'long long unsigned int *'} but argument is of type 'size_t *' {aka 'unsigned int *'}
> >  static int do_read_u64(struct feat_fd *ff, u64 *addr)
> >                                             ~~~~~^~~~
> > In file included from /usr/mips-linux-gnu/include/string.h:494,
> >                  from util/string2.h:7,
> >                  from util/header.c:5:
> > In function 'memcpy',
> >     inlined from '__do_read_buf' at util/header.c:202:2,
> >     inlined from '__do_read' at util/header.c:213:9,
> >     inlined from 'do_read_u64' at util/header.c:233:8,
> >     inlined from 'process_clockid' at util/header.c:2552:6:
> > /usr/mips-linux-gnu/include/bits/string_fortified.h:34:10: error: '__builtin___memcpy_chk' forming offset [5, 8] is out of the bounds [0, 4] of object 'clockid_res_ns' with type 'size_t' {aka 'unsigned int'} [-Werror=array-bounds]
> >    return __builtin___memcpy_chk (__dest, __src, __len, __bos0 (__dest));
> >           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > util/header.c: In function 'process_clockid':
> > util/header.c:2550:9: note: 'clockid_res_ns' declared here
> >   size_t clockid_res_ns;
> >          ^~~~~~~~~~~~~~
> >   MKDIR    /tmp/build/perf/scripts/
> >   LD       /tmp/build/perf/scripts/libperf-in.o
> >   CC       /tmp/build/perf/builtin-kmem.o
> >   CC       /tmp/build/perf/builtin-lock.o
> >   CC       /tmp/build/perf/ui/browsers/map.o
> >   CC       /tmp/build/perf/builtin-kvm.o
> > cc1: all warnings being treated as errors
> > mv: cannot stat '/tmp/build/perf/util/.header.o.tmp': No such file or directory
> > make[4]: *** [/git/linux/tools/build/Makefile.build:97: /tmp/build/perf/util/header.o] Error 1
> > make[3]: *** [/git/linux/tools/build/Makefile.build:139: util] Error 2
> > make[3]: *** Waiting for unfinished jobs....
> > 
> 
> Hope this helps.
> 
> ---
> tools/perf/util/header.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 4ce5339158f7..afaebbb53035 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -1517,7 +1517,7 @@ static void print_cpu_topology(struct feat_fd *ff, FILE *fp)
>  
>  static void print_clockid(struct feat_fd *ff, FILE *fp)
>  {
> -       fprintf(fp, "# clockid frequency: %ld MHz\n",
> +       fprintf(fp, "# clockid frequency: %zd MHz\n",
>                 ff->ph->env.clockid_res_ns * 1000);
>  }
>  
> @@ -2549,7 +2549,7 @@ static int process_clockid(struct feat_fd *ff,
>  {
>         size_t clockid_res_ns;
>  
> -       if (do_read_u64(ff, &clockid_res_ns))
> +       if (__do_read(ff, &clockid_res_ns, sizeof(clockid_res_ns)))
>                 return -1;
>  
>         ff->ph->env.clockid_res_ns = clockid_res_ns;

Are you sure about that? Isn't this always encoded as an u64? Also, look
at what else do_read_u64 does besides just reading:

static int do_read_u64(struct feat_fd *ff, u64 *addr)
{
        int ret;

        ret = __do_read(ff, addr, sizeof(*addr));
        if (ret)
                return ret;

        if (ff->ph->needs_swap)
                *addr = bswap_64(*addr);
        return 0;
}

/me goes to look at the original patch to see how you encode that
clod_id_res_ns in the perf.data header...

- Arnaldo
