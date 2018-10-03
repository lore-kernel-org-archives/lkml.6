Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCEEC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25341213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ajQXizrM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25341213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbeJDCkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 22:40:17 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41271 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbeJDCkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 22:40:17 -0400
Received: by mail-io1-f67.google.com with SMTP id q4-v6so6044477iob.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 12:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=P5UWwD4T6WWnqGDRei0YUcepzJf1Kxs+8lDvVBEzWe0=;
        b=ajQXizrMheTn4BrTy6E+czzx1brc7UH21/K8y3VmhEX2xfQAb3F7HiCefoAkli+oM4
         aolXCN5jjVibm/Mk317tzPKKfM2UM92S0td5dNS5uiZDOEeUHxymEHP9q7pSYzmYweYJ
         0Je3CHrzSi1r9CYdeZkAmA5RGBY+N0UkRFeGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=P5UWwD4T6WWnqGDRei0YUcepzJf1Kxs+8lDvVBEzWe0=;
        b=MQ3DJ5kTXLBDzMaN6UJ3gycjepUDRLrx2ED2SLSFLq3ATzKn1lmVdsfNSt17QjkFIK
         4TzqxZRvjgC2qzXDoJS9yXTT/lHDxiYHCJ5Psbo5OLF8kgh3Q/QNOKn1FE4DJbhXRkb3
         +gI65KxmKD5Suy1l1MYsmIer2SIJolxAQoXhK2IUUJU7RjIb0fRjZZVhZCqUdK45YC1v
         fvhdHCfhofeVIagIaZo5g7J0EWR0nhFmXCAAz0tSzl4J5ittPMDVs6e7BUAWF+g3Tu45
         gsXAhOtO4Grs2T+92IDQOZm2MayX9kWL20wQhxc79nLdFzm6QG0x/E4fKyW4zaiSmyDe
         J1Tw==
X-Gm-Message-State: ABuFfoiOrbo6OL/mHRSEKSeI7MBlWh7LHMUGQsbNoqjAPKZXTXLLLz/g
        N8V6Q14e5VkyFmblkjfNqidQBg==
X-Google-Smtp-Source: ACcGV629h7tC5AIdruk/DYF+DVPN5lAXn451r470mFowG+Gf4UExBOveZ4VIbTXUIWOXUxnUwLTMlg==
X-Received: by 2002:a6b:3ac2:: with SMTP id h185-v6mr2330245ioa.36.1538596227806;
        Wed, 03 Oct 2018 12:50:27 -0700 (PDT)
Received: from localhost (c-107-2-67-121.hsd1.mn.comcast.net. [107.2.67.121])
        by smtp.gmail.com with ESMTPSA id n17-v6sm617611ioh.58.2018.10.03.12.50.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 12:50:26 -0700 (PDT)
Date:   Wed, 3 Oct 2018 14:50:25 -0500
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Subject: Re: [PATCH 4.9 00/94] 4.9.131-stable review
Message-ID: <20181003195025.hhvjh66vjomsxwzu@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
References: <20181002132500.494838053@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181002132500.494838053@linuxfoundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 06:24:14AM -0700, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.131 release.
> There are 94 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Oct  4 13:24:37 UTC 2018.
> Anything received after that time might be too late.

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.9.131-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.9.y
git commit: f80dcfd9c7f99eda914bb380a43af8c56dc0e4cd
git describe: v4.9.130-95-gf80dcfd9c7f9
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/build/v4.9.130-95-gf80dcfd9c7f9


No regressions (compared to build v4.9.130)


Ran 21282 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- qemu_arm
- qemu_arm64
- qemu_i386
- qemu_x86_64
- x15 - arm
- x86_64

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
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

-- 
Linaro LKFT
https://lkft.linaro.org
