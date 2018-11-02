Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34BFC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0D42082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ivOqA60i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D0D42082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbeKCDJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:09:16 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46893 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeKCDJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:09:16 -0400
Received: by mail-pf1-f196.google.com with SMTP id r64-v6so1348846pfb.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 11:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oFspRD9YkcB621l+lK9bx9lJ9ONTkzo8Em7/PlYXrak=;
        b=ivOqA60iAETVg4SWxw4X2K6X2SpQ/6OjjJn+CLYbqgoWlV+/Q4k0AFQSu1eIP7KbsA
         ACGRzVyhbsAO7yp+cVfh1eUPoEphi1AskrOnAFOuaCsT3EpQxWLOcgEYcVVSazNC1Oyk
         CHZid654yDA9v6BrPnejwbjW/vhkxDEEeBMTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oFspRD9YkcB621l+lK9bx9lJ9ONTkzo8Em7/PlYXrak=;
        b=ILUmM6/RshENEBYAXSwsAELRlt5WJGmX+ngolPyZhADIhSeNSwvsCfNQFcmEjY14x3
         8Hlr/PgXNV85IoER1xlU4yPPsSg1AShHzYLCqJCcbr84zdW4eJu57dg/F5Q28mS8U0vs
         wJnEwOe07YPpv6+KjWeQWBBsb4uOuW1IUhdRDQaeaoOtkckW4mZ8nomRKnnJSqaulrTc
         TXcTmbHf9tYeX6yCbGbal0MwkrYtrUONFJLquOzjcyy+HlDxadQf21HU4bE6SIfaQXxf
         4ceX9hK6MOQKOpZvAdlKKJSwMeCCapXJu8RPNdIean3FRLe48p5tIMQQ52RF6efwX7aD
         QB4A==
X-Gm-Message-State: AGRZ1gLfUsgBB+rmZ76Xz3n3x4V7hkHe3CPW3d5iAfgzg1beA2x3c5Yq
        Ht047vbiDgL1sJJNro8/wYXrOA==
X-Google-Smtp-Source: AJdET5eMTn2uFdt+GjXOk2i5HAxQeXFjWVeAp/Fc8IGWiOtS24vi92rn3lCiF/aALGCZrcza8E2fuw==
X-Received: by 2002:a63:c70a:: with SMTP id n10-v6mr11576500pgg.431.1541181674240;
        Fri, 02 Nov 2018 11:01:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id t26-v6sm45705607pfa.158.2018.11.02.11.01.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 11:01:12 -0700 (PDT)
Date:   Fri, 2 Nov 2018 11:01:11 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 8/8] pstore/ram: Correctly calculate usable PRZ bytes
Message-ID: <20181102180111.GA14942@google.com>
References: <20181101235200.28584-1-keescook@chromium.org>
 <20181101235200.28584-9-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101235200.28584-9-keescook@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 04:52:00PM -0700, Kees Cook wrote:
> The actual number of bytes stored in a PRZ is smaller than the
> bytes requested by platform data, since there is a header on each
> PRZ. Additionally, if ECC is enabled, there are trailing bytes used
> as well. Normally this mismatch doesn't matter since PRZs are circular
> buffers and the leading "overflow" bytes are just thrown away. However, in
> the case of a compressed record, this rather badly corrupts the results.

Actually this would also mean some data loss for non-compressed records were
also there before, but is now fixed?

> This corruption was visible with "ramoops.mem_size=204800 ramoops.ecc=1".
> Any stored crashes would not be uncompressable (producing a pstorefs
> "dmesg-*.enc.z" file), and triggering errors at boot:
> 
>   [    2.790759] pstore: crypto_comp_decompress failed, ret = -22!
> 
> Reported-by: Joel Fernandes <joel@joelfernandes.org>
> Fixes: b0aad7a99c1d ("pstore: Add compression support to pstore")
> Signed-off-by: Kees Cook <keescook@chromium.org>

Thanks!
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Also should this be fixed for other backends or are those good? AFAIR, I saw
this for EFI too.

- Joel



> ---
>  fs/pstore/ram.c        | 15 ++++++---------
>  include/linux/pstore.h |  5 ++++-
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index 25bede911809..10ac4d23c423 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -814,17 +814,14 @@ static int ramoops_probe(struct platform_device *pdev)
>  
>  	cxt->pstore.data = cxt;
>  	/*
> -	 * Console can handle any buffer size, so prefer LOG_LINE_MAX. If we
> -	 * have to handle dumps, we must have at least record_size buffer. And
> -	 * for ftrace, bufsize is irrelevant (if bufsize is 0, buf will be
> -	 * ZERO_SIZE_PTR).
> +	 * Since bufsize is only used for dmesg crash dumps, it
> +	 * must match the size of the dprz record (after PRZ header
> +	 * and ECC bytes have been accounted for).
>  	 */
> -	if (cxt->console_size)
> -		cxt->pstore.bufsize = 1024; /* LOG_LINE_MAX */
> -	cxt->pstore.bufsize = max(cxt->record_size, cxt->pstore.bufsize);
> -	cxt->pstore.buf = kmalloc(cxt->pstore.bufsize, GFP_KERNEL);
> +	cxt->pstore.bufsize = cxt->dprzs[0]->buffer_size;
> +	cxt->pstore.buf = kzalloc(cxt->pstore.bufsize, GFP_KERNEL);
>  	if (!cxt->pstore.buf) {
> -		pr_err("cannot allocate pstore buffer\n");
> +		pr_err("cannot allocate pstore crash dump buffer\n");
>  		err = -ENOMEM;
>  		goto fail_clear;
>  	}
> diff --git a/include/linux/pstore.h b/include/linux/pstore.h
> index 3549f2ba865c..f46e5df76b58 100644
> --- a/include/linux/pstore.h
> +++ b/include/linux/pstore.h
> @@ -90,7 +90,10 @@ struct pstore_record {
>   *
>   * @buf_lock:	spinlock to serialize access to @buf
>   * @buf:	preallocated crash dump buffer
> - * @bufsize:	size of @buf available for crash dump writes
> + * @bufsize:	size of @buf available for crash dump bytes (must match
> + *		smallest number of bytes available for writing to a
> + *		backend entry, since compressed bytes don't take kindly
> + *		to being truncated)
>   *
>   * @read_mutex:	serializes @open, @read, @close, and @erase callbacks
>   * @flags:	bitfield of frontends the backend can accept writes for
> -- 
> 2.17.1
> 
