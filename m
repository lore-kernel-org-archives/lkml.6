Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751077AbeBJOnZ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 09:43:25 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:39705 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbeBJOnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 09:43:23 -0500
X-Google-Smtp-Source: AH8x2244zJGBUftcg9pUXIyOp6lOiIsMMY8iVbucRtnk4CvshIt2RdeoAias6TUHNgB/ETwkpYsJPA==
Date: Sun, 11 Feb 2018 00:43:09 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>,
        aneesh.kumar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 1/5] powerpc/mm/slice: Remove intermediate bitmap
 copy
Message-ID: <20180211004309.2eda56a3@roar.ozlabs.ibm.com>
In-Reply-To: <01e8f783db8f4d4d41df91e0400a8634272b326f.1518226173.git.christophe.leroy@c-s.fr>
References: <01e8f783db8f4d4d41df91e0400a8634272b326f.1518226173.git.christophe.leroy@c-s.fr>
Organization: IBM
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Feb 2018 13:54:25 +0100 (CET)
Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> bitmap_or() and bitmap_andnot() can work properly with dst identical
> to src1 or src2. There is no need of an intermediate result bitmap
> that is copied back to dst in a second step.

Everyone seems to be working on the slice code all of a sudden. I
had the same change in my series I just posted, but I didn't notice
this one of yours earlier, and it's better split out, so this is
fine by me.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  v2: New in v2
>  v3: patch moved up front of the serie to avoid ephemeral slice_bitmap_copy() function in following patch
>  v4: No change
> 
>  arch/powerpc/mm/slice.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
> index 23ec2c5e3b78..98b53d48968f 100644
> --- a/arch/powerpc/mm/slice.c
> +++ b/arch/powerpc/mm/slice.c
> @@ -388,21 +388,17 @@ static unsigned long slice_find_area(struct mm_struct *mm, unsigned long len,
>  
>  static inline void slice_or_mask(struct slice_mask *dst, struct slice_mask *src)
>  {
> -	DECLARE_BITMAP(result, SLICE_NUM_HIGH);
> -
>  	dst->low_slices |= src->low_slices;
> -	bitmap_or(result, dst->high_slices, src->high_slices, SLICE_NUM_HIGH);
> -	bitmap_copy(dst->high_slices, result, SLICE_NUM_HIGH);
> +	bitmap_or(dst->high_slices, dst->high_slices, src->high_slices,
> +		  SLICE_NUM_HIGH);
>  }
>  
>  static inline void slice_andnot_mask(struct slice_mask *dst, struct slice_mask *src)
>  {
> -	DECLARE_BITMAP(result, SLICE_NUM_HIGH);
> -
>  	dst->low_slices &= ~src->low_slices;
>  
> -	bitmap_andnot(result, dst->high_slices, src->high_slices, SLICE_NUM_HIGH);
> -	bitmap_copy(dst->high_slices, result, SLICE_NUM_HIGH);
> +	bitmap_andnot(dst->high_slices, dst->high_slices, src->high_slices,
> +		      SLICE_NUM_HIGH);
>  }
>  
>  #ifdef CONFIG_PPC_64K_PAGES
