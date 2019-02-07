Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBA3C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F268721904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CVut03Jt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfBGPw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:52:57 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42986 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfBGPw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 10:52:57 -0500
Received: by mail-qt1-f194.google.com with SMTP id b8so338633qtr.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 07:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=N3sRoWnV8l9cuish6xpPYCWFViw68bxZ7EA3iVa8O1s=;
        b=CVut03Jtn8IM+EcNxiK6siZZHgvwBNTkWRJ/DbHXGHeW9XZieuz3U0QMflo32eYDCK
         YZEcpTmOw1oqbwkZlcKXedeRksRe0eh0m9p/SKFp0FS8500yGKQQ8fcVkUgMCka2qGRQ
         Z5ipqvZYbTmYvTZdRQgkfccPZRTgx7C3hW/U77eveMpRGCxHcoeoiQJ4Bt1V6RrnqLId
         +qx/sqtI38t+RH3KVicP2dqX4/FZDcp4FYktDb/Z+H1IpU5Pws84DxQ/a+rdpnfNOuyy
         FyFWnvYkuJlFUgkT7icdrXuXysr0ntTcgTLoZtO9Ulc7kLaH6lOnmmOz8F7WvASmDkOB
         mCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=N3sRoWnV8l9cuish6xpPYCWFViw68bxZ7EA3iVa8O1s=;
        b=klZRzo5KkyUoa7jlP3YEPprrbWf3yyCjz3Lbv9Ayb5pUl76glu/rq6A1jpcLzfGGgs
         AOYZy5Tq9ngFOrgMNj1aSS2tuhMNWSDQkRix0pLTrt29puxEgBUAnSm7lXePCjECJdqk
         i7tbdvPeKAeb0a4Q866/+fA6b5Qn1OoWRwfAng8Yw0VcWdch8rCcwEWQMEFsJVWL5vba
         jAurxK9ZUYflxun1iBmyPwwiJOwTSB6002JiLTC46KiitjR9/XGH1TQvINZR4ZEOB4c2
         3qRtOGICcdDHfQoSShX4Hp6JSGLcojjyhBGnunwEbRR87JTExdJce76MsiFc+IXwebQC
         D5wQ==
X-Gm-Message-State: AHQUAubiRSxGr82pmim+YCVXRodK7ExDC3YfAHJu2X4FQRtESFQ0udWn
        z94VwKrVB/RLON9AR73zt/Od8g==
X-Google-Smtp-Source: AHgI3IYAZcgvr8QUtHv1ptPc4VTZhVvVqb5q9Kbmz3qvexxqneYJ9T8n8UmA1DHR9y0+pYQ9X4xtMA==
X-Received: by 2002:aed:23a3:: with SMTP id j32mr12241830qtc.205.1549554775825;
        Thu, 07 Feb 2019 07:52:55 -0800 (PST)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id e35sm4744164qte.8.2019.02.07.07.52.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 07:52:55 -0800 (PST)
Date:   Thu, 7 Feb 2019 10:52:53 -0500 (EST)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Stefan Agner <stefan@agner.ch>
cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        ndesaulniers@google.com, natechancellor@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, ard.biesheuvel@linaro.org,
        thierry.reding@gmail.com, Will Deacon <will.deacon@arm.com>,
        julien.thierry@arm.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/5] ARM: use unified assembler in macros
In-Reply-To: <5b710816f634307d6a67ffcf7e4b538818dcb2a3.1549532513.git.stefan@agner.ch>
Message-ID: <nycvar.YSQ.7.76.1902071051030.2213@knanqh.ubzr>
References: <cover.1549532513.git.stefan@agner.ch> <5b710816f634307d6a67ffcf7e4b538818dcb2a3.1549532513.git.stefan@agner.ch>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2019, Stefan Agner wrote:

> Use unified assembler syntax (UAL) in macros. Divided syntax is
> considered depricated. This will also allow to build the kernel
> using LLVM's integrated assembler.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  arch/arm/lib/copy_from_user.S | 2 +-
>  arch/arm/lib/copy_to_user.S   | 2 +-
>  arch/arm/lib/memcpy.S         | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/lib/copy_from_user.S b/arch/arm/lib/copy_from_user.S
> index 0d4c189c7f4f..712ca399f559 100644
> --- a/arch/arm/lib/copy_from_user.S
> +++ b/arch/arm/lib/copy_from_user.S
> @@ -91,7 +91,7 @@
>  	.endm
>  
>  	.macro str1b ptr reg cond=al abort
> -	str\cond\()b \reg, [\ptr], #1
> +	strb\cond\() \reg, [\ptr], #1

You don't need the \() any longer. This was used simply to separate the 
b suffix from the cond parameter name. 


Nicolas
