Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3423C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75E272081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Go3S+ftW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75E272081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbeKCDdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:33:05 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43891 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727465AbeKCDdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:33:04 -0400
Received: by mail-pg1-f194.google.com with SMTP id n10-v6so1319125pgv.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 11:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C/8mSVbPQ47lvLevvaWkk5GqZkYMInYFZylQMtpWups=;
        b=Go3S+ftW7k/GcMXZq9SL2inhhXL11XzN1hGEItaNDsaaitf3PSWPOVExg/+do/GQad
         4Mw1R0L7AuY1XnX/uQMXpyXkoxw0crrbW/5a9Fs99K9EHD+kh7P1WBmWXi5Ds1Ypgmli
         D33C5Mqq2lGDfb0QBh2qEfKIK7IoX3S7Y7/1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C/8mSVbPQ47lvLevvaWkk5GqZkYMInYFZylQMtpWups=;
        b=agJMwFcqrg4rFPFU9nUFrAkkXG/tm5Kvz0r3oe3f+uGM4M8vbuQEG9lY5Lydj+MPj6
         EM1zwz0JuGwaD2FcxM4XByaxWIvSqloU63eqqgvy6ySgXhIduAcRBzbEPRfW8DJ+4q7F
         sqCm1mTwcEXCs3yK8y9Tycyxj9fKA+58YEDCNQ8kwoB8ape2imAfMgWLky07mn5h/dtQ
         GipnqAI/oIv3MlKQU6zic4Wsxk7FiHLmNajB6ud6DS/YCWxrhl2sIVn1pNqssJIeghop
         sSJSjVr81kOehwl2ZpE0rM9Qt/YJg/c2MDLVXPq+x2US9BQ+YPX9zCZOOuiRcBr1iao8
         Sn+w==
X-Gm-Message-State: AGRZ1gLNiin/mvXAlSWFmUWX2jgF09pK2KNUxOqt2sQtYuv85dLIA/3O
        HSoAkipMDpAv2D3t2+ZNAwgnReFo81g=
X-Google-Smtp-Source: AJdET5eicLswCmbK1x5B4KeWupeByqlVdEqOU5igolTbFd+VtY2nlNrXk4A6EHOgOuMKmjx9oTHXKQ==
X-Received: by 2002:a63:27c1:: with SMTP id n184-v6mr11860857pgn.334.1541183096947;
        Fri, 02 Nov 2018 11:24:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id c128-v6sm32302331pfb.147.2018.11.02.11.24.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 11:24:55 -0700 (PDT)
Date:   Fri, 2 Nov 2018 11:24:54 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 2/8] pstore: Do not use crash buffer for decompression
Message-ID: <20181102182454.GB14942@google.com>
References: <20181101235200.28584-1-keescook@chromium.org>
 <20181101235200.28584-3-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101235200.28584-3-keescook@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 04:51:54PM -0700, Kees Cook wrote:
> The pre-allocated compression buffer used for crash dumping was also
> being used for decompression. This isn't technically safe, since it's
> possible the kernel may attempt a crashdump while pstore is populating the
> pstore filesystem (and performing decompression). Instead, just allocate

Yeah, that would be bad if it happened ;)

> a separate buffer for decompression. Correctness is preferred over
> performance here.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  fs/pstore/platform.c | 56 ++++++++++++++++++++------------------------
>  1 file changed, 25 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
> index b821054ca3ed..8b6028948cf3 100644
> --- a/fs/pstore/platform.c
> +++ b/fs/pstore/platform.c
> @@ -258,20 +258,6 @@ static int pstore_compress(const void *in, void *out,
>  	return outlen;
>  }
>  
> -static int pstore_decompress(void *in, void *out,
> -			     unsigned int inlen, unsigned int outlen)
> -{
> -	int ret;
> -
> -	ret = crypto_comp_decompress(tfm, in, inlen, out, &outlen);
> -	if (ret) {
> -		pr_err("crypto_comp_decompress failed, ret = %d!\n", ret);
> -		return ret;
> -	}
> -
> -	return outlen;
> -}
> -
>  static void allocate_buf_for_compression(void)
>  {
>  	struct crypto_comp *ctx;
> @@ -656,8 +642,9 @@ EXPORT_SYMBOL_GPL(pstore_unregister);
>  
>  static void decompress_record(struct pstore_record *record)
>  {
> +	int ret;
>  	int unzipped_len;

nit: We could get rid of the unzipped_len variable now I think.

> -	char *decompressed;
> +	char *unzipped, *workspace;
>  
>  	if (!record->compressed)
>  		return;
> @@ -668,35 +655,42 @@ static void decompress_record(struct pstore_record *record)
>  		return;
>  	}
>  
> -	/* No compression method has created the common buffer. */
> +	/* Missing compression buffer means compression was not initialized. */
>  	if (!big_oops_buf) {
> -		pr_warn("no decompression buffer allocated\n");
> +		pr_warn("no decompression method initialized!\n");
>  		return;
>  	}
>  
> -	unzipped_len = pstore_decompress(record->buf, big_oops_buf,
> -					 record->size, big_oops_buf_sz);
> -	if (unzipped_len <= 0) {
> -		pr_err("decompression failed: %d\n", unzipped_len);
> +	/* Allocate enough space to hold max decompression and ECC. */
> +	unzipped_len = big_oops_buf_sz;
> +	workspace = kmalloc(unzipped_len + record->ecc_notice_size,

Should tihs be unzipped_len + record->ecc_notice_size + 1. The extra byte
being for the NULL character of the ecc notice?

This occurred to me when I saw the + 1 in ram.c. It could be better to just
abstract the size as a macro.

> +			    GFP_KERNEL);
> +	if (!workspace)
>  		return;
> -	}
>  
> -	/* Build new buffer for decompressed contents. */
> -	decompressed = kmalloc(unzipped_len + record->ecc_notice_size,
> -			       GFP_KERNEL);
> -	if (!decompressed) {
> -		pr_err("decompression ran out of memory\n");
> +	/* After decompression "unzipped_len" is almost certainly smaller. */
> +	ret = crypto_comp_decompress(tfm, record->buf, record->size,
> +					  workspace, &unzipped_len);
> +	if (ret) {
> +		pr_err("crypto_comp_decompress failed, ret = %d!\n", ret);
> +		kfree(workspace);
>  		return;
>  	}
> -	memcpy(decompressed, big_oops_buf, unzipped_len);
>  
>  	/* Append ECC notice to decompressed buffer. */
> -	memcpy(decompressed + unzipped_len, record->buf + record->size,
> +	memcpy(workspace + unzipped_len, record->buf + record->size,
>  	       record->ecc_notice_size);
>  
> -	/* Swap out compresed contents with decompressed contents. */
> +	/* Copy decompressed contents into an minimum-sized allocation. */
> +	unzipped = kmemdup(workspace, unzipped_len + record->ecc_notice_size,
> +			   GFP_KERNEL);
> +	kfree(workspace);
> +	if (!unzipped)
> +		return;
> +
> +	/* Swap out compressed contents with decompressed contents. */
>  	kfree(record->buf);
> -	record->buf = decompressed;
> +	record->buf = unzipped;

Rest of it LGTM, thanks!

 - Joel
