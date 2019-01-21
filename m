Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D009AC2F3A1
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A27652085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbfAUMim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 07:38:42 -0500
Received: from foss.arm.com ([217.140.101.70]:33274 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728163AbfAUMil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 07:38:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F17EE80D;
        Mon, 21 Jan 2019 04:38:40 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 782BD3F614;
        Mon, 21 Jan 2019 04:38:39 -0800 (PST)
Date:   Mon, 21 Jan 2019 12:38:37 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Elena Reshetova <elena.reshetova@intel.com>
Cc:     akpm@linux-foundation.org, aryabinin@virtuozzo.com,
        anders.roxell@linaro.org, dvyukov@google.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        peterz@infradead.org
Subject: Re: [PATCH] kcov: convert kcov.refcount to refcount_t
Message-ID: <20190121123836.GC47506@lakrids.cambridge.arm.com>
References: <1547634429-772-1-git-send-email-elena.reshetova@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547634429-772-1-git-send-email-elena.reshetova@intel.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 12:27:09PM +0200, Elena Reshetova wrote:
> atomic_t variables are currently used to implement reference
> counters with the following properties:
>  - counter is initialized to 1 using atomic_set()
>  - a resource is freed upon counter reaching zero
>  - once counter reaches zero, its further
>    increments aren't allowed
>  - counter schema uses basic atomic operations
>    (set, inc, inc_not_zero, dec_and_test, etc.)
> 
> Such atomic variables should be converted to a newly provided
> refcount_t type and API that prevents accidental counter overflows
> and underflows. This is important since overflows and underflows
> can lead to use-after-free situation and be exploitable.
> 
> The variable kcov.refcount is used as pure reference counter.
> Convert it to refcount_t and fix up the operations.
> 
> **Important note for maintainers:
> 
> Some functions from refcount_t API defined in lib/refcount.c
> have different memory ordering guarantees than their atomic
> counterparts.
> The full comparison can be seen in
> https://lkml.org/lkml/2017/11/15/57 and it is hopefully soon
> in state to be merged to the documentation tree.
> Normally the differences should not matter since refcount_t provides
> enough guarantees to satisfy the refcounting use cases, but in
> some rare cases it might matter.
> Please double check that you don't have some undocumented
> memory guarantees for this variable usage.
> 
> For the kcov.refcount it might make a difference
> in following places:
>  - kcov_put(): decrement in refcount_dec_and_test() only
>    provides RELEASE ordering and control dependency on success
>    vs. fully ordered atomic counterpart
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: David Windsor <dwindsor@gmail.com>
> Reviewed-by: Hans Liljestrand <ishkamiel@gmail.com>
> Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>

Just to check, has this been tested with CONFIG_REFCOUNT_FULL and
something poking kcov?

Given lib/refcount.c is instrumented, the refcount_*() calls will
recurse back into the kcov code. It looks like that's fine, given these
are only manipulated in setup/teardown paths, but it would be nice to be
sure.

Thanks,
Mark.

> ---
>  kernel/kcov.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index c2277db..051e86e 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -20,6 +20,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/uaccess.h>
>  #include <linux/kcov.h>
> +#include <linux/refcount.h>
>  #include <asm/setup.h>
>  
>  /* Number of 64-bit words written per one comparison: */
> @@ -44,7 +45,7 @@ struct kcov {
>  	 *  - opened file descriptor
>  	 *  - task with enabled coverage (we can't unwire it from another task)
>  	 */
> -	atomic_t		refcount;
> +	refcount_t		refcount;
>  	/* The lock protects mode, size, area and t. */
>  	spinlock_t		lock;
>  	enum kcov_mode		mode;
> @@ -228,12 +229,12 @@ EXPORT_SYMBOL(__sanitizer_cov_trace_switch);
>  
>  static void kcov_get(struct kcov *kcov)
>  {
> -	atomic_inc(&kcov->refcount);
> +	refcount_inc(&kcov->refcount);
>  }
>  
>  static void kcov_put(struct kcov *kcov)
>  {
> -	if (atomic_dec_and_test(&kcov->refcount)) {
> +	if (refcount_dec_and_test(&kcov->refcount)) {
>  		vfree(kcov->area);
>  		kfree(kcov);
>  	}
> @@ -312,7 +313,7 @@ static int kcov_open(struct inode *inode, struct file *filep)
>  	if (!kcov)
>  		return -ENOMEM;
>  	kcov->mode = KCOV_MODE_DISABLED;
> -	atomic_set(&kcov->refcount, 1);
> +	refcount_set(&kcov->refcount, 1);
>  	spin_lock_init(&kcov->lock);
>  	filep->private_data = kcov;
>  	return nonseekable_open(inode, filep);
> -- 
> 2.7.4
> 
