Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB51C282C6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE942218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIimmBv7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbfAYXQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:16:29 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45157 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfAYXQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:16:29 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so4788020pgc.12;
        Fri, 25 Jan 2019 15:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l91x4eU2NRh1oJK6+gwINAc/ohyao6QlmosSBFLwZ2w=;
        b=LIimmBv76GJxTLkCEZIhF+ICTvmykxyM2eZIfx/4Vxj45DjRc1HWXkl713JgpkWt85
         DFIUS3XJOHALuDSw5/3nihE4FLoalgxXulXWYnWNH5Z1Ba4hrPZ8kI0wQHKmcuPVTbi6
         9WI0ElpPZIX2WD0r1P0ZIeh9NxJAhTx7H07uvS4mkWGKrzGPhmYh9KlByuO/Imb+rV8D
         xApjuyf7oYUmf51tnrnRIL26wufaDHTsbGZ0wYfXRHSs0CR0AHv5d8E2r5hPrJazEoOm
         RsVcyN0bNGdfCOqcD5ZjaoAvFi9fuqvWJd0EP3gUpznja0lJms+JYl1wODZVxxlmf7ck
         VDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=l91x4eU2NRh1oJK6+gwINAc/ohyao6QlmosSBFLwZ2w=;
        b=ecvKQ8Fcl5J/WYlxPotvRdhbXMQzkjUGqg9T7kIrz2OBK8Gzt9Xn6BMikWZ4dUofof
         r603hAzrA1MBuh/1pztC4oxZQHj2RsrPXgnOJY5x2h7dUgd9s0RUsQdEssL+tyxAjFon
         VsrIIf4P5oOEYiq7PTYN5yTy0CQ7Mb6T0Ynynq8p0F1wonsnCEg3LI9bkuA78sU5x2h7
         Lu0ozzOmJwkhrNAvZMM2msEBJymY+/hmFQZcEKwYMZgNlkIEkyppnK3FlcmnecyfAVJX
         xVfvZrkZlrial6WGLrcJz4sJvSoiZrwon+qCkEaGpjNyN+5WpxC1RTPFT5j4sWiQ3R+t
         r5lA==
X-Gm-Message-State: AJcUukdSWuGbGPBHAtnmc4PextzrDLG7jFE3kZTDwI+lXDMXwEyb4FiI
        Cpg1nkR55vnOB/OkyQ4u93c=
X-Google-Smtp-Source: ALg8bN6KXS1Z0M8uKfpq65NmGfMkIaAsSvEXBMicQ2oiPhY7sz/AVbTSBBZlyQHGoDXgU247xJeB2w==
X-Received: by 2002:a62:4bcf:: with SMTP id d76mr13460344pfj.170.1548458188450;
        Fri, 25 Jan 2019 15:16:28 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l70sm52897950pgd.20.2019.01.25.15.16.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 15:16:27 -0800 (PST)
Date:   Fri, 25 Jan 2019 15:16:26 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 000/104] 4.4.172-stable review
Message-ID: <20190125231626.GB27619@roeck-us.net>
References: <20190124190154.968308875@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124190154.968308875@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 08:18:49PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.172 release.
> There are 104 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Jan 26 19:01:09 UTC 2019.
> Anything received after that time might be too late.
> 
Build results:
	total: 171 pass: 171 fail: 0
Qemu test results:
	total: 291 pass: 291 fail: 0

Guenter
