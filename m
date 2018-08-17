Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A402C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 08:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE3A21896
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 08:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LChmcydZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BE3A21896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbeHQLqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 07:46:40 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54120 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbeHQLqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 07:46:40 -0400
Received: by mail-wm0-f65.google.com with SMTP id s9-v6so6852340wmh.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 01:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CrY+KJctFbw4AVPhHRgoye4LLjyBDIvZauxXJpZhsfQ=;
        b=LChmcydZ7CbFnmSDmkbM7JRTPXxp1KeeKa+8PhxBHigAjVFmwq0uC4uSxd84FkdU8b
         waeuaTFj8Y/v+RLJRT3CMF6lfPkjvAQRCjuvMkn02fgQu4e5HbBCSbkUlzQbqYGUKiIB
         0UoUT+d1zPZV1TtWz03ZtGKKQYTUPRzHBfyqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CrY+KJctFbw4AVPhHRgoye4LLjyBDIvZauxXJpZhsfQ=;
        b=A0cCys4QEpj+aawqCbBkBkbnYkQkxnsJLiQDujUbRv/uvrTe0xL9t4DGyqdXnoz4Eu
         wiRqM4TvbKh/WOrevFraqyreWflw/dmpqAPXJrhAXk0GsdRQQcA2klRwMySQ+ERwPCYI
         usOJ5hhobiCozv0XX8xHrBULrKI6Gu+Xi/6GETWdTOq6TOAg4QRXIrJvn73dlGP8ZyIa
         Ez//MeHKHyDQ3FfFxSC2AnY1tEE/jqEtwJ5k9O5Aa/jHyjKW0CyyIvGOp2szhuQ1ESa2
         9yPXkEenONNPwsaNCaglkBLNXPLdv8pwt3kU5Xs+se/ncnH7t/DWmZu1wFrzTqSFFOet
         hSsA==
X-Gm-Message-State: AOUpUlHeWyJaroprw08duwIJHlU/gVTlMCHJ3DRfyXw6hDr3Ww1GoBoQ
        ppJBEoqZK9T31OPBA4q2VkfOig==
X-Google-Smtp-Source: AA+uWPxIGNvnD9/qEKLwkpp9KqezSM/PQmAKG2KVWTvicltvSGkuC+DrH/jqI5mgqjRMUE6n46+OUA==
X-Received: by 2002:a1c:c7c1:: with SMTP id x184-v6mr17749891wmf.134.1534495446801;
        Fri, 17 Aug 2018 01:44:06 -0700 (PDT)
Received: from holly.lan (89-145-231-170.xdsl.murphx.net. [89.145.231.170])
        by smtp.gmail.com with ESMTPSA id s5-v6sm1290880wro.33.2018.08.17.01.44.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Aug 2018 01:44:05 -0700 (PDT)
Date:   Fri, 17 Aug 2018 09:44:02 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kdb: kdb_main: refactor code in kdb_md_line
Message-ID: <20180817084402.ccqulr3mei6mjxgs@holly.lan>
References: <20180816140141.GA28913@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816140141.GA28913@embeddedor.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 09:01:41AM -0500, Gustavo A. R. Silva wrote:
> Replace the whole switch statement with a for loop.
> This makes the code much clear and easy to read.
> 
> This also addresses the following Coverity warnings:
> 
> Addresses-Coverity-ID: 115090 ("Missing break in switch")
> Addresses-Coverity-ID: 115091 ("Missing break in switch")
> Addresses-Coverity-ID: 114700 ("Missing break in switch")
> 
> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
> Changes in v2:
>  - Add new variable j and use it for the for loop.
> 
>  kernel/debug/kdb/kdb_main.c | 21 +++------------------
>  1 file changed, 3 insertions(+), 18 deletions(-)
> 
> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index 2ddfce8..a9ad288 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -1493,6 +1493,7 @@ static void kdb_md_line(const char *fmtstr, unsigned long addr,
>  	char cbuf[32];
>  	char *c = cbuf;
>  	int i;
> +	int j;
>  	unsigned long word;
>  
>  	memset(cbuf, '\0', sizeof(cbuf));
> @@ -1538,25 +1539,9 @@ static void kdb_md_line(const char *fmtstr, unsigned long addr,
>  			wc.word = word;
>  #define printable_char(c) \
>  	({unsigned char __c = c; isascii(__c) && isprint(__c) ? __c : '.'; })
> -			switch (bytesperword) {
> -			case 8:
> +			for (j = 0; j < bytesperword; j++)
>  				*c++ = printable_char(*cp++);
> -				*c++ = printable_char(*cp++);
> -				*c++ = printable_char(*cp++);
> -				*c++ = printable_char(*cp++);
> -				addr += 4;
> -			case 4:
> -				*c++ = printable_char(*cp++);
> -				*c++ = printable_char(*cp++);
> -				addr += 2;
> -			case 2:
> -				*c++ = printable_char(*cp++);
> -				addr++;
> -			case 1:
> -				*c++ = printable_char(*cp++);
> -				addr++;
> -				break;
> -			}
> +			addr += bytesperword;
>  #undef printable_char
>  		}
>  	}
> -- 
> 2.7.4
> 
