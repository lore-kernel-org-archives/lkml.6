Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754793AbeDCHVV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 03:21:21 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:39474 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754233AbeDCHVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 03:21:19 -0400
X-Google-Smtp-Source: AIpwx4+s+QVlV/p5YqTuMvNLST/cE7+8tBcYFSHIJ7eS3uhWY5tpsgDfKrGZU/xT/LZpp38e17xfv6ECRYgZhnSbbXI=
MIME-Version: 1.0
In-Reply-To: <1522692821-27706-1-git-send-email-okaya@codeaurora.org>
References: <1522692821-27706-1-git-send-email-okaya@codeaurora.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 3 Apr 2018 09:21:18 +0200
X-Google-Sender-Auth: 4vuAMkavNvqcJuN-1jtqTL1uUc8
Message-ID: <CAK8P3a0WwhDoTdQNoxnpBVDZu8a7oKdB2tSjVRTRf3rrecEKMA@mail.gmail.com>
Subject: Re: [PATCH v2] MIPS: io: add a barrier after register read in readX()
To: Sinan Kaya <okaya@codeaurora.org>
Cc: "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Timur Tabi <timur@codeaurora.org>, sulrich@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 2, 2018 at 8:13 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> While a barrier is present in writeX() function before the register write,
> a similar barrier is missing in the readX() function after the register
> read. This could allow memory accesses following readX() to observe
> stale data.
>
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/mips/include/asm/io.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
> index 0cbf3af..7f9068d 100644
> --- a/arch/mips/include/asm/io.h
> +++ b/arch/mips/include/asm/io.h
> @@ -377,6 +377,7 @@ static inline type pfx##read##bwlq(const volatile void __iomem *mem)        \
>                 BUG();                                                  \
>         }                                                               \
>                                                                         \
> +       war_io_reorder_wmb();                                           \
>         return pfx##ioswab##bwlq(__mem, __val);                         \
>  }

I'm not sure if this is the right barrier: what we want here is a read
barrier to
prevent any following memory access from being prefetched ahead of the readl(),
so I would have expected a kind of rmb() rather than wmb().

The barrier you used here is defined as

#if defined(CONFIG_CPU_CAVIUM_OCTEON) || defined(CONFIG_LOONGSON3_ENHANCEMENT)
#define war_io_reorder_wmb()            wmb()
#else
#define war_io_reorder_wmb()            do { } while (0)
#endif

which appears to list the particular CPUs that have a reordering
write buffer. That may not be the same set of CPUs that have the
capability to do out-of-order loads.

       Arnd
