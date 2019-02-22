Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB9AC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D9C22070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJkKQJkn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfBVXar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 18:30:47 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46352 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfBVXaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 18:30:46 -0500
Received: by mail-pl1-f193.google.com with SMTP id o6so1729215pls.13;
        Fri, 22 Feb 2019 15:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zkr2WDi8+CNWij0OMfJ7R6RJVFZVFhP8tq4H6V31gVM=;
        b=KJkKQJknEaJR3+2C5aLBezhmzFbL1Nk70ApGYmNnKsQE9ECk/pJG6kz4eDweWs+jLA
         Ikpqnhyo0hSNohoKm72g6q0N2j9PTZf4FPvv5cYEvj97Yc/fcpAzGgqauUXIqVM+a54s
         F9oJJcY7ofCGVALKld61Jbgr+8hK2ipJP+P6Obax2SNchFWEJHYuekGRZd/qCBbswu5A
         Dsb80azE5lYFZpwbo7HxlzMOwJEaanvVXOkzyluJrACp94lHyvfJrfozJUxAoGJxqxcb
         O2F7Efmmzs1x4dzoPfuSPU66GS1Lpj5y118LNc7gvk2NMJVELja2fuXQEy/L0rabVh75
         ZySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zkr2WDi8+CNWij0OMfJ7R6RJVFZVFhP8tq4H6V31gVM=;
        b=Xy+eJAqFztOp3/vUSAnHajyW37pyb9ZWm/ZZbXNSKrcXOFDkZQqeUBIHnTvg7uFGXs
         i4JyW80GRTKf1x0KgMusTBUivgUk4Kxk4yspHTKx0Fesct6E6ZLa3jC1fAjKi3RrLYGJ
         YEOi7zrHxKb7uywTkz+WMc6gDHQmzW4Kexerf5nNmdzG/Ni2IPegxIUFVAs0g6mBaBwJ
         JF8Ql9Zv5Wn5RnjUJlk8BC9Oz0m5PdEcdbvQqtjmgeMEfsAOc2Prflib6jNevYylmJtL
         qxBm5IuRnYbVhW3Q725EoDZ0iVGQLfwXX3fCRyWhp4X1gFZ4JzQAq1fPCwsg8mB/VD91
         u5YQ==
X-Gm-Message-State: AHQUAuaATnVIhh07xxDrK8QCkIxrVVN9t5P25x3CD2uGCIL1qh6mthT2
        SjbE6sYWY8CkflVQKLxBV3o=
X-Google-Smtp-Source: AHgI3Ib4kedri3X+0R0gbjo0XWAbMKCfbwnlohW4rOA9KPv+nUUzJdnpn9oJmvbHZwzBDgHvjGZ+PA==
X-Received: by 2002:a17:902:7682:: with SMTP id m2mr6743358pll.311.1550878246075;
        Fri, 22 Feb 2019 15:30:46 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l19sm5612027pfi.71.2019.02.22.15.30.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 15:30:45 -0800 (PST)
Date:   Fri, 22 Feb 2019 15:30:44 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/20] 4.4.176-stable review
Message-ID: <20190222233044.GB25975@roeck-us.net>
References: <20190221141946.772985220@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221141946.772985220@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 03:35:30PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.176 release.
> There are 20 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Feb 23 14:19:37 UTC 2019.
> Anything received after that time might be too late.
> 
Build results:
	total: 171 pass: 171 fail: 0
Qemu test results:
	total: 291 pass: 291 fail: 0

Guenter
