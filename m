Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26CCC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD6DF21534
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SLiUCdxP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD6DF21534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeHOXZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:25:35 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:33609 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbeHOXZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:25:35 -0400
Received: by mail-it0-f65.google.com with SMTP id d16-v6so18351227itj.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 13:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7uqlqsUlMCTPsPyK6+actzhEIfr9XJtvVtbEUzMfTG0=;
        b=SLiUCdxP52NDeVj1fuiPL4G/cGOeTeuRrNJGO+Ce6FyiJljm9rW6boo9JVrkZmtV6y
         09u9DGAhtsrKYdRdQ1tfqxzoE7y5SySFh8IsUXQiN+/61L8ZwLvM2mmZTYub69E3fLxo
         iG42YUWSWiOo6SvR+G1ekslY2Mi4ASXh3OsyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=7uqlqsUlMCTPsPyK6+actzhEIfr9XJtvVtbEUzMfTG0=;
        b=n9qkpmygMlH23z03HNxjP8L9tTT70kvrvzDkUWPQv3tZPBe/UgepVmMYSV2qt4dWO3
         DQH/hphirrmNTPaqM96/WMfSCwEAZSEyW9RRD+JrpVk/tZd38/p/K4FqyJ1ifRhlFTfx
         BzfpqxRm3UmCm1ElaEPp/PGYXcbIR5r6tDTj4iDTQrJTgl5EJk3DjQ5GoXZCQpxYhmc2
         4QNS1/aEgaR6FrrpRWHx35urnp+Shp+79gQx5HK6Pzexp+KnyjpUvw3lK3D5RokvaeRo
         SmRecsnED6gDaQ/c9yHU2ESeRzRymffIgKkkTjQj1TauRpRX4De5zP8xvMJi7aA27WT5
         HiWw==
X-Gm-Message-State: AOUpUlFh8XJ0p2gnkc6g1gyGowdvXrOfJeiu2uU4RSeSpPhye1hPqRci
        UWAQ+R5qNw45zqP9W5W22FmWdFwFyyo=
X-Google-Smtp-Source: AA+uWPzws/pzGUrteCi/LJEbPkmbm0lN6pqSF9Q9h/1sLWHdbs7dnAaPuNcIIg/A8gnMg518qfPDTQ==
X-Received: by 2002:a24:120a:: with SMTP id 10-v6mr19301304itp.35.1534365112359;
        Wed, 15 Aug 2018 13:31:52 -0700 (PDT)
Received: from localhost (c-68-47-89-210.hsd1.mn.comcast.net. [68.47.89.210])
        by smtp.gmail.com with ESMTPSA id b3-v6sm987151itj.32.2018.08.15.13.31.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 13:31:51 -0700 (PDT)
Date:   Wed, 15 Aug 2018 15:31:51 -0500
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.17 00/97] 4.17.15-stable review
Message-ID: <20180815203151.m7m7haaeg5wxc4af@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20180814171433.160434170@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180814171433.160434170@linuxfoundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 07:16:12PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.17.15 release.
> There are 97 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Aug 16 17:14:15 UTC 2018.
> Anything received after that time might be too late.

4.17 looks good. I included -rc2 and -rc3 partial results below - both
have been manually reviewed based on the data that we have so far.

Results from Linaro’s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.17.15-rc3
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.17.y
git commit: 8164cbf5064ab1b6558a90a6573023b1aaa0c0ae
git describe: v4.17.14-102-g8164cbf5064a
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.17-oe/build/v4.17.14-102-g8164cbf5064a


No regressions (compared to build v4.17.14)


Ran 2040 total tests in the following environments and test suites.

Environments
--------------
- qemu_arm
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

-- 
Linaro LKFT
https://lkft.linaro.org


Results from Linaro’s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.17.15-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.17.y
git commit: 2293fe70092e6b788833a9d7e12327b8bc66fa07
git describe: v4.17.14-101-g2293fe70092e
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.17-oe/build/v4.17.14-101-g2293fe70092e


No regressions (compared to build v4.17.14)


Ran 11122 total tests in the following environments and test suites.

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

-- 
Linaro LKFT
https://lkft.linaro.org
