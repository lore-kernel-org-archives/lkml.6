Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8B6C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3057220C0B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dLUES0qX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3057220C0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390003AbeGKUSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:18:53 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:39640 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389095AbeGKUSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:18:53 -0400
Received: by mail-oi0-f65.google.com with SMTP id d189-v6so51563482oib.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 13:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=o2RNXyovajhJYRkkTUKGJHhBx9H2zREocUDLtG2A8qI=;
        b=dLUES0qXarbU9XK/i+LM8W/2H/9jCKNFZP9MAqmVWDLSwyu4um11wCw36af/1JgnEH
         eiDnW0HC3epPHmioALa5Q4XPZJxX/1OtcVQTZgIQK7/s6WdSjxfaZqIrjDcHE0i0xBZ+
         r1yjj+lI+6d7B8wkXmHUzGREQ99JdPXHFP/5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=o2RNXyovajhJYRkkTUKGJHhBx9H2zREocUDLtG2A8qI=;
        b=gQbYqrm9tp7nDmjWyklEa+6cHET9o6A6Jv3sHuLbN5xH317jcQRH3ZuG4eRIXwIiZA
         6TrTCe06Mgj+NbPiZQATcnMW0SlxZHf2SWDO6nvlYictmobpK/EAOxAp3XpF8FnMgW5A
         Vew9iQseCik7qWJY2oI5VjxqdKcb8wv9mftbzDx7e4XPsaNwGk6mot90GS3LDx09nXI9
         s25cXYRCQIN2AI0zZK53m9C0pRhp6yrKZ1KjSbw9zdENWPzyCyiQSDbUi3UBPwwYnJHf
         1lXhbyrDRSoyJztZfYPDQNJ2xczMkEGierXhfY8KmB80fdcLyMLijZtfZ89m67aZxFAi
         lEIA==
X-Gm-Message-State: AOUpUlFAo96Q78XhZdcalav5Ihrp0QmyPtm0olSToVBTG3oblUGk7Mgh
        9imyOfLqpno5a1ZoRAjBv8i6+A==
X-Google-Smtp-Source: AAOMgpdEJCrMnIzdv88bUzPTfeJ2OBEc7HfYca7XbMwrGgDrCewJcsptSFkhmuQgv8x2oHP9rWFz2g==
X-Received: by 2002:aca:5003:: with SMTP id e3-v6mr104513oib.89.1531339974218;
        Wed, 11 Jul 2018 13:12:54 -0700 (PDT)
Received: from localhost ([2600:3c00::f03c:91ff:fefc:c793])
        by smtp.gmail.com with ESMTPSA id h9-v6sm18708542oic.1.2018.07.11.13.12.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 13:12:53 -0700 (PDT)
Date:   Wed, 11 Jul 2018 20:12:52 +0000
From:   Dan Rue <dan.rue@linaro.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Subject: Re: [PATCH 4.9 00/52] 4.9.112-stable review
Message-ID: <20180711201252.jhkojtuvscwpqsb2@linode.therub.org>
References: <20180710182449.285532226@linuxfoundation.org>
 <CA+G9fYuXPJ3v9ua3UiN9ydF=WoxBj7qE2mcxaHZVyooMYk51MA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYuXPJ3v9ua3UiN9ydF=WoxBj7qE2mcxaHZVyooMYk51MA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 04:47:35PM +0530, Naresh Kamboju wrote:
> On 10 July 2018 at 23:54, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > This is the start of the stable review cycle for the 4.9.112 release.
> > There are 52 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu Jul 12 18:24:30 UTC 2018.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.112-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm and x86_64.

Additionally, I've verified that "ethtool --phy-statistics eth0" no
longer causes a NULL pointer dereference as a result of patch "net: phy:
micrel: fix crash when statistic requested for KSZ9031 phy"

https://bugs.linaro.org/show_bug.cgi?id=3762

Dan

> 
> Summary
> ------------------------------------------------------------------------
> 
> kernel: 4.9.112-rc1
> git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> git branch: linux-4.9.y
> git commit: 74d7eea2e72c5481ba8b578cfa663c117ab7f23b
> git describe: v4.9.111-53-g74d7eea2e72c
> Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/build/v4.9.111-53-g74d7eea2e72c
> 
> 
> No regressions (compared to build v4.9.111-52-g0d73d5427339)
> 
> 
> Ran 16283 total tests in the following environments and test suites.
> 
> Environments
> --------------
> - dragonboard-410c - arm64
> - hi6220-hikey - arm64
> - juno-r2 - arm64
> - qemu_arm
> - qemu_arm64
> - qemu_x86_64
> - x15 - arm
> - x86_64
> 
> Test Suites
> -----------
> * boot
> * kselftest
> * libhugetlbfs
> * ltp-cap_bounds-tests
> * ltp-containers-tests
> * ltp-cve-tests
> * ltp-fcntl-locktests-tests
> * ltp-filecaps-tests
> * ltp-fs-tests
> * ltp-fs_bind-tests
> * ltp-fs_perms_simple-tests
> * ltp-fsx-tests
> * ltp-hugetlb-tests
> * ltp-io-tests
> * ltp-ipc-tests
> * ltp-math-tests
> * ltp-nptl-tests
> * ltp-pty-tests
> * ltp-sched-tests
> * ltp-securebits-tests
> * ltp-syscalls-tests
> * ltp-timers-tests
> * ltp-open-posix-tests
> * kselftest-vsyscall-mode-native
> * kselftest-vsyscall-mode-none
> 
> -- 
> Linaro LKFT
> https://lkft.linaro.org
