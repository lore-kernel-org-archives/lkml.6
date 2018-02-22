Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751803AbeBVBwU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 20:52:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:42528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751645AbeBVBwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 20:52:19 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9315B20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 21 Feb 2018 20:52:15 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: James Hogan <jhogan@kernel.org>
Cc: linux-metag@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-mm@kvack.org
Subject: Re: [PATCH 04/13] Drop a bunch of metag references
Message-ID: <20180221205215.40fa4407@gandalf.local.home>
In-Reply-To: <20180221233825.10024-5-jhogan@kernel.org>
References: <20180221233825.10024-1-jhogan@kernel.org>
        <20180221233825.10024-5-jhogan@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Feb 2018 23:38:16 +0000
James Hogan <jhogan@kernel.org> wrote:

> Now that arch/metag/ has been removed, drop a bunch of metag references
> in various codes across the whole tree:
>  - VM_GROWSUP and __VM_ARCH_PECIFIC_1.
>  - MT_METAG_* ELF note types.
>  - METAG Kconfig dependencies (FRAME_POINTER) and ranges
>    (MAX_STACK_SIZE_MB).
>  - metag cases in tools (checkstack.pl, recordmcount.c, perf).
> 
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: linux-mm@kvack.org
> Cc: linux-metag@vger.kernel.org
> ---
>  include/linux/mm.h             |  2 --

>  include/trace/events/mmflags.h |  2 +-

>  include/uapi/linux/elf.h       |  3 ---
>  lib/Kconfig.debug              |  2 +-
>  mm/Kconfig                     |  7 +++----
>  scripts/checkstack.pl          |  4 ----

>  scripts/recordmcount.c         | 20 --------------------

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve


>  tools/perf/perf-sys.h          |  4 ----
>  8 files changed, 5 insertions(+), 39 deletions(-)



> diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
> index dbe1bb058c09..a81cffb76d89 100644
> --- a/include/trace/events/mmflags.h
> +++ b/include/trace/events/mmflags.h
> @@ -115,7 +115,7 @@ IF_HAVE_PG_IDLE(PG_idle,		"idle"		)
>  #define __VM_ARCH_SPECIFIC_1 {VM_PAT,     "pat"           }
>  #elif defined(CONFIG_PPC)
>  #define __VM_ARCH_SPECIFIC_1 {VM_SAO,     "sao"           }
> -#elif defined(CONFIG_PARISC) || defined(CONFIG_METAG) || defined(CONFIG_IA64)
> +#elif defined(CONFIG_PARISC) || defined(CONFIG_IA64)
>  #define __VM_ARCH_SPECIFIC_1 {VM_GROWSUP,	"growsup"	}
>  #elif !defined(CONFIG_MMU)
>  #define __VM_ARCH_SPECIFIC_1 {VM_MAPPED_COPY,"mappedcopy"	}


> diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
> index 16e086dcc567..8c9691c3329e 100644
> --- a/scripts/recordmcount.c
> +++ b/scripts/recordmcount.c
> @@ -33,20 +33,6 @@
>  #include <string.h>
>  #include <unistd.h>
>  
> -/*
> - * glibc synced up and added the metag number but didn't add the relocations.
> - * Work around this in a crude manner for now.
> - */
> -#ifndef EM_METAG
> -#define EM_METAG      174
> -#endif
> -#ifndef R_METAG_ADDR32
> -#define R_METAG_ADDR32                   2
> -#endif
> -#ifndef R_METAG_NONE
> -#define R_METAG_NONE                     3
> -#endif
> -
>  #ifndef EM_AARCH64
>  #define EM_AARCH64	183
>  #define R_AARCH64_NONE		0
> @@ -538,12 +524,6 @@ do_file(char const *const fname)
>  			gpfx = '_';
>  			break;
>  	case EM_IA_64:	 reltype = R_IA64_IMM64;   gpfx = '_'; break;
> -	case EM_METAG:	 reltype = R_METAG_ADDR32;
> -			 altmcount = "_mcount_wrapper";
> -			 rel_type_nop = R_METAG_NONE;
> -			 /* We happen to have the same requirement as MIPS */
> -			 is_fake_mcount32 = MIPS32_is_fake_mcount;
> -			 break;
>  	case EM_MIPS:	 /* reltype: e_class    */ gpfx = '_'; break;
>  	case EM_PPC:	 reltype = R_PPC_ADDR32;   gpfx = '_'; break;
>  	case EM_PPC64:	 reltype = R_PPC64_ADDR64; gpfx = '_'; break;
