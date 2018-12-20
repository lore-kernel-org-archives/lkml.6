Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF13C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4143218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6FoMLTW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389044AbeLTS2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:28:48 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35507 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732986AbeLTS2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:28:48 -0500
Received: by mail-pg1-f195.google.com with SMTP id s198so1272993pgs.2;
        Thu, 20 Dec 2018 10:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RZ4DiUx7yv0PXlyA/Y/2n5ljf2uT8UezOaJ9MoDBOvM=;
        b=b6FoMLTW5mG9pA+fFNA4rMe/UzcFGHXAF1+4OZzmYZVhYorHpU6fSw7K03gQH8B0An
         M+nm4eOTlxHKxqEO9UDbZTZWHUgV5yxozAPL23g0FsjgTnQ0hYga5HSOONQVJX8x5sxp
         Nyp3kqt3O8v9MbweL1CJcCk8QDSNDDfJxne1Zhh0Rvv4XbnJRZfny9sdSoV6e8aCaH9k
         D4c70kDDUulVoTFQhTzvLelkLQIJk3G80FB3JrddrWHMFdo0h7naTxlYWDVRkGjuV9lV
         Wo+za85Xtn5r+hzVY66q6TKxxyuqmIge/0cZdTJmWIqw82r6eMdm2jSONIyUtZ1GufFV
         te+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=RZ4DiUx7yv0PXlyA/Y/2n5ljf2uT8UezOaJ9MoDBOvM=;
        b=YnR80rHk5K94vyjahABKDkmmmxJf2fOGnhN5yoYUIyht+Bp8ML6pEMa0QXy740D28l
         ovk6zu+CY0l494WzuBEhdGVr97qdaltcNz6NQ87JkpRJub0c+clm/BQnq4G4tY8qX/sB
         pgrb3vJBQXmNfU12zILEo2vpoQ9uwGN9sOrzvwcmGL3O6zfyawQo9bNwfixzKVOOXlqN
         /v0/S+4OCfAIwDoBLu2G5Jx2b2l3Uw0u67/++XBcPxIrPRfCy9Hs8E4kclGCBmqoLiV5
         eoSX9ESsv54sngu9dk4QSiflBylaIEXB7p4dQCYIdKy4Lro8PH26bYKkPYgx7dn1BngP
         VOJg==
X-Gm-Message-State: AA+aEWbiW1sR0jkei+eFK7GgDkZAcNENu7yGiN894BGau1PEFJ3HstXZ
        qmXKm7SgdcN9CaG4zDVFEvI=
X-Google-Smtp-Source: AFSGD/WkPN7GI2kLh9VIfj+8RioommWm4bR8tFzT+PUGoVvd2fkstiDMNwtQNobRGSRuJ6wQ+3PXYg==
X-Received: by 2002:a62:76cc:: with SMTP id r195mr9896950pfc.38.1545330527043;
        Thu, 20 Dec 2018 10:28:47 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o84sm34379882pfi.172.2018.12.20.10.28.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 10:28:46 -0800 (PST)
Date:   Thu, 20 Dec 2018 10:28:45 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/61] 4.9.147-stable review
Message-ID: <20181220182845.GC12802@roeck-us.net>
References: <20181220085843.743900603@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220085843.743900603@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 10:18:00AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.147 release.
> There are 61 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Dec 22 08:58:31 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 171 pass: 171 fail: 0
Qemu test results:
	total: 301 pass: 301 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
