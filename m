Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01965C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC5E321B68
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550186716;
	bh=7ZccXBZKT3FuR4VsmgBeFjALPcke+/W/6buCNxRGf+c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=wLZbfBPZtXq+BU8FLQ3BatmUE7Q9CKrGytHr1x8VZckL1+I7Tuti9/wbyACHt3cQb
	 SqmPtagnou3lGY4KoGBhBlBpPJCYJO4V+iFCyo/VkI4uoZlCvnH2wQ9PHWEXKdydHy
	 u5P4Td0y/vKttEF88glyPiy124JDcKWcZGazMVcA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729063AbfBNXZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 18:25:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:41174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbfBNXZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 18:25:14 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D22DD21B1C;
        Thu, 14 Feb 2019 23:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550186713;
        bh=7ZccXBZKT3FuR4VsmgBeFjALPcke+/W/6buCNxRGf+c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SUAP/f4pAhrky3z/XA46kmKNwGPpGYJ3lIaRCQV9qdbln1GPZmd284kuzGAG62pqH
         PUKG+P/s72DvnjirOyvwPy3NaK5xMctgvi55vnV0jXuTWDxI3MelpFH25ZUgJIrcSI
         WXa8ZxKRW0E+MlA5lOWe2pcfY1Igooyy2NNV2Hc8=
Message-ID: <1550186711.2498.10.camel@kernel.org>
Subject: Re: [PATCH v15 05/15] tracing: Add conditional snapshot
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Date:   Thu, 14 Feb 2019 17:25:11 -0600
In-Reply-To: <20190214181150.0453ecdf@gandalf.local.home>
References: <cover.1550100284.git.tom.zanussi@linux.intel.com>
         <1bea07828d5fd6864a585f83b1eed47ce097eb45.1550100284.git.tom.zanussi@linux.intel.com>
         <20190214181150.0453ecdf@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Thu, 2019-02-14 at 18:11 -0500, Steven Rostedt wrote:
> On Wed, 13 Feb 2019 17:42:45 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > +
> > +/**
> > + * tracing_snapshot_cond_enable - enable conditional snapshot for
> > an instance
> > + * @tr:		The tracing instance
> > + * @cond_data:	User data to associate with the snapshot
> > + * @update:	Implementation of the cond_snapshot update
> > function
> > + *
> > + * Check whether the conditional snapshot for the given instance
> > has
> > + * already been enabled, or if the current tracer is already using
> > a
> > + * snapshot; if so, return -EBUSY, else create a cond_snapshot and
> > + * save the cond_data and update function inside.
> > + *
> > + * Returns 0 if successful, error otherwise.
> > + */
> > +int tracing_snapshot_cond_enable(struct trace_array *tr, void
> > *cond_data,
> > +				 cond_update_fn_t update)
> > +{
> > +	struct cond_snapshot *cond_snapshot;
> > +	int ret = 0;
> > +
> > +	cond_snapshot = kzalloc(sizeof(*cond_snapshot),
> > GFP_KERNEL);
> > +	if (!cond_snapshot)
> > +		return -ENOMEM;
> > +
> > +	cond_snapshot->cond_data = cond_data;
> > +	cond_snapshot->update = update;
> > +
> > +	mutex_lock(&trace_types_lock);
> > +
> > +	ret = tracing_alloc_snapshot_instance(tr);
> > +	if (ret)
> > +		goto fail_unlock;
> > +
> > +	if (tr->current_trace->use_max_tr) {
> > +		ret = -EBUSY;
> > +		goto fail_unlock;
> > +	}
> > +
> > +	if (tr->cond_snapshot) {
> > +		ret = -EBUSY;
> > +		goto fail_unlock;
> > +	}
> > +
> > +	arch_spin_lock(&tr->max_lock);
> > +	tr->cond_snapshot = cond_snapshot;
> > +	arch_spin_unlock(&tr->max_lock);
> > +
> > +	mutex_unlock(&trace_types_lock);
> > +
> > +	return ret;
> > +
> > + fail_unlock:
> > +        mutex_unlock(&trace_types_lock);
> > +        kfree(cond_snapshot);
> > +        return ret;
> 
> Some whitespace damage here. No need to resend, I fixed it.
> 

OK, thanks.

> 
> > +}
> > +EXPORT_SYMBOL_GPL(tracing_snapshot_cond_enable);
> > +
> 
> I also added this change on top of your series.
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 0460cc0f28fd..2cf3c747a357 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -1116,6 +1116,14 @@ int tracing_snapshot_cond_enable(struct
> trace_array *tr, void *cond_data,
>  		goto fail_unlock;
>  	}
>  
> +	/*
> +	 * The cond_snapshot can only change to NULL without the
> +	 * trace_types_lock. We don't care if we race with it going
> +	 * to NULL, but we want to make sure that it's not set to
> +	 * something other than NULL when we get here, which we can
> +	 * do safely with only holding the trace_types_lock and not
> +	 * having to take the max_lock.
> +	 */
>  	if (tr->cond_snapshot) {
>  		ret = -EBUSY;
>  		goto fail_unlock;
> 

Looks good, thanks for adding that back.

Tom

> I'll start testing your series now.
> 
> Thanks!
> 
> -- Steve
> 
