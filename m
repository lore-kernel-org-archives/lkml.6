Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED78C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3967520684
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBfp6Et1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3967520684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbeJCTmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 15:42:46 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36400 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbeJCTmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 15:42:46 -0400
Received: by mail-pl1-f195.google.com with SMTP id y11-v6so302384plt.3;
        Wed, 03 Oct 2018 05:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K6sjOmiR45l6yElu7rOMOQZ40sxE3ZXxnO54brAkl+8=;
        b=KBfp6Et1FbUs8DqWaxfBbATy6o4pd++euNU7HsCOx2qP9PYs9G1NJ1ElAkBHM3PMor
         OEXb+ZWbnENZIItFMQBLAgSSZH3/+n2Kvq6U7YAVmB08G7tfChACEa62nm4BiHUyrLIE
         YXDkomP8rOAgbh9peSPs2W9BkBK/RwAggX9djyywT5QSkPq0SYCdl+jM8Kt3Zf9oZoyq
         C9FDy5j282fYuNHd058uMOJYSaEY7nxPPMQenMnutrCGJkxZv4uFOT0EeA73ZAfxO90O
         nD1tTRGj6TrNLutdWUPhytIw12AnpOLf+0Gi5INA+VQRj3y9Fpf7sXmjHAaOP23zWsA8
         9DXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K6sjOmiR45l6yElu7rOMOQZ40sxE3ZXxnO54brAkl+8=;
        b=HC3X8xz72XEEK28WfEWtjwCvDQLuvkoYmn1x9jPl3yaKpmHjLUyAzWc7rWEzXCxF1a
         PWCjRa89VuAJp06YGtNUlbra14zm854jihjjyj/vSSDB3ignHw8lZ9hEdnR0FMjYRO/0
         wOePloS73ix7X4UPGQ3R6lXhIwIllDOUa4PSxwVSnyp47bi20/Gr8SLF2haVD0r/Zlla
         f/Wp9Nz/L71eHPpqCpPKKUW0OocdZzAsw5cNZ8U1u2j25cZznkua5ywRoSKyegHz7sUF
         wHEidtX//C0FIfLkfBBhs8pEV4akWOC8LazQiqPNTucW6n4LG3HAJMWYZMyl0Q0EV0t3
         5SnA==
X-Gm-Message-State: ABuFfojm+Pd+Y+UwRUB6G8G0anV54GII82XxLgMiTuYMWyrHb6q88pl9
        dlnX9XEoh1E+o1sGXyK7e77mqc6E
X-Google-Smtp-Source: ACcGV615jqB2y9t/q8/J+066MjmN5AaOVjpL8RaNlgOSDBCwgYjwCaUGHOKsj/WegC5/pyE7W4RzPg==
X-Received: by 2002:a17:902:ba95:: with SMTP id k21-v6mr1548140pls.38.1538571269072;
        Wed, 03 Oct 2018 05:54:29 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id l16-v6sm3346763pfj.179.2018.10.03.05.54.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 05:54:27 -0700 (PDT)
Subject: Re: [PATCH 4.9 00/94] 4.9.131-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20181002132500.494838053@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <b1a49884-8992-e88d-4a2a-a94470cb4094@roeck-us.net>
Date:   Wed, 3 Oct 2018 05:54:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181002132500.494838053@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2018 06:24 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.131 release.
> There are 94 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Oct  4 13:24:37 UTC 2018.
> Anything received after that time might be too late.
> 


Build results:
	total: 151 pass: 151 fail: 0
Qemu test results:
	total: 308 pass: 307 fail: 1
Failed tests:
	powerpc:g3beige:ppc_book3s_defconfig:nosmp:ide:rootfs

Details are available at https://kerneltests.org/builders/.

Guenter
