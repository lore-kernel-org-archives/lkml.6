Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A7B03C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A718208B2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SH7hkG0U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A718208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933790AbeFLPq6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 11:46:58 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:42422 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933244AbeFLPq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 11:46:57 -0400
Received: by mail-io0-f196.google.com with SMTP id r24-v6so28607714ioh.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 08:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j4TC+nj10rNkL/ZJtMeaK1orhGF07APHb/8Md6K12+4=;
        b=SH7hkG0U9eWEL6nkmAmeg85FEBsBC4LTGa+/9HeB3ub6CwPLDaR9C0pqYA9zv6piNR
         DlZCo3iJxgq8DRqkBy4TPulJyMkbQZFZuKPeS2joMJ7mktpPmqFK79P3Hxg1d3XlTZBi
         lILUWKR+Aij17zISbgfxJoB31VRjWKGPqmrto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j4TC+nj10rNkL/ZJtMeaK1orhGF07APHb/8Md6K12+4=;
        b=JjJeBIA/CE3SL6bMWwXaDNVZQEf/do+djiqJeqb6LpWU9UvyAnmLTlGHCeIsFesIU6
         12lyepob5U4z+r8csViiY/ybv6mX4fvvcgKmu1X121x6CXFZk5RJMoOJUIvmL6uqW3Tm
         0XfH1kEtMZNKaoqzUg2UtqEmMB8UDYMloxvY73T/SR4YkewQyBbQ1GA0GVsjEYV9Wnj/
         H6k8K2tzVltuNB6gj0KySTPGxR0Uk8hmkWI9eLe04FlXDfSa1QI+6afXNLxzycu4sKZ8
         7byHfw/XHyqHlrWDJkgeXNCpNCN2+KqtG2IKMRE0O4KCakJIvfzFk9Kh4PeRaAQ1lN96
         WX+Q==
X-Gm-Message-State: APt69E0ufiqFf3O3sVbaIsM/T/R16JExnGG4bg7d0jYZPHf4MglaT5I+
        a49sscxHU5OKB7yNLU2UBhukRYTJUyM=
X-Google-Smtp-Source: ADUXVKJgA5X46fOEFiJ8l9xwmpPkeF/4Ziwykce3WlRHRaJYto59Flg/ZR1IMRT51mFPWK0P7JRWqg==
X-Received: by 2002:a6b:b8d5:: with SMTP id i204-v6mr1001906iof.284.1528818416610;
        Tue, 12 Jun 2018 08:46:56 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id c93-v6sm482790itd.40.2018.06.12.08.46.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 08:46:55 -0700 (PDT)
Date:   Tue, 12 Jun 2018 08:49:05 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     andy.gross@linaro.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, david.brown@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: apq8096-db820c: disable uart0 by default
Message-ID: <20180612154905.GX510@tuxbook-pro>
References: <20180612144806.19201-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612144806.19201-1-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12 Jun 07:48 PDT 2018, Srinivas Kandagatla wrote:

> Access to UART0 is disabled by bootloaders. By leaving it enabled by
> default would reboot the board.
> Disable this for now, this would alteast give a board which boots.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
> index 0f829db33efe..4d5ef01f43a3 100644
> --- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
> +++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
> @@ -75,7 +75,7 @@
>  
>  		serial@75b1000 {
>  			label = "LS-UART0";
> -			status = "okay";
> +			status = "disabled";
>  			pinctrl-names = "default", "sleep";
>  			pinctrl-0 = <&blsp2_uart2_4pins_default>;
>  			pinctrl-1 = <&blsp2_uart2_4pins_sleep>;
> -- 
> 2.16.2
> 
