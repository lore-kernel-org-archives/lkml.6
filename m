Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506D8ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18AF620645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="a2l15UxD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18AF620645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbeJSURT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:17:19 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43452 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbeJSURS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:17:18 -0400
Received: by mail-ot1-f67.google.com with SMTP id k9so32940448otl.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 05:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jDJ9et9TD3onWgXlgq4YgRk4LiQ21Y28bz9MsUjV3z4=;
        b=a2l15UxD7PXXl36iPUMToeKr+8WFoWf0zR6bp03uTYPDcKfWx9lSUIJWoeU7TwvZZP
         VaBJ52Hm99CMP72cAZ5VfzXsARiO5qaa6+lH1vBpd4eGj273UZ8x31z5wofW6ZpB47VR
         +oOUAFa2/y8NnhwMA/lqwNnDYAJsaLOuvjS38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jDJ9et9TD3onWgXlgq4YgRk4LiQ21Y28bz9MsUjV3z4=;
        b=QLDuvZiHEuuhplNH7XGhUKq7Qk2A0r4tA2Ey2x7HdP8rECVsCThqguDSG0M5OuoWbv
         sgiIbjB1+GVT+qfIZ69LebAD/lEDry37CL6CBQE/AdSIAjv8jJnLj2gg4pawhDTNg+X3
         egXSEEeHWu7CSfWEK8u9mojq8dMqw4ADN3JN0iR8RKCJhveAuLKzcD1AjkCKT9n/v6qP
         MW15Uu9CzbfohfDVKVJZENUBlfHnWAjd8N7vWtDvF/czsI+5fesbBM/kExj+gZhvfVPS
         X9+/Nn9Ytd2hwZcL8jKwOJDCR+LAYy0aeKARNf54cAsnL+K/MjJKQBjyk+hBwwhBQA0O
         lP3Q==
X-Gm-Message-State: ABuFfohfp4k9wTIFOovSnYUYifWK7TqSTPQYUxIx07E/w7Urbae24nIb
        VPL61aivVat0x9oosfhR241tBkPOfWDaXQ==
X-Google-Smtp-Source: ACcGV603a+ZzjR/waPj1lOAffH437sseyJmm2dYzI8zPwP72DyEKrSOjD5mJNE4aObPSa4Xj4eJ2MA==
X-Received: by 2002:a9d:fd6:: with SMTP id m22mr23073940otd.227.1539951089120;
        Fri, 19 Oct 2018 05:11:29 -0700 (PDT)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com. [209.85.210.48])
        by smtp.gmail.com with ESMTPSA id u107sm4711638otb.71.2018.10.19.05.11.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 05:11:27 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id c32so32951657otb.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 05:11:26 -0700 (PDT)
X-Received: by 2002:a9d:9c3:: with SMTP id 3mr22582152otz.181.1539951086330;
 Fri, 19 Oct 2018 05:11:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:7915:0:0:0:0:0 with HTTP; Fri, 19 Oct 2018 05:10:55
 -0700 (PDT)
In-Reply-To: <20181018175416.718399607@linuxfoundation.org>
References: <20181018175416.718399607@linuxfoundation.org>
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
Date:   Fri, 19 Oct 2018 09:10:55 -0300
X-Gmail-Original-Message-ID: <CABdQkv9-k9K3c21TgzrY_gdjOvVpuugGTLJjx3XbDAdvzPvQcA@mail.gmail.com>
Message-ID: <CABdQkv9-k9K3c21TgzrY_gdjOvVpuugGTLJjx3XbDAdvzPvQcA@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/41] 4.14.78-stable review
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
> This is the start of the stable review cycle for the 4.14.78 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Oct 20 17:53:55 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.78-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.14.78-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 901b7ab9634ee1196ac3e77271f7d70dbacf12e9
git describe: v4.14.76-152-g901b7ab9634e
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.76-152-g901b7ab9634e


No regressions (compared to build v4.14.77)


No fixes (compared to build v4.14.77)


Ran 21098 total tests in the following environments and test suites.

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
* ltp-fsx-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
