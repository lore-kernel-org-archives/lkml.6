Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4498C282C5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8143121726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oo0hGwdk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfAVUpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 15:45:02 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39359 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfAVUpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 15:45:02 -0500
Received: by mail-pl1-f193.google.com with SMTP id 101so12039506pld.6;
        Tue, 22 Jan 2019 12:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vAsISQbuIJu9KAI6bWjLnpvtxvooIv/shcH2//UyEMM=;
        b=oo0hGwdk2pqMWz8iX0SvL7qMLaPgxlwyKcbE/kLTLjfdwYOu7rtpXkgZm6U/Hjpe7N
         DsXMU0OBHpfEGQkjeG7Dr4IDltbaPNn0ouH3+64Q92RuUK93f5AabXii/cYBaZM1ERG6
         yVZvYjtc0f0+gNBy1bDAExicOlrf8pX43GJTdGZ5ZJIHZnXUwNbbo7jviy6H0nB0zGDW
         UoSaQtwMC8n/XWznfhwsyXq++fnVbQueHgtRaGVBidTrBuAgY/0rCKs5DCIdziZQEJFd
         hpgMfXzUVfcfRufgD2GM49HKTYyaffLiAd+wh8Jshmm8DFZkJkARWKbPS2M6GmODQ7pj
         LzPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vAsISQbuIJu9KAI6bWjLnpvtxvooIv/shcH2//UyEMM=;
        b=fw8l8R/5o60FPJPJS2zBH9riKocg7ExTU9fRsgOoa27aWOfPeSFCKYIB7FTBuFxW5T
         C/5mh/cXD96yFU+Q+RycMkH1MMzHGqZ8Xz9kx+Fq6vf3uKAKpZ7MXR4YKmfNnqcUpNla
         7TY6Vc2nD037FiL/0b1x7VVerxNljqnRZCCvCPnhXb7V8T/mVm1stbtBgKFyaublyaS+
         84VjmzqrAq5poVwZ8TLXxQ4JlQ8l06oghrtqEl7Ay6cRC4iIjdnBykK081XFwWecUYLe
         BYtrgECLb+c6dCHnppG1b9W6vlcpdYjrMbP19RE8LzlvsdBZ6GmkjUeFMWm0slWK+XBP
         HTfQ==
X-Gm-Message-State: AJcUukfU/Wpe9AB2pLISIYZVp40nWBoMy18VoZXuUpyQtK8RdW0ShZvy
        xyhlxupVtcNPAczMaLgt33o=
X-Google-Smtp-Source: ALg8bN5j3ZcBiikBsgd33tKXh0BnvUxtE4hnledZ/1A4kaK8S0SR5dCT/sD6KCfsq2xhgbK+WynPTw==
X-Received: by 2002:a17:902:4401:: with SMTP id k1mr36057645pld.307.1548189901279;
        Tue, 22 Jan 2019 12:45:01 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g28sm27393087pfd.100.2019.01.22.12.44.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 12:45:00 -0800 (PST)
Date:   Tue, 22 Jan 2019 12:44:58 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/51] 4.9.152-stable review
Message-ID: <20190122204458.GA13061@roeck-us.net>
References: <20190121122453.700446926@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121122453.700446926@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 02:43:56PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.152 release.
> There are 51 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Jan 23 12:24:02 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 315 pass: 315 fail: 0

Guenter
