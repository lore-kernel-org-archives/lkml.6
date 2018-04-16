Return-Path: <jsimmons@infradead.org>
X-Google-Smtp-Source: AIpwx48lFFewm1srBuBj6oBbuL8ULAH00Zc/BaklC5eTVgL4s36KSFVtlmpURUtD+KEjp2hn3+2R
ARC-Seal: i=1; a=rsa-sha256; t=1523850512; cv=none;
        d=google.com; s=arc-20160816;
        b=0xXZ+vooOswG2wD5N+qdGI4A22zvw7SbmeesGpnKRZFPtKGyAmLeWRhi1HG08F4mFw
         Ycjps2MgvLSY1DdicA+BFHCzT3AnPeX7iJiuG78CMXbLDV8Cz+HCoXevfQ+5Oed1yL9m
         ojhkPaBMmjPGXi1qSq1+NtU3aXppA1Gkih86duvW/KBvSEOBNEI+D+w2FpWjtpOhtVNv
         RTT1NYZaUtDczL/0HfsAVnu6NIMOPeC7eEMg2ojwi3g0nRgUIgY/Jat2rnhDuwQjC2H8
         F18gTQ8Kbg6pA/lFt/Z3Rl2asvvQYujM1CfmvGZLoY2DBjD0o3iVyDt4QKn8pt6eyGa7
         gaqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=qq2WcdwjNo6D/1nnEJfnBykosET5ZmIxpPIXqUGLEAw=;
        b=aHxJReL72qa7AgumHRdcnPBakMxASvn/Bwsr0BbXCYqws/od0pujAnHB/DqttJWIPe
         maoj6arG9tF/Gtzdf0Xc5XU9KH1HuCW6Sf0Iwc6ylEOED1Mth8L7KziqgzfgplvO4VZG
         8+O6qR44C8Xk4iGYRrli/5135c0MtEHlnA3RvhV/1WaQhsNKBJinMZ2V+Cgwe7jYXBHb
         O7XegsDBH8AcIcxmEMNJXQ/uiJpwK8kXcjCjQCPgPmaj017g/Cll4jcpMIrmgcojejVl
         ood0WyvnEBxbumgfV6zn1NxItzyasoAyoCWcQI1kaI4POZBjcQWfv02RUBJbceqZRKl+
         K4WA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=SEwjvGEx;
       spf=pass (google.com: best guess record for domain of jsimmons@infradead.org designates 2001:8b0:10b:1236::1 as permitted sender) smtp.mailfrom=jsimmons@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=SEwjvGEx;
       spf=pass (google.com: best guess record for domain of jsimmons@infradead.org designates 2001:8b0:10b:1236::1 as permitted sender) smtp.mailfrom=jsimmons@infradead.org
Date: Mon, 16 Apr 2018 04:48:26 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: NeilBrown <neilb@suse.com>
cc: Oleg Drokin <oleg.drokin@intel.com>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Andreas Dilger <andreas.dilger@intel.com>,
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
    Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 1/6] staging: lustre: move stack-check macros to
 libcfs_debug.h
In-Reply-To: <152383935730.23409.6748888065027051683.stgit@noble>
Message-ID: <alpine.LFD.2.21.1804160438220.16188@casper.infradead.org>
References: <152383910760.23409.2327082725637657049.stgit@noble> <152383935730.23409.6748888065027051683.stgit@noble>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20180416_044827_113296_FED3457A 
X-CRM114-Status: GOOD (  17.69  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: SpamAssassin version 3.4.1 on casper.infradead.org summary:
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597861409409058351?=
X-GMAIL-MSGID: =?utf-8?q?1597873074627551120?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> CDEBUG_STACK() and CHECK_STACK() are macros to help with
> debugging, so move them from
>    drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h
> to
>    drivers/staging/lustre/include/linux/libcfs/libcfs_debug.h
> 
> This seems a more fitting location, and is a step towards
> removing linux/libcfs.h and simplifying the include file structure.

Nak. Currently the lustre client always enables debugging but that
shouldn't be the case. What we do need is the able to turn off the 
crazy debugging stuff. In the development branch of lustre it is
done with CDEBUG_ENABLED. We need something like that in Kconfig
much like we have CONFIG_LUSTRE_DEBUG_EXPENSIVE_CHECK. Since we like
to be able to turn that off this should be moved to just after
LIBCFS_DEBUG_MSG_DATA_DECL. Then from CHECK_STACK down to CWARN()
it can be build out. When CDEBUG_ENABLED is disabled CDEBUG_LIMIT
would be empty.
 
> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
>  .../lustre/include/linux/libcfs/libcfs_debug.h     |   32 ++++++++++++++++++++
>  .../lustre/include/linux/libcfs/linux/libcfs.h     |   31 -------------------
>  2 files changed, 32 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/staging/lustre/include/linux/libcfs/libcfs_debug.h b/drivers/staging/lustre/include/linux/libcfs/libcfs_debug.h
> index 9290a19429e7..0dc7b91efe7c 100644
> --- a/drivers/staging/lustre/include/linux/libcfs/libcfs_debug.h
> +++ b/drivers/staging/lustre/include/linux/libcfs/libcfs_debug.h
> @@ -62,6 +62,38 @@ int libcfs_debug_str2mask(int *mask, const char *str, int is_subsys);
>  extern unsigned int libcfs_catastrophe;
>  extern unsigned int libcfs_panic_on_lbug;
>  
> +/* Enable debug-checks on stack size - except on x86_64 */
> +#if !defined(__x86_64__)
> +# ifdef __ia64__
> +#  define CDEBUG_STACK() (THREAD_SIZE -				 \
> +			  ((unsigned long)__builtin_dwarf_cfa() &       \
> +			   (THREAD_SIZE - 1)))
> +# else
> +#  define CDEBUG_STACK() (THREAD_SIZE -				 \
> +			  ((unsigned long)__builtin_frame_address(0) &  \
> +			   (THREAD_SIZE - 1)))
> +# endif /* __ia64__ */
> +
> +#define __CHECK_STACK(msgdata, mask, cdls)			      \
> +do {								    \
> +	if (unlikely(CDEBUG_STACK() > libcfs_stack)) {		  \
> +		LIBCFS_DEBUG_MSG_DATA_INIT(msgdata, D_WARNING, NULL);   \
> +		libcfs_stack = CDEBUG_STACK();			  \
> +		libcfs_debug_msg(msgdata,			       \
> +				 "maximum lustre stack %lu\n",	  \
> +				 CDEBUG_STACK());		       \
> +		(msgdata)->msg_mask = mask;			     \
> +		(msgdata)->msg_cdls = cdls;			     \
> +		dump_stack();					   \
> +	      /*panic("LBUG");*/					\
> +	}							       \
> +} while (0)
> +#define CFS_CHECK_STACK(msgdata, mask, cdls)  __CHECK_STACK(msgdata, mask, cdls)
> +#else /* __x86_64__ */
> +#define CFS_CHECK_STACK(msgdata, mask, cdls) do {} while (0)
> +#define CDEBUG_STACK() (0L)
> +#endif /* __x86_64__ */
> +
>  #ifndef DEBUG_SUBSYSTEM
>  # define DEBUG_SUBSYSTEM S_UNDEFINED
>  #endif
> diff --git a/drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h b/drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h
> index 07d3cb2217d1..83aec9c7698f 100644
> --- a/drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h
> +++ b/drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h
> @@ -80,35 +80,4 @@
>  #include <stdarg.h>
>  #include "linux-cpu.h"
>  
> -#if !defined(__x86_64__)
> -# ifdef __ia64__
> -#  define CDEBUG_STACK() (THREAD_SIZE -				 \
> -			  ((unsigned long)__builtin_dwarf_cfa() &       \
> -			   (THREAD_SIZE - 1)))
> -# else
> -#  define CDEBUG_STACK() (THREAD_SIZE -				 \
> -			  ((unsigned long)__builtin_frame_address(0) &  \
> -			   (THREAD_SIZE - 1)))
> -# endif /* __ia64__ */
> -
> -#define __CHECK_STACK(msgdata, mask, cdls)			      \
> -do {								    \
> -	if (unlikely(CDEBUG_STACK() > libcfs_stack)) {		  \
> -		LIBCFS_DEBUG_MSG_DATA_INIT(msgdata, D_WARNING, NULL);   \
> -		libcfs_stack = CDEBUG_STACK();			  \
> -		libcfs_debug_msg(msgdata,			       \
> -				 "maximum lustre stack %lu\n",	  \
> -				 CDEBUG_STACK());		       \
> -		(msgdata)->msg_mask = mask;			     \
> -		(msgdata)->msg_cdls = cdls;			     \
> -		dump_stack();					   \
> -	      /*panic("LBUG");*/					\
> -	}							       \
> -} while (0)
> -#define CFS_CHECK_STACK(msgdata, mask, cdls)  __CHECK_STACK(msgdata, mask, cdls)
> -#else /* __x86_64__ */
> -#define CFS_CHECK_STACK(msgdata, mask, cdls) do {} while (0)
> -#define CDEBUG_STACK() (0L)
> -#endif /* __x86_64__ */
> -
>  #endif /* _LINUX_LIBCFS_H */
> 
> 
> 
