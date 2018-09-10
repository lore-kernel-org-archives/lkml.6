Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B237CC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2996B204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kl/BB25Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2996B204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbeIJHMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 03:12:15 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46996 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbeIJHMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 03:12:14 -0400
Received: by mail-io1-f67.google.com with SMTP id y12-v6so5774022ioj.13
        for <linux-kernel@vger.kernel.org>; Sun, 09 Sep 2018 19:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=yBPoCWz92CFbV3dAMOh939v4SdK25anjaBP00H8PqKE=;
        b=Kl/BB25QTgLl0iYkTCLNNUmX17uIL/hUBX33PxM7a4WILkwXFnp1jFfOZt0bkn3xTy
         I/zgF9b3nfFXamUdncqfeMf9QiRZ2sR2tJcCv5R59iYTzYZLBM5K2lx4V/KLOwaKCKJD
         xafc81xF7TySpFNtRk7SZFhrmrQfeRtq11Xr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=yBPoCWz92CFbV3dAMOh939v4SdK25anjaBP00H8PqKE=;
        b=FurRT1U6fp6md1I0MeaIh9lXNhg1CszTbqm5s8AlkFPx30Lzh1g9xsuL0cPotx2SX0
         1yqtKAoHY4xga0egjTSfmQtYIKYoz1AI5ZJeq5twLi9HGEQED+HKAgnFgSAco5nzke4Q
         z53OFEGO4Om4WShv/gH+OjL7Ej+DVmMA4/3CDSiIQBZGbeb+I+mzVMGHS7ut8yRB02mO
         lD4Pjrmvaz6XVNg0sWHskECVXba1qtavVd1sr/rXvxa+yk0s09Cray5PTwA20uFJCTfD
         YOgQtFGcJqyNs8oV7DzNb23K8nsCR1Cs319nu3WyA9kep++7urbf9fJC2Om94FybPI2L
         4KWw==
X-Gm-Message-State: APzg51CLmBnilvQ36i/MEQWmzfHUzz9cP4jjpUiSbZzG7Eqf9pm72Xo3
        C8PZ9OxmDqbSLQzfT24Hp65I9HjbEd0=
X-Google-Smtp-Source: ANB0VdYSrhGrVajby1viLwgfnqiEV7ixzgJ8nH2ekXmpCuwR78tntzyXXMf1zncS1CysoKVN6klcMw==
X-Received: by 2002:a6b:b583:: with SMTP id e125-v6mr3590579iof.201.1536542825289;
        Sun, 09 Sep 2018 18:27:05 -0700 (PDT)
Received: from localhost (c-107-2-67-121.hsd1.mn.comcast.net. [107.2.67.121])
        by smtp.gmail.com with ESMTPSA id 14-v6sm6793620itu.20.2018.09.09.18.27.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Sep 2018 18:27:04 -0700 (PDT)
Date:   Sun, 9 Sep 2018 20:27:04 -0500
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Subject: Re: [PATCH 4.4 00/47] 4.4.155-stable review
Message-ID: <20180910012704.tmra75wxchcqbe32@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>, Shuah Khan <shuah@kernel.org>,
        patches@kernelci.org, Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
References: <20180907210904.607934824@linuxfoundation.org>
 <CA+G9fYsuVwSd2V=Na9YJT68nGHsA4f9qbPUZOFbn9OecBNM9qw@mail.gmail.com>
 <20180909091703.GD4195@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180909091703.GD4195@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 09, 2018 at 11:17:03AM +0200, Greg Kroah-Hartman wrote:
> On Sun, Sep 09, 2018 at 10:22:27AM +0530, Naresh Kamboju wrote:
> > On 8 September 2018 at 02:39, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > This is the start of the stable review cycle for the 4.4.155 release.
> > > There are 47 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Sun Sep  9 21:08:44 UTC 2018.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.155-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> > >
> > > -------------
> > > Pseudo-Shortlog of commits:
> > >
> > > Jann Horn <jannh@google.com>
> > >     userns: move user access out of the mutex
> > 
> > Results from Linaro’s test farm.
> > Regressions on arm64, arm, x86_64 and i386.
> > LTP containers tests
> > 
> > Test cases: userns02/03/06/07 failed on all devices.
> > 
> > LTP: user_namespace2 1 TBROK : safe_macros.c:452: userns02.c:95:
> > write(6,0x7ffc133113d0,18446744073709551615) failed: errno=EFAULT(14):
> > Bad address
> > 
> > Other bug from kernel selftests,
> > mount_run_tests.sh bugs needs to be investigated.
> > 
> > selftests: mount_run_tests.sh [FAIL]
> > write to /proc/self/uid_map failed: Bad address
> 
> -rc3 is pushed out now with, hopefully, the fix for this.

Looks good. The issues we saw in -rc1 in kselftest/mount_run_tests.sh and
ltp/userns* have been resolved in -rc3. The "regressions" flagged below in the
report are known intermittent failures, unrelated to the content of this
release.

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.4.155-rc3
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.4.y
git commit: f4777549b6b8529d14ec8d0735ae16a75a576d0c
git describe: v4.4.154-48-gf4777549b6b8
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/build/v4.4.154-48-gf4777549b6b8

Regressions (compared to build v4.4.153-81-gc9eed05cd5dd)
------------------------------------------------------------------------

i386:
  ltp-open-posix-tests:
    * clock_settime_8-1

    * test src: git://github.com/linux-test-project/ltp.git
  ltp-syscalls-tests:
    * fcntl36
    * runltp_syscalls

    * test src: git://github.com/linux-test-project/ltp.git



Ran 16810 total tests in the following environments and test suites.

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

kernel: 4.4.155-rc3
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.155-rc3-hikey-20180909-278
git commit: 5cfd2cd505263e1e94e7d97e3b348dcd9f5e893b
git describe: 4.4.155-rc3-hikey-20180909-278
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4-oe/build/4.4.155-rc3-hikey-20180909-278


No regressions (compared to build v4.4.153-81-gc9eed05cd5dd)


Ran 2724 total tests in the following environments and test suites.

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
