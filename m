Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751184AbeD3E3W (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 00:29:22 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:44792 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750771AbeD3E3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 00:29:20 -0400
X-Google-Smtp-Source: AB8JxZp2eIFUgKbgl01+OOL0VsjJILRl3drqdbvwT2B2wzQXZVFpUfzpCwgsij2RxeQgp95gc45TLEwsPrY9KQVKyro=
MIME-Version: 1.0
In-Reply-To: <1525061625-7940-1-git-send-email-chandan.vn@samsung.com>
References: <CGME20180430041448epcas1p228a727858328da77c67c01c25802b86d@epcas1p2.samsung.com>
 <1525061625-7940-1-git-send-email-chandan.vn@samsung.com>
From: Chandan Vn <vn.chandan@gmail.com>
Date: Mon, 30 Apr 2018 09:58:39 +0530
Message-ID: <CADYJ94eKmHpp6d4KA35_OC7ryFbJht9W_vfXUBPNGY+zV8=n_g@mail.gmail.com>
Subject: Re: [PATCHv2 1/1] arm64: To remove initrd reserved area entry from memblock
To: CHANDAN VN <chandan.vn@samsung.com>
Cc: catalin.marinas@arm.com, will.deacon@arm.com,
        Takahiro Akashi <takahiro.akashi@linaro.org>, james.morse@arm.com,
        robin.murphy@arm.com, Laura Abbott <labbott@redhat.com>,
        steve.capper@arm.com, kristina.martsenko@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        cpgs@samsung.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore this mail. I missed replying to the thread.
I have resubmitted over the proper thread.

On Mon, 30 Apr 2018, 09:44 CHANDAN VN, <chandan.vn@samsung.com> wrote:
>
> INITRD reserved area entry is not removed from memblock
> even though initrd reserved area is freed. After freeing
> the memory it is released from memblock. The same can be
> checked from /sys/kernel/debug/memblock/reserved.
>
> The patch makes sure that the initrd entry is removed from
> memblock when keepinitrd is not enabled.
>
> The patch only affects accounting and debugging. This does not
> fix any memory leak.
>
> Signed-off-by: CHANDAN VN <chandan.vn@samsung.com>
> ---
>  arch/arm64/mm/init.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 9f3c47a..1b18b47 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -646,8 +646,10 @@ void free_initmem(void)
>
>  void __init free_initrd_mem(unsigned long start, unsigned long end)
>  {
> -       if (!keep_initrd)
> +       if (!keep_initrd) {
>                 free_reserved_area((void *)start, (void *)end, 0, "initrd");
> +               memblock_free(__virt_to_phys(start), end - start);
> +       }
>  }
>
>  static int __init keepinitrd_setup(char *__unused)
> --
> 1.9.1
>
