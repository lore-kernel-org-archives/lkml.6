Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932231AbeEWJhO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 05:37:14 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41500 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754411AbeEWJhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 05:37:10 -0400
X-Google-Smtp-Source: AB8JxZq1wLA2nZkkQCYdkO2kpc68NV3ZN8kcyg9ESkFqTj6xALtbXkYcozFJLHyR114YkoTHKEGmwg==
Date: Wed, 23 May 2018 19:36:59 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v9] powerpc/mm: Only read faulting instruction when
 necessary in do_page_fault()
Message-ID: <20180523193659.03857d14@roar.ozlabs.ibm.com>
In-Reply-To: <3f8c7feadca2d52fa97c8feb5170c2ab67b6f992.1527065339.git.christophe.leroy@c-s.fr>
References: <3f8c7feadca2d52fa97c8feb5170c2ab67b6f992.1527065339.git.christophe.leroy@c-s.fr>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 May 2018 10:53:22 +0200 (CEST)
Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> Commit a7a9dcd882a67 ("powerpc: Avoid taking a data miss on every
> userspace instruction miss") has shown that limiting the read of
> faulting instruction to likely cases improves performance.
> 
> This patch goes further into this direction by limiting the read
> of the faulting instruction to the only cases where it is likely
> needed.
> 
> On an MPC885, with the same benchmark app as in the commit referred
> above, we see a reduction of about 3900 dTLB misses (approx 3%):
> 
> Before the patch:
>  Performance counter stats for './fault 500' (10 runs):
> 
>          683033312      cpu-cycles                                                    ( +-  0.03% )
>             134538      dTLB-load-misses                                              ( +-  0.03% )
>              46099      iTLB-load-misses                                              ( +-  0.02% )
>              19681      faults                                                        ( +-  0.02% )
> 
>        5.389747878 seconds time elapsed                                          ( +-  0.06% )
> 
> With the patch:
> 
>  Performance counter stats for './fault 500' (10 runs):
> 
>          682112862      cpu-cycles                                                    ( +-  0.03% )
>             130619      dTLB-load-misses                                              ( +-  0.03% )
>              46073      iTLB-load-misses                                              ( +-  0.05% )
>              19681      faults                                                        ( +-  0.01% )
> 
>        5.381342641 seconds time elapsed                                          ( +-  0.07% )
> 
> The proper work of the huge stack expansion was tested with the
> following app:
> 
> int main(int argc, char **argv)
> {
> 	char buf[1024 * 1025];
> 
> 	sprintf(buf, "Hello world !\n");
> 	printf(buf);
> 
> 	exit(0);
> }
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Thanks,
Nick
