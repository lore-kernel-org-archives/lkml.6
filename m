Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbeCZNr7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 09:47:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39716 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751109AbeCZNr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 09:47:57 -0400
Date: Mon, 26 Mar 2018 15:47:53 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com,
        pmorel@linux.vnet.ibm.com
Subject: Re: [PATCH 3/4] vfio: ccw: set ccw->cda to NULL defensively
Message-ID: <20180326154753.327503ba.cohuck@redhat.com>
In-Reply-To: <20180321020822.86255-4-bjsdjshi@linux.vnet.ibm.com>
References: <20180321020822.86255-1-bjsdjshi@linux.vnet.ibm.com>
        <20180321020822.86255-4-bjsdjshi@linux.vnet.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Mar 2018 03:08:21 +0100
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> Let's avoid free on ccw->cda that points to a guest address
> or a already freed memory area by setting it to NULL if memory
> allocation didn't happen or failed.

Does not hurt, I guess.

> 
> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_cp.c | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> index 3abc9770910a..5958c35ab343 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -491,7 +491,7 @@ static int ccwchain_fetch_direct(struct ccwchain *chain,
>  	struct ccw1 *ccw;
>  	struct pfn_array_table *pat;
>  	unsigned long *idaws;
> -	int idaw_nr;
> +	int idaw_nr, ret;
>  
>  	ccw = chain->ch_ccw + idx;
>  
> @@ -511,18 +511,20 @@ static int ccwchain_fetch_direct(struct ccwchain *chain,
>  	 * needed when translating a direct ccw to a idal ccw.
>  	 */
>  	pat = chain->ch_pat + idx;
> -	if (pfn_array_table_init(pat, 1))
> -		return -ENOMEM;
> -	idaw_nr = pfn_array_alloc_pin(pat->pat_pa, cp->mdev,
> +	ret = pfn_array_table_init(pat, 1);
> +	if (ret)
> +		goto out_init;
> +
> +	idaw_nr = ret = pfn_array_alloc_pin(pat->pat_pa, cp->mdev,

Ugh, I don't like setting both at the same time... only set idaw_nr for
ret > 0? (personal preference)

>  				      ccw->cda, ccw->count);
> -	if (idaw_nr < 0)
> -		return idaw_nr;
> +	if (ret < 0)
> +		goto out_init;
