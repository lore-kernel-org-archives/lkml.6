Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EC8C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 14:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE7621757
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 14:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QUy3BSX9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DE7621757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbeHRR3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 13:29:03 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:37393 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbeHRR3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 13:29:02 -0400
Received: by mail-qk0-f196.google.com with SMTP id f17-v6so872983qkh.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 07:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=TGbwkzQdKggQUrJmzYrFNX9HHDLwDEXKastxfiQkA6U=;
        b=QUy3BSX9RLbCg2uZQwxJT5EsXdD+44auifPff6hRd81ycOMci2e35kL6Miujow7yNc
         F63+dPOWaOkjsm84DnP2GpYNUwF3pObqg9107ACBVfCtpzUULloumSlPw8+TOxfIb/SJ
         pGV94Y/X/XUi09BAcL9Ge/a9Csw2Le6/0Py+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TGbwkzQdKggQUrJmzYrFNX9HHDLwDEXKastxfiQkA6U=;
        b=UBoC1ufwcR/xp8Z4Cu3+cl+vy0/JCSUaLuvem2sJC6Arc4x9LdEMpld4M3TOKyVF43
         PwYwIxf03pumnsu2KKdizBBLNWNeApE4AJgSw4bVqZQiYIOyEJ1EpcedotQztz7m5JFB
         SqNreMH7/nfMgWNClSt9uERB5Bovb145nDl+yCigRu5JUGg4dN68NpSXqAIkP/ISjgDJ
         cmfdBGEHhsyTD2MhEvN6Cz4/IBCnUqEMJZiRQ5Tq8DxHJudTq9qaKlQGYQOLDYahoMx/
         RDCgUGkUEQMvHo4R+rMQt91bKcbX3LFhFGrJAYNVbtexJOpasMLLMb/7DTPP+Q4l/LQJ
         vTsg==
X-Gm-Message-State: AOUpUlFPVK4W3TqcJGa3PGHrhpVLIcR8zXNeBpe+S1o5bFioyelme/S3
        unA1aO64/7maUIPjU+iHMbovHQ==
X-Google-Smtp-Source: AA+uWPwi79V0EIyzFmF+7elkW1b798+B2bquj33PYlYMwy3lG0J1yRbgVkO/ZIr8Ft/wTFxWgK3O4Q==
X-Received: by 2002:a37:6f84:: with SMTP id k126-v6mr34565045qkc.342.1534602070163;
        Sat, 18 Aug 2018 07:21:10 -0700 (PDT)
Received: from localhost ([168.194.163.45])
        by smtp.gmail.com with ESMTPSA id f2-v6sm2579410qkm.51.2018.08.18.07.21.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Aug 2018 07:21:09 -0700 (PDT)
Date:   Sat, 18 Aug 2018 11:21:07 -0300
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Subject: Re: [PATCH 4.18 00/22] 4.18.2-stable review
Message-ID: <20180818142107.kaob63iv6kpd3vtn@mobile.celeiro.br>
References: <20180816171556.502583508@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180816171556.502583508@linuxfoundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 08:45:16PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.18.2 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Aug 18 17:15:44 UTC 2018.
> Anything received after that time might be too late.
> 

Results from Linaro’s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.18.3-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.18.y
git commit: d86e34a614bfd8fa7278945932dd87f18510611f
git describe: v4.18.2-2-gd86e34a614bf
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.18-oe/build/v4.18.2-2-gd86e34a614bf


No regressions (compared to build v4.18.1)


Ran 14019 total tests in the following environments and test suites.

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

kernel: 4.18.3
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.18.y
git commit: 8a8c540db3ff1968317759961c0230221882367d
git describe: v4.18.3
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.18-oe/build/v4.18.3


No regressions (compared to build v4.18.1)


Ran 12427 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- qemu_arm
- qemu_arm64
- qemu_x86_64
- x15 - arm
- x86_64

Test Suites
-----------
* boot
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
* kselftest
* libhugetlbfs
* ltp-syscalls-tests
* ltp-timers-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

-- 
Linaro LKFT
https://lkft.linaro.org
