Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F043C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 14:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27C0C215A3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 14:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ParrWntq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27C0C215A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbeHOR0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 13:26:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44627 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729265AbeHOR0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 13:26:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id r16-v6so1306024wrt.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 07:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W26SVNuV0Ic1Ue7iJXtjz4o/7KNXxapJvV1hYuqBOLE=;
        b=ParrWntqxwisS+ul2NWmoY+2Q1nZ/XR3ZeN3KUxiecHqYdbAXNI7qYTbfaPDin6zWa
         UssDA6kUTUQR66mD79+qZNBs0upqTgOsAGp9V52OtZDto4e4mAmquURipjAQBkn+AYnx
         jpdhFWzaqqTWGXFqkxu6dX/WjYlqwWkq9AKNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W26SVNuV0Ic1Ue7iJXtjz4o/7KNXxapJvV1hYuqBOLE=;
        b=AE2hHpe7UMAX+x4a4WnZzVzu1k0zKlTkhpD/oD4C6U9qjI+QHfG0IAj/rrP3g9OADw
         phq6aTh5pU4DhnBkBiTT4WOOwTDq7k2ughe4kq10+nCRDYGBwCo2ro4ZOqom0TAG6xoK
         zXKA7O36jXv1n2IropMnhYi2LLWY2nLoRl5i57ytSXgSSduhNILVkM2qsxj7Yw4Pse+b
         1lkCPZG3qXKxkllcNi70HXyrJmlUJGj7m10uMecu6UVaWo0OQDYfYtyvbo6Zovx3OoYD
         CWNSLkvuMgwo23zR5vH1qiLq1k0s4UkmKBQMjQUbEwGuuwXCjYbNRgiwRHkPYPLPvL+9
         q0Sg==
X-Gm-Message-State: AOUpUlHZXFMuYwh8IjbDMzDR8ZFodEM0JgADBh6IIvze2gZ9fnr40aCm
        FelCYxlejomJaHlYmF8IzJTqjjnyky0=
X-Google-Smtp-Source: AA+uWPzTgqf3eh3GOASdOu8catD20VDUerqVyc3SdLB5ODdwx1auWyUzZA2rgwXTg/p895FvHSr1Dg==
X-Received: by 2002:adf:d842:: with SMTP id k2-v6mr15551162wrl.26.1534343649005;
        Wed, 15 Aug 2018 07:34:09 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.googlemail.com with ESMTPSA id j6-v6sm34559846wrs.91.2018.08.15.07.34.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 07:34:07 -0700 (PDT)
Subject: Re: [PATCH] kdb: kdb_main: mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jason Wessel <jason.wessel@windriver.com>
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20180805041454.GA18449@embeddedor.com>
From:   Daniel Thompson <daniel.thompson@linaro.org>
Message-ID: <a47008fd-1e52-a268-8085-a2cdcd5dce01@linaro.org>
Date:   Wed, 15 Aug 2018 15:34:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180805041454.GA18449@embeddedor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/18 05:14, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Addresses-Coverity-ID: 115090 ("Missing break in switch")
> Addresses-Coverity-ID: 115091 ("Missing break in switch")
> Addresses-Coverity-ID: 114700 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Adding fall through isn't wrong but its reasonable to ask why there is a 
complex hand unrolled loop here in the first place (and doubly so 
without a comment). The whole switch statement would be much clear 
expressed as:

	for (j=0; j<bytesperword; j++)
		*c++ = printable_char(*cp++);
	addr += bytesperword;


Daniel.


> ---
>   kernel/debug/kdb/kdb_main.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index 2ddfce8..2249645 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -1545,13 +1545,16 @@ static void kdb_md_line(const char *fmtstr, unsigned long addr,
>   				*c++ = printable_char(*cp++);
>   				*c++ = printable_char(*cp++);
>   				addr += 4;
> +				/* fall through */
>   			case 4:
>   				*c++ = printable_char(*cp++);
>   				*c++ = printable_char(*cp++);
>   				addr += 2;
> +				/* fall through */
>   			case 2:
>   				*c++ = printable_char(*cp++);
>   				addr++;
> +				/* fall through */
>   			case 1:
>   				*c++ = printable_char(*cp++);
>   				addr++;
> 

