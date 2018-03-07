Return-Path: <kernel-hardening-return-12219-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuregxmGcenLyMynO0SRbT5KMPxzYWUyPqF1jKPlunvxGVLsj/ebjsEMod7V+IkKJJtr0Lb
ARC-Seal: i=1; a=rsa-sha256; t=1520466178; cv=none;
        d=google.com; s=arc-20160816;
        b=csbEuCJ95Wv9PiPb47IHgiOtOkfMRBLd7mbwHlbebICzbm4H+y8xXzRcuHwDou5mt8
         dl4chLBcLQO+KHY1spHd9DXoFw39kUsvsE4FJ7bc/BdGbokfvycyZpw/BemDvjiallWd
         30tV9lJa7j01hspuR+MQD0+jnIZKLobUgrvRmLJEYOJ7Od389L9glpIIzDFU9lTQha/Q
         +FtQUDrKxgOptIH/W9pls60glpIlZzEEAYJdJQ+TjJD9tiizxryG37ndrgHeMMy9aMC/
         s8O80+zHxax+fJkHSJ12jlJF9EiWfEY2HsFo2H4loSEeRb6Awd6raKgdyc/ClVBKiX9e
         bdyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=O/eV2JkP/Qk6olBPQ/IxSCmZldZhMYmB4/AS3OAvfYQ=;
        b=lLR+iDMklx9inQCd4RM4IUHlQYj2zvMnyQO7MrrO0vckLN29I+zYvRAYMlQlfLYVEc
         pvlimJskqii324VfRJiR0iblzM6G0451FT0mNXVO4uVo2ECIMXCtV7EtH6ZVboPWSPSp
         liNi4eboi26IgzLTdvT4zRS9UPmJzSrJbjr5HE3Yx7GXw31tLWjkkYo5PU7YKNDsoixv
         KQnpCn0fxVrDoZ1dfsBoewk9pzLA1TnmcUWWIEMVhoXD+LK6Sb3aMPunLRczGEED0TlP
         ITnRNqjwidvnjq6pLH0Um0lrjiy490qUflni/P5fBOM4KB5K+7F3nddOowyt/9r/l7Uw
         vOAA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=isb8557z;
       spf=pass (google.com: domain of kernel-hardening-return-12219-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12219-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=isb8557z;
       spf=pass (google.com: domain of kernel-hardening-return-12219-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12219-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 7 Mar 2018 16:42:38 -0700
From: Tycho Andersen <tycho@tycho.ws>
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Tobin C. Harding" <me@tobin.cc>, Jonathan Corbet <corbet@lwn.net>,
	Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>,
	kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] vsprintf: Remove accidental VLA usage
Message-ID: <20180307234238.yxbbaka35ck2xymw@smitten>
References: <20180307230714.GA20797@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307230714.GA20797@beast>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594322119542311159?=
X-GMAIL-MSGID: =?utf-8?q?1594324343843703432?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Kees,

On Wed, Mar 07, 2018 at 03:07:14PM -0800, Kees Cook wrote:
> The "sym" calculation is actually a fixed size, but since the max()
> macro uses some extensive tricks for safety, it ends up looking like a
> variable size. This replaces max() with a simple max macro which is
> sufficient for the calculation of the array size.
> 
> Seen with -Wvla. Fixed as part of the directive to remove all VLAs from
> the kernel: https://lkml.org/lkml/2018/3/7/621
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  lib/vsprintf.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index d7a708f82559..f420ab1477cb 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -744,8 +744,9 @@ char *resource_string(char *buf, char *end, struct resource *res,
>  #define FLAG_BUF_SIZE		(2 * sizeof(res->flags))
>  #define DECODED_BUF_SIZE	sizeof("[mem - 64bit pref window disabled]")
>  #define RAW_BUF_SIZE		sizeof("[mem - flags 0x]")
> -	char sym[max(2*RSRC_BUF_SIZE + DECODED_BUF_SIZE,
> -		     2*RSRC_BUF_SIZE + FLAG_BUF_SIZE + RAW_BUF_SIZE)];
> +#define SIMPLE_MAX(x, y)	((x) > (y) ? (x) : (y))

It's probably worth hoisting this out into some other header. When I
was looking at this a while ago, this problem happens in a few places,
see e.g. net/ipv4/proc.c:TCPUDP_MIB_MAX.

Cheers,

Tycho
