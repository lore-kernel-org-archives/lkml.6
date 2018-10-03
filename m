Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8C6C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F8521470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CxSBqWbd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94F8521470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbeJDCso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 22:48:44 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39944 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbeJDCso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 22:48:44 -0400
Received: by mail-io1-f68.google.com with SMTP id w16-v6so6059212iom.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 12:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ftBi7uE6RfpTBnDBTIFY8qW3+dgoaovYMFLV/Uj+ztw=;
        b=CxSBqWbdgcuwgLZAXnt6hAwubB+l41OKm9byEm43Yz+pB+3MsCvGOK8QyMUyAktNRq
         dnCm0WmVz97OtGKH1XYu+MLXXuVQ8+QPDte4yIeNT7a2BFlsjz42EOR1G8FmmNoNrhT1
         QYFE1gv+u2b9t5NWdPE47xTACJq+DICQiSQX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ftBi7uE6RfpTBnDBTIFY8qW3+dgoaovYMFLV/Uj+ztw=;
        b=QaiJpr7uyx/stryBNUBiZqqk9uOE9jNUOy/uglODBzEkPxN55pVapW4vcECIVetP0V
         /TVU9KmL2pOdSfKRIOjsk4vLVXWg2UHH+sAf3mLw5XLBSoxjQnSGZMw0fErcWy8oRzYN
         KDDZerxtHzbP3HKyBiuHr3YqeJwTXkCP1AIfNm74USHDOhv4kxF/PW3EDDNdjtQWnpHX
         wUVs0NzSLQav8nOHButJH6kwBLayoycpnzbAZmEEjeebX1hpk+b0GfLnCzwBoMeEIaKL
         +J/d3vTcPLKDSxgYfBE926/FtSqmeytmsxrd8zCkNNYYy3DDKAczeFK0QkUzegB4np+R
         pzGg==
X-Gm-Message-State: ABuFfohn/BO+sJn6YeiweiDV1nBE+kJ6rSgBvk7RpdS3SluwrUSxtHVy
        6TElRdGznsogrWAad639bQGiYg==
X-Google-Smtp-Source: ACcGV61zPHC0isxmQQPhKe84T2KV68FlNFqIr8qj5mZqyGcExfWimk8cKXbkz87sk5+zWXpMMwjdJw==
X-Received: by 2002:a5e:cb48:: with SMTP id h8-v6mr2268346iok.178.1538596732765;
        Wed, 03 Oct 2018 12:58:52 -0700 (PDT)
Received: from localhost (c-107-2-67-121.hsd1.mn.comcast.net. [107.2.67.121])
        by smtp.gmail.com with ESMTPSA id m47-v6sm1014045iti.1.2018.10.03.12.58.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 12:58:51 -0700 (PDT)
Date:   Wed, 3 Oct 2018 14:58:50 -0500
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Subject: Re: [PATCH 4.18 000/228] 4.18.12-stable review
Message-ID: <20181003195850.f4x22bgjss4jd4f5@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
References: <20181002132459.032960735@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 06:21:37AM -0700, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.18.12 release.
> There are 228 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Oct  4 13:24:08 UTC 2018.
> Anything received after that time might be too late.

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.18.12-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.18.y
git commit: e894b754af73d0948e34f61e6070f2d9407a4f98
git describe: v4.18.11-230-ge894b754af73
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.18-oe/build/v4.18.11-230-ge894b754af73

No regressions (compared to build v4.18.11)
------------------------------------------------------------------------

Ran 20361 total tests in the following environments and test suites.

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
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* ltp-math-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

-- 
Linaro LKFT
https://lkft.linaro.org
