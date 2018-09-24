Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16974C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B272720877
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PG3bC8J6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B272720877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbeIYDKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 23:10:49 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:54383 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbeIYDKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 23:10:48 -0400
Received: by mail-it1-f194.google.com with SMTP id f14-v6so12594907ita.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 14:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jzNcTkTJ+lo4eLSxPDQI7r573NxGYjp2ehmzGbalLaI=;
        b=PG3bC8J6nlQTJSMz05fFM05Kx1Lx/wCIWhsaYPym060YCz8JfTSh1QzZuZYd2pTzQP
         U/JXDglpMH/vQOctzvZmJEGWr7KrNyUZ32XFM9oWDKZZI9r+p4iFKyUvASfFnAsxntU6
         3gLZ5/gDemqmvR1QbMjESke0R0aDjDTk/zIzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=jzNcTkTJ+lo4eLSxPDQI7r573NxGYjp2ehmzGbalLaI=;
        b=tmFrbC3ba7dIM4ZZ53FbXdeS/+CmXRDKV93ZSnYUxNvEcG/u4MjQBb3nrXyoHFOcHw
         ofj6iurlLwcPuIudD3STGi1Tu7N8ooNmVqjK0H5KQABRxODC7iRpYXFfmUUV9sIptIiP
         5s0JOBU0P4eDzafCaXu1h72wnZXza/0mQKUmz8FbNDPuT8JJXuKbtQwrM8cnmUdqkTRS
         22mlDCkbUYtRtSZcFFr4W371rXSgGhA6ickr20Vtpj3knebQaSu1XkTxesPgySBvlP9I
         dETGv6inA7nG+m2ogtDthe2Qid8ZUb4W2hFmT5UJ9HMj/OrDKRmRYDMTrWI0JG98YIQJ
         qK0A==
X-Gm-Message-State: ABuFfogbXQvF1w4BiMf0e/LZuRo7Pub+1dbyDIRG/uYYFT2RVRaxpiCn
        c/G2ROuAuJIbkc3jPc9E+oy+oQ==
X-Google-Smtp-Source: ACcGV63jfzKjeE/zQR3j7mMTQTfU53Le2++US/ebEHSMwx3R/ZBZcdjkFHqCDz/MYrUaHXhe8VSaUQ==
X-Received: by 2002:a24:cb02:: with SMTP id u2-v6mr201077itg.107.1537823200898;
        Mon, 24 Sep 2018 14:06:40 -0700 (PDT)
Received: from localhost (c-107-2-67-121.hsd1.mn.comcast.net. [107.2.67.121])
        by smtp.gmail.com with ESMTPSA id s3-v6sm124066ioo.87.2018.09.24.14.06.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 14:06:39 -0700 (PDT)
Date:   Mon, 24 Sep 2018 16:06:39 -0500
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/70] 4.4.158-stable review
Message-ID: <20180924210639.fvu5rn2tfmpoxvdr@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20180924113058.420454070@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180924113058.420454070@linuxfoundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 01:51:59PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.158 release.
> There are 70 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Sep 26 11:30:25 UTC 2018.
> Anything received after that time might be too late.

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.4.158-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.4.y
git commit: caf273efe9e5a0544c24dfcbc3e887af5aa56657
git describe: v4.4.157-71-gcaf273efe9e5
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/build/v4.4.157-71-gcaf273efe9e5


No regressions (compared to build v4.4.157)


Ran 16823 total tests in the following environments and test suites.

Environments
--------------
- i386
- juno-r2 - arm64
- qemu_arm
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
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

Summary
------------------------------------------------------------------------

kernel: 4.4.158-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.158-rc1-hikey-20180924-290
git commit: 14bb2972eaf3d110a491622f3a3330c440afcb82
git describe: 4.4.158-rc1-hikey-20180924-290
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4-oe/build/4.4.158-rc1-hikey-20180924-290


No regressions (compared to build 4.4.158-rc1-hikey-20180923-289)


Ran 2725 total tests in the following environments and test suites.

Environments
--------------
- hi6220-hikey - arm64
- qemu_arm64

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

-- 
Linaro LKFT
https://lkft.linaro.org
