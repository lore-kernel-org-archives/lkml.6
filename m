Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC84C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96DE620CAA
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sz17VyZ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96DE620CAA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934639AbeGFRyP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:54:15 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:37863 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933964AbeGFRyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:54:13 -0400
Received: by mail-vk0-f65.google.com with SMTP id h22-v6so7273894vke.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 10:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=r2kxLHbqcw2a1AK15tnCmxUNNaY6CiaaMiEbHjTYHsY=;
        b=Sz17VyZ3pK7GhcsO5ERKc7v3eUAHnvmQ5nXT0rhGDGQZsQ3F7OwIa26dKQsCPBN2ro
         1pNGs20/XQadQR16cJFm7ePEfAMRTpRHVgyhYVN+DDlJGdzXNfht9m/65UEo2CDd5mxz
         abQR3eRD2xGkAcqB7oP2Esk/iEJiKQI3tlvWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=r2kxLHbqcw2a1AK15tnCmxUNNaY6CiaaMiEbHjTYHsY=;
        b=aXuPPukAl/fRZiqJIysrm846BE6nlO2lponXC7rREcCRGPRKz69vmr94jfGzaAos9Q
         un1fpy2MavV/ogTWc/O/xbuEPLLWsYyODoIOWqA+1bbJ4ZAeRctyCGKiU5kZTKl1Bzlw
         jQRqwiD4OannxP4sDzm+TzR4UcmLq475OeJILCk5t3B4HwQnwRcZJ2HH0MPE0rFhpXgs
         tF0X/lSguS3RizM3zBz3oJoh/GWGEkZvjUi7vVY7/k9xRczDrVm3CzpMlh/u8WRa/pf6
         tHdjoi09+Td577pTTHr76HJGQSLgUJHbUtxKqdfQt1vgFfDDhJovyBA6/aG4YIw9iFn3
         BPDA==
X-Gm-Message-State: APt69E1+uOt8HfWEj/mA+60cF7raK7X6MYjO0ncDPeOM6z8e80Msq1EB
        ntN9K5Cqqk3tjUoEe/yqQlYcTuCoa50=
X-Google-Smtp-Source: AAOMgpdm2pPLxvORBcW4GUjuipaZkS0ihNfVNxAoBbOwEsAQO+4QQZCR16cl6sdhz4qAXKn/HkTbog==
X-Received: by 2002:a1f:dc85:: with SMTP id t127-v6mr6784186vkg.120.1530899652517;
        Fri, 06 Jul 2018 10:54:12 -0700 (PDT)
Received: from localhost ([201.205.46.105])
        by smtp.gmail.com with ESMTPSA id z123-v6sm2248696vkd.55.2018.07.06.10.54.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 10:54:11 -0700 (PDT)
Date:   Fri, 6 Jul 2018 11:54:10 -0600
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/61] 4.14.54-stable review
Message-ID: <20180706175410.vma4jyghbj5c4z5m@xps>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20180706054712.332416244@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180706054712.332416244@linuxfoundation.org>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 07:46:24AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.54 release.
> There are 61 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Results from Linaro’s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.14.54-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.14.y
git commit: f0c73a14ce42af51660f44259cca95e19193ed38
git describe: v4.14.53-62-gf0c73a14ce42
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/build/v4.14.53-62-gf0c73a14ce42

No regressions (compared to build v4.14.53-62-g70a54698ad0b)

Ran 16444 total tests in the following environments and test suites.

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
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* ltp-cap_bounds-tests
* ltp-containers-tests
* ltp-math-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

-- 
Linaro LKFT
https://lkft.linaro.org
