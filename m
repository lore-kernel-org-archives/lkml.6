Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F545C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3832081C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p5SJeFmI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E3832081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbeLGUbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 15:31:20 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37044 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbeLGUbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 15:31:20 -0500
Received: by mail-pg1-f195.google.com with SMTP id 80so2200705pge.4;
        Fri, 07 Dec 2018 12:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E49qziV8/rLMZKniMdYhFNIPSPsK+BAdPJQDZ6JHbhg=;
        b=p5SJeFmIrVCqKDE8Ftoc6/B7MV+vZlzhRGgffM/NYGqtrS4prkfEbISczGkYKTt5sp
         N2+PtT4MFiuUoQ3Nf6ZHzmqVO5WDXtcGADSt6KuaZQzllMApuOnMmUTDnzDhPfi58EOr
         AXmbI2snZW6KY3wd/G7KzXtKr6du8vDA7337OjAXgZTmUBvNjiJj5bNoOheEw7jaTkJM
         AuKxOIl2q2dhqeqp6w78BEdWQgT/YG6GP+yHrMN/j59PgozmAmb3hCA+GoG9Bwb5dhCB
         kJNI3cXWlz2OvLqOcN4GZWoAJfzHKLtj+x0mxnSVshRVsI35u7vU+JjDKZNGzPQgzkzC
         3QEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=E49qziV8/rLMZKniMdYhFNIPSPsK+BAdPJQDZ6JHbhg=;
        b=Iq0LqyCGrqyGGBQUjGhBdNE2zO8oC2Ptre7SzQ69L5/UomIFyNXyWj2BG/mJtyvqO1
         2pp+3qmDQXn4/2wyKQl4OGGm7crO+7trghpmNBFOxSd6xIyftELcyjE/0Qz98P03IGbw
         /mckb6UHtMvDFW+4+PPc3+QkNvcO5C2dvg+UGGZaDq4j0NEN+lCi/gqNTOkwbG9sTEXR
         XXtT21rEIXJl9YK3i7gzGppAWHmv5b4DzmstEythrTYEAzI4zJ7vO5H6JbYLt1RlETmf
         gofuQsqm43bWQYOJWXMgXXdtkkUwFAaz5BFbXnruRnK7Y0pOxQf84eQ04coMXLUTz/oA
         FjBg==
X-Gm-Message-State: AA+aEWZikmDfzTHKqpRQ8m2+KKacuUUI9ygZ89CB8UGCGSIHhRa4yy7J
        tB+O6NWHjevFJFUFIuf7adE=
X-Google-Smtp-Source: AFSGD/Uph06nJWkRKO+CDUNGGXbqe5C4s0ODLrjDgWVX/VnuKXM8RmwtGH2L+aQzTP7V5o4+S9IK9g==
X-Received: by 2002:a62:31c1:: with SMTP id x184mr3776012pfx.204.1544214679477;
        Fri, 07 Dec 2018 12:31:19 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l185sm6467289pfl.54.2018.12.07.12.31.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 12:31:18 -0800 (PST)
Date:   Fri, 7 Dec 2018 12:31:17 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/41] 4.19.8-stable review
Message-ID: <20181207203117.GB16551@roeck-us.net>
References: <20181206142949.757402551@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206142949.757402551@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 03:38:40PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.8 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Dec  8 14:29:30 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 337 pass: 337 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
