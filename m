Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E702AC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A790920863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+5tycid"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A790920863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbeLAJjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 04:39:04 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38712 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbeLAJjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 04:39:04 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so3469832pfi.5;
        Fri, 30 Nov 2018 14:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k+y54eiu6RS2k510h5raxPS97qX1rAXsEtNpct0VKv4=;
        b=S+5tycidiuM0zuvtPYIgDRPqtUoYS/8SpT9qniycMCVbGL7+9bU58JGC1xJlyqjemf
         jriAYI4zuFMIPqI8jdyiDttud7AVJIySqA24U3D2wYb4a1EeMzggqiLYN8PclVB2jSq0
         V6ZY4Nr9YHHfmeFNMwtXTU+PLa42pjmnSPZhpkHaWLFGfl+uxMHPJagU5Xr4AuE1Xz9X
         L7hZNMqU5M28MTKiy68lXKgEgxL75wMJE59LG+ME21L9uZhGyftoK782EZ4UvSbKc22d
         unp57i+WEgsvUwZOpFPp4lxCey9WG/ewqckoZdGMmxFCaaMn5EO1im7qA45uYLv+Ifm9
         cxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=k+y54eiu6RS2k510h5raxPS97qX1rAXsEtNpct0VKv4=;
        b=BviZnnA2BJGzxf6VR1wk8f+7VFnHhJ9l1cQI3BNZ/p7LIc92jwc112aaVBr8gamOOL
         tyC5jP68SRvfpjkEOUABErTDggpWYWDqoDXQd6eOY9WUZF3ym++QSSPSWXVG4pR1tMSc
         X+S5C7qURp4Sip+IAtwgTLHq8UMZWPgAfMGP1xlH6e50MK32AbR7XHXsohlZBc1rZGEG
         oQ3ncJRKjzl6PFcniKtbdzja+RV4wJpoUmgrE0uIkYAR/6eVMzaDPOWBFoPFzzeeVPAo
         HuDtDU4VoHadiOfuBg5WBgqVokF/w19pa7eOGP2HrC9A1nuX503BwhoHSgHBKejJnAbv
         UbmA==
X-Gm-Message-State: AA+aEWbBwg0RYWmkX5ATzBlLOw8b/sD/uJBUiLzutuCR7WfkvmyCtwOx
        p9Mq8JeEAGbc1xxRny6ERas=
X-Google-Smtp-Source: AFSGD/WKY2DXFpE+5bPiMWl+pU2prGFx4Vc+aagdrNV3Sb+cGfhW9XaIMro7EHI1x40kEKKrBqw99A==
X-Received: by 2002:a62:ed0f:: with SMTP id u15mr6969875pfh.188.1543616896361;
        Fri, 30 Nov 2018 14:28:16 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c7sm11553594pfh.18.2018.11.30.14.28.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 14:28:15 -0800 (PST)
Date:   Fri, 30 Nov 2018 14:28:14 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/92] 4.9.142-stable review
Message-ID: <20181130222814.GC13361@roeck-us.net>
References: <20181129140106.520639693@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129140106.520639693@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 03:11:29PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.142 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Dec  1 14:00:37 UTC 2018.
> Anything received after that time might be too late.
> 

For v4.9.141-91-gdc9fc9db643c:

Build results:
	total: 175 pass: 175 fail: 0
Qemu test results:
	total: 311 pass: 311 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
