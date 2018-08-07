Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E22DC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA2D4217B7
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CN2UheeI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA2D4217B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389167AbeHGPfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 11:35:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:34410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388404AbeHGPfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 11:35:19 -0400
Received: from jouet.infradead.org (unknown [179.95.176.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B61621770;
        Tue,  7 Aug 2018 13:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533648059;
        bh=v8q0k59kfiVMwCQhm1wW583DarGK17gzDWpmZuGlWpg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CN2UheeIXhCVmxmTVZG530FjtBGJTuBT9GKE1SuZWQKxey7AO7u+pVM3LSj5O529i
         SMyps1yq9HoOUBNAoLSUCYILHEwqLzHCdRK/3VOAQDTk09KJy4cZaPl0UBnmfKEyC5
         Fvhl3dmJ+euqG731H7m6/5Kjpx0z7mKN+UfHH6fw=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 54FAA140A1C; Tue,  7 Aug 2018 10:20:57 -0300 (-03)
Date:   Tue, 7 Aug 2018 10:20:57 -0300
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
Subject: Re: [PATCH] perf arm64: Fix include path for asm-generic/unistd.h
Message-ID: <20180807132057.GC4173@kernel.org>
References: <20180706163443.22626f5e9e10e5bab5e5c662@arm.com>
 <20180718155752.GA1814@kernel.org>
 <20180720150653.GD4329@kernel.org>
 <20180723185905.GA13220@kernel.org>
 <20180723190121.GB13220@kernel.org>
 <20180806172800.bbcec3cfcc51e2facc978bf2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806172800.bbcec3cfcc51e2facc978bf2@arm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 06, 2018 at 05:28:00PM -0500, Kim Phillips escreveu:
> The new syscall table support for arm64 mistakenly used the system's
> asm-generic/unistd.h file when processing the
> tools/arch/arm64/include/uapi/asm/unistd.h file's include directive:
> 
> 	#include <asm-generic/unistd.h>
> 
> See "Committer notes" section of commit 2b5882435606 "perf arm64:
> Generate system call table from asm/unistd.h" for more details.
> 
> This patch removes the committer's temporary workaround, and instructs
> the host compiler to search the build tree's include path for the right
> copy of the unistd.h file, instead of the one on the system's
> /usr/include path.
> 
> It thus fixes the committer's test that cross-builds an arm64 perf
> on an x86 platform running Ubuntu 14.04.5 LTS with an old toolchain:
> 
> $ tools/perf/arch/arm64/entry/syscalls/mksyscalltbl /gcc-linaro-5.4.1-2017.05-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-gcc gcc `pwd`/tools tools/arch/arm64/include/uapi/asm/unistd.h | grep bpf
> 	[280] = "bpf",
> 
> Cc: Hendrik Brueckner <brueckner@linux.ibm.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
> Fixes: 2b5882435606 ("perf arm64: Generate system call table from asm/unistd.h")
> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> ---
> Hi, sorry for late response - was on vacation.  I was able to reproduce
> and fix by adding this -I to the $hostcc line.  Please test, and let me
> know if this is an acceptable fix.

Looks better than what I did, that indeed was a stopgap solution till
something better came along.

There are newer toolchains in my container collection to cross build
arm64/arm:

  17 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 7.3.0-15) 7.3.0
  46 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  47 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609


I think its time to add ubuntu:18.04-x- variants, to get a more recent
toolchain on ubuntu, will do.

Anyway, I'll repeat the tests after applying your patch,

- Arnaldo
 
>  tools/perf/arch/arm64/Makefile                    | 5 +++--
>  tools/perf/arch/arm64/entry/syscalls/mksyscalltbl | 6 +++---
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/arch/arm64/Makefile b/tools/perf/arch/arm64/Makefile
> index f013b115dc86..dbef716a1913 100644
> --- a/tools/perf/arch/arm64/Makefile
> +++ b/tools/perf/arch/arm64/Makefile
> @@ -11,7 +11,8 @@ PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
>  
>  out    := $(OUTPUT)arch/arm64/include/generated/asm
>  header := $(out)/syscalls.c
> -sysdef := $(srctree)/tools/include/uapi/asm-generic/unistd.h
> +incpath := $(srctree)/tools
> +sysdef := $(srctree)/tools/arch/arm64/include/uapi/asm/unistd.h
>  sysprf := $(srctree)/tools/perf/arch/arm64/entry/syscalls/
>  systbl := $(sysprf)/mksyscalltbl
>  
> @@ -19,7 +20,7 @@ systbl := $(sysprf)/mksyscalltbl
>  _dummy := $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
>  
>  $(header): $(sysdef) $(systbl)
> -	$(Q)$(SHELL) '$(systbl)' '$(CC)' '$(HOSTCC)' $(sysdef) > $@
> +	$(Q)$(SHELL) '$(systbl)' '$(CC)' '$(HOSTCC)' $(incpath) $(sysdef) > $@
>  
>  clean::
>  	$(call QUIET_CLEAN, arm64) $(RM) $(header)
> diff --git a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
> index 52e197317d3e..2dbb8cade048 100755
> --- a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
> +++ b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
> @@ -11,7 +11,8 @@
>  
>  gcc=$1
>  hostcc=$2
> -input=$3
> +incpath=$3
> +input=$4
>  
>  if ! test -r $input; then
>  	echo "Could not read input file" >&2
> @@ -28,7 +29,6 @@ create_table_from_c()
>  
>  	cat <<-_EoHEADER
>  		#include <stdio.h>
> -		#define __ARCH_WANT_RENAMEAT
>  		#include "$input"
>  		int main(int argc, char *argv[])
>  		{
> @@ -42,7 +42,7 @@ create_table_from_c()
>  	printf "%s\n" "	printf(\"#define SYSCALLTBL_ARM64_MAX_ID %d\\n\", __NR_$last_sc);"
>  	printf "}\n"
>  
> -	} | $hostcc -o $create_table_exe -x c -
> +	} | $hostcc -I $incpath/include/uapi -o $create_table_exe -x c -
>  
>  	$create_table_exe
>  
> -- 
> 2.17.1
