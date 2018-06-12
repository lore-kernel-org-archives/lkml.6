Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CA918C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9B7208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CrbUCIdl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E9B7208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934479AbeFLUfl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:35:41 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35004 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933915AbeFLUfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:35:38 -0400
Received: by mail-lf0-f67.google.com with SMTP id i15-v6so466416lfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 13:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zuMM8Vronmvx1XCOxQUyCPwGjsGt3kv/k4dLmFa3nmw=;
        b=CrbUCIdltGs+wCw87zL1by1jelpVw3F4rheEQmyKt80zLHTzVyWuxL/XlZQhukZrMN
         7H0+VYLtEz9+ifl1OZYWeybCL6rw1CumX+EI+Wh3r5OGgyQcvdWlFuNKddDBUXL4ao+Q
         kM5IA2vbjnvGF5rtqcGrc6iTmoJpTM6bHCF1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=zuMM8Vronmvx1XCOxQUyCPwGjsGt3kv/k4dLmFa3nmw=;
        b=k2nI8qbLTUnXyd/dl7vK2evnaMYicQWfVSWz1LlD8iXbAZoUcf/ydZrI8sqDxmkXxh
         it/H/pre703PfAtmJyRLFXzW89zhBCjLWMiBIcG9ktrfHD3IUQZrNoWGXCs/GNYTtJp8
         G2xOKBYCbOXrwCDiDL9sSsbkg1w+RmAwZHNZS8mE2ZsKURQHxpxE+qgZaPmgtwCXXnQm
         0kzhDWZRmWnJtvaviPHLA0EfDvC1iuw3TKJH/txr0P2gMrtjFKUk5X5YbkdKAYEjKZi1
         Gi9yDxuaUCHXMCcu6mf0WRaBr0nnm1lzJCT+sY9t0NOP3lJFezrp5CTq/CKR9yuMII+r
         0iKw==
X-Gm-Message-State: APt69E1j4T+xK+GFal90SUEyXhERqoL2SfFYeUOQsnJsgYNXNc/9X9bY
        4vbWcm7fM707C9+il6d26hENrw==
X-Google-Smtp-Source: ADUXVKLn1lLIUSvAwWSXSSgYRL6SiG0GFsdVVDbcAVGTaQ2NoslJ6t63faEwChuwbmYPuEh+nE0/dw==
X-Received: by 2002:a2e:8257:: with SMTP id j23-v6mr1204149ljh.1.1528835737351;
        Tue, 12 Jun 2018 13:35:37 -0700 (PDT)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id a19-v6sm187219lff.84.2018.06.12.13.35.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 13:35:36 -0700 (PDT)
Date:   Tue, 12 Jun 2018 23:35:34 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     grygorii.strashko@ti.com, davem@davemloft.net, corbet@lwn.net,
        akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, vinicius.gomes@intel.com,
        henrik@austad.us, jesus.sanchez-palencia@intel.com,
        ilias.apalodimas@linaro.org, p-varis@ti.com, spatton@ti.com,
        francois.ozog@linaro.org, yogeshs@ti.com, nsekhar@ti.com
Subject: Re: [PATCH net-next 3/6] net: ethernet: ti: cpsw: add MQPRIO Qdisc
 offload
Message-ID: <20180612203533.GB9473@khorivan>
Mail-Followup-To: Andrew Lunn <andrew@lunn.ch>, grygorii.strashko@ti.com,
        davem@davemloft.net, corbet@lwn.net, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        vinicius.gomes@intel.com, henrik@austad.us,
        jesus.sanchez-palencia@intel.com, ilias.apalodimas@linaro.org,
        p-varis@ti.com, spatton@ti.com, francois.ozog@linaro.org,
        yogeshs@ti.com, nsekhar@ti.com
References: <20180611133047.4818-1-ivan.khoronzhuk@linaro.org>
 <20180611133047.4818-4-ivan.khoronzhuk@linaro.org>
 <20180612163658.GC12251@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180612163658.GC12251@lunn.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 06:36:58PM +0200, Andrew Lunn wrote:
>On Mon, Jun 11, 2018 at 04:30:44PM +0300, Ivan Khoronzhuk wrote:
>> That's possible to offload vlan to tc priority mapping with
>> assumption sk_prio == L2 prio.
>>
>> Example:
>> $ ethtool -L eth0 rx 1 tx 4
>>
>> $ qdisc replace dev eth0 handle 100: parent root mqprio num_tc 3 \
>> map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 queues 1@0 1@1 2@2 hw 1
>>
>> $ tc -g class show dev eth0
>> +---(100:ffe2) mqprio
>> |    +---(100:3) mqprio
>> |    +---(100:4) mqprio
>> |    
>> +---(100:ffe1) mqprio
>> |    +---(100:2) mqprio
>> |    
>> +---(100:ffe0) mqprio
>>      +---(100:1) mqprio
>>
>> Here, 100:1 is txq0, 100:2 is txq1, 100:3 is txq2, 100:4 is txq3
>> txq0 belongs to tc0, txq1 to tc1, txq2 and txq3 to tc2
>> The offload part only maps L2 prio to classes of traffic, but not
>> to transmit queues, so to direct traffic to traffic class vlan has
>> to be created with appropriate egress map.
>>
>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>> ---
>>  drivers/net/ethernet/ti/cpsw.c | 82 ++++++++++++++++++++++++++++++++++
>>  1 file changed, 82 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
>> index 406537d74ec1..fd967d2bce5d 100644
>> --- a/drivers/net/ethernet/ti/cpsw.c
>> +++ b/drivers/net/ethernet/ti/cpsw.c
>> @@ -39,6 +39,7 @@
[...]

>>
>> +static int cpsw_set_tc(struct net_device *ndev, void *type_data)
>> +{
>
>Hi Ivan
>
>Maybe this is not the best of names. What if you add support for
>another TC qdisc? So you have another case in the switch statement
>below?
>
>Maybe call it cpsw_set_mqprio?

Yes, proposed name is more suitable.

-- 
Regards,
Ivan Khoronzhuk
