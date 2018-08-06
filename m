Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C24C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A88221A56
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZYFTjQL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A88221A56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387422AbeHGAbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 20:31:51 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36414 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731258AbeHGAbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 20:31:51 -0400
Received: by mail-pg1-f196.google.com with SMTP id h12-v6so6836207pgs.3;
        Mon, 06 Aug 2018 15:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xtDo7/n6IdwSWNNB8K6HngQ26jse3qYibwd/QMTpsqE=;
        b=mZYFTjQLjqiWuFACYyORZdDQFH2zMWtBbOTrEG6SZsEsdPKA0ipKBA/HM5sw8gjpgu
         vmKk83K/WlV/K0yEhzqrHSPyqyHGUZymHn80UkEKgVjIZpKlsAsFcRST+deTmMsyLnqC
         ZVfSf33WhXWJWAoLZhRjEn5NKNIp8pN7JYqsSxqUIPTGk909Y2SL4RTDHB2zm1Y8dJKe
         7f0/q2YMRM1XlBKqk9lH3sbH3S7mW6Gjbn+aOAuKclwcO9vNfc3XsUGdO1elsyKdAhR0
         3cV3Cym0s14VwZh1pXYJEc35CeQwzJf+d7RsaYIbz3/4mO15t5c0AZuw5p+yAPSEuHmh
         zx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xtDo7/n6IdwSWNNB8K6HngQ26jse3qYibwd/QMTpsqE=;
        b=CTv1/6Dcnf5/R0SIB1qtXdbBpGkpLCszJpnAI6i6Pl8sl/J+dLHxN4l1T8ugRbpoBo
         u/FpFRnMUoyGCMMj4ES+IhE79i+lpBm8tfgNmYaujSyRQLBBMby5ISfIW73M8kwOAmYp
         1rBLyCXKWTHcYNLY1aoWgLPOWjOMsN6C07fEdbzaXB2vXAlshcKTNkSjAUdBgM9uvcmo
         lhirpl4jOslOv275+Lmbr4kYeFa7NIr0RgrspOZlXzojESE5X6a7ogtg9Cdpw2gfCWaN
         mEgUzbSmQZZxz52XSvEHgcVUj2yq0HfMzqkg5THCDbo1cXpdbArx+m3O4MrMFnB7G+Sk
         XBww==
X-Gm-Message-State: AOUpUlF7BlkhLTXXEcIVuTdiYV5c3v9StXU1kJxL2t43oqpDOXUXl9ym
        vJ7K+Hkfyw3QFYltjoXoA36QscAO
X-Google-Smtp-Source: AAOMgpfUv2vq0euxeHgFEzUFLprvmVO4H8xGTdzFGeeAOP3j4U8RYg0UsnV6mrdy5g9rCTiX54vPtA==
X-Received: by 2002:a63:2dc1:: with SMTP id t184-v6mr16001268pgt.62.1533594042029;
        Mon, 06 Aug 2018 15:20:42 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id b1-v6sm18146140pgi.91.2018.08.06.15.20.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 15:20:40 -0700 (PDT)
Date:   Mon, 6 Aug 2018 15:20:39 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: raydium_i2c_ts - use true and false for boolean
 values
Message-ID: <20180806222039.GA141444@dtor-ws>
References: <20180805003406.GA30522@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180805003406.GA30522@embeddedor.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 04, 2018 at 07:34:06PM -0500, Gustavo A. R. Silva wrote:
> Return statements in functions returning bool should use true or false
> instead of an integer value.
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/raydium_i2c_ts.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/touchscreen/raydium_i2c_ts.c
> index d1c09e6..c89853a 100644
> --- a/drivers/input/touchscreen/raydium_i2c_ts.c
> +++ b/drivers/input/touchscreen/raydium_i2c_ts.c
> @@ -466,7 +466,7 @@ static bool raydium_i2c_boot_trigger(struct i2c_client *client)
>  		}
>  	}
>  
> -	return 0;
> +	return false;
>  }
>  
>  static bool raydium_i2c_fw_trigger(struct i2c_client *client)
> @@ -492,7 +492,7 @@ static bool raydium_i2c_fw_trigger(struct i2c_client *client)
>  		}
>  	}
>  
> -	return 0;
> +	return false;
>  }
>  
>  static int raydium_i2c_check_path(struct i2c_client *client)
> -- 
> 2.7.4
> 

-- 
Dmitry
