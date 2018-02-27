Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752534AbeB0JFG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 04:05:06 -0500
Received: from mail-pf0-f175.google.com ([209.85.192.175]:37270 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752519AbeB0JFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 04:05:01 -0500
X-Google-Smtp-Source: AH8x224eAaH27obVKrZXZ+6UUk4oEqKZcU/F0n0Ji/cbqgUU7ey8eLUXCOJTcwyl1f9G0GrivKzbig==
Date: Tue, 27 Feb 2018 19:04:40 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC REBASED 3/5] powerpc/mm/slice: implement
 slice_check_range_fits
Message-ID: <20180227190440.45ce8641@roar.ozlabs.ibm.com>
In-Reply-To: <87k1uy7vbr.fsf@linux.vnet.ibm.com>
References: <02a62db83282b5ef3e0e8281fdc46fa91beffc86.1518382747.git.christophe.leroy@c-s.fr>
        <caa9d52e0a8ef15719bafe8002a4ad2dc359c634.1518382747.git.christophe.leroy@c-s.fr>
        <87k1uy7vbr.fsf@linux.vnet.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Feb 2018 12:50:08 +0530
"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:

> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>  +	if ((start + len) > SLICE_LOW_TOP) {
> > +		unsigned long start_index = GET_HIGH_SLICE_INDEX(start);
> > +		unsigned long align_end = ALIGN(end, (1UL << SLICE_HIGH_SHIFT));
> > +		unsigned long count = GET_HIGH_SLICE_INDEX(align_end) - start_index;
> > +		unsigned long i;
> >  
> > -	slice_bitmap_and(result, mask->high_slices, available->high_slices,
> > -			 slice_count);
> > +		for (i = start_index; i < start_index + count; i++) {
> > +			if (!test_bit(i, available->high_slices))
> > +				return false;
> > +		}
> > +	}  
> 
> why not bitmap_equal here instead of test_bit in loop?

Because we only have the available bitmap now. If we see large ranges
here we could use some bitmap operation like find_next_zero_bit perhaps.

Thanks,
Nick
