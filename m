Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B21CC7112F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A6B20861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="j+9ddWCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfAULvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:51:24 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44451 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbfAULvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:51:23 -0500
Received: by mail-ed1-f65.google.com with SMTP id y56so16300098edd.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 03:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yy8YGFbB718gasMSjGqC36DNt4n4QGM032q6+65QHEg=;
        b=j+9ddWCIXtkILmA7Jjnp+TTR31vMRld/u1gH2Zngm0QVWiefT3IdJvJTINrzOayetQ
         J2IWXL6WH7JBa+kAjCOGlVS0YKO/Kvd6YJlTiwWiu1Av3ZtlGNbWli6edBQMKPIyI74E
         qZXAw5NgOtVgfw1UZ/2hk3oeinmZwPIHRWskU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yy8YGFbB718gasMSjGqC36DNt4n4QGM032q6+65QHEg=;
        b=He5Igry6ljOdh0QgHVrfzkjAbYwnMVGyQid6hYxaSMQj1Y1CZU1QzRH+TJTVwnsZhF
         9bYcujb5Gtsv+cAv9mU/x00inJknJhs0sdOs3pSte9Zk1ps22XPtoorHvxlPYT8XxcGs
         fbNnKjrd/uQ17neQcAFNJ7CgsY3Qn8TXMJ/BSbOrSRclXkQvSeN1V4IACDwql8mIUqeO
         y7xj8sVX6io3QD2Xu/hWKqtxu2JswFLHqoG0AvxpCanlG9lhMGd3fB3jybYAK6I5AAFs
         dmVgReH5+LvQuiaoXGZfJFYAQ+PpjRpAtVAVNqzYQqutEaNbmCw7rfAGgmr2vGYKFxwL
         blAw==
X-Gm-Message-State: AJcUukdTzVvEk3kZO/NgA+WpM3ksxmPCtvYOb5hUbkDnQSvzautuuv9x
        x7Bup1gM5GqDm33lqBjVDbVOcQ==
X-Google-Smtp-Source: ALg8bN4akm3sEVnZdrijPOtG9Ct0dawZIAXHhq+1BAL/8TK2djD1L+YAYjI3Eq2AaAlgMm7ePgQpYA==
X-Received: by 2002:a17:906:340a:: with SMTP id c10-v6mr14983867ejb.130.1548071481639;
        Mon, 21 Jan 2019 03:51:21 -0800 (PST)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id r8-v6sm5219278ejb.52.2019.01.21.03.51.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 03:51:21 -0800 (PST)
Date:   Mon, 21 Jan 2019 12:51:14 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Elena Reshetova <elena.reshetova@intel.com>
Cc:     akpm@linux-foundation.org, aryabinin@virtuozzo.com,
        anders.roxell@linaro.org, mark.rutland@arm.com, dvyukov@google.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        peterz@infradead.org
Subject: Re: [PATCH] kcov: convert kcov.refcount to refcount_t
Message-ID: <20190121115114.GA8350@andrea>
References: <1547634429-772-1-git-send-email-elena.reshetova@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547634429-772-1-git-send-email-elena.reshetova@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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

Reviewed-by: Andrea Parri <andrea.parri@amarulasolutions.com>

(Same remark about the reference in the commit message. ;-) )

  Andrea


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
