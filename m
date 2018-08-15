Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B04C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0292F206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="J660RoDH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0292F206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbeHORyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 13:54:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:48710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729125AbeHORyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 13:54:31 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 562A02064A;
        Wed, 15 Aug 2018 15:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534345319;
        bh=sOXhoWQ0nRDR9kEo8r+atRRxjDTj4nj8SGx5438HAKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J660RoDHTuAM1HhZyX8B85vxeH4wvPhueDEF+IjLUj68DdheuSy52QNNuV1P9PtiF
         W1U1mVBx4QAO2B/3QaoFb4CwcYz1+r122AKpE2UmFOQG6qFNALjglDtaTHmREyEXgz
         Kv1Ak0nkNOCbBfitpbHsw5GKWXmpcLpuqLffSzM4=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 45805140A1C; Wed, 15 Aug 2018 12:01:53 -0300 (-03)
Date:   Wed, 15 Aug 2018 12:01:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org, alexander.kapshuk@gmail.com
Subject: Re: [PATCH 1/2] perf tools: Make check-headers.sh check based on
 kernel dir
Message-ID: <20180815150153.GB30887@kernel.org>
References: <20180811083915.17471-1-alexander.kapshuk@gmail.com>
 <20180813111504.3568-1-jolsa@kernel.org>
 <87mutplnwk.fsf@concordia.ellerman.id.au>
 <20180814072726.GA13931@krava>
 <20180814180644.GA24338@kernel.org>
 <20180814231120.GB3180@krava>
 <87wossaqwn.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wossaqwn.fsf@concordia.ellerman.id.au>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 15, 2018 at 08:02:48PM +1000, Michael Ellerman escreveu:
> Jiri Olsa <jolsa@redhat.com> writes:
> > On Tue, Aug 14, 2018 at 03:06:44PM -0300, Arnaldo Carvalho de Melo wrote:
> >> Em Tue, Aug 14, 2018 at 09:27:26AM +0200, Jiri Olsa escreveu:
> >> > sry.. Arnaldo, would you change it for simple cd (attached below)
> >> > or should I send the fix?

> >> Nah, I'm folding this in, to keep it bisectable.

> > any chance one of your docker tests could run build in sh/zsh? ;-)

It does already, see below :-)

> Just using an Ubuntu image, where /bin/sh == dash should work, that's
> how I hit it.

So, I do the tests only prior to pushing to Ingo, so didn't catch this,
lemme check, put that change back on, start a ubuntu:18.04 perf build
container, try to build, see if it would fail, yeah, I'd have detected
this before pushing to Ingo, so probably I have to run the tests before
pushing to my acme/perf/core branch, will try to operate like that from
now on.

[root@jouet perf]# git diff
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 466540ee8ea7..80bf84803677 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -88,7 +88,7 @@ check () {
 # differences.
 test -d ../../include || exit 0
 
-cd ../..
+pushd ../.. > /dev/null
 
 # simple diff check
 for i in $HEADERS; do
@@ -104,4 +104,4 @@ check include/uapi/linux/mman.h       '-I "^#include <\(uapi/\)*asm/mman.h>"'
 # diff non-symmetric files
 check_2 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl
 
-cd tools/perf
+popd > /dev/null
[root@jouet perf]# docker run --privileged --entrypoint=/bin/sh -v /home/acme/git:/git:Z --rm -ti docker.io/acmel/linux-perf-tools-build-ubuntu:18.04
$ bash
perfbuilder@65ead4a4734a:/$ cd /git/perf
perfbuilder@65ead4a4734a:/git/perf$ make -C tools/perf O=/tmp/build/perf/ install-bin
make: Entering directory '/git/perf/tools/perf'
  BUILD:   Doing 'make -j4' parallel build
  HOSTCC   /tmp/build/perf/fixdep.o
  HOSTLD   /tmp/build/perf/fixdep-in.o
  LINK     /tmp/build/perf/fixdep
./check-headers.sh: 91: ./check-headers.sh: pushd: not found
diff: tools/perf/arch/x86/entry/syscalls/syscall_64.tbl: No such file or directory
Warning: Kernel ABI header at 'tools/perf/arch/x86/entry/syscalls/syscall_64.tbl' differs from latest version at 'arch/x86/entry/syscalls/syscall_64.tbl'
diff -u tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl
./check-headers.sh: 107: ./check-headers.sh: popd: not found
Makefile.perf:205: recipe for target 'sub-make' failed
make[1]: *** [sub-make] Error 127
Makefile:109: recipe for target 'install-bin' failed
make: *** [install-bin] Error 2
make: Leaving directory '/git/perf/tools/perf'
perfbuilder@65ead4a4734a:/git/perf$

