Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E125C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F092085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgVJc+LD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15F092085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387487AbeKFBEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 20:04:54 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36221 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729019AbeKFBEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 20:04:54 -0500
Received: by mail-pl1-f193.google.com with SMTP id w24-v6so4646740plq.3;
        Mon, 05 Nov 2018 07:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Oy9VqFWD1GSxmNnbPPQiiEQ0jvGc4EL8GlxBQs0NNGg=;
        b=mgVJc+LDo5Fqx3rrbiCnNWmfTYLc2fJ/JZI8Q89cHYj5ZhAreL9X4bPUBZVnuNvj/D
         7tG8mc/20GvNNCk7tq3iEjGq3LT60J8yz6bAcWZ9X7Nc+uy7KXzitCcz0zkUkvL2yoIp
         J85JKWqB6eJTkmq1vPWbri6CDQguLLyCYCfy9LJ2OQM9DiRGBKVFQnwyyzrLfKfj6blA
         ZnmtWWI3mfPs8QRbMc/WY4m7upk0BCsw2llZNbbDKNUM2ASlFjeHEMJqOkeLUWMYfMR2
         MAGFpKifmKcW6Z2kXhGRzFRqaVfQnvihTC1+7pWl5c+S8Fqkuq+ywriOMIO8iErVEPmj
         jAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Oy9VqFWD1GSxmNnbPPQiiEQ0jvGc4EL8GlxBQs0NNGg=;
        b=FpDEJtDKUzE2cfkp3OqyGSzgMr7OL5cedyqntqKH6FPd7+YPaMmKMWhQxwt9MY6o/C
         /o6dtZPiRVXRuK5WiJ/xSHJbladdKy+ftzSbwOF/hzlrH6HFJgFa++CMrzuj6I3buAmV
         bpO2nd1yO7CQdzCUYhsWWkmK93pViiZOAu0WcXuPopf1xJ+8m6pUkuzLwwlT1SC5y0vT
         lp9y5s3SAB5p2JX2lNTMVFQix9SDnE5d3s2DE+AxcJGbIq8BDDfQRsfvRk2cM3k9tvxY
         XyZbHIaXuZB4rKJ7O4BkfEbFbakOS/z+bUze5xFjnZS0X4BHeqNRkCvhARziG1FqQ6+X
         X2yA==
X-Gm-Message-State: AGRZ1gJBTEI38uUXGqXzzFsu4nxmolB9Cg+2GN97jzkUIdM0wywmk8AU
        ScvlVD5DUSYZyiOv6bA794s=
X-Google-Smtp-Source: AJdET5em7qr/RXY5g/uA1NtK0mhXv8b2BA9mbt01qeRat5uGsQ+YYFq/WpJyj2l8dK7ryifOcumTSg==
X-Received: by 2002:a17:902:a50e:: with SMTP id s14-v6mr22682002plq.78.1541432676460;
        Mon, 05 Nov 2018 07:44:36 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u2-v6sm29844759pfn.50.2018.11.05.07.44.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 07:44:35 -0800 (PST)
Date:   Mon, 5 Nov 2018 07:44:33 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: Re: [PATCH 19/28] perf beauty: Wire up the mmap flags table
 generator to the Makefile
Message-ID: <20181105154433.GA11115@roeck-us.net>
References: <20181031164508.4784-1-acme@kernel.org>
 <20181031164508.4784-20-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031164508.4784-20-acme@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 01:44:59PM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Now when we run 'make -C tools/perf O=/tmp/build/perf' we end up with:
> 
>   $ cat /tmp/build/perf/trace/beauty/generated/mmap_flags_array.c
>   static const char *mmap_flags[] = {
> 	[ilog2(0x40) + 1] = "32BIT",
> 	[ilog2(0x01) + 1] = "SHARED",
> 	[ilog2(0x02) + 1] = "PRIVATE",
> 	[ilog2(0x10) + 1] = "FIXED",
> 	[ilog2(0x20) + 1] = "ANONYMOUS",
> 	[ilog2(0x100000) + 1] = "FIXED_NOREPLACE",
> 	[ilog2(0x0100) + 1] = "GROWSDOWN",
> 	[ilog2(0x0800) + 1] = "DENYWRITE",
> 	[ilog2(0x1000) + 1] = "EXECUTABLE",
> 	[ilog2(0x2000) + 1] = "LOCKED",
> 	[ilog2(0x4000) + 1] = "NORESERVE",
> 	[ilog2(0x8000) + 1] = "POPULATE",
> 	[ilog2(0x10000) + 1] = "NONBLOCK",
> 	[ilog2(0x20000) + 1] = "STACK",
> 	[ilog2(0x40000) + 1] = "HUGETLB",
> 	[ilog2(0x80000) + 1] = "SYNC",
>   };
>   $
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: David Ahern <dsahern@gmail.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Wang Nan <wangnan0@huawei.com>
> Link: https://lkml.kernel.org/n/tip-t3fn7u3tjsupio6e6vkufx9m@git.kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/Makefile.perf | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index a31c5c29d53a..3ccb4f0bf088 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -1,4 +1,5 @@
>  include ../scripts/Makefile.include
> +include ../scripts/Makefile.arch
>  
>  # The default target of this Makefile is...
>  all:
> @@ -385,6 +386,8 @@ export INSTALL SHELL_PATH
>  SHELL = $(SHELL_PATH)
>  
>  linux_uapi_dir := $(srctree)/tools/include/uapi/linux
> +asm_generic_uapi_dir := $(srctree)/tools/include/uapi/asm-generic
> +arch_asm_uapi_dir := $(srctree)/tools/arch/$(ARCH)/include/uapi/asm/
>  

This doesn't work for me. With v4.20-rc1:

$ make ARCH=x86_64 defconfig
*** Default configuration is based on 'x86_64_defconfig'
#
# configuration written to .config
#
groeck@server:~/src/linux-staging$ make ARCH=x86_64 -j30 tools/perf
scripts/kconfig/conf  --syncconfig Kconfig
  BUILD:   Doing 'make -j16' parallel build
  HOSTCC   /home/groeck/src/linux-staging/tools/perf/fixdep.o
  HOSTLD   /home/groeck/src/linux-staging/tools/perf/fixdep-in.o
  LINK     /home/groeck/src/linux-staging/tools/perf/fixdep
Warning: Kernel ABI header at 'tools/include/uapi/drm/i915_drm.h' differs from latest version at 'include/uapi/drm/i915_drm.h'
diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h
Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h
Warning: Kernel ABI header at 'tools/include/uapi/asm-generic/ioctls.h' differs from latest version at 'include/uapi/asm-generic/ioctls.h'
diff -u tools/include/uapi/asm-generic/ioctls.h include/uapi/asm-generic/ioctls.h
Makefile.config:814: No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
Makefile.config:851: No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel
make[4]: *** No rule to make target '/home/groeck/src/linux-staging/tools/arch/x86_64/include/uapi/asm//mman.h', needed by '/home/groeck/src/linux-staging/tools/perf/trace/beauty/generated/mmap_flags_array.c'.  Stop.
make[4]: *** Waiting for unfinished jobs....
  PERF_VERSION = 4.20.rc1.g6510223
Makefile.perf:206: recipe for target 'sub-make' failed
make[3]: *** [sub-make] Error 2
Makefile:69: recipe for target 'all' failed
make[2]: *** [all] Error 2
Makefile:77: recipe for target 'perf' failed
make[1]: *** [perf] Error 2
Makefile:1688: recipe for target 'tools/perf' failed
make: *** [tools/perf] Error 2
groeck@server:~/src/linux-staging$ ls tools/arch
alpha  arc  arm  arm64	h8300  hexagon	ia64  microblaze  mips	parisc	powerpc  s390  sh  sparc  x86  xtensa

