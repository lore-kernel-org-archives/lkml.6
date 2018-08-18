Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46629C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 14:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4898217BB
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 14:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NBBpynJa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4898217BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbeHRRNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 13:13:50 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:47010 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbeHRRNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 13:13:50 -0400
Received: by mail-qt0-f177.google.com with SMTP id d4-v6so11769335qtn.13
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 07:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=NTOb3hc2QF2kOjyuLu+XvC/HNsLDbegAMxVKZ4B3l+s=;
        b=NBBpynJahEzyhz4cJGzy60A8FfEqPD7eYzcOrXb/dLEz9OkOHoUAx/vKH6n25ChcFL
         AVQys87UQ63M82WdR3B6roStvjQ1QZXIzFOD/xmRLrbcW8byr9Bq9YcILqGUiTuXLDz/
         xxR5b015PeLuAONb0tWzjXXEYTJ0gLgT5SHp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=NTOb3hc2QF2kOjyuLu+XvC/HNsLDbegAMxVKZ4B3l+s=;
        b=faVQ7oqC2AO0Y1ewmrxb3dRMofjS691+n9UoCLjUeISIjU0Rq08oH5wGLs8Uenvf5D
         dTw1PX0X291BdpwkQnvV286s6fv2T94/4ZINxggeMCOtpCp3EYfeVBIpEbaB/8E6Zp0W
         UeCr00qw/ONqJiLJrlDFB4gHHHrszrhV1Yw323+CrBnOPdj421mcoeNUCENyS0mNAAbv
         9Xn8mhIsLCoq295bfyxzEXbZoVkVECCNBzc33rt70R7qmcUJb5bQMvWhdzvmI14JDPHx
         Dpmh/z/Q0UlT8wJmsItYAMtbjlN6bM9N7uNbPb1HIdwQ0eFVvbtYhM7C/UMSPO1dQtN6
         A+pw==
X-Gm-Message-State: AOUpUlHOZRBvvAGq34bg84cDpycBt5jlBMf8sYZRz4xIJLIzygcCiJqT
        Tdhc9R2LlkletzO6nEwftzop6A==
X-Google-Smtp-Source: AA+uWPzQj8Pb5Os6ibwxsOe7tQ4k5mM4PktDKDrv8OrxJctJ/u6DWs63lE25sg08Jz6xhsVwXucYLw==
X-Received: by 2002:a0c:c993:: with SMTP id b19-v6mr34963339qvk.95.1534601159762;
        Sat, 18 Aug 2018 07:05:59 -0700 (PDT)
Received: from localhost ([168.194.163.45])
        by smtp.gmail.com with ESMTPSA id f13-v6sm2537340qth.62.2018.08.18.07.05.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Aug 2018 07:05:58 -0700 (PDT)
Date:   Sat, 18 Aug 2018 11:05:56 -0300
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Subject: Re: [PATCH 4.17 00/21] 4.17.16-stable review
Message-ID: <20180818140556.pipcfnr4gn3swze3@mobile.celeiro.br>
References: <20180816171612.136242278@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180816171612.136242278@linuxfoundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 08:45:10PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.17.16 release.
> There are 21 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Aug 18 17:16:02 UTC 2018.
> Anything received after that time might be too late.

Results from Linaro’s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.17.17-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.17.y
git commit: c3f554469fe42eddeaaef5f3992136828528f8ce
git describe: v4.17.16-2-gc3f554469fe4
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.17-oe/build/v4.17.16-2-gc3f554469fe4


No regressions (compared to build v4.17.15)


Ran 16701 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- juno-r2 - arm64
- qemu_arm
- qemu_arm64
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
* ltp-fcntl-locktests-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

AND

Summary
------------------------------------------------------------------------

kernel: 4.17.17
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.17.y
git commit: fa535b8a37597c80c0ac7d3669edccda9d91195b
git describe: v4.17.17
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.17-oe/build/v4.17.17


No regressions (compared to build v4.17.15)


Ran 7508 total tests in the following environments and test suites.

Environments
--------------
- hi6220-hikey - arm64
- qemu_arm64
- qemu_x86_64
- x86_64

Test Suites
-----------
* boot
* kselftest
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-containers-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
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
* ltp-cve-tests
* ltp-fs-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ltp-open-posix-tests

--
Linaro LKFT
https://lkft.linaro.org
