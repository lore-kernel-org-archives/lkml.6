Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BFCECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CFAA21476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FTqJmQbX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CFAA21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbeJSV1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 17:27:03 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39993 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbeJSV1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 17:27:03 -0400
Received: by mail-ot1-f67.google.com with SMTP id w67so33121869ota.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 06:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QZP7J5TaRm4ahVFM9hMV2APPsTbezNiP5Ip1GvLBdgI=;
        b=FTqJmQbXSpjiRiiggkiKfh7Qyv46o/FiTjn0mc3o6vaMEw5EIAYOB8Q6MFy+AmWc7o
         m3cHwa70xxM+vVOQ2qAAaL+/uuw5JMZV92cWhifKJlobDBmE2l+sQNzqX1uYJRom3OSq
         r27kAuubYqWH5ZX17JjEBk/30sx4hAKuND19g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QZP7J5TaRm4ahVFM9hMV2APPsTbezNiP5Ip1GvLBdgI=;
        b=rs7eZUmB2e6UbusnQbB0smyFRtuQVXT02klpyaOMFXfxqcgQ3bJqSwOZBwIuTvZG2W
         neEEI4Tfljo+V3ECcHWSDNcyMo4Z0PzKW5Btgg/CLZrNV6Z+C27CJtpDqn1bZLXQJIyT
         U+74MuCTJF8gmXgJkmAy86WFis+9URXajveMHpBzGpDfxjC/rm1nZjVEh8FK2Fdf1yKu
         D1LXpHfoV7QFY4kO05Lu/iXQpO874Dqr43cLlsg1T8pdNRNC9zYzd8TxyIz4lpOpbdpW
         x7JMmKmK+VKTn8nNggaPWcgCaa38RDjVZ5MPP1E3E3129s4184cTQSisRfkYh9GSOt5p
         w0xQ==
X-Gm-Message-State: ABuFfoiB7kTcEt2RK+o6zMvvN0bIuu1rorVmR3NfgFfcSPpK0PbiJ5d8
        9pECEMSyUNWafDpE5Uq+iVRoLs40ALz2tg==
X-Google-Smtp-Source: ACcGV62gf8Ju9IIcmcacGbK/8K7Zepa5B0Xxxmfydtbp04MQgbKc8idAfw0uivRcqpyiqZppjo1CTQ==
X-Received: by 2002:a9d:a82:: with SMTP id 2mr23231064otq.136.1539955255844;
        Fri, 19 Oct 2018 06:20:55 -0700 (PDT)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com. [209.85.167.171])
        by smtp.gmail.com with ESMTPSA id c62sm7133680otb.60.2018.10.19.06.20.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 06:20:54 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id e17-v6so26762821oib.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 06:20:54 -0700 (PDT)
X-Received: by 2002:aca:c743:: with SMTP id x64-v6mr17554766oif.139.1539955253826;
 Fri, 19 Oct 2018 06:20:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:7915:0:0:0:0:0 with HTTP; Fri, 19 Oct 2018 06:20:23
 -0700 (PDT)
In-Reply-To: <20181018175422.506152522@linuxfoundation.org>
References: <20181018175422.506152522@linuxfoundation.org>
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
Date:   Fri, 19 Oct 2018 10:20:23 -0300
X-Gmail-Original-Message-ID: <CABdQkv89pU7qpRWm_GSQEp9h+Xtunc0fjBxKbk8b9uOcsa4teg@mail.gmail.com>
Message-ID: <CABdQkv89pU7qpRWm_GSQEp9h+Xtunc0fjBxKbk8b9uOcsa4teg@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/35] 4.9.135-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 2:54 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.9.135 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Oct 20 17:54:00 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.135-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.9.135-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 199d569d5f73d62a53a8ed6ce5cfecffefde3bb5
git describe: v4.9.133-106-g199d569d5f73
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.133-106-g199d569d5f73


No regressions (compared to build v4.9.134)


No fixes (compared to build v4.9.134)


Ran 21028 total tests in the following environments and test suites.

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

--=20
Linaro LKFT
https://lkft.linaro.org
