Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639E6C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BED821782
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rvjbn1U5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BED821782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbeHRSi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 14:38:56 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:42312 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbeHRSi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 14:38:56 -0400
Received: by mail-qt0-f182.google.com with SMTP id z8-v6so11938856qto.9
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 08:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=n0lvPViChPvFfQ0u4b0Xse2xtupYJ4Ls55b95kOm+Co=;
        b=Rvjbn1U55/iG1MZrsdMQklfMyIHDroDeaUp15VzmgCQpAkviu4UDdP0O9tWJ9qfVJs
         NbHf0fM0iZ/Ws0qPReRmI89q9e53Yt5Jf1AK9NIyFGFZJaTijD6m0RMCshD7882rfxb6
         ClGdqJP0HdjCWAL2rMFFqCcsvpijRy2G4oaD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=n0lvPViChPvFfQ0u4b0Xse2xtupYJ4Ls55b95kOm+Co=;
        b=h+eRdWJmVF/GRHCLf3vvODmrx8PG8WK2NFrB1ViSzXcrHilcDoffLeJfgFxfW97MvG
         a7U3KCjwbIV2ZLX2kUNMlQIB6LPIFgPvTVWsFKdjWIeRT+t0hB8tjRwU/NnRSs63Syee
         zb04TUY6fMcJDnfFAJt1OejpfPs1fm2CzAtVTgAKVA9UL5vYZJxlnjEq8FfWPrwc17+2
         O9rSXUq/MzdzEoBkei28f2hQNlDKteX8Wnh8P/wjBP6/HZqytjPwvyvspyh3JQRAs0Wc
         oB8ZZSNeGlZqYoMfrluHjq0P5SnmstPfXqA/JzHB8ubNzF1CnUX9PQL1ynQ82yyM/yAN
         jbSw==
X-Gm-Message-State: AOUpUlHZAUlvG3NYLHewWDD6pWvRPFEG8aj0Wgizyzw4QF/E7dzluhEY
        ei6CpLg1C2BfWZEZDC9sCHGO/w==
X-Google-Smtp-Source: AA+uWPwBpvMhBDzmZpYIGHf//6Gxqo0mrUP8RkGRZhfcYaTvOX+CtH+nCvp6LZ1iLUNmcf5roRpsHQ==
X-Received: by 2002:a0c:b3d4:: with SMTP id b20-v6mr34994644qvf.141.1534606250510;
        Sat, 18 Aug 2018 08:30:50 -0700 (PDT)
Received: from localhost ([168.194.163.45])
        by smtp.gmail.com with ESMTPSA id v1-v6sm3078260qtg.7.2018.08.18.08.30.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Aug 2018 08:30:49 -0700 (PDT)
Date:   Sat, 18 Aug 2018 12:30:47 -0300
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Subject: Re: [PATCH 4.4 00/13] 4.4.149-stable review
Message-ID: <20180818153047.wzsx6hogdxfuik2c@mobile.celeiro.br>
References: <20180816171628.554317013@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180816171628.554317013@linuxfoundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 08:41:47PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.149 release.
> There are 13 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Aug 18 17:16:16 UTC 2018.
> Anything received after that time might be too late.
> 

Results from Linaro’s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.4.150
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.4.y
git commit: 7dc18ebc3101229d5238a2dc740804cd4836b383
git describe: v4.4.150
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/build/v4.4.150


No regressions (compared to build v4.4.148-14-g23871eab85a2)


Ran 5943 total tests in the following environments and test suites.

Environments
--------------
- qemu_arm
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

Summary
------------------------------------------------------------------------

kernel: 4.4.150-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.150-rc1-hikey-20180817-261
git commit: dc7326348e08ce8a119ce1d545db4258a0313264
git describe: 4.4.150-rc1-hikey-20180817-261
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4-oe/build/4.4.150-rc1-hikey-20180817-261


No regressions (compared to build 4.4.149-rc1-hikey-20180816-260)


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
