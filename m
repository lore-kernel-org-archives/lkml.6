Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE40FC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE6F2176F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549308485;
	bh=WwBcvPhk662nuEkTjSc2TB+F6rMqDNf/TtbxrhkvjGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XPyZWrtTre8UXeoKsfriSPqLUhdBB5Gg0ad5bjAlHsuCy9bMHHsvqd5vMRsocXULn
	 Y2X7A9fCs+a+pA205XGhBbZzD7Qs8Ax/F7MOtelnn6jcPEx7C19fq5MOTIhBrgieWv
	 Wmkzwf3A1E3Wo+XDlp/fgjVdfFDSrHpYgIa6wzok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729951AbfBDT2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 14:28:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:56598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727544AbfBDT2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 14:28:03 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A30D620821;
        Mon,  4 Feb 2019 19:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549308481;
        bh=WwBcvPhk662nuEkTjSc2TB+F6rMqDNf/TtbxrhkvjGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rP2gVosya9qGim0K9Nr4AwuWD2xPwbwk95dl4bgykUW/mDhLX688W6H5WI3ggYHNP
         hrc/xLvx464yDGt3KmL+12OLScBWtQ8CszKlWIYYvKOe2xeb9eCVqX4jnhW270bIDd
         7te8zi2NsqiGF5Ce0ocq6pSo15o0+PCOp/jLJ8IA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D6AD34034F; Mon,  4 Feb 2019 16:27:58 -0300 (-03)
Date:   Mon, 4 Feb 2019 16:27:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Coresight ML <coresight@lists.linaro.org>
Subject: Re: [PATCH v7 0/8] perf cs-etm: Add support for sample flags
Message-ID: <20190204192758.GJ5593@kernel.org>
References: <20190129122842.32041-1-leo.yan@linaro.org>
 <CANLsYky9fUcCkek3CWh8vXpRN07YbnnPirWxtRLum13a1FEQ2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYky9fUcCkek3CWh8vXpRN07YbnnPirWxtRLum13a1FEQ2g@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 04, 2019 at 11:41:28AM -0700, Mathieu Poirier escreveu:
> On Tue, 29 Jan 2019 at 05:29, Leo Yan <leo.yan@linaro.org> wrote:
> >
> > This patch seris adds support for sample flags so can facilitate perf
> > to print sample flags for branch instruction.
> >
> > Patch 0001 is used to save last branch information in packet structure,
> > this includes instruction type, subtype and condition flag to help
> > making decision for which branch instruction it is.  It passes related
> > information from decoder layer to cs-etm.c, so we use cs-etm.c as a
> > central place to set sample flags.
> >
> > Patch 0002 is used to set sample flags for instruction range packet.
> >
> > Patch 0003 is used to set sample flags for trace discontinuity packet.
> >
> > Patches 0004/0005/0006 are preparation for exception packet handling:
> > Patch 0004 addes exception number in packet; pacth 0005/0006 is to use
> > traceID/metadata tuple to access metadata pointer based on traceID, this
> > can help decide if the CPU is connected with ETMv3 or ETMv4, ETMv3 and
> > ETMv4 have totally different definition for exception numbers.
> >
> > Patch 0007 sets sample flags for exception packet; patch 0008 support
> > sample flags for exception return packet.
> >
> > This patch set is applied on the acme's perf core branch with the latest
> > commit bdec77cfe58d ("Merge remote-tracking branch 'tip/perf/urgent'
> > into perf/core").
> >
> > This patch set has been verified for x86 and arm64 perf building and
> > also is verified with below command:
> >
> > Before:
> >
> >   # perf script -F,-time,+flags -k vmlinux
> >
> >   [...]
> >
> >   main  6650 [001]          1              branches:                                f7b08490 lib_loop_test+0xc (/root/coresight_test/libcstest.so)
> >   main  6650 [001]          1              branches:                                f7b084a2 lib_loop_test+0x1e (/root/coresight_test/libcstest.so)
> >   main  6650 [001]          1              branches:                                f7b084a2 lib_loop_test+0x1e (/root/coresight_test/libcstest.so)
> >   main  6650 [001]          1              branches:                                f7b084a2 lib_loop_test+0x1e (/root/coresight_test/libcstest.so)
> >   main  6650 [001]          1              branches:                                f7b084a2 lib_loop_test+0x1e (/root/coresight_test/libcstest.so)
> >   main  6650 [001]          1              branches:                                f7b084a2 lib_loop_test+0x1e (/root/coresight_test/libcstest.so)
> >   main  6650 [001]          1              branches:                                f7b084b0 lib_loop_test+0x2c (/root/coresight_test/libcstest.so)
> >   main  6650 [001]          1              branches:                                  6b65a8 main+0x1c (/root/coresight_test/main)
> >   main  6650 [001]          1              branches:                                  6b6448 printf@plt+0x8 (/root/coresight_test/main)
> >   main  6650 [001]          1              branches:                                  6b642c _init+0x18 (/root/coresight_test/main)
> >   main  6650 [001]          1              branches:                                f7b2d23c [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
> >   main  6650 [001]          1              branches:                                f7b2906e [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
> >   main  6650 [001]          1              branches:                                f7b2559a [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
> >   main  6650 [001]          1              branches:                                f7b2559a [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
> >   main  6650 [001]          1              branches:                                f7b2559a [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
> >   main  6650 [001]          1              branches:                                f7b2559a [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
> >   main  6650 [001]          1              branches:                                f7b2559a [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
> >   main  6650 [001]          1              branches:                                f7b255ee [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
> >   main  6650 [001]          1              branches:                                f7b25634 [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
> >
> >   [...]
> >
> >
> > After:
> >
> >   # perf script -F,-time,+flags -k vmlinux
> >
> >   [...]
> >
> >   main  6650 [001]          1              branches:   jmp                          f7b08490 lib_loop_test+0xc (/root/coresight_test/libcstest.so)
> >   main  6650 [001]          1              branches:   jcc                          f7b084a2 lib_loop_test+0x1e (/root/coresight_test/libcstest.so)
> >   main  6650 [001]          1              branches:   jcc                          f7b084a2 lib_loop_test+0x1e (/root/coresight_test/libcstest.so)
> >   main  6650 [001]          1              branches:   jcc                          f7b084a2 lib_loop_test+0x1e (/root/coresight_test/libcstest.so)
> >   main  6650 [001]          1              branches:   jcc                          f7b084a2 lib_loop_test+0x1e (/root/coresight_test/libcstest.so)
> >   main  6650 [001]          1              branches:   jcc                          f7b084a2 lib_loop_test+0x1e (/root/coresight_test/libcstest.so)
> >   main  6650 [001]          1              branches:   return                       f7b084b0 lib_loop_test+0x2c (/root/coresight_test/libcstest.so)
> >   main  6650 [001]          1              branches:   call                           6b65a8 main+0x1c (/root/coresight_test/main)
> >   main  6650 [001]          1              branches:   return                         6b6448 printf@plt+0x8 (/root/coresight_test/main)
> >   main  6650 [001]          1              branches:   return                         6b642c _init+0x18 (/root/coresight_test/main)
> >   main  6650 [001]          1              branches:   call                         f7b2d23c [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
> >   main  6650 [001]          1              branches:   call                         f7b2906e [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
> >   main  6650 [001]          1              branches:   jcc                          f7b2559a [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
> >   main  6650 [001]          1              branches:   jcc                          f7b2559a [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
> >   main  6650 [001]          1              branches:   jcc                          f7b2559a [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
> >   main  6650 [001]          1              branches:   jcc                          f7b2559a [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
> >   main  6650 [001]          1              branches:   jcc                          f7b2559a [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
> >   main  6650 [001]          1              branches:   jmp                          f7b255ee [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
> >   main  6650 [001]          1              branches:   call                         f7b25634 [unknown] (/usr/lib/arm-linux-gnueabihf/ld-2.27.so)
> >
> >   [...]
> 
> Good day Arnaldo,
> 
> I have reviewed, compiled and tested this patchset - please consider
> for inclusion.


Thanks, I'll check it after I push perf/urgent, that is almost ready.

> Regards,
> Mathieu
> 
> >
> >
> > Changes from v6:
> > * Addressed Mathieu's suggestion for patch 0005, refined its commit log
> >   and comment and fixed cs_etm__get_cpu() definitions in header file;
> >   also tested with perf for Arm and x86 buildings.
> > * Added Mathieu's review tags.
> >
> > Changes from v5:
> > * Addressed Rob's suggestion to add specification info for exception
> >   number encoding;
> > * Added Rob's review tag in patch 0007.
> >
> > Changes from v4:
> > * Fixed typos in comments, and removed redundant info from commit log;
> > * Addressed Mathieu's suggestion to add helper functions for metadata
> >   fields (CS_ETM_CPU and CS_ETM_MAGIC) accessing;
> > * Addressed Mathieu's suggestion to include headers with alphabetical
> >   order.
> >
> > Changes from v3:
> > * Fixed typos in commit logs;
> > * Rearranged fields in cs_etm_packet by grouping with same variable
> >   types;
> > * Fixed ETMv4 exception number which pointed by Mike;
> > * Fixed ETMv4 SVC / SMC / HVC in the same CALL, by checking svc
> >   instruction to distinguish them;
> > * Refine ETMv4 return exception packet handling.
> >
> > Changes from v2:
> > * Addressed Mathieu's suggestion to split one big patch to 3 small
> >   patches for setting sample flags, one is for instruction range
> >   packet, one is for discontinuity packet and one is for exception
> >   packet.
> > * Added supporting for ETMv3 exception packet.
> > * Followed Mathieu's suggestion to move all sample flags handling
> >   from decoder layer to cs-etm.c, thus it has enough info to set flags
> >   based on trace context in single place.
> >
> > Changes from v1:
> > * Moved exception packets handling patches into patch series 'perf
> >   cs-etm: Correct packets handling'.
> > * Added sample flags fixing up for TRACE_OFF packet.
> > * Created a new function which is used to maintain flags fixing up.
> >
> >
> > Leo Yan (8):
> >   perf cs-etm: Add last instruction information in packet
> >   perf cs-etm: Set sample flags for instruction range packet
> >   perf cs-etm: Set sample flags for trace discontinuity
> >   perf cs-etm: Add exception number in exception packet
> >   perf cs-etm: Change tuple from traceID-CPU# to traceID-metadata
> >   perf cs-etm: Add traceID in packet
> >   perf cs-etm: Set sample flags for exception packet
> >   perf cs-etm: Set sample flags for exception return packet
> >
> >  .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  41 +-
> >  .../perf/util/cs-etm-decoder/cs-etm-decoder.h |   6 +
> >  tools/perf/util/cs-etm.c                      | 394 +++++++++++++++++-
> >  tools/perf/util/cs-etm.h                      |  53 ++-
> >  4 files changed, 476 insertions(+), 18 deletions(-)
> >
> > --
> > 2.17.1
> >

-- 

- Arnaldo
