Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29CAC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 839F02081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="jEy7l80g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 839F02081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbeKCDkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:40:17 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36676 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727747AbeKCDkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:40:17 -0400
Received: by mail-pf1-f196.google.com with SMTP id j22-v6so1408165pfh.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 11:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lGr1/GPhODRNl1DjrK/xhjMVkRLtOcHFU4zI5hPAmoY=;
        b=jEy7l80gAkC6w6FsjraAuOg0wmNPMoUroVQPMjlpHIAJi/2OL8NlIQhyqPJIDh1RJM
         gzjzyWAyPhK3JYy4IxuCpoDr5esPDff+ptGtgtDPtmfeWF9mnDdBH1EOe2jWHO6IZ5Rq
         7Xl0m5zX/zNUAHzpiXyAXH0Xv18wf2PBprL04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lGr1/GPhODRNl1DjrK/xhjMVkRLtOcHFU4zI5hPAmoY=;
        b=L7iqzWWVig40M1QVE+1nlaf6zkP/KWBfRNr6UHVUVrmYw6WxQHEaWiMlsbJfSwADlf
         bx/rj71UfyXAGFI4ZnMPTncheSIXofWJd78s8As+yTDRPFfgDRgEIHau1NGY9t+j0lqT
         wHcyhEBL1SRNiTN2iDafuWtFO//nK8JQ/esjYut5dafB23ZmJ7M0Dn7STwUcGWJ/M93Z
         WUVUiOxrK4VQZVCZCGdHEGxLAwzlKKeAA7hhEWesYWD7fcG9EO7tu9pWWMuW4nW307N/
         WBwn4u+4enXKnw3zc6g9n1XKHI4eNU4ZCHEussN4FjJv5X2NUoOD6xJsB6JCWj1Cv++2
         MGXA==
X-Gm-Message-State: AGRZ1gLsHvDT1ltBVfoQZmW0KVhg8yKhW9gyyF+oqUO3Vu7fDSVQEaCA
        UrLIDWX2XC/Icy7zyrIo5GXi1Hz83Qs=
X-Google-Smtp-Source: AJdET5cvrfCX08lgln3JWyDZzmQNALEIeTnyRBqlBGpmmtYubp+2JruPI1wso6s6oIobWwYtNYSTXA==
X-Received: by 2002:a65:4244:: with SMTP id d4-v6mr11868515pgq.289.1541183527247;
        Fri, 02 Nov 2018 11:32:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id t4-v6sm39487571pfb.44.2018.11.02.11.32.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 11:32:05 -0700 (PDT)
Date:   Fri, 2 Nov 2018 11:32:04 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 7/8] pstore: Remove needless lock during console writes
Message-ID: <20181102183204.GC14942@google.com>
References: <20181101235200.28584-1-keescook@chromium.org>
 <20181101235200.28584-8-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101235200.28584-8-keescook@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 04:51:59PM -0700, Kees Cook wrote:
> Since commit 70ad35db3321 ("pstore: Convert console write to use
> ->write_buf"), the console writer does not use the preallocated crash
> dump buffer any more, so there is no reason to perform locking around it.

Out of curiosity, what was the reason for having this preallocated crash
buffer in the first place? I thought the 'console' type only did regular
kernel console logging, not crash dumps.

I looked at all the patches and had some minor nits, with the nits addressed
(if you agree with them), feel free to add my Reviewed-by on future respins:

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Also I wonder if Namhyung is still poking around that virtio pstore driver he
mentioned in the commit mentioned above. :)

thanks,

- Joel

> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  fs/pstore/platform.c | 29 ++++++-----------------------
>  1 file changed, 6 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
> index a956c7bc3f67..32340e7dd6a5 100644
> --- a/fs/pstore/platform.c
> +++ b/fs/pstore/platform.c
> @@ -461,31 +461,14 @@ static void pstore_unregister_kmsg(void)
>  #ifdef CONFIG_PSTORE_CONSOLE
>  static void pstore_console_write(struct console *con, const char *s, unsigned c)
>  {
> -	const char *e = s + c;
> +	struct pstore_record record;
>  
> -	while (s < e) {
> -		struct pstore_record record;
> -		unsigned long flags;
> -
> -		pstore_record_init(&record, psinfo);
> -		record.type = PSTORE_TYPE_CONSOLE;
> -
> -		if (c > psinfo->bufsize)
> -			c = psinfo->bufsize;
> +	pstore_record_init(&record, psinfo);
> +	record.type = PSTORE_TYPE_CONSOLE;
>  
> -		if (oops_in_progress) {
> -			if (!spin_trylock_irqsave(&psinfo->buf_lock, flags))
> -				break;
> -		} else {
> -			spin_lock_irqsave(&psinfo->buf_lock, flags);
> -		}
> -		record.buf = (char *)s;
> -		record.size = c;
> -		psinfo->write(&record);
> -		spin_unlock_irqrestore(&psinfo->buf_lock, flags);
> -		s += c;
> -		c = e - s;
> -	}
> +	record.buf = (char *)s;
> +	record.size = c;
> +	psinfo->write(&record);
>  }
>  
>  static struct console pstore_console = {
> -- 
> 2.17.1
> 
