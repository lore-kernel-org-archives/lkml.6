Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544E3ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A9E02064D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PUnUXGXP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A9E02064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388197AbeGWXSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 19:18:01 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:42939 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388088AbeGWXSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 19:18:01 -0400
Received: by mail-oi0-f67.google.com with SMTP id n84-v6so3990966oib.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 15:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0vfVOM4S4t2avr4n1OHCiBfnXhUlrbP2x7tUxW2XNNM=;
        b=PUnUXGXPM+GJ7T3bqek2NalKc22otM759n0k1QtUJTqLTUan6hdpc5sDwIMuujYcXg
         GB2rFzhnQcaZlDRBpVJn/HnZJyOV9k9s0js6c4VSb6ARmpekYXdD3MwRUjAFAaxE67yW
         nv7sNbgD8Yi8IetdXCnmqkLWnhnp1wSSJon+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0vfVOM4S4t2avr4n1OHCiBfnXhUlrbP2x7tUxW2XNNM=;
        b=Jx9N8Ft1KFvoQ7fYe17DnMudyBWGajoOwGsNKQP66M1HnT3YBgrlpMl38kOX8O4ndh
         WTqvkAaN2tjNcHr0GG0DuBYZKwZOXRo86dlLI4lBbGMGGu8CSsaChHhOfwLYAp5u+qAI
         jP23ntGHb76AeEQ2d8GXzQq824AOjPC2ZMG+HF2sEmYxaqV2zoQVyWKz8ugGCZec/Ff5
         rkaL0CPnaa5i9zgzuHaxagaW42jc21p8PTRj8WYbH3Jloy0dSvA/EiEMOBifE8h229Dn
         kPVidBHiMDPkok/7/2oufgdD7sO5B0hAVBmzvsbydivUXSfp63rwVYWdA9AlMxg9wkcH
         B3YA==
X-Gm-Message-State: AOUpUlE39zEBHtsm13qy0dRBGt12MFeZbzIySKKJUSaocYKqkwrdMKrQ
        yUu2PsJrEbgJIcp4ItqQBdpjxw==
X-Google-Smtp-Source: AAOMgpdt0syVO5jTDIZSXMpT5XEvfNLzdZviH7MqeJ3LM7eNYzLvgLyBV2sX1C4AeXm1t4tls4/9FA==
X-Received: by 2002:aca:3407:: with SMTP id b7-v6mr626204oia.345.1532384082499;
        Mon, 23 Jul 2018 15:14:42 -0700 (PDT)
Received: from localhost ([2600:3c00::f03c:91ff:fefc:c793])
        by smtp.gmail.com with ESMTPSA id p132-v6sm7891185oia.31.2018.07.23.15.14.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 15:14:41 -0700 (PDT)
Date:   Mon, 23 Jul 2018 22:14:40 +0000
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 000/107] 4.4.144-stable review
Message-ID: <20180723221440.ijksdjtcilwa4cwx@linode.therub.org>
References: <20180723122413.003644357@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180723122413.003644357@linuxfoundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 02:40:54PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.144 release.
> There are 107 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Jul 25 12:23:53 UTC 2018.
> Anything received after that time might be too late.

Results from Linaro’s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.4.144-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.4.y
git commit: 189cc8cb2eefebfa921f0ea038e3190d48559829
git describe: v4.4.143-108-g189cc8cb2eef
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/build/v4.4.143-108-g189cc8cb2eef


No regressions (compared to build v4.4.142-32-g6c3754d773f4)


Ran 12126 total tests in the following environments and test suites.

Environments
--------------
- juno-r2 - arm64
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

kernel: 4.4.144-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.144-rc1-hikey-20180723-241
git commit: 74ff347a1f4bd5b91588a4025bfd29ae7a28329d
git describe: 4.4.144-rc1-hikey-20180723-241
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4-oe/build/4.4.144-rc1-hikey-20180723-241


No regressions (compared to build 4.4.143-rc1-hikey-20180720-238)


Ran 2648 total tests in the following environments and test suites.

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
* ltp-syscalls-tests
* ltp-securebits-tests
* ltp-timers-tests

-- 
Linaro LKFT
https://lkft.linaro.org
