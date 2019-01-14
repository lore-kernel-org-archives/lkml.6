Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB49C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7188D206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AAfP+stn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbfANSdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 13:33:19 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38693 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfANSdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 13:33:19 -0500
Received: by mail-qt1-f195.google.com with SMTP id p17so20636qtl.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 10:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6N1/HKt1n78dJ9bREzjDznhTmzqFXsir9IPW0YPB9JI=;
        b=AAfP+stnSJy6ThBVJH7pmweX8FXy8drt2svbXRROCoLyy1+v/2KB52UfBv6khMX3Ig
         3aC7DTumBscWDAzFSjwSM97JF5J0Ff2y06i7G3O/JpSAXv3BxT9fBzLZgY7+CwJJs+SI
         ECYddKsHGFXpPHX6THeU5hiMeouIGp2PsnyplHI57Hkj27O+pR+f+F4lHhVPTVyHsViN
         JcjRRj9O0SKN+2xF/laBFZJid9xPDJ9Ln5/6Fb0qUeqgn3gjmurCccGLKVruK8qdCQET
         TC+anrCiUIwigNl7Pubb1k1UvxEtJJHU8izvqkgp+d+7MMqWL9otL0PAp7gs9Q2FsLe5
         rxww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6N1/HKt1n78dJ9bREzjDznhTmzqFXsir9IPW0YPB9JI=;
        b=oHXepzSyeoo87ICznwGhbuGv+P6jnQrCZTDb1NNdJoV5RxyEATb/srgjIop1JSr/rE
         GPcckcRqqVVnuotGEsmFysVz3kVzWrseVnVuootXQkSTZEe0kN4kOfKbOcjFjErIhaGX
         Qo7W8Y70ZaOxwYIhUOlQx6LXig9/Txk4OwFbZvdwkIXwBcEN22+rh9xhQaJJfviB6saD
         HkRnLy7OD6dn+fN5dQ8wVP5xtyup56dBWY4QaAdxG5rmTqAbC5WXclcmBzUSJebCts2N
         wJV0sRWxo5KxsrpRj1o0IFUAuOfNM3YQP/lY79ygfcCF9PnIt6NYqKKmoiSOVM882cIA
         FtGA==
X-Gm-Message-State: AJcUukcSYXn3ltXXfoZoIFmJ/YxPNhQCswMJlYqZUIZc1jPUlr1tvxB7
        rfzFtZh+PokQDv4XeA/bZ3lNqA==
X-Google-Smtp-Source: ALg8bN7lVex4Opgn3QfLaeYPDmY3T5Yb92LY7SNAF/6AlPvf8Gulke2JkdcEX9TBAdLCZ70PyYZpkg==
X-Received: by 2002:ac8:2881:: with SMTP id i1mr25604114qti.382.1547490797658;
        Mon, 14 Jan 2019 10:33:17 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cfd0:d2ee:d54d:ab6d])
        by smtp.gmail.com with ESMTPSA id v57sm54838493qtv.80.2019.01.14.10.33.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 10:33:17 -0800 (PST)
Date:   Mon, 14 Jan 2019 13:33:16 -0500
From:   Joel Fernandes <joelaf@google.com>
To:     Todd Kjos <tkjos@android.com>
Cc:     tkjos@google.com, gregkh@linuxfoundation.org, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com, joel@joelfernandes.org, kernel-team@android.com
Subject: Re: [PATCH v3] binder: create node flag to request sender's security
 context
Message-ID: <20190114183316.GA199154@google.com>
References: <20190114171021.86171-1-tkjos@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114171021.86171-1-tkjos@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 09:10:21AM -0800, Todd Kjos wrote:
> To allow servers to verify client identity, allow a node
> flag to be set that causes the sender's security context
> to be delivered with the transaction. The BR_TRANSACTION
> command is extended in BR_TRANSACTION_SEC_CTX to
> contain a pointer to the security context string.
> 
> Signed-off-by: Todd Kjos <tkjos@google.com>
> ---
> v2: fix 32-bit build warning
> v3: fix smatch warning on unitialized struct element
> 
>  drivers/android/binder.c            | 106 ++++++++++++++++++++++------
>  include/uapi/linux/android/binder.h |  19 +++++
>  2 files changed, 102 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index cdfc87629efb8..5f6ef5e63b91e 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -329,6 +329,8 @@ struct binder_error {
>   *                        (invariant after initialized)
>   * @min_priority:         minimum scheduling priority
>   *                        (invariant after initialized)
> + * @txn_security_ctx:     require sender's security context
> + *                        (invariant after initialized)
>   * @async_todo:           list of async work items
>   *                        (protected by @proc->inner_lock)
>   *
> @@ -365,6 +367,7 @@ struct binder_node {
>  		 * invariant after initialization
>  		 */
>  		u8 accept_fds:1;
> +		u8 txn_security_ctx:1;
>  		u8 min_priority;
>  	};
>  	bool has_async_transaction;
> @@ -615,6 +618,7 @@ struct binder_transaction {
>  	long	saved_priority;
>  	kuid_t	sender_euid;
>  	struct list_head fd_fixups;
> +	binder_uintptr_t security_ctx;
>  	/**
>  	 * @lock:  protects @from, @to_proc, and @to_thread
>  	 *
> @@ -1152,6 +1156,7 @@ static struct binder_node *binder_init_node_ilocked(
>  	node->work.type = BINDER_WORK_NODE;
>  	node->min_priority = flags & FLAT_BINDER_FLAG_PRIORITY_MASK;
>  	node->accept_fds = !!(flags & FLAT_BINDER_FLAG_ACCEPTS_FDS);
> +	node->txn_security_ctx = !!(flags & FLAT_BINDER_FLAG_TXN_SECURITY_CTX);
>  	spin_lock_init(&node->lock);
>  	INIT_LIST_HEAD(&node->work.entry);
>  	INIT_LIST_HEAD(&node->async_todo);
> @@ -2778,6 +2783,8 @@ static void binder_transaction(struct binder_proc *proc,
>  	binder_size_t last_fixup_min_off = 0;
>  	struct binder_context *context = proc->context;
>  	int t_debug_id = atomic_inc_return(&binder_last_id);
> +	char *secctx = NULL;
> +	u32 secctx_sz = 0;
>  
>  	e = binder_transaction_log_add(&binder_transaction_log);
>  	e->debug_id = t_debug_id;
> @@ -3020,6 +3027,20 @@ static void binder_transaction(struct binder_proc *proc,
>  	t->flags = tr->flags;
>  	t->priority = task_nice(current);
>  
> +	if (target_node && target_node->txn_security_ctx) {
> +		u32 secid;
> +
> +		security_task_getsecid(proc->tsk, &secid);
> +		ret = security_secid_to_secctx(secid, &secctx, &secctx_sz);
> +		if (ret) {
> +			return_error = BR_FAILED_REPLY;
> +			return_error_param = ret;
> +			return_error_line = __LINE__;
> +			goto err_get_secctx_failed;
> +		}
> +		extra_buffers_size += ALIGN(secctx_sz, sizeof(u64));
> +	}
> +
>  	trace_binder_transaction(reply, t, target_node);
>  
>  	t->buffer = binder_alloc_new_buf(&target_proc->alloc, tr->data_size,
> @@ -3036,6 +3057,19 @@ static void binder_transaction(struct binder_proc *proc,
>  		t->buffer = NULL;
>  		goto err_binder_alloc_buf_failed;
>  	}
> +	if (secctx) {
> +		size_t buf_offset = ALIGN(tr->data_size, sizeof(void *)) +
> +				    ALIGN(tr->offsets_size, sizeof(void *)) +
> +				    ALIGN(extra_buffers_size, sizeof(void *)) -
> +				    ALIGN(secctx_sz, sizeof(u64));
> +		char *kptr = t->buffer->data + buf_offset;
> +
> +		t->security_ctx = (uintptr_t)kptr +
> +		    binder_alloc_get_user_buffer_offset(&target_proc->alloc);
> +		memcpy(kptr, secctx, secctx_sz);

Just for my clarification, instead of storing the string in the transaction
buffer, would it not be better to store the security context id in
t->security_ctx, and then do the conversion to string later, during
binder_thread_read? Then some space will also be saved in the transaction
buffer?

thanks,

 - Joel


