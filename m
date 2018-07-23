Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D3EECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 18:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4CBE20874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 18:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYr7Wj6B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4CBE20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388123AbeGWUBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 16:01:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:47688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387970AbeGWUBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 16:01:46 -0400
Received: from jouet.infradead.org (unknown [177.79.84.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE08F20852;
        Mon, 23 Jul 2018 18:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532372350;
        bh=CVN3G3y1dWYeY4MHUGXvpMdNB8rutxFryo7dUc9FiZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eYr7Wj6B5R9KCzacHtfqnYhiVVKgAg8U9cpOsdV6HQ870TfrToCaDWtYWz21CMUBl
         9kWv5dex6pZsnGT57oJZzszSKhvEKSHlBe6VUvTt8iKy8oDDwZ1goPymAB3g9cr2PW
         HdhjXFilK9I7JgWuBWN/CWPAtOT0xAr7ucxSGL1Y=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 429F2140260; Mon, 23 Jul 2018 15:59:05 -0300 (-03)
Date:   Mon, 23 Jul 2018 15:59:05 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Kim Phillips <kim.phillips@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] perf arm64: Generate system call table from
 asm/unistd.h
Message-ID: <20180723185905.GA13220@kernel.org>
References: <20180706163443.22626f5e9e10e5bab5e5c662@arm.com>
 <20180718155752.GA1814@kernel.org>
 <20180720150653.GD4329@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720150653.GD4329@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jul 20, 2018 at 12:06:53PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Jul 18, 2018 at 12:57:52PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Fri, Jul 06, 2018 at 04:34:43PM -0500, Kim Phillips escreveu:
> > > This should speed up accessing new system calls introduced with the
> > > kernel rather than waiting for libaudit updates to include them.
> > > 
> > > Using the existing other arch scripts resulted in this error:
> > > 
> > > tools/perf/arch/arm64/entry/syscalls//mksyscalltbl: 25: printf: __NR3264_ftruncate: expected numeric value
> > > 
> > > because, unlike other arches, asm-generic's unistd.h does things like:
> > > 
> > >  #define __NR_ftruncate __NR3264_ftruncate
> > > 
> > > Turning the scripts printf's %d into a %s resulted in this in the
> > > generated syscalls.c file:
> > > 
> > >     static const char *syscalltbl_arm64[] = {
> > >             [__NR3264_ftruncate] = "ftruncate",
> > > 
> > > So we use the host C compiler to fold the macros, and print them out
> > > from within a temporary C program, in order to get the correct output:
> > > 
> > >     static const char *syscalltbl_arm64[] = {
> > >             [46] = "ftruncate",
> > > 
> > 
> > One of my containers, ubuntu:14.04.4-x-linaro-arm64, that build perf in
> > a cross-build env, failed to build, please take a look if what is in the
> > output below is enough for you to find the problem, perhaps you forgot
> > to add the new files grabbed from the kernel sources to the
> > tools/perf/MANIFEST file that is used to create the tarball that is then
> > used to test build it? I'll check that later, in a hurry right now.
> 

So it fails with:

perfbuilder@7dbfe2fe9bef:/git/perf$ tools/perf/arch/arm64/entry/syscalls/mksyscalltbl /gcc-linaro-5.4.1-2017.05-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-gcc gcc tools/arch/arm64/include/uapi/asm/unistd.h
static const char *syscalltbl_arm64[] = {
<stdin>: In function 'main':
<stdin>:257:38: error: '__NR_getrandom' undeclared (first use in this function)
<stdin>:257:38: note: each undeclared identifier is reported only once for each function it appears in
<stdin>:258:41: error: '__NR_memfd_create' undeclared (first use in this function)
<stdin>:259:32: error: '__NR_bpf' undeclared (first use in this function)
<stdin>:260:37: error: '__NR_execveat' undeclared (first use in this function)
tools/perf/arch/arm64/entry/syscalls/mksyscalltbl: 47: tools/perf/arch/arm64/entry/syscalls/mksyscalltbl: /tmp/create-table-60liya: Permission denied

Because it uses as input this file
tools/arch/arm64/include/uapi/asm/unistd.h, that basically just does:

perfbuilder@1015f8b85ded:/git/perf$ cat tools/arch/arm64/include/uapi/asm/unistd.h
#define __ARCH_WANT_RENAMEAT

#include <asm-generic/unistd.h>
perfbuilder@1015f8b85ded:/git/perf$

And this ends up getting the system's asm-generic/unistd.h file, not the one
shipped in tools/, so:

perfbuilder@1015f8b85ded:/git/perf$ grep bpf /usr/include/asm-generic/unistd.h 
perfbuilder@1015f8b85ded:/git/perf$ grep _NR_ /usr/include/asm-generic/unistd.h  | tail -4
#define __NR_mmap2 __NR3264_mmap
#define __NR_fadvise64_64 __NR3264_fadvise64
#define __NR_stat64 __NR3264_stat
#define __NR_lstat64 __NR3264_lstat
perfbuilder@1015f8b85ded:/git/perf$ 

A quick hack is to do this instead:

diff --git a/tools/perf/arch/arm64/Makefile b/tools/perf/arch/arm64/Makefile
index 85fdf4949db3..f013b115dc86 100644
--- a/tools/perf/arch/arm64/Makefile
+++ b/tools/perf/arch/arm64/Makefile
@@ -11,7 +11,7 @@ PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
 
 out    := $(OUTPUT)arch/arm64/include/generated/asm
 header := $(out)/syscalls.c
-sysdef := $(srctree)/tools/arch/arm64/include/uapi/asm/unistd.h
+sysdef := $(srctree)/tools/include/uapi/asm-generic/unistd.h
 sysprf := $(srctree)/tools/perf/arch/arm64/entry/syscalls/
 systbl := $(sysprf)/mksyscalltbl
 
diff --git a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
index c21023509960..52e197317d3e 100755
--- a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
+++ b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
@@ -28,6 +28,7 @@ create_table_from_c()
 
 	cat <<-_EoHEADER
 		#include <stdio.h>
+		#define __ARCH_WANT_RENAMEAT
 		#include "$input"
 		int main(int argc, char *argv[])
 		{
