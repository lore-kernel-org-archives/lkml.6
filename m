Return-Path: <mgautam@codeaurora.org>
X-Google-Smtp-Source: AB8JxZpCjsGZbPKWooQrycIlxNUvLk15aQHlvO79x9raypVzaslzXX6qqBhiLIgLoqkvEB/6Y9vh
ARC-Seal: i=1; a=rsa-sha256; t=1525752414; cv=none;
        d=google.com; s=arc-20160816;
        b=euneisHpirhnmUzwzVQTTMrWH7l/DKKGSlmP5Fi78Auj4El27nHu6NIzy7J8WeItUD
         YpQf6sM9cG/VXxsuf3HdsYrJNOgmVCWlCw36FiIiP932oB2l/vru8VN+LpDZhQruwmii
         yhw/GJGWlnLJ5SR2lM3K7Wp4/kx9+47GO5mA4EaXwhNWDSBB9T6IRLcBP7D3diZYYT+X
         lgaSasLwoT3BZtnGMa3wI328haFaSwZlhBZSpi6hoxkmaLz8HRUIIfiF162h/zvA0INP
         Peh/uk5EjGwtM+EtLQpueN8nHfaLjRWYrC37Yp6F3v+naYJpc3pdgnQ45zxApmYJDDRr
         tuOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=kJp1QXny0rCHpMPJjKtTnFbmQ0n+UOnIzbEbrrCnyOA=;
        b=sz6uLGZAFf27defcgw5V16cOadrRJ93f8m3iW2J/lVwOij14EM+310OYvgnLOIOL0P
         Wi1LV+MxL5kj3j7EhMYBQU9tKKU+z5b82MiCN7iU9D0Pj9efA+wXtqIlEIlQvrXEEUgV
         gu7h4YPGze7pIrD4aoI0TmsrgGXX9ZMJnRg0Vi9LRes3wCZIY0bM2ah3ARAFGzFwbTgV
         DQwwxpf945UxdY90AIjziyeD/Bb0ICSRdJBOQU0nXhGeD8IqOKdOK+FMBpxJxixfAGkY
         jAcvbyD8Wdx+WEJ0leWRjQnGuU4Wm29lHtv6Lvv/AYr0W6BKcuWJfF5y4A3voapoWFAE
         xDpw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=jxVpy8S1;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=jxVpy8S1;
       spf=pass (google.com: domain of mgautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=mgautam@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=jxVpy8S1;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=jxVpy8S1;
       spf=pass (google.com: domain of mgautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=mgautam@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B963E6022C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
Subject: Re: [PATCH v3 2/3] usb: dwc3: Add Qualcomm DWC3 glue driver
To: balbi@kernel.org, robh@kernel.org, andy.gross@linaro.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, robh+dt@kernel.org,
 linux-arm-msm@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1525459689-1358-1-git-send-email-mgautam@codeaurora.org>
 <1525459689-1358-3-git-send-email-mgautam@codeaurora.org>
From: Manu Gautam <mgautam@codeaurora.org>
Message-ID: <7bc35d33-c819-fb64-353c-f64dce08505f@codeaurora.org>
Date: Tue, 8 May 2018 09:36:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525459689-1358-3-git-send-email-mgautam@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599560444627073315?=
X-GMAIL-MSGID: =?utf-8?q?1599867363610182809?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 5/5/2018 12:18 AM, Manu Gautam wrote:
> DWC3 controller on Qualcomm SOCs has a Qscratch wrapper.
> Some of its uses are described below resulting in need to
> have a separate glue driver instead of using dwc3-of-simple:
>  - It exposes register interface to override vbus-override
>    and lane0-pwr-present signals going to hardware. These
>    must be updated in peripheral mode for DWC3 if vbus lines
>    are not connected to hardware block. Otherwise RX termination
>    in SS mode or DP pull-up is not applied by device controller.
>  - pwr_events_irq_stat support to check if USB2 PHY is in L2 state
>    before glue driver proceeds with suspend.
>  - Support for wakeup interrupts lines that are asserted whenever
>    there is any wakeup event on USB3 or USB2 bus.
>  - Support to replace pip3 clock going to DWC3 with utmi clock
>    for hardware configuration where SSPHY is not used with DWC3.
>
> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
[snip]
> +static const struct of_device_id dwc3_qcom_of_match[] = {
> +	{ .compatible = "qcom,dwc3" },

I should also add SOC specific compatibles.
Will do that in next patch.


-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
