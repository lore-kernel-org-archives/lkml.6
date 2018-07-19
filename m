Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CE4C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A0520684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSx7uA0w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A0520684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731748AbeGSOBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:01:21 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44655 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731577AbeGSOBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:01:21 -0400
Received: by mail-pl0-f68.google.com with SMTP id m16-v6so3648913pls.11;
        Thu, 19 Jul 2018 06:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZpYpUYcW6uQ0rOWzICxvvGtqbC5PWuTHNC22Jt71hZc=;
        b=TSx7uA0wiOmLnbKpQwL5FMtRuYklsnUShry9sJ/9OgHV6CfiD8bffSmN99nigr3OHL
         hzAThGex+3pM/lAufMsRMnbPaYPvNpAAnyKJXNPZVyrUh7g/vzrkseDn3/3qosv0P72C
         2c4R7b+bp493y9hUtId2fCGNmBFXjCXMkp4S44wOJq+OaEkg689nEkwznbJTwmXRSm9+
         bsjzdZ72SyC7EaybEXGXCmBjggF+MnFwq6VemkGpCz12J+KWI23VMInfud3Gd7KqpuZP
         oekntuIk4adWBErEarUYo7vUXVRXJsUoUmAYhonVxqgNvx1fn3mFqsktqPqg3AGuRpsO
         xu8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZpYpUYcW6uQ0rOWzICxvvGtqbC5PWuTHNC22Jt71hZc=;
        b=gjINzibD7/4Vp8WVVkWQgmscvhCwXwPPyyEIjU6GhLU3rDPlpV6pR/sQg7dFH/Go9O
         iNiuXqCxbxiUuuER2bqTvuZ1YMv9+eX1ywS2piHSpp5xyJbdsNslLDu341ZxfPETF57i
         893qociMhMHJWRRs5RvXAwlsmxhDRv7f+DGU9p1HHtYQw29e6la4z8aAH6SfxDtopDDj
         yc+EYJ/xxzozoY2ReO6nnUDyUxdOUfcMOBHVqZh8/HRfdZLL8nYjpL0YO6D3qmhrrSnI
         o0Q2wueRwufGlhx+S/0cI087UaSyd9i4VhBcSnOiA4XRB/lepXhShge5l8Ckw57vyZhY
         dp9g==
X-Gm-Message-State: AOUpUlG5QRRe7lpLXIbbdbktNqlyFchvmDGFojd7BSpU058lAh3FEYSB
        GoWH+5/Xzwu9MMv8zusGWStRacbj
X-Google-Smtp-Source: AAOMgpdOgihmqs+hrwQT3LKS1iQA8ZrC+3/0dmSPTvBpREkoj/nCT3xr3KI3OSaYV+fdxwas+PTHyA==
X-Received: by 2002:a17:902:1e6:: with SMTP id b93-v6mr10145903plb.149.1532006293298;
        Thu, 19 Jul 2018 06:18:13 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id r87-v6sm16607317pfb.1.2018.07.19.06.18.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 06:18:12 -0700 (PDT)
Subject: Re: [PATCH 4.4 0/3] 4.4.142-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180718145156.152413234@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <a35c02f5-d90c-9617-771c-9047f2cfa38f@roeck-us.net>
Date:   Thu, 19 Jul 2018 06:18:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180718145156.152413234@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/18/2018 08:01 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.142 release.
> There are 3 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Jul 20 14:51:50 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 148 pass: 148 fail: 0
Qemu test results:
	total: 149 pass: 149 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter

