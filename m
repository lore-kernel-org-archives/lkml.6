Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EDEC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 14:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E1EE217BB
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 14:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cf6xeqCR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E1EE217BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbeHRRog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 13:44:36 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:42027 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbeHRRog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 13:44:36 -0400
Received: by mail-qt0-f195.google.com with SMTP id z8-v6so11833057qto.9
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 07:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7D4owSONQWG8fVL91HwU5Lw7hoCCp2DtQoekNrrECDY=;
        b=Cf6xeqCRTRBSA0IQcBwJPXI4UHLWzZ4AKDbnzjR9pvLXhuaGYS9qGuWjAD/3HSQDUU
         S73zAAHpsFq2mEbzhsNwa8+JNCrEHdFMb29ydj1CoFfOvp6heCKpPeKJGCZWSzNuENK0
         jklNDruKZ3B0YFQ2i4R++i0iN7ZRkeWc7IWuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7D4owSONQWG8fVL91HwU5Lw7hoCCp2DtQoekNrrECDY=;
        b=Wc9+tFQj8VOxvFoYabMlVS8GQaPloZLRRQp3Mic8Tyea0LYW95DNVyW2ALEwrmn/Yy
         LoXf01xDm+GWUVegclpeo9nceobu/xU4/v/IKdZRaLS7uOFTcDjkNGlLDScrlXmeUYch
         A3HvzRXaKyW+XV+I1rvXkWwBgCysGMdWAyNatfQs98JHDyHBSpoL/hb9IKgF8GJraXa2
         8q9z2SnmcvrQCQJ5a35bDCPrR2UywtKU+teuyo1EjokuzKPjfM7mEMEeMB5qGkqfXVZb
         WkjCCB4AV6CIhjWymzn+JobEpRHU4B1L0jBIm3u9MyVhkvtahmzg533QtGAI+RlvQIrf
         LqGQ==
X-Gm-Message-State: AOUpUlHD2u3J3mCJ6FlYbYv6BZfWg7bUveUshA31gh7mIUjQRMf9Bi2w
        Gpuk6PoahmdARK9EyOZ4fzvgsQ==
X-Google-Smtp-Source: AA+uWPz5lRiosIbig2vs4XbP7cQlsZtPDtqoj7YufbESmRBSuHiL6rX+csmXVR+p6y7+gyxOh6RIOg==
X-Received: by 2002:ac8:302e:: with SMTP id f43-v6mr37952463qte.217.1534603000338;
        Sat, 18 Aug 2018 07:36:40 -0700 (PDT)
Received: from localhost ([168.194.163.45])
        by smtp.gmail.com with ESMTPSA id m51-v6sm3283076qtc.85.2018.08.18.07.36.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Aug 2018 07:36:39 -0700 (PDT)
Date:   Sat, 18 Aug 2018 11:36:37 -0300
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Subject: Re: [PATCH 4.14 00/22] 4.14.64-stable review
Message-ID: <20180818143637.kpejgcpkqxiryce7@mobile.celeiro.br>
References: <20180816171622.831964729@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180816171622.831964729@linuxfoundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 08:45:01PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.64 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Aug 18 17:16:07 UTC 2018.
> Anything received after that time might be too late.
> 

Results from Linaro’s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.14.65
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.14.y
git commit: 4cea13b66144903ae7310331b43e08f7b2d6aadb
git describe: v4.14.65
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/build/v4.14.65


No regressions (compared to build v4.14.62-110-gaff06b616b3c)


Ran 8890 total tests in the following environments and test suites.

Environments
--------------
- hi6220-hikey - arm64
- qemu_arm
- qemu_arm64
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

--
Linaro LKFT
https://lkft.linaro.org
