Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA74C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E8E62081B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730330AbfBFL6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 06:58:24 -0500
Received: from ozlabs.org ([203.11.71.1]:36889 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726957AbfBFL6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 06:58:24 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43vg240LDFz9sLw;
        Wed,  6 Feb 2019 22:58:20 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Deepa Dinamani <deepa.kernel@gmail.com>, davem@davemloft.net,
        linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org,
        ccaulfie@redhat.com, deller@gmx.de, paulus@samba.org,
        ralf@linux-mips.org, rth@twiddle.net, cluster-devel@redhat.com,
        linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH net-next v5 11/12] socket: Rename SO_RCVTIMEO/ SO_SNDTIMEO with _OLD suffixes
In-Reply-To: <20190202153454.7121-12-deepa.kernel@gmail.com>
References: <20190202153454.7121-1-deepa.kernel@gmail.com> <20190202153454.7121-12-deepa.kernel@gmail.com>
Date:   Wed, 06 Feb 2019 22:58:18 +1100
Message-ID: <87o97pku1x.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deepa Dinamani <deepa.kernel@gmail.com> writes:

> SO_RCVTIMEO and SO_SNDTIMEO socket options use struct timeval
> as the time format. struct timeval is not y2038 safe.
> The subsequent patches in the series add support for new socket
> timeout options with _NEW suffix that will use y2038 safe
> data structures. Although the existing struct timeval layout
> is sufficiently wide to represent timeouts, because of the way
> libc will interpret time_t based on user defined flag, these
> new flags provide a way of having a structure that is the same
> for all architectures consistently.
> Rename the existing options with _OLD suffix forms so that the
> right option is enabled for userspace applications according
> to the architecture and time_t definition of libc.
>
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> Acked-by: Willem de Bruijn <willemb@google.com>
> Cc: ccaulfie@redhat.com
> Cc: deller@gmx.de
> Cc: paulus@samba.org
> Cc: ralf@linux-mips.org
> Cc: rth@twiddle.net
> Cc: cluster-devel@redhat.com
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-mips@vger.kernel.org
> Cc: linux-parisc@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> ---
>  arch/alpha/include/uapi/asm/socket.h   | 7 +++++--
>  arch/mips/include/uapi/asm/socket.h    | 6 ++++--
>  arch/parisc/include/uapi/asm/socket.h  | 6 ++++--
>  arch/powerpc/include/uapi/asm/socket.h | 4 ++--

The powerpc changes look OK to me.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

> diff --git a/arch/powerpc/include/uapi/asm/socket.h b/arch/powerpc/include/uapi/asm/socket.h
> index 94de465e0920..12aa0c43e775 100644
> --- a/arch/powerpc/include/uapi/asm/socket.h
> +++ b/arch/powerpc/include/uapi/asm/socket.h
> @@ -11,8 +11,8 @@
>  
>  #define SO_RCVLOWAT	16
>  #define SO_SNDLOWAT	17
> -#define SO_RCVTIMEO	18
> -#define SO_SNDTIMEO	19
> +#define SO_RCVTIMEO_OLD	18
> +#define SO_SNDTIMEO_OLD	19
>  #define SO_PASSCRED	20
>  #define SO_PEERCRED	21
>  
> diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
> index 2713e0fa68ef..c56b8b487c12 100644
> --- a/include/uapi/asm-generic/socket.h
> +++ b/include/uapi/asm-generic/socket.h
> @@ -30,8 +30,8 @@
>  #define SO_PEERCRED	17
>  #define SO_RCVLOWAT	18
>  #define SO_SNDLOWAT	19
> -#define SO_RCVTIMEO	20
> -#define SO_SNDTIMEO	21
> +#define SO_RCVTIMEO_OLD	20
> +#define SO_SNDTIMEO_OLD	21
>  #endif
>  
>  /* Security levels - as per NRL IPv6 - don't actually do anything */
> @@ -116,6 +116,8 @@
>  
>  #if !defined(__KERNEL__)
>  
> +#define	SO_RCVTIMEO SO_RCVTIMEO_OLD
> +#define	SO_SNDTIMEO SO_SNDTIMEO_OLD
>  #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
>  /* on 64-bit and x32, avoid the ?: operator */
>  #define SO_TIMESTAMP		SO_TIMESTAMP_OLD
