Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x227SXxZXALhw95p52v0trZ4+ELBsyZqLiSvlFPYvCkix3tGxzSD3SUWfBduXEokVMCNk1eQJ
ARC-Seal: i=1; a=rsa-sha256; t=1519259038; cv=none;
        d=google.com; s=arc-20160816;
        b=NwnhX27+tbbj+TovSw6HfiPjMAeXhQ04uA1QEm+UB7yV8B7sqfoH4u8KSUpAPTFzHu
         07tuj7MsUxWP0lQCZFi1wc6M2ZlKRVv6ef3EohE8rCQOuAZzb0FMMf4kzlOFMQJSmKP8
         zLBeKHmZVteEata4Hk6l8DDwtkP0d8iUIPb7Lhr2AAx1I7zrxR7hnpK7lxZIHyKeM0nf
         haHLuUeu9gcpNcb5/lR6Fde99u9mG5avcmWdCoa5B8jL8lEGNSLfGJjO3mZG3vX01ubh
         /OESnb04DAo7+/oDaCRlljXgrXaRKdlzvHoG9D58Gdj44vdl5qlD+9wPFtJGER7oHtnn
         /MXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:arc-authentication-results;
        bh=wkY+YcYjfOiSNwzlcjSbnPTqKyH22Jrg43hBH1yP4d8=;
        b=jruhAdKKtMBjjmLjImhnejd3jzxRYIbH0g7rXZsRRIwz0mN7O8nBOs+5NFbxs4+fJ4
         L3jpcjDrwlOsoSjNZoOFn1F26+nG4leceEq5rdTIsI37weaRnlvpO/YSJrkwDqvQECxH
         HNhJzMV+7MZKFs0oG1lTj/LcE2Ph4AAUCq0C3OnQo/HRVpVGMlNbZ+oJWp9qwDgABCZB
         riVWK6UhMpRPE7HHdx8BKjUPBvOuGdTcj2d6I/PeTkK+nZXBUZkm3nUcqhDG3/E1j6lP
         tZgH4KgAVgSetA5tSibbyKCq6eKiPaTC6cNxgRqiZF1KoD0tinPqifmGNIl49o68wmSJ
         drCg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751302AbeBVAXj (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 19:23:39 -0500
Received: from www62.your-server.de ([213.133.104.62]:53306 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbeBVAXh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 19:23:37 -0500
Subject: Re: [PATCH] selftests/bpf: tcpbpf_kern: use in6_* macros from glibc
To: Anders Roxell <anders.roxell@linaro.org>, shuah@kernel.org
Cc: ast@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20180221165116.9754-1-anders.roxell@linaro.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <1e230f62-7ee7-93b5-354d-cb2b708d6034@iogearbox.net>
Date: Thu, 22 Feb 2018 01:23:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180221165116.9754-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593030175575827124?=
X-GMAIL-MSGID: =?utf-8?q?1593058565282368955?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/21/2018 05:51 PM, Anders Roxell wrote:
> Both glibc and the kernel have in6_* macros definitions. Build fails
> because it picks up wrong in6_* macro from the kernel header and not the
> header from glibc.
> 
> Fixes build error below:
> clang -I. -I./include/uapi -I../../../include/uapi
>      -Wno-compare-distinct-pointer-types \
>          -O2 -target bpf -emit-llvm -c test_tcpbpf_kern.c -o - |      \
> llc -march=bpf -mcpu=generic -filetype=obj
>      -o .../tools/testing/selftests/bpf/test_tcpbpf_kern.o
> In file included from test_tcpbpf_kern.c:12:
> .../netinet/in.h:101:5: error: expected identifier
>     IPPROTO_HOPOPTS = 0,   /* IPv6 Hop-by-Hop options.  */
>     ^
> .../linux/in6.h:131:26: note: expanded from macro 'IPPROTO_HOPOPTS'
>                                 ^
> In file included from test_tcpbpf_kern.c:12:
> /usr/include/netinet/in.h:103:5: error: expected identifier
>     IPPROTO_ROUTING = 43,  /* IPv6 routing header.  */
>     ^
> .../linux/in6.h:132:26: note: expanded from macro 'IPPROTO_ROUTING'
>                                 ^
> In file included from test_tcpbpf_kern.c:12:
> .../netinet/in.h:105:5: error: expected identifier
>     IPPROTO_FRAGMENT = 44, /* IPv6 fragmentation header.  */
>     ^
> 
> Since both glibc and the kernel have in6_* macros definitions, use the
> one from glibc.  Kernel headers will check for previous libc definitions
> by including include/linux/libc-compat.h.
> 
> Reported-by: Daniel Díaz <daniel.diaz@linaro.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Applied to bpf tree, thanks Anders!
