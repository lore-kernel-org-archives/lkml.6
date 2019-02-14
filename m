Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702C4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43086222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406004AbfBNHEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 02:04:46 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:26126 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389635AbfBNHEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 02:04:46 -0500
X-IronPort-AV: E=Sophos;i="5.58,367,1544482800"; 
   d="scan'208";a="369343814"
Received: from abo-58-107-68.mrs.modulonet.fr (HELO hadrien) ([85.68.107.58])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2019 08:04:43 +0100
Date:   Thu, 14 Feb 2019 08:04:43 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Dan Carpenter <dan.carpenter@oracle.com>
cc:     Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        codalist@telemann.coda.cs.cmu.edu, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fs/coda: get rid of CODA_ALLOC()
In-Reply-To: <20190214065848.GB21768@kadam>
Message-ID: <alpine.DEB.2.21.1902140804170.2466@hadrien>
References: <20190214065848.GB21768@kadam>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Feb 2019, Dan Carpenter wrote:

> These days we have kvzalloc() so we can delete CODA_ALLOC().

Maybe it would be better to get rid fo CODA_FREE as well?

julia

>
> I made a couple related changes in coda_psdev_write().  First, I
> added some error handling to avoid a NULL dereference if the allocation
> failed.  Second, I used kvmalloc() instead of kvzalloc() because we
> copy over the memory on the next line so there is no need to zero it
> first.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  fs/coda/coda_linux.h | 10 ----------
>  fs/coda/psdev.c      |  6 +++++-
>  fs/coda/upcall.c     |  4 ++--
>  3 files changed, 7 insertions(+), 13 deletions(-)
>
> diff --git a/fs/coda/coda_linux.h b/fs/coda/coda_linux.h
> index 126155cadfa9..1ea9521e79d7 100644
> --- a/fs/coda/coda_linux.h
> +++ b/fs/coda/coda_linux.h
> @@ -63,16 +63,6 @@ unsigned short coda_flags_to_cflags(unsigned short);
>  void coda_sysctl_init(void);
>  void coda_sysctl_clean(void);
>
> -#define CODA_ALLOC(ptr, cast, size) do { \
> -    if (size < PAGE_SIZE) \
> -        ptr = kzalloc((unsigned long) size, GFP_KERNEL); \
> -    else \
> -        ptr = (cast)vzalloc((unsigned long) size); \
> -    if (!ptr) \
> -	pr_warn("kernel malloc returns 0 at %s:%d\n", __FILE__, __LINE__); \
> -} while (0)
> -
> -
>  #define CODA_FREE(ptr, size) kvfree((ptr))
>
>  /* inode to cnode access functions */
> diff --git a/fs/coda/psdev.c b/fs/coda/psdev.c
> index c5234c21b539..49d44a485c9a 100644
> --- a/fs/coda/psdev.c
> +++ b/fs/coda/psdev.c
> @@ -124,7 +124,11 @@ static ssize_t coda_psdev_write(struct file *file, const char __user *buf,
>  				hdr.opcode, hdr.unique);
>  		        nbytes = size;
>  		}
> -		CODA_ALLOC(dcbuf, union outputArgs *, nbytes);
> +		dcbuf = kvmalloc(nbytes, GFP_KERNEL);
> +		if (!dcbuf) {
> +			retval = -ENOMEM;
> +			goto out;
> +		}
>  		if (copy_from_user(dcbuf, buf, nbytes)) {
>  			CODA_FREE(dcbuf, nbytes);
>  			retval = -EFAULT;
> diff --git a/fs/coda/upcall.c b/fs/coda/upcall.c
> index 1175a1722411..203f029bcdc3 100644
> --- a/fs/coda/upcall.c
> +++ b/fs/coda/upcall.c
> @@ -46,7 +46,7 @@ static void *alloc_upcall(int opcode, int size)
>  {
>  	union inputArgs *inp;
>
> -	CODA_ALLOC(inp, union inputArgs *, size);
> +	inp = kvzalloc(size, GFP_KERNEL);
>          if (!inp)
>  		return ERR_PTR(-ENOMEM);
>
> @@ -743,7 +743,7 @@ static int coda_upcall(struct venus_comm *vcp,
>  	sig_req = kmalloc(sizeof(struct upc_req), GFP_KERNEL);
>  	if (!sig_req) goto exit;
>
> -	CODA_ALLOC((sig_req->uc_data), char *, sizeof(struct coda_in_hdr));
> +	sig_req->uc_data = kvzalloc(sizeof(struct coda_in_hdr), GFP_KERNEL);
>  	if (!sig_req->uc_data) {
>  		kfree(sig_req);
>  		goto exit;
> --
> 2.17.1
>
>
