Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7A3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1CF5218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEc2kemJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388902AbeLTS1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:27:51 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40216 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731963AbeLTS1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:27:47 -0500
Received: by mail-pl1-f194.google.com with SMTP id u18so1252784plq.7;
        Thu, 20 Dec 2018 10:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wV5CEyVl2YymnkrHEjtL4kRdrC8pJSO03kQ/nWzSNUs=;
        b=IEc2kemJOEOgFYSqA/sMa9qBtTC5c0wyF/mVXCV8CMXxt5JR34eY0CACaqDh26E3eG
         aS8QWNSw4JLamn+8bLB20Funp6CI6j8nej5UeN5KkTZaD/9mVoYiMkbzMCxeXOW60EPY
         fVDVsXapbf9smyr+E3DZo5TKp7WgMhEwHnqJne+dPCwKG12IvnetmkIZGWadw5eQDHk0
         cR+j+3Vr+Ea4d+a5ifdR0GArgNdTJqyBeCpJfsV1f9wTwziw6P451zYT/rPIRCAfesoE
         WruxDyoE7YZVA4WQPdqwEetgmeWXYi+n2j58nft1PlHG19GYi8Wr1W6L1egaT3DGQznh
         gB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wV5CEyVl2YymnkrHEjtL4kRdrC8pJSO03kQ/nWzSNUs=;
        b=Zv5rTtGVMjR+6l3MOMxw3On38rBmNBRHnAES78DTlEco4U8/iIiqLMTkNcgiAszuhz
         bIWLI5MG07fQfFMDhFFm0fEdQ9dF3i52gFgBH6EW60P1WQirHpwOtPcK3PHur/LTKJzW
         zpXTiNejOl2A4ALth2OCko/4WYL3tqgE/bUFWUCUZbCEFoR8pqwBMWwncElrdGPaaTTJ
         1iSf6mK8EKRDYvK5c8fmOJ96gwWJiu2oDMyj+OOckcmK++6gn6Dw4MP8zQdCQi27i2/8
         T7tfTAQxeLDNU4MCXTmBScQkw1naM7jGickgKpYqQ+YmfUz7Cz9Fg+UIFHOA85xl7aWU
         izrA==
X-Gm-Message-State: AA+aEWYyxU84bWwhPwscYis6ov7UKC6rvOWmGBFESuetvdTkYGbidkgO
        WyOhbT61UPV4oWO7SzQ9pYoqNatJ
X-Google-Smtp-Source: AFSGD/UFGBx99+RGt9vUZdpk3R5BRyiIoMbXI1IPTxIItwXmNFPqMe/s9IJDdM3xczQZsHOKVV01tw==
X-Received: by 2002:a17:902:503:: with SMTP id 3mr25401944plf.233.1545330467206;
        Thu, 20 Dec 2018 10:27:47 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g3sm49036705pfe.37.2018.12.20.10.27.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 10:27:46 -0800 (PST)
Date:   Thu, 20 Dec 2018 10:27:44 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/31] 3.18.131-stable review
Message-ID: <20181220182744.GA12802@roeck-us.net>
References: <20181220085742.601260254@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220085742.601260254@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 10:18:12AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.131 release.
> There are 31 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Dec 22 08:57:30 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 154 pass: 154 fail: 0
Qemu test results:
	total: 214 pass: 214 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
