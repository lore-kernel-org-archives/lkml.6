Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E21C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0BB72184C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRF0c+eB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfAXI37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 03:29:59 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44092 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbfAXI36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 03:29:58 -0500
Received: by mail-pg1-f194.google.com with SMTP id t13so2336327pgr.11;
        Thu, 24 Jan 2019 00:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LEFs+VdK+tLN8hb7yXI9KJRvJ1tvQsYGwKQ02Hq326w=;
        b=LRF0c+eBWxwDwbO6Z5VQliiHkjH+pXCICP7FmJhd5TW+WD6at3ltaqVRPwN+VyxDey
         ksIUd3kttpdsVB0Iwu9DXpq6T0QLBZkSx+TdRt2BR/Kvei1LmaHhGwlnbbpfyovxfaSN
         d0XEQovfqvZVy13M3JgnWcymNXMVuzwdbzHNMy5Y82yZ4cYrfoyxmXisSiQsKOz4V1i5
         /U1zOcT5SDUdPXXX8hQ3kGCNj6QRRXic3ovYMmq9gHlK1n57WM7vSL18m+v/U2xZ+gYB
         NyZztah8ZlwX7HRw59Jkvk1WtontNxNOgE3Mf6N8e9SV+1/oL5LcdFFHXLXNnq7t8go2
         kquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LEFs+VdK+tLN8hb7yXI9KJRvJ1tvQsYGwKQ02Hq326w=;
        b=SwTVUtFXZHjoL7r8YQOeftc4fOWVHh6iYZ/y3lVIkUJ+xiJaqpTwUOpnTR4pum246t
         le3NT+uuwCY8+Uyhx5zxk3cmsNz7X7+3nfaoIF4e1wnhQP3EB5LsuAx8Mgsl9jXrMCHL
         MTKUa5qRCdnAofXcXMLFW2eEnT3Skd5vsAVhkfWa4l/GsALE4Q9OWg8HwjB9nnexABji
         ogqJuiCOWH+cxEVs4GwTvrsy6J3shuxUGGOkC63BOubGJKVkEvogpNQg5kdUSVgiqH4+
         K3ZdddKd7U0XdUPDP/jHy5FGXGL9ecXXZW9iuCoa1ggjyVw/7wZKGKGRqEuH/50dm2UD
         1zNA==
X-Gm-Message-State: AJcUukdLrqIteNRDC/S34N5BnZ9nJh9riE/ECkyWpEIIZOdK+xxsfrlG
        atsc16sL7Kzh2vlXslJu/3/J5MQo
X-Google-Smtp-Source: ALg8bN5TyP6UqtLRLiaNzhkJpvVhnkNJBEab0QF/isHYeLTsM+7/A9AGggRVpVd1ZjyRe0sVvIl5mQ==
X-Received: by 2002:a63:ea15:: with SMTP id c21mr4818520pgi.361.1548318597921;
        Thu, 24 Jan 2019 00:29:57 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id m3sm39446272pfi.102.2019.01.24.00.29.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 00:29:57 -0800 (PST)
Date:   Thu, 24 Jan 2019 00:29:55 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, davem@davemloft.net, y2038@lists.linaro.org
Subject: Re: [PATCH] input: Fix the CONFIG_SPARC64 mixup
Message-ID: <20190124082955.GA139904@dtor-ws>
References: <20190121014914.2328-1-deepa.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121014914.2328-1-deepa.kernel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20, 2019 at 05:49:14PM -0800, Deepa Dinamani wrote:
> Arnd Bergmann pointed out that CONFIG_* cannot be used
> in a uapi header. Override with an equivalent conditional.
> 
> Fixes: 2e746942ebac ("Input: input_event - provide override for sparc64")
> Fixes: 152194fe9c3f ("Input: extend usable life of event timestamps to 2106 on 32 bit systems")
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>

Applied, thank you.

> ---
>  include/uapi/linux/input.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
> index ffab958bc512..f056b2a00d5c 100644
> --- a/include/uapi/linux/input.h
> +++ b/include/uapi/linux/input.h
> @@ -32,7 +32,7 @@ struct input_event {
>  #define input_event_usec time.tv_usec
>  #else
>  	__kernel_ulong_t __sec;
> -#ifdef CONFIG_SPARC64
> +#if defined(__sparc__) && defined(__arch64__)
>  	unsigned int __usec;
>  #else
>  	__kernel_ulong_t __usec;
> -- 
> 2.17.1
> 

-- 
Dmitry
