Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB14C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D728420684
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwTxrc6s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D728420684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbeJCTnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 15:43:24 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42241 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbeJCTnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 15:43:24 -0400
Received: by mail-pg1-f194.google.com with SMTP id i4-v6so1531644pgq.9;
        Wed, 03 Oct 2018 05:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r54B72j0i0XxbBFretRDTbihu92D7GzNkV6X6YzR7Uo=;
        b=YwTxrc6s+gHu2eU8Epgjp1NMA39iblI3Ol4/giRCIxc2aAjFwAjINzljFnwjkwR08J
         DrVwpdv2/olhAu2KsQsl6RwEEx+ZnKynN40puFu73F0TeQemvGrapWRxzp4/lkbnfQFx
         haO9A2iMxcz1MR1pGN2RkcA6vKUyr6ZiBxwbx3QqYzQZxng9sRWtQ3NVu6W1hPLUfeAG
         Qx8sTGT1xE/ZRESXXZygnQXGaOcbPtXxOdyUNWZKBRuSq1/WFL/KsQCPbHGtFSpsoAKq
         AbbIdMG2j0B40DCyu6MjnpvQk7DRShMnbLP6GRdYAqNgUEKq9koqMopaCVBLkwedXSpe
         Y1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r54B72j0i0XxbBFretRDTbihu92D7GzNkV6X6YzR7Uo=;
        b=uHIjPv3QyqJV/7SVdsB0hAGsUTbfsOsK65RnY6G+Q4bcDtPHCGEVbIFC/NU3d2wnPd
         shERzt+fyj2Lb6IGmK9zJqXIOsBSxDxQPz/bWBokqIbCHFPeq29xHjtcFjZu5bUj3Za1
         k3h5Q031fcrbvwa+pqVuWCcNZH8rmqwtyhCuO9xePqt6lPmswlPps8IGuVm0eexoGvgV
         8l5Vz5sduvIZbLnkffi0JKpNeCS967oHUK0eUKFFZxi/rEu9VsOnU6GWFWsrybXhzUIT
         TPFQkSu7IQXfYSZ3771Jhp388W7Zifet94CVXp0LR/XSFeKp26+T7nTUPPbAtbJVVelZ
         tF7g==
X-Gm-Message-State: ABuFfojnBBMAyaN1PeTv1HbORNIW1btP3B/y6iCXr1Qse8d5DxiImUjG
        1CfRZ9RANHbnltWRPyb2A9gEqDO6
X-Google-Smtp-Source: ACcGV62VN2MM3qQTgXC35cnHn/PmOQ05ICa3JlyHeKhs7OBbW0jla/nvjhkf7zYaLSYiU8YSjlchUQ==
X-Received: by 2002:a62:184a:: with SMTP id 71-v6mr1492431pfy.246.1538571306994;
        Wed, 03 Oct 2018 05:55:06 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id v5-v6sm3335467pfd.64.2018.10.03.05.55.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 05:55:06 -0700 (PDT)
Subject: Re: [PATCH 4.14 000/137] 4.14.74-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20181002132458.446916963@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <51958cf1-5824-3780-04fb-6be78c35cf60@roeck-us.net>
Date:   Wed, 3 Oct 2018 05:55:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181002132458.446916963@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2018 06:23 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.74 release.
> There are 137 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Oct  4 13:24:18 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 151 pass: 151 fail: 0
Qemu test results:
	total: 318 pass: 317 fail: 1
Failed tests:
	powerpc:g3beige:ppc_book3s_defconfig:nosmp:ide:rootfs

Details are available at https://kerneltests.org/builders/.

Guenter
