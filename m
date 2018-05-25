Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966811AbeEYLmk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 07:42:40 -0400
Received: from ozlabs.org ([203.11.71.1]:53233 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966683AbeEYLlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 07:41:52 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 0e36b0d12501e278686634712975b785bae11641
In-Reply-To: <3f8c7feadca2d52fa97c8feb5170c2ab67b6f992.1527065339.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, npiggin@gmail.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v9] powerpc/mm: Only read faulting instruction when necessary in do_page_fault()
Message-Id: <40skqg0byNz9s3B@ozlabs.org>
Date: Fri, 25 May 2018 21:41:50 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-05-23 at 08:53:22 UTC, Christophe Leroy wrote:
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
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/0e36b0d12501e278686634712975b7

cheers
