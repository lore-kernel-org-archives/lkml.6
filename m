Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83151ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34914214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V1az7oqm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34914214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbeJQWKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:10:43 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37135 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbeJQWKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:10:43 -0400
Received: by mail-io1-f68.google.com with SMTP id m16-v6so18875766ioj.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 07:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5Ux/Fi7ep7dYg3pEqecG3tdShbwa+jT3j31RNyLErzY=;
        b=V1az7oqmQ8BCna3c5XUv0vSAgKKFN6OnE82wXgXqVTbWWzzwrQM48SyLA3tFo0AvqK
         Pt95JH9i0m3OjdmHeiAtA4N33kwvuc55rGjvTH2rn9/3gSHdKGQH1iOrqZqioxPTFhUh
         9Ujp/kPlhbF5Mc/5Y1rCexDYnC5WgXBKn5zBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=5Ux/Fi7ep7dYg3pEqecG3tdShbwa+jT3j31RNyLErzY=;
        b=P3QAR8rFpnjWDGnyT8cnVsbRir6VtYtYoHLnFtUBfxBRKZvXQINRAVnpbWJwvsjVzz
         RH9FRJ/38e8Y2UoXjsCJEcToHjWG0UcMLrGdavo24HhwI7ZXeJc2icXMWM2VtdNByHsC
         2rSnCrH6GUjO0QLtuS2R1xKUR1B3T2Oja1GjaHCVPNlBM0cM5GRmvEzyy1xfiBQB3ae1
         wHzpvkVD1bthvvflDte4bCwTyjpU7R2JfSAYQLne45vg2KM6HA7oQK8YHLpG7x560Gkk
         9OGzET4Diwh685wP7yKIZsiYvQ4phxYez/Z3nlISriJnDBNEEHthS8aIpzTna8Ft2ZDd
         qpsA==
X-Gm-Message-State: ABuFfojTi8Fgwz/rVzm+wmWaw378RxR2mhK3cOB+PagsfB4BjwUEb4bw
        sv7wuMMRnQLy5SsKks1valEQzg==
X-Google-Smtp-Source: ACcGV61sZUDsOHC9rPi0iPgpw69dyJF2u1NgM7nl6eHoSeqRZY4y6VttNgHsfqy3bP8GVa+XVAwbfw==
X-Received: by 2002:a6b:b20b:: with SMTP id b11-v6mr17027107iof.172.1539785688920;
        Wed, 17 Oct 2018 07:14:48 -0700 (PDT)
Received: from localhost (c-107-2-67-121.hsd1.mn.comcast.net. [107.2.67.121])
        by smtp.gmail.com with ESMTPSA id d75-v6sm916883itc.41.2018.10.17.07.14.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 07:14:47 -0700 (PDT)
Date:   Wed, 17 Oct 2018 09:14:46 -0500
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.18 000/135] 4.18.15-stable review
Message-ID: <20181017141446.ecg2ri5bv26jfozc@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20181016170515.447235311@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 07:03:50PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.18.15 release.
> There are 135 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Oct 18 17:04:43 UTC 2018.
> Anything received after that time might be too late.

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.18.15-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.18.y
git commit: 62569d12d9372bc0c50a04fe8923c47fd89435fc
git describe: v4.18.14-136-g62569d12d937
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.18-oe/build/v4.18.14-136-g62569d12d937


No regressions (compared to build v4.18.14)


No fixes (compared to build v4.18.14)


Ran 21140 total tests in the following environments and test suites.

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
