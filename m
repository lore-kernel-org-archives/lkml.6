Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752238AbeEKGBj convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 02:01:39 -0400
Received: from ozlabs.org ([203.11.71.1]:55103 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750927AbeEKGBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 02:01:38 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH  05/17] powerpc: move io mapping functions into ioremap.c
In-Reply-To: <b6f1dc10a4e2be3674fb9999d5b176a5ce9787e6.1525435203.git.christophe.leroy@c-s.fr>
References: <cover.1525435203.git.christophe.leroy@c-s.fr> <b6f1dc10a4e2be3674fb9999d5b176a5ce9787e6.1525435203.git.christophe.leroy@c-s.fr>
Date: Fri, 11 May 2018 16:01:36 +1000
Message-ID: <87y3gqrarj.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> diff --git a/arch/powerpc/mm/ioremap.c b/arch/powerpc/mm/ioremap.c
> new file mode 100644
> index 000000000000..5d2645193568
> --- /dev/null
> +++ b/arch/powerpc/mm/ioremap.c
> @@ -0,0 +1,350 @@
> +/*
> + * This file contains the routines for mapping IO areas
> + *
> + *  Derived from arch/powerpc/mm/pgtable_32.c and
> + *  arch/powerpc/mm/pgtable_64.c
> + *
> + * SPDX-License-Identifier: GPL-2.0

This goes at the top of the file as:

// SPDX-License-Identifier: GPL-2.0

See:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/license-rules.rst?#n56

> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/types.h>
> +#include <linux/mm.h>
> +#include <linux/vmalloc.h>
> +#include <linux/init.h>
> +#include <linux/highmem.h>
> +#include <linux/memblock.h>
> +#include <linux/slab.h>
> +
> +#include <asm/pgtable.h>
> +#include <asm/pgalloc.h>
> +#include <asm/fixmap.h>
> +#include <asm/io.h>
> +#include <asm/setup.h>
> +#include <asm/sections.h>

I needed:

+#include <asm/machdep.h>

To fix:

../arch/powerpc/mm/ioremap.c: In function ‘ioremap_wc’:
../arch/powerpc/mm/ioremap.c:290:6: error: ‘ppc_md’ undeclared (first use in this function)
  if (ppc_md.ioremap)
      ^~~~~~

cheers
