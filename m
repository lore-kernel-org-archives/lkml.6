Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B94ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43FA921486
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V5yhcwwx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43FA921486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbeJSUuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:50:03 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43339 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbeJSUuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:50:03 -0400
Received: by mail-ot1-f65.google.com with SMTP id k9so33027739otl.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 05:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PjYxYBoyeAexRESl5ZH5s0eqiIiEjHQn7C/A2r7P2YQ=;
        b=V5yhcwwxkzD8cZNcwCvTDAAKwNNHR6ns1PE4FEX/goQMi9Ec3l4ReOaxBTCnPNwEtN
         ZJ3MPSvTNOQUlCBrb82vNEYAY/2DIpq27MiR+3RHpW7mpxsKrSmNbdqwS/00TCuewqRX
         3zNO5FXItlwonBb2/tz3O/B8zJ9jneko0B1Zo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PjYxYBoyeAexRESl5ZH5s0eqiIiEjHQn7C/A2r7P2YQ=;
        b=jZXiud1x52/Ow/vo9HpBSjbZe4Qw4MdJVNyKern5rw3K5keMe+e34TOQwzTryWXn2k
         3Gvm7WenbUfkbtOeSp2uFKi7YPTtj3rEfdy7cdTwNs46eaREP5Uncr2+WAKaCbN5jndY
         aQoAfj/S89oqtz5ZmQtIHQhhJXPg6O0Jo9mMjjk2Aydl8OQ/N31UgE6rYphu3iOrDtNx
         rrofOC/+756YFEDAHxgj/FoNmv6xMRd+YjAAiuZKIArx5xlcQOySt9PGa/94ruAxXbIv
         9q26J9fH4ULbP+zLFyyV0165umgrXWkDx2vheSaBmzUYUYh923o0YNZtwV9Ie9mPQWji
         AcDg==
X-Gm-Message-State: ABuFfogq/KVUtgf0mATBbeyqZ3w8SwkzLv5XATFMjzH26uWunMv0AAP+
        hF+68piVcV7rJOUoPHVs4eeRRDVvi9xidQ==
X-Google-Smtp-Source: ACcGV61l3vdvLeN9PnujOOQVuZ7NtUDauuA3AsSJvRCwmUEo4v1DPzXoDSLVVspf/v95e+ChRgpLHw==
X-Received: by 2002:a9d:2949:: with SMTP id d67mr23362368otb.74.1539953044011;
        Fri, 19 Oct 2018 05:44:04 -0700 (PDT)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com. [209.85.167.172])
        by smtp.gmail.com with ESMTPSA id f75-v6sm7765234oib.30.2018.10.19.05.44.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 05:44:02 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id v69-v6so26708280oif.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 05:44:01 -0700 (PDT)
X-Received: by 2002:aca:c593:: with SMTP id v141-v6mr19182737oif.113.1539953041398;
 Fri, 19 Oct 2018 05:44:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:7915:0:0:0:0:0 with HTTP; Fri, 19 Oct 2018 05:43:30
 -0700 (PDT)
In-Reply-To: <20181018175416.561567978@linuxfoundation.org>
References: <20181018175416.561567978@linuxfoundation.org>
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
Date:   Fri, 19 Oct 2018 09:43:30 -0300
X-Gmail-Original-Message-ID: <CABdQkv9tZZVofvmCjkwprpirBSRg-fFoG9qUsdHNCi=u+fZjdw@mail.gmail.com>
Message-ID: <CABdQkv9tZZVofvmCjkwprpirBSRg-fFoG9qUsdHNCi=u+fZjdw@mail.gmail.com>
Subject: Re: [PATCH 4.18 00/53] 4.18.16-stable review
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

On Thu, Oct 18, 2018 at 2:53 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.18.16 release.
> There are 53 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Oct 20 17:53:52 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.18.16-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.18.16-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.18.y
git commit: 5a51f0f88556afcacaab1fad30ca0e1f20a4b097
git describe: v4.18.14-189-g5a51f0f88556
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.18-oe/bu=
ild/v4.18.14-189-g5a51f0f88556


No regressions (compared to build v4.18.15)


No fixes (compared to build v4.18.15)


Ran 21223 total tests in the following environments and test suites.

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
* ltp-fs-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
