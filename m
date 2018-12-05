Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09313C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF94620879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="i6F2xwfc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF94620879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbeLEQpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:45:06 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37850 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbeLEQpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:45:06 -0500
Received: by mail-qk1-f196.google.com with SMTP id 131so12237297qkd.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 08:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:subject:to:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IFOB6pgExgVZ1d6kNSaV585E85kE5U4g3ZSs7OgHW/0=;
        b=i6F2xwfcYN46zInR40Ih7M7e8aGbSJzh2AkNYFyf4KWZyDpwWzizATff+kWH6SkNGX
         fcthYfXoac8lDd8kuFHSU/1h6XiyrVvE0mnvwmOm/gHqk5M6Mx8+RT4GfPJA04yn3TGm
         4FykZ3/bAJGN2fD0s6Q720XQgo8d3UYMWlKZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=IFOB6pgExgVZ1d6kNSaV585E85kE5U4g3ZSs7OgHW/0=;
        b=NBOWLWk6eUWkvJnz4/OX+kZQSUjMdMl01EqiBVkvX1Hzc0VgPRo0xkiAuYEttuBLta
         5ObVIkjawtHqotZdIdVF1Urh+WHqSDjTgfAQz7H9zubNwZWU3s8fUckDHbRQpj/N+IjW
         iu5ovGGEzUz3CC7tZs+Z49K+j7nIN4EON7Yi/yPrR0xpaEehPxqG7IqRaPoEYtkDpC5F
         8k/ECdVTNAdjEwY0aNGRNgjQL8hmPdns22H3qChSt5bLZgjKGX1IhEgIC6C8IDAIrreo
         BvXbJgqK7JJ7is4MFOVxk59PxDtStas4hTlhhgVQhJDtvhQEFzgVM4aPlDAt3lwKYtA2
         rfGw==
X-Gm-Message-State: AA+aEWasRS5jyE3rnkjnZIXtPCywXh2F+mcxuEUIs6T4DDN7qi5nbjAC
        FPRz+P9ddHxFrsmaKRXC7rE0Mw==
X-Google-Smtp-Source: AFSGD/Xvg5uvY6fnjHCPKUo+BUE0Vt9Ljl03CZv7bHd2RO9IF3yNWG+93KYQKalA8ByduRgA9Up04Q==
X-Received: by 2002:ae9:ef8a:: with SMTP id d132mr22429822qkg.11.1544028305099;
        Wed, 05 Dec 2018 08:45:05 -0800 (PST)
Received: from [192.168.49.18] ([138.204.25.29])
        by smtp.gmail.com with ESMTPSA id x24sm13500753qtk.70.2018.12.05.08.45.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 08:45:03 -0800 (PST)
Cc:     Rafael David Tinoco <rafael.tinoco@linaro.org>, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Subject: Re: [PATCH 4.19 000/139] 4.19.7-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20181204103649.950154335@linuxfoundation.org>
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
Organization: Linaro
Message-ID: <98b81960-a81b-765a-797f-d59dfd8da8b0@linaro.org>
Date:   Wed, 5 Dec 2018 14:44:59 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/18 8:48 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.7 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Dec  6 10:36:22 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h


Note: As a consequence of the retpoline backport, we upgraded our
toolchain that is used to build the kernel and userspace from 7.0 to
7.3 (containing retpoline support).

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.19.7-rc1
git repo:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.19.y
git commit: 987a6da5152c29e37cc11de9a2d10a23a48015c9
git describe: v4.19.6-140-g987a6da5152c
Test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/build/v4.19.6-140-g987a6da5152c


No Regressions (compared to build v4.19.6)


No Fixes (compared to build v4.19.6)


Ran 20285 total tests in the following environments and test suites.

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
* install-android-platform-tools-r2600
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
