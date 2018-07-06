Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC94FC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D8121992
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="by17vxbU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D8121992
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934201AbeGFRvd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:51:33 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:46896 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934006AbeGFRv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:51:29 -0400
Received: by mail-ua0-f193.google.com with SMTP id r18-v6so8035898ual.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 10:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=W0tCRz+0A4bjRkrKy0bCtDxGtTrH+CTQwDAKU4Za40A=;
        b=by17vxbU9bgPE+z2MPIjsadGbSsjJD1A+P8sxLVBBUC6GvJxypjcsKV70x6r3NVlUm
         BZZ3JvPrCqq+b8paUMZLRCPYXaDEh3zpBIqq3tWdRtErExJRiSqdPA2vDD6NWm8ZArLE
         HyuY5nBFj6npzNHimExzATjLs01X37HasvpMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=W0tCRz+0A4bjRkrKy0bCtDxGtTrH+CTQwDAKU4Za40A=;
        b=BZEuvwM63CSV3v8JzrF1NtzARQAA3MZ5vFScHRPI6CKwHyK4IdCI5QP8KQY4J/K8LK
         r6wd4X/Hg86MQF941LNkXZqZC8zedEe4NklP2oIJfxCIYiluUwEQP1MbfzAf5tU4mgEh
         FKdduKiMwuWgdFjqpNrY1KHP4Bb+0yLvU//BXjC7V9IFjwElm77L9bJTtlsrxGiJgZxv
         LhEzFStKxLJFNZbWfROaEYQgfyDwt7Mr5SB0AdG2W/VLIirW4tZB8stT58IpLPXfyJyf
         dTy1CgSwxhOLIIkJSDqTDbUezHcTipzisqI99kYbjwz+cCuA9ik+u2xr+Y1xbwmVC2Fx
         QDGA==
X-Gm-Message-State: APt69E09/S0EiO1bNEIrZYrJ4UrzeKf0kytYYjKit+I60iSPA0D9Iczz
        OQpdFR5bRdX/RfpAIb7VX9cM7w==
X-Google-Smtp-Source: AAOMgpet43wh86v6M3a/DhJV2ksFJ3gUkvsCDSKfcT5S8/6TWelJk4fo5cgftKJPOnfjdM7WjUtXFw==
X-Received: by 2002:ab0:16dc:: with SMTP id g28-v6mr6745008uaf.7.1530899488474;
        Fri, 06 Jul 2018 10:51:28 -0700 (PDT)
Received: from localhost ([201.205.46.105])
        by smtp.gmail.com with ESMTPSA id q45-v6sm1120498uad.53.2018.07.06.10.51.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 10:51:27 -0700 (PDT)
Date:   Fri, 6 Jul 2018 11:51:24 -0600
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.17 00/46] 4.17.5-stable review
Message-ID: <20180706175124.4l7zf5wxzwnwxcsy@xps>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20180706054524.595521988@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180706054524.595521988@linuxfoundation.org>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 07:46:21AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.17.5 release.
> There are 46 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Results from Linaro’s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.17.5-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.17.y
git commit: 211fe6663749212887c5d36f2e483acfb831377b
git describe: v4.17.4-47-g211fe6663749
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.17-oe/build/v4.17.4-47-g211fe6663749

No regressions (compared to build v4.17.4-47-gd0d428d64248)

Ran 16369 total tests in the following environments and test suites.

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
* kselftest
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

-- 
Linaro LKFT
https://lkft.linaro.org
