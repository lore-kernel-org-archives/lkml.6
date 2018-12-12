Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B39CC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE172086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxB+HeuS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE172086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbeLLSti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:49:38 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37117 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727897AbeLLSti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:49:38 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5so9008666plr.4;
        Wed, 12 Dec 2018 10:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+IzO5o21z10YQePFBfpW9ZrgbW0cs8jzNnbvDKrUWd8=;
        b=fxB+HeuSSgyw20acN+YrCkI06oEZRA7eksH4NEwDJPXHDmCaYMDUe7MywLAAixGLT4
         lAzyklSR3VWYEc6iRw8JI0PYWL3A9ERGx+wDdWJ3qYLAT0qq24rIqMbSOiIbQbb2rCMq
         Ko69GIwwfQSDZyEKdt4cPu9dCICtAOi/q7kwKXg0ngx6Si/7vGQ43/R8y7f/Uex54jNt
         PXk6PURkvXWDAlr9VI+2j0PwRHN/5JX6Z82WLgldU5Uxn4hcK3hObzVZPq+rR4QpkoFR
         2zCw3UiffOauGrdUtI8OwRQ3S6UTROmy5CA9yF7XHwqwpsegMm9wae6ZZtiChD5vY+fA
         FbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=+IzO5o21z10YQePFBfpW9ZrgbW0cs8jzNnbvDKrUWd8=;
        b=Lm1XUEbPdNC3HXqFBCrD0SCFPzGr9Zihoxu1EHEYsMsBIOHrMMpfIA7CGNg0S7EGny
         viZnQ/5odpCxxjhOZTwRTR9xNVroiAkt2XSdofR0K5tmfMb5hXWBtoFTzQn93u3fa5Da
         l71otovTe2RmEy2M2UPIdc3WpEJYLHSsPB0nlLPXK/BCdFZ65YUwHmVe3UKa7bH6aS2R
         3y8Lvhqq+JyjE2jnOkD15srBQWNPfkWzxUIHsiwZD4Nj5vg+zx3MLt+Hs/hydE3cjIV4
         E4NJKbeURvf0swBf8OFMI1ILMcPYU+FXpX47gYk+4O8RlRF3wNd7kyps1UasJMa+026x
         rFuw==
X-Gm-Message-State: AA+aEWa7Nn4h96fqwH3YYnkhtDVzQYMBbbHbxLj6geGjVpx0MwxeKM/q
        WQxJRXODcJ7g4TATdDor0IE=
X-Google-Smtp-Source: AFSGD/Un+WyqdwKpbW2FuaESfcuCx3V2+ZCJhK+5DbGovS4c0YOKXWoDpXsk1sEZkuXMe0h7Y97Alw==
X-Received: by 2002:a17:902:2006:: with SMTP id n6mr21205825pla.66.1544640577916;
        Wed, 12 Dec 2018 10:49:37 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h69sm24011403pge.4.2018.12.12.10.49.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 10:49:36 -0800 (PST)
Date:   Wed, 12 Dec 2018 10:49:35 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/51] 4.9.145-stable review
Message-ID: <20181212184935.GA21649@roeck-us.net>
References: <20181211151612.328911565@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211151612.328911565@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 04:41:08PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.145 release.
> There are 51 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Dec 13 15:15:52 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 171 pass: 171 fail: 0
Qemu test results:
	total: 311 pass: 311 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
