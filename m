Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F49C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCC6521545
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jFObCUbK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCC6521545
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbeHOXbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:31:51 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:39675 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbeHOXbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:31:51 -0400
Received: by mail-it0-f66.google.com with SMTP id g141-v6so3731257ita.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 13:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=d8hj0l4DkQoR+qHPNz2dKQwzNXyE++FCBGbvY+IEuSI=;
        b=jFObCUbK5En0oSycKEn1G+vFxUdSJZxqQGdZ14nmifGfSChqdvqnLAumleLCXAN8gv
         x0A/XcvIFgx8iNE2oRZt5r+4mV6xTdZ8sjZ8Pd5MmbUuOPCSoYG4KAgbm2RbN7FmZJoN
         60swG+P0OQt/ZnSLsDdDV/z3cvcsCU2FKiOVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=d8hj0l4DkQoR+qHPNz2dKQwzNXyE++FCBGbvY+IEuSI=;
        b=S/95S8TZOQL7v87q9UJYRLTo6dMAesV0BFObi5OWilmqDw/KqxnN1cZ93hAQSPjxDQ
         MWicrKwrf+Joso0cX9UK3xUJ3KVk+HRuzdCEIkHXLsq+ntqsvyrVeKtisKDoyvD1nnx0
         KLrPGhWZW/FhQCIk9+f13zR71053hpJZOicuOJ/88WtLkfVszqvFxDh8wDZgFSdDetqu
         SPXzYEzY13kCMzMAz4hryIjViDg9Kig8DorYDzr4f3yKY1AK3/JN1ArcEZHgpv/jSt2B
         e6D/QyzRrh9LntkmDxSmvQV0DRNBnIktoLhKhw0bkGyL+Ws+yU6IHCXV6ksH2kOhp7lk
         oVAQ==
X-Gm-Message-State: AOUpUlG9ooaJj9GWb8HDiI9xlVWa+AaZNwaoUIlWVKI7dM7E43E82/Gh
        iL9xFhBT6im0qp5m7ZYhlwBg4g==
X-Google-Smtp-Source: AA+uWPy25cqav19lq9H53rgYfOng9Cykzlpj7xseUcdnEwnEVo81G/1BlgrMK1mTPiPI3wkZavjk4g==
X-Received: by 2002:a24:69cb:: with SMTP id e194-v6mr20748356itc.102.1534365486305;
        Wed, 15 Aug 2018 13:38:06 -0700 (PDT)
Received: from localhost (c-68-47-89-210.hsd1.mn.comcast.net. [68.47.89.210])
        by smtp.gmail.com with ESMTPSA id w8-v6sm1790356itb.0.2018.08.15.13.38.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 13:38:05 -0700 (PDT)
Date:   Wed, 15 Aug 2018 15:38:05 -0500
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/104] 4.14.63-stable review
Message-ID: <20180815203805.3syqtgztxbnuotpv@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20180814171515.270692185@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180814171515.270692185@linuxfoundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 07:16:14PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.63 release.
> There are 104 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Aug 16 17:14:49 UTC 2018.
> Anything received after that time might be too late.

Results from Linaro’s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.14.63-rc3
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.14.y
git commit: aff06b616b3c87631fc6a162679eab65b9685c2b
git describe: v4.14.62-110-gaff06b616b3c
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/build/v4.14.62-110-gaff06b616b3c


No regressions (compared to build v4.14.62)


Ran 10327 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- qemu_arm
- qemu_arm64
- qemu_x86_64
- x15 - arm

Test Suites
-----------
* boot
* kselftest
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-containers-tests
* ltp-cve-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* ltp-open-posix-tests

-- 
Linaro LKFT
https://lkft.linaro.org
