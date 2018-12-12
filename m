Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4033C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9920920849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3Fg+YW3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9920920849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbeLLOYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 09:24:35 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33393 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbeLLOYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 09:24:33 -0500
Received: by mail-pg1-f195.google.com with SMTP id z11so8417053pgu.0;
        Wed, 12 Dec 2018 06:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TTKARY+ljSCpqS4GmL1e0c14E135jdv17FzMIRH0kxg=;
        b=B3Fg+YW37E3SQLk92NjjN+n7lkcU7xw0SJgP7tP2rmqvhuSPuLpeXcN4M+MmXWDEzY
         JN2QpcxxxIYGm/uCsr+HmDPU1qqZDPCIpP0mByUYDG6UBa/WB2cq2yBmV7i/F2l7kRaf
         tlLqNzp3aOsBJPxd3Ia3eAK5AIt/gM6edCdMNfjm2M73NisZ4hnAKht/DhT0kl70ciTC
         LhpMsEER+uYwDMwhyRmHXRiyhB2GHUcW56QXGqBIu0+e2V3FPFg2CNyugvab1nRK9xfU
         gScAs5ji1TLdLZp9W55LUBRnF0VAA/PGZQ7vRQ8WXGo1/x9hE7Ko8e8MdKDmVNvCqXTS
         8Y1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TTKARY+ljSCpqS4GmL1e0c14E135jdv17FzMIRH0kxg=;
        b=JHbmv9wqCwOGt867rQM6+i7jsDfW8L7dhI6ofT2V0q1UhwOL6PxeWqE28v7CuWcCHO
         +5T3kVeeP8qtzByUDD8r40/mGjGcbK/j4XqtRa4sWdFAzDDnQJuHi15xjeTR+C/WaH9w
         FbKvNpd5g+jObBCeBMHluyr61dW18q7RnoGLBgyZMFOP35QZFqQh9NOrrbdB1E/7B9uc
         ObbzEe36L5tnQyRkIRdB/kw+r6fhW4dS8L3tfJqBm8tfadekMIctlDBG7pkn/Y6a1qJ9
         PsoCOksaLfdaWP6gllU5YIOaz7ihYoYKbnTLM/ib/tsbJrloZrNikNDRkfq/nzgTR7dJ
         Gs1Q==
X-Gm-Message-State: AA+aEWZeDX/8+uwdjPZNvfLzEp84BlOpDlrRi5QpTdjsVWxb/O/mxCtl
        NpiLyWB+VPKjFw9BXD6+uT4l5ntL
X-Google-Smtp-Source: AFSGD/VrUHL/T8r69xF81Cs/JxemIQo0sw7DBXzeF0E+LdWcscmgJdvsS0/AwJjUYE3AuT/QWWL0yg==
X-Received: by 2002:a63:fb10:: with SMTP id o16mr18404226pgh.211.1544624671649;
        Wed, 12 Dec 2018 06:24:31 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k26sm43051983pgf.65.2018.12.12.06.24.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 06:24:30 -0800 (PST)
Subject: Re: [PATCH 4.4 00/91] 4.4.167-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20181211151606.026852373@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <533608e5-526b-0e65-643a-4ca539882e89@roeck-us.net>
Date:   Wed, 12 Dec 2018 06:24:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181211151606.026852373@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/18 7:40 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.167 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Dec 13 15:15:44 UTC 2018.
> Anything received after that time might be too late.
> 

[ preliminary ]

arm:allmodconfig, arm:omap2plus_defconfig:

drivers/dma/cppi41.c: In function 'cppi41_stop_chan':
include/linux/kernel.h:815:27: error: 'struct cppi41_channel' has no member named 'node'

[and various other similar errors]

The same problem also affects v3.18.y.

Guenter
