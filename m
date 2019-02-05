Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD34C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD09F217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549379731;
	bh=DPr/+DfxCeUNO38aqOFTtaTK8v1qaC3OLAZuIip2w2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0k2pekaGyasczNhbtl9PsDUWBm5R3LU//qi5tlp5VUV2537k6qoGN66EYmah4SSxi
	 YnqHq1RDkIFowILZ2/XQxtwz8EcpwnVs4r2ubehoSiR6FLJZzAX7TaUoCoTyEN97cI
	 GCZvP8upFe/tj/ira1imu+62zEuciP6jIr1bOy70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbfBEPPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:15:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:45182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728220AbfBEPPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:15:30 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7295B20811;
        Tue,  5 Feb 2019 15:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549379728;
        bh=DPr/+DfxCeUNO38aqOFTtaTK8v1qaC3OLAZuIip2w2A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1Q1jyCeA1g3qIdbzwcUeozwB5QbQ/dRB95Btpyfkesq5fgAOEcuRH4I1pFc8g8Hul
         wwi3LoA9uhvFZI3PAFnw+uZiN55FJvmqeiOZtN+ejHZJB9/yXFOHtePdEPU+YdHRJ5
         +Ts9Q3R5Ga8J6OU0k+0GlCAoP1UdSdos9CUNWpuM=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 28F834034F; Tue,  5 Feb 2019 12:15:26 -0300 (-03)
Date:   Tue, 5 Feb 2019 12:15:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/4] perf record: bind the AIO user space buffers to
 nodes
Message-ID: <20190205151526.GC10613@kernel.org>
References: <af72a20b-117c-ec65-5fc9-35f4e81b26bd@linux.intel.com>
 <5a5adebc-afe0-4806-81cd-180d49ec043f@linux.intel.com>
 <20190204192910.GK5593@kernel.org>
 <62d94ac3-45ac-c4e4-0f9e-1084c4a25b83@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62d94ac3-45ac-c4e4-0f9e-1084c4a25b83@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 04, 2019 at 10:47:03PM +0300, Alexey Budankov escreveu:
> 
> On 04.02.2019 22:29, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Jan 22, 2019 at 08:48:54PM +0300, Alexey Budankov escreveu:
> >>
> >> Allocate and bind AIO user space buffers to the memory nodes
> >> that mmap kernel buffers are bound to.
> > 
> > [root@quaco amazonlinux]# perf test -v python
> > 18: 'import perf' in python                               :
> > --- start ---
> > test child forked, pid 526
> > Traceback (most recent call last):
> >   File "<stdin>", line 1, in <module>
> > ImportError: /tmp/build/perf/python/perf.so: undefined symbol: mbind
> 
> Argh. Missed that.
> 
> > test child finished with -1
> > ---- end ----
> > 'import perf' in python: FAILED!
> > [root@quaco amazonlinux]#
> > 
> > 
> > Please always use 'perf test' before pushing upstream, I'll try to fix
> > this one, either by linking libnuma into the python binding or by moving
> > the routines using it to a separate file.
> 
> Will do. Thanks for followup.

this seems to do the trick:

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index d3ffc18424b5..88ffa995b44b 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -56,6 +56,7 @@ ext_sources = list(map(lambda x: '%s/%s' % (src_perf, x) , ext_sources))
 perf = Extension('perf',
 		  sources = ext_sources,
 		  include_dirs = ['util/include'],
+		  libraries = ['numa'],
 		  extra_compile_args = cflags,
 		  extra_objects = [libtraceevent, libapikfs],
                  )

------------------------------------------------

[root@quaco ~]# ldd /tmp/build/perf/python/perf.cpython-37m-x86_64-linux-gnu.so
	linux-vdso.so.1 (0x00007ffdf53c3000)
	libunwind-x86_64.so.8 => /lib64/libunwind-x86_64.so.8 (0x00007fa538b82000)
	libunwind.so.8 => /lib64/libunwind.so.8 (0x00007fa538b66000)
	liblzma.so.5 => /lib64/liblzma.so.5 (0x00007fa538b3d000)
	libnuma.so.1 => /lib64/libnuma.so.1 (0x00007fa538b2f000)
	libpython3.7m.so.1.0 => /lib64/libpython3.7m.so.1.0 (0x00007fa5387b7000)
	libpthread.so.0 => /lib64/libpthread.so.0 (0x00007fa538795000)
	libc.so.6 => /lib64/libc.so.6 (0x00007fa5385cd000)
	libgcc_s.so.1 => /lib64/libgcc_s.so.1 (0x00007fa5385b2000)
	/lib64/ld-linux-x86-64.so.2 (0x00007fa538c1a000)
	libdl.so.2 => /lib64/libdl.so.2 (0x00007fa5385ac000)
	libutil.so.1 => /lib64/libutil.so.1 (0x00007fa5385a7000)
	libm.so.6 => /lib64/libm.so.6 (0x00007fa538423000)
[root@quaco ~]#

[root@quaco ~]# perf test python
18: 'import perf' in python                               : Ok
[root@quaco ~]#


So I'm ammending that hunk to the patch that introduces that mbind
usage.

Thanks,

- Arnaldo
