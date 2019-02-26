Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282AFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F268921850
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/loDanN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbfBZRrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 12:47:19 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33060 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfBZRrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 12:47:16 -0500
Received: by mail-pf1-f194.google.com with SMTP id i19so6601285pfd.0;
        Tue, 26 Feb 2019 09:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U9JFlRKFFGcaaLySl/Ja0ZjxrhaozMjWP1gmbxSB7jo=;
        b=e/loDanNcwuvWZ0XlIR9gVUGrwqLDnXczPHP0eLaSOlBuFVYPbJ9WX5+7gvYvd4Keb
         ufqILRq+lFpbmFbqFMkvPIEA65iB+xptlyPNRoBBMn15SlajrWGQ+KGNLAEUFJmDkhLL
         0fHhej3lln46N78xRBiJNIJwrc0ZoOV+P/ZtMA2JA7jOAUTw/m1+MJL59RvZvOofR4Pe
         pC1Sl/aMMN+CPqbry7m9IKo/Pgshbai9D5uS+2ad54K7EDZBTmwVOFdx/Hej/mY9y+Bs
         bjJ8GWIITGHc6ZdX6jzHvkisBk3mguzhJ4oaZwxflvR07Fbq3jYNupbrXEkLB+NkWJa2
         GQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=U9JFlRKFFGcaaLySl/Ja0ZjxrhaozMjWP1gmbxSB7jo=;
        b=V/rSFupJPzu21Y0e3ZQbPb3IAYFGl8eubYx13qwmj2diUCuCCoivlgPdRAcYgs9Keo
         d9XsWUBA1uGf6iK5F+ON7PXLev2gPC8HdJcxNvjEfzbmNsoEmZv332RPpauLjw1vIf8u
         aCQrRCEY89SovESRoPWSjKmTsWb1Y79D1cSzYvu4OrkO826zvEZCUlv8MSSlKU69IZTp
         XR3v8NSKqVVqSyFOvyyAnGadppbI3HNgjSxYYL6HOAAX4KWY5WhK5rZlbDwrHdMQTk+O
         R+G0NtXfq6aNJRMyYubxkzEzZvs1W5OBarGSdn/ZMujK1XAxIG2Zk+Ah8ThnsPw9nzE5
         DUog==
X-Gm-Message-State: AHQUAuZ63u5q9kD9SL6VXfZ5aDRgkgrB56FQAW3b7ckU3slojLdVNXTk
        EKl+WqNyTMn7D7MfAcbRuac=
X-Google-Smtp-Source: AHgI3IaWHxknKbDJi4RZC8+y1jYqHdFEgtH4d8acVsJHYTD3rl7LtkLzGaQPnwT2e0U2pvEZkgI4Iw==
X-Received: by 2002:aa7:8a81:: with SMTP id a1mr26211992pfc.246.1551203236233;
        Tue, 26 Feb 2019 09:47:16 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z7sm7967376pfn.177.2019.02.26.09.47.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 09:47:15 -0800 (PST)
Date:   Tue, 26 Feb 2019 09:47:14 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/152] 4.19.26-stable review
Message-ID: <20190226174714.GE8682@roeck-us.net>
References: <20190225195043.645958524@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 10:09:52PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.26 release.
> There are 152 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb 27 19:49:57 UTC 2019.
> Anything received after that time might be too late.
> 
Build results:
	total: 156 pass: 155 fail: 1
Failed builds: 
	powerpc:ppc6xx_defconfig
Qemu test results:
	total: 343 pass: 343 fail: 0

Guenter
