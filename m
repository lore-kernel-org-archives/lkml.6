Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2C8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C31D218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAdA12fi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389203AbeLTSaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:30:03 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39192 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732867AbeLTSaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:30:02 -0500
Received: by mail-pf1-f196.google.com with SMTP id r136so1313293pfc.6;
        Thu, 20 Dec 2018 10:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=agQhlHnDS6qw0/w65vhA80s5i76caEAtTOe88jjr9lc=;
        b=MAdA12fiXExl7JPy57r1RX+kFS9SeGJTSz4HXTwmp12CF2OTjkaEj+cCkW304Vy4gz
         HagTYfBevqm363MgfP4o7EHPhRD/SH288jM/BRJOgCBTFIz5qys8m5zRWbUnKV6p3+BO
         FwRGhAod2NoY+ItnIkcdAqw6M87FhX+ek1FgYO6FfuNsNglHTbAnmyKoBpmhcgdJ83AF
         ushEnQiwoAJpiJ/SIlECFvMG/sfxk+Y1mC17t4QjzOaXu/v47imz/5XHtRf4rWyasik+
         Afc0yAgcFdkOZJWtF/8sf7k4jpp31fnsKH7KXJpQiSP23kRIQfXun5hvckB84bkr0s/r
         pazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=agQhlHnDS6qw0/w65vhA80s5i76caEAtTOe88jjr9lc=;
        b=uLKVujEXtKSvo6fihbKgqvYMGgRjePDAfoLWX61N+t6ymEx8KCkPlW1rO5lzMDVV2c
         rBnV1Yf9h/0X+8C+eLEuxKw3hp6KIGpAWuPsgRpNRNXn0Z/bQRTXDPjF9KCk3AkfpSOY
         DetTHiQZBiYdqrkK/9sJAIU0jYwfhoLoQWsxgRBOQwIxCiPSZSX5qjtmRC1U+i58Frn5
         EuH/k0d2rMj57Gl6b5Mk32nwLQttIhYvmkeksnyxGMyINz56wMc1fVxoM32mXFMHzu00
         YUU9Zotn3+3l8CQROgHHQVIDOjiklvVFO9+wRDYZ9rHQog9aIp/gid+KeMDChv2KA+47
         kOBA==
X-Gm-Message-State: AA+aEWZ5cyAL7Xrgn+kTj8DMO0pFTaSneIAzw2nkwcWHWywJed4oNEOa
        oqklPmlRvIx0pok5oMsqYuQ=
X-Google-Smtp-Source: AFSGD/V6cdTYdiEo6VRWRvMSYhc9U75thJRVTM9C6FtHQthFuUDqOd7n14mx8GTstkvD/noH7K0pMA==
X-Received: by 2002:a62:4156:: with SMTP id o83mr25255764pfa.72.1545330601096;
        Thu, 20 Dec 2018 10:30:01 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q75sm31203315pfa.38.2018.12.20.10.30.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 10:30:00 -0800 (PST)
Date:   Thu, 20 Dec 2018 10:29:59 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/67] 4.19.12-stable review
Message-ID: <20181220182959.GE12802@roeck-us.net>
References: <20181220085903.562090333@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220085903.562090333@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 10:18:12AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.12 release.
> There are 67 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Dec 22 08:58:49 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 328 pass: 328 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
