Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6816AC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 220C6217BB
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="A3z+1mR5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 220C6217BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbeHRSQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 14:16:45 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:45987 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbeHRSQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 14:16:45 -0400
Received: by mail-qk0-f196.google.com with SMTP id c192-v6so8190451qkg.12
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 08:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=oB0JuOWc1x45JgRUhlAAPF3mHDZBBo0TJ6IgHW13xbU=;
        b=A3z+1mR5CXfSON69qGYuwlL56rhkUPx3qSF9JHkt3ucAgrOqxzlc/FB4Qv97B0Gfme
         HLvfLBM9djXeG9BVIbD7T8eC8vcH9Me7FpXV4BukGoKaK/8n0ht9mOSciXolUNHmTj60
         Te0FWm3IQVR0HnLW81Mq2EGG5DxZalHjqerbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=oB0JuOWc1x45JgRUhlAAPF3mHDZBBo0TJ6IgHW13xbU=;
        b=rhJ7zxyk8nbUvXZFAd6OdVwQr01WLavrK2HzjhesUyuB5TqS9IxHs0RInp+5GCquBR
         4YaXT3QWFC2O3vdmBeXjtx/+lnVCbzxKOvRFhavNqcMo+A8M0/3MN0X1v+zpHTM97yeZ
         umEiyr/towDpmzDXXALsviaMbRS++UB2c0V1ytxkAqSgLFVq+fWOnlHFZMTdJh2+pmL4
         uP7Dgjixnh26AFVnkY3NPbsqkmYH48UiVW3+dyPeJe9e9sjdXZdGXOrg/84kxaqLORne
         Tn3RdGdiFqhTq8TMOc3MhTvamO6eRNmqG7pgiUbCB0j/I+VMPi+bKe+ltdSARE74+Pz7
         jj8Q==
X-Gm-Message-State: AOUpUlHHC+7hapiRqB7F4C3/Cw+MmlJlqku9rjqXSUOUpPyBPU8fuVMn
        8Lea9VDe7HF0xiPSP7dh9rUSiA==
X-Google-Smtp-Source: AA+uWPwS9wOLlAhC5TANjtztMTWp0blPEyMNm9G1U5TNaGVPffcbdWx1O0QaiexSfGUJpM/Acd4/iA==
X-Received: by 2002:a37:b982:: with SMTP id j124-v6mr35876510qkf.134.1534604924084;
        Sat, 18 Aug 2018 08:08:44 -0700 (PDT)
Received: from localhost ([168.194.163.45])
        by smtp.gmail.com with ESMTPSA id 14-v6sm3286387qty.57.2018.08.18.08.08.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Aug 2018 08:08:43 -0700 (PDT)
Date:   Sat, 18 Aug 2018 12:08:38 -0300
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Subject: Re: [PATCH 4.9 00/15] 4.9.121-stable review
Message-ID: <20180818150838.fkl5wkgu72i2lozp@mobile.celeiro.br>
References: <20180816171625.340082081@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180816171625.340082081@linuxfoundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 08:41:53PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.121 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Aug 18 17:16:11 UTC 2018.
> Anything received after that time might be too late.
> 

Results from Linaro’s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.9.122-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.9.y
git commit: a239ebd443c4cec0db041fbd89ecd4f40738c496
git describe: v4.9.121-2-ga239ebd443c4
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/build/v4.9.121-2-ga239ebd443c4


No regressions (compared to build v4.9.119-112-g1a93cfe68391)


Ran 16231 total tests in the following environments and test suites.

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

AND

Summary
------------------------------------------------------------------------

kernel: 4.9.122
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.9.y
git commit: ea101a702611f987c937a5fafe00f714fd9c1fe8
git describe: v4.9.122
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/build/v4.9.122


No regressions (compared to build v4.9.119-112-g1a93cfe68391)


Ran 12144 total tests in the following environments and test suites.

Environments
--------------
- hi6220-hikey - arm64
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
