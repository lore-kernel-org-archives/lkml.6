Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA195C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 00:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FEFF214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 00:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="krnKQ8ih"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FEFF214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbeIZGjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 02:39:07 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:55180 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbeIZGjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 02:39:07 -0400
Received: by mail-it1-f195.google.com with SMTP id f14-v6so641752ita.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 17:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bJUaOZKg72c4OAC3WLSUlx/EPfde1niexsdVqsFxDY8=;
        b=krnKQ8ihq1gXjFn/MONzq57+Gc1n2eCbsslOy3xc54c6queKEq0TFqHg2canusFgCe
         Abra1z/RIE37eowR3hrp/3mjkusfyqTjLOURJo1H9Amk900D7luTxrcIyCUzJGewaQm/
         LB9oiu8Qal2DdV7dz9rWEmDi91o5YK1fATck4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=bJUaOZKg72c4OAC3WLSUlx/EPfde1niexsdVqsFxDY8=;
        b=QT0K6/JecupfobIOqauHSZN7A6yHHqYGw3rkUlighyixPLP4CX8xldhCJIRT1F4oua
         lz+IQTZJqfKDxF4IgMwN27Zen827TRYz5KtJCMQh7xuWCAvHvc8zAG6hT2bIoIdqLodK
         In4Pdgo0k6A2IkZ/rVk2xDrsmSzx6WWttyekfv6ITmKMfFEYeQcne+r6ix+cHaUg2Aja
         o/kDttuvYXJO0ovr1lDP0kesfq3ULKJFOy2hZFXJz3L+tvSJR/g9dXVZLwzPOpLoacOc
         ueY+kMKD+Lx2kyKh2Jlu8B1N6EoNDYEFAMgxowH2oLTtE3SsiZHm5McCkBJtDA6APW3E
         xvsQ==
X-Gm-Message-State: ABuFfohtxcKoowsfZVt1zWLBPT2Y2MUOntWb0zM3Qjn1ThVcskOLrwDs
        rkU2Cncb09Dl0beHLjKULtlPXW0sgkE=
X-Google-Smtp-Source: ACcGV62xsxoTFw6fcxNxBJjVQPyP7c8vvpLKR4v1vUo2kZnjnlDDv0WB2q6x+CUNqgUo4kGGE8IzkA==
X-Received: by 2002:a24:7012:: with SMTP id f18-v6mr3008375itc.87.1537921739760;
        Tue, 25 Sep 2018 17:28:59 -0700 (PDT)
Received: from localhost (c-107-2-67-121.hsd1.mn.comcast.net. [107.2.67.121])
        by smtp.gmail.com with ESMTPSA id a63-v6sm2192605itc.38.2018.09.25.17.28.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 17:28:58 -0700 (PDT)
Date:   Tue, 25 Sep 2018 19:28:57 -0500
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/173] 4.14.72-stable review
Message-ID: <20180926002857.ajqqxi2qcfcwsg7g@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20180924113114.334025954@linuxfoundation.org>
 <20180925090733.GB21224@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180925090733.GB21224@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 11:07:33AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Sep 24, 2018 at 01:50:34PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.14.72 release.
> > There are 173 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Sep 26 11:30:10 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.72-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> > and the diffstat can be found below.
> 
> -rc2 is out to resolve some reported problems:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.72-rc2.gz

-rc2 looks good. There is a problem on dragonboard during boot that was
introduced in v4.14.71 that I didn't notice last week. We'll bisect it
and report back later this week. dragonboard on the other branches (4.9,
4.18, mainline) looks fine.

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.14.72-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.14.y
git commit: a514b8f4ac33c076ad63ba833cdc3325d8c2e7fc
git describe: v4.14.71-171-ga514b8f4ac33
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/build/v4.14.71-171-ga514b8f4ac33

No regressions (compared to build v4.14.71)
------------------------------------------------------------------------

Ran 18749 total tests in the following environments and test suites.

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
* ltp-filecaps-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

-- 
Linaro LKFT
https://lkft.linaro.org
