Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932699AbeEHWwA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 18:52:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59266 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754148AbeEHWv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 18:51:59 -0400
Date: Tue, 8 May 2018 15:51:58 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, aryabinin@virtuozzo.com,
        dvyukov@google.com, mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH 2/3] kcov: prefault the kcov_area
Message-Id: <20180508155158.7e6a789d950bcaf957c8c3bf@linux-foundation.org>
In-Reply-To: <20180504135535.53744-3-mark.rutland@arm.com>
References: <20180504135535.53744-1-mark.rutland@arm.com>
        <20180504135535.53744-3-mark.rutland@arm.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  4 May 2018 14:55:34 +0100 Mark Rutland <mark.rutland@arm.com> wrote:

> On many architectures the vmalloc area is lazily faulted in upon first
> access. This is problematic for KCOV, as __sanitizer_cov_trace_pc
> accesses the (vmalloc'd) kcov_area, and fault handling code may be
> instrumented. If an access to kcov_area faults, this will result in
> mutual recursion through the fault handling code and
> __sanitizer_cov_trace_pc(), eventually leading to stack corruption
> and/or overflow.
> 
> We can avoid this by faulting in the kcov_area before
> __sanitizer_cov_trace_pc() is permitted to access it. Once it has been
> faulted in, it will remain present in the process page tables, and will
> not fault again.
> 
> ...
>
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -324,6 +324,17 @@ static int kcov_close(struct inode *inode, struct file *filep)
>  	return 0;
>  }
>  
> +static void kcov_fault_in_area(struct kcov *kcov)

It would be nice to have a comment here explaining why the function
exists.

umm, this?

--- a/kernel/kcov.c~kcov-prefault-the-kcov_area-fix-fix
+++ a/kernel/kcov.c
@@ -324,6 +324,10 @@ static int kcov_close(struct inode *inod
 	return 0;
 }
 
+/*
+ * fault in a lazily-faulted vmalloc area, to avoid recursion issues if the
+ * vmalloc fault handler itself is instrumented.
+ */
 static void kcov_fault_in_area(struct kcov *kcov)
 {
 	unsigned long stride = PAGE_SIZE / sizeof(unsigned long);

> +{
> +	unsigned long stride = PAGE_SIZE / sizeof(unsigned long);
> +	unsigned long *area = kcov->area;
> +	unsigned long offset;
> +
> +	for (offset = 0; offset < kcov->size; offset += stride) {
> +		READ_ONCE(area[offset]);
> +	}
> +}
