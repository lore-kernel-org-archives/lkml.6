Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80E6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7D2A2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itQnTTbv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbeLNPj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 10:39:56 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38038 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbeLNPj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 10:39:56 -0500
Received: by mail-pg1-f196.google.com with SMTP id g189so2866597pgc.5;
        Fri, 14 Dec 2018 07:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P7M9r+rs9+fpBnMvCIOiQC49+rvVZBHrqLn+wd0l+Vk=;
        b=itQnTTbvJGeCoWXIm4l0h3IS5BcWnpPY9EsOKV2e9Td3xEiYdpZr7q16O3+FkvbCW7
         0sca943fKuhCp+hRJO3xNFwV+b43w3WkvBKi/rTBHiGyO/6gpL57y8Q2NM2HleKkjN6w
         DR7hxo6YUPcy7ymxv/mnNDF2WGSho+GOzYTa/eYcnvEE0V/vaHHeV3bVX6YnaGtf7vEL
         3XqwlpXTXmVO7dkwmHJP8rgMAJXrEEWDb52Q3GFEOrt7627voR3son+RrGslo1xyIqX1
         GCPgCLZeEXBEunV1tgdYaFPEfvCs0NwWZC3PEzWU9agGhZnRtsAAU/OGs7x/ZuCxgALJ
         93bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=P7M9r+rs9+fpBnMvCIOiQC49+rvVZBHrqLn+wd0l+Vk=;
        b=CeMYl1l44soE4x0NO7WDEN9C7VHkuliSDtp0U6V1By0yxN5KmNqflvm4SJmDAhfede
         uzeSkREU9QpkgtvmEbaqRRxjRjyojZLMa906tdJbmNavl7gIAAJb7lpnysz78zbpeFP5
         dKatykr8+ah8ZDUtRCCZi2RLY3SKI11YxaG73aZ0cxT4K6biIpHnJiVbi3yai6vBEJID
         x6pzUhST/gYSET2eQnw1dZ3ZJlIp9RAGNnwLMGizAZMVl37mLhRuf1CAlFK21Fdtdxy/
         TGwDVrcUvtQBv1WjrMD/IHSZ89MtcGHYnkBMbRvqmcAJb1oSTpYyXkucv30ogP0X+wPy
         3PRg==
X-Gm-Message-State: AA+aEWYEIbcScUELm0n0uq6/jibb8gRF2u0tDABt+P9SQwij+axVkJWi
        iMpGX2Dzas0yvCdYr8RhWUs=
X-Google-Smtp-Source: AFSGD/U782fPN8YDCDqCygjjhvkGxPdXtDCHb/Yx7a/76ePfTyFvuZz0yjb1bbfOLRdiFokShvOLhw==
X-Received: by 2002:a62:f5da:: with SMTP id b87mr3298867pfm.253.1544801995645;
        Fri, 14 Dec 2018 07:39:55 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b26sm9891500pfe.91.2018.12.14.07.39.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 07:39:54 -0800 (PST)
Date:   Fri, 14 Dec 2018 07:39:52 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/88] 4.4.168-stable review
Message-ID: <20181214153952.GA23374@roeck-us.net>
References: <20181214115702.151309521@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214115702.151309521@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 12:59:34PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.168 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Dec 16 11:56:41 UTC 2018.
> Anything received after that time might be too late.
> 

All nommu builds fail:

mm/nommu.c:211:49: error: 'write' undeclared 

and various similar errors.

Guenter
