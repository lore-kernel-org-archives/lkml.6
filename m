Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935208AbeE1XIq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 19:08:46 -0400
Received: from gate.crashing.org ([63.228.1.57]:42765 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751432AbeE1XIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 19:08:42 -0400
Message-ID: <0f79b2e8bd86d95f0acd087432f0efef0abc86d3.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/64: Fix build failure with GCC 8.1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 29 May 2018 09:08:17 +1000
In-Reply-To: <1d3fd6a6c35e41d3e25ebe5256adf021369ada7c.1527525305.git.christophe.leroy@c-s.fr>
References: <1d3fd6a6c35e41d3e25ebe5256adf021369ada7c.1527525305.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1 (3.28.1-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-05-28 at 16:37 +0000, Christophe Leroy wrote:
>   CC      arch/powerpc/kernel/nvram_64.o
> arch/powerpc/kernel/nvram_64.c: In function 'nvram_create_partition':
> arch/powerpc/kernel/nvram_64.c:1042:2: error: 'strncpy' specified bound 12 equals destination size [-Werror=stringop-truncation]
>   strncpy(new_part->header.name, name, 12);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
>   CC      arch/powerpc/kernel/trace/ftrace.o
> In function 'make_field',
>     inlined from 'ps3_repository_read_boot_dat_address' at arch/powerpc/platforms/ps3/repository.c:900:9:
> arch/powerpc/platforms/ps3/repository.c:106:2: error: 'strncpy' output truncated before terminating nul copying 8 bytes from a string of the same length [-Werror=stringop-truncation]
>   strncpy((char *)&n, text, 8);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

That's not completely correct, here it's gcc warning being over-
zealous. The old specs I could find define the format to be a 12
characters strings *or* a less-than-12 characters NUL terminated
string. So it's perfectly ok to drop the trailing 0 if the name
happens to be exactly 12 characters.

Cheers,
Ben.

> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/kernel/nvram_64.c          | 2 +-
>  arch/powerpc/platforms/ps3/repository.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
> index ba681dac7b46..7507448cd904 100644
> --- a/arch/powerpc/kernel/nvram_64.c
> +++ b/arch/powerpc/kernel/nvram_64.c
> @@ -1039,7 +1039,7 @@ loff_t __init nvram_create_partition(const char *name, int sig,
>  	new_part->index = free_part->index;
>  	new_part->header.signature = sig;
>  	new_part->header.length = size;
> -	strncpy(new_part->header.name, name, 12);
> +	strncpy(new_part->header.name, name, sizeof(new_part->header.name) - 1);
>  	new_part->header.checksum = nvram_checksum(&new_part->header);
>  
>  	rc = nvram_write_header(new_part);
> diff --git a/arch/powerpc/platforms/ps3/repository.c b/arch/powerpc/platforms/ps3/repository.c
> index 50dbaf24b1ee..b4d6628eec5e 100644
> --- a/arch/powerpc/platforms/ps3/repository.c
> +++ b/arch/powerpc/platforms/ps3/repository.c
> @@ -101,9 +101,9 @@ static u64 make_first_field(const char *text, u64 index)
>  
>  static u64 make_field(const char *text, u64 index)
>  {
> -	u64 n;
> +	u64 n = 0;
>  
> -	strncpy((char *)&n, text, 8);
> +	memcpy((char *)&n, text, min(sizeof(n), strlen(text)));
>  	return n + index;
>  }
>  
