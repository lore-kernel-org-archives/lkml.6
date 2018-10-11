Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFE9C677FF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 18:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 187F120658
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 18:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="pGUtEcty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 187F120658
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbeJLBml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 21:42:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44789 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbeJLBmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 21:42:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id 63-v6so10719958wra.11;
        Thu, 11 Oct 2018 11:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ad00m6xN6lDlmdS2qr6HB18bEWnin8CUs6FPBeaHi2Q=;
        b=pGUtEctyE34XZDpolr2AXwns3PhepESvxen02wUVN7KhxMzrTJzP8qKtsZD5YXiLRX
         aWE/U9fsVI0cjpxm5AnY23sbLdfYRwdfd11IhotSJmP+kim4Z9aHdbS1I1fDYDTga1NF
         hRjhfxsgHjNou23IDJXUGcP/dczyjf2nHZwfHFqaR1BTQqCo2uYZEXHsMxVkfYoAtcop
         ne8mTojKu1BAcV95NPGp/xksqzVh4cIApL9y9x5YftJxcuqSpG/HuUeN/0KjQ/pK1Ggl
         VvKGyZyOUNTR7IPar0uMBz72cOo1Ulzoeo9XoRZrHwQE2NIuK7bIKiVsrNYcUPZL0qch
         IXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ad00m6xN6lDlmdS2qr6HB18bEWnin8CUs6FPBeaHi2Q=;
        b=b1r5SuWkDy7kqC7A7Z6XVpt5tfa8xqfoVNgWJENoRnVnJWYVJCVYKjlbigImKbyrRI
         jU6TDN0uDuDlVdxEDLpAecI0gEH1TYUZMEierXmSPbExt94O+3+lfuZNavEz78vIT9K/
         K/6IeE+UVpezW7kgJ28GHQy7krL7xaiXplIxVWK8DpqK4qnQMd598PUNdfir7MY72Wzh
         rUtK3360FVAvppMUoQ1R/sRhfl078Wj6FMaLCKf3xe1UefabLpyVZ9itonjWNHidKobU
         0SrmPNQXfYJQhgSnalDbxLwDh4RF8tz2fu5QrtSGh8eGZZgW26GsD7GePBiUh7DoLsa2
         a+VQ==
X-Gm-Message-State: ABuFfoiURN75xhW2h7a19d6g71XrT1PedmNsxu4KPocSa50EO/TMbJGw
        /jiozXtz4kLvHTXeIUkZnBq/UtuT
X-Google-Smtp-Source: ACcGV61YW1kvHJI1KLnKGMGlm5/I1rENBL3hWZyacNqsWB3fAwTuIOTV8sczaZOYVonF9qpWvZrfIg==
X-Received: by 2002:adf:f986:: with SMTP id f6-v6mr2549193wrr.293.1539281657578;
        Thu, 11 Oct 2018 11:14:17 -0700 (PDT)
Received: from [192.168.0.20] ([94.1.125.110])
        by smtp.googlemail.com with ESMTPSA id l4-v6sm31957422wrb.92.2018.10.11.11.14.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 11:14:17 -0700 (PDT)
Subject: Re: [PATCH] r8169: set RX_MULTI_EN bit in RxConfig for 8168F-family
 chips
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Azat Khuzhin <a3at.mail@gmail.com>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <73ee1d68-2a27-aee9-d8b5-79ba3eda8187@maciej.szmigiero.name>
From:   Chris Clayton <chris2553@googlemail.com>
Message-ID: <865c59af-f396-c50a-007e-9a62d4e17037@googlemail.com>
Date:   Thu, 11 Oct 2018 19:14:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <73ee1d68-2a27-aee9-d8b5-79ba3eda8187@maciej.szmigiero.name>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/10/2018 15:02, Maciej S. Szmigiero wrote:
> It has been reported that since
> commit 05212ba8132b42 ("r8169: set RxConfig after tx/rx is enabled for RTL8169sb/8110sb devices")
> at least RTL_GIGA_MAC_VER_38 NICs work erratically after a resume from
> suspend.
> The problem has been traced to a missing RX_MULTI_EN bit in the RxConfig
> register.
> We already set this bit for RTL_GIGA_MAC_VER_35 NICs of the same 8168F
> chip family so let's do it also for its other siblings: RTL_GIGA_MAC_VER_36
> and RTL_GIGA_MAC_VER_38.
> 
> Curiously, the NIC seems to work fine after a system boot without having
> this bit set as long as the system isn't suspended and resumed.
> 
> Fixes: 05212ba8132b42 ("r8169: set RxConfig after tx/rx is enabled for RTL8169sb/8110sb devices")
> Reported-by: Chris Clayton <chris2553@googlemail.com>
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> ---
>  drivers/net/ethernet/realtek/r8169.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
> index 7d3f671e1bb3..b68e32186d67 100644
> --- a/drivers/net/ethernet/realtek/r8169.c
> +++ b/drivers/net/ethernet/realtek/r8169.c
> @@ -4269,8 +4269,8 @@ static void rtl_init_rxcfg(struct rtl8169_private *tp)
>  		RTL_W32(tp, RxConfig, RX_FIFO_THRESH | RX_DMA_BURST);
>  		break;
>  	case RTL_GIGA_MAC_VER_18 ... RTL_GIGA_MAC_VER_24:
> -	case RTL_GIGA_MAC_VER_34:
> -	case RTL_GIGA_MAC_VER_35:
> +	case RTL_GIGA_MAC_VER_34 ... RTL_GIGA_MAC_VER_36:
> +	case RTL_GIGA_MAC_VER_38:
>  		RTL_W32(tp, RxConfig, RX128_INT_EN | RX_MULTI_EN | RX_DMA_BURST);
>  		break;
>  	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_51:
> 

Once this is merged in 4.19,  a backport for 4.18 stable will be needed because the same problem was introduced at 4.18.8.

Tested-by: Chris Clayton <chris2553@googlemail.com>
