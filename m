Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376DCC282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F3720844
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="omF2WdcH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbfAYXUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:20:50 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34780 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfAYXUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:20:49 -0500
Received: by mail-pl1-f195.google.com with SMTP id w4so5238290plz.1;
        Fri, 25 Jan 2019 15:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MeMJvq4a6zgIZgpXegstXkUvv42lmzp5EtyRneFt82A=;
        b=omF2WdcHHNqr8RCc9TmwvqNm9G6w/BJRuwJNvvs6aj3NK56Z+g3W6KaqpVCyvwtBp7
         UdFP/Km66TocO74E73XGDw3uxOf5/Lm4zz1OSIKyHV3VnG+sPnWks1LCfCbe2i9jKc0s
         aBdy3LR7+5Sqw9Dh7/IQ015MnYpxSJob0xZk8YJfJ0nN+iTN+tWwUGYmqMj2d4w0X1YO
         sLWSwnbIK9gc+0sCabkaOJMCuad8drpx9qaiiHC21f0ONZZu63kKbisLFajw1QmJ5UMx
         jh1HIHJPDuC5MaZliC/3mgM2lp89/3Zrv8u8iox7OZD62GljgYRDUAYbp7e/LjXJkRwl
         NgaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=MeMJvq4a6zgIZgpXegstXkUvv42lmzp5EtyRneFt82A=;
        b=HoYuttri2caTpjnMwnTcaa04PsM3fSBloK5jY/hCrdQSdUseraoYGbfxnR2cM/6C+0
         Y9My4UgOVRgeXHPfM1iYeuD6JCS33D7FuZBlNeOwD5pDl6vR6NecIkN99eANIxqgZFNO
         R/rXOJflqxyLwLBHdCIOrf3yToysVfkIZP3A6gNL1PIpXi0uho5iWihhKJ2Z3NBF7y6T
         2taY6Di2AtioOQU2187eR4247wR/F5PYD4jf/pG9jsdpcqBWbOWYzRwlqm0Q95M30e7p
         mJRSNOOviOmRSOSNWM+ERCK/nK8nPHpOcn2aP1vTwdcPZkijLbITcHPla/nMhhfbXRRI
         tefA==
X-Gm-Message-State: AJcUukeRE0ZbwjG06Ag5ajd6GADa2KhWL0u9w4xnp2e+weHzNXDj1K8E
        i41mVwoPLaPk+aQun8I7AVg=
X-Google-Smtp-Source: ALg8bN5uok7c4woJVaSYDl+OQKyBiOvulVGqEQ3onCLp/aIlZuDHJesN0nU5LTMy6gK34B3mDHyrtw==
X-Received: by 2002:a17:902:9a47:: with SMTP id x7mr12930755plv.126.1548458448892;
        Fri, 25 Jan 2019 15:20:48 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g28sm43374765pfd.100.2019.01.25.15.20.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 15:20:48 -0800 (PST)
Date:   Fri, 25 Jan 2019 15:20:47 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.20 000/127] 4.20.5-stable review
Message-ID: <20190125232047.GF27619@roeck-us.net>
References: <20190124190211.984305387@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124190211.984305387@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 08:19:06PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.20.5 release.
> There are 127 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Jan 26 19:01:19 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 343 pass: 343 fail: 0

Guenter
