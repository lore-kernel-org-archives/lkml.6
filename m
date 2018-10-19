Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E09ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D744421476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jR/UC2R9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D744421476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeJSWFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 18:05:13 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44102 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbeJSWFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 18:05:13 -0400
Received: by mail-oi1-f196.google.com with SMTP id u74-v6so26859394oia.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 06:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T329XFZ9o2JLPV/sq32xKDpHwva1vTjiMGwKfyyx6AU=;
        b=jR/UC2R9gZPyrdB810E1gX787OlBaRjPu5cMWYqSywpcer8FMzwng8w0ez5ZGzRRxh
         CPAz0Y+Q9Nvr24HKJbcGL+GH0X4N9UQReH3J46OU1MSH3kgaFkhlkH4CjEgYj6K2Tvdf
         9HSVdJRlO5e1rLFF2GZSFO0sofqFBMGM8der8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T329XFZ9o2JLPV/sq32xKDpHwva1vTjiMGwKfyyx6AU=;
        b=Y6xZsztrTP/XLar4LIVdeqt6Mn7Pp84NoO0otQEqTGh4DS4RrTsKaZk8NfLUVE39ep
         KRlLELoAK5m9u/r2KjXKDerG5EI9YmOi5lDPGMoIDmkaRrTnPWQRBxcGnYXPZozo6GFy
         6TzR6Vggwfj9dp9FWPJmHC+GyWqpuWGNzS6cS+Pd2wB9vkFyMU5gxXnxZitEk+zAzG0b
         bM794Fzim5PTmeXVKaEXUR9qQKnqLN0bYG0OtpEuiqaXDa0s/U8eFXYHt9p+t/IFQyVo
         KDdrUpbwMuTdNbUTsHO0JP4N9JKM/7mAQZ62iQBaydKbcY+b/qCQGpCW3ujocW0eidBC
         hbOA==
X-Gm-Message-State: ABuFfojNvZTwn2weQANBMg3Ih8oiwPkJGIVBCrbSJh0nJNHPZsby0UIo
        xeVZTLK5NmGH+Kyw4iHceaGq1HjQW1JcHQ==
X-Google-Smtp-Source: ACcGV63Hdbft4KQyiLhVe/ooXdoeNAagjOrV/F9kHS+cf1Wbe7p8sUTImz0jHrik8zsNKYlGu37YGg==
X-Received: by 2002:aca:a811:: with SMTP id r17-v6mr19086351oie.5.1539957536836;
        Fri, 19 Oct 2018 06:58:56 -0700 (PDT)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com. [209.85.167.179])
        by smtp.gmail.com with ESMTPSA id u11sm7644583otc.14.2018.10.19.06.58.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 06:58:54 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id s69-v6so26842477oie.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 06:58:53 -0700 (PDT)
X-Received: by 2002:aca:ba54:: with SMTP id k81-v6mr19654292oif.177.1539957533382;
 Fri, 19 Oct 2018 06:58:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:7915:0:0:0:0:0 with HTTP; Fri, 19 Oct 2018 06:58:23
 -0700 (PDT)
In-Reply-To: <20181018175427.133690306@linuxfoundation.org>
References: <20181018175427.133690306@linuxfoundation.org>
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
Date:   Fri, 19 Oct 2018 10:58:23 -0300
X-Gmail-Original-Message-ID: <CABdQkv_k-RnNZFoG+Hf_qABAaSByF=wU2Y-38cib0rPwe79axQ@mail.gmail.com>
Message-ID: <CABdQkv_k-RnNZFoG+Hf_qABAaSByF=wU2Y-38cib0rPwe79axQ@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/48] 4.4.162-stable review
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
> This is the start of the stable review cycle for the 4.4.162 release.
> There are 48 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Oct 20 17:54:03 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.162-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.4.162-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: 3918330d8012ab71d8ad89c6a3465a729ad1d61e
git describe: v4.4.161-49-g3918330d8012
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.161-49-g3918330d8012


No regressions (compared to build v4.4.161)


No fixes (compared to build v4.4.161)


Ran 16804 total tests in the following environments and test suites.

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

kernel: 4.4.162-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.162-rc1-hikey-20181018-306
git commit: 0264de6b9902e4883d60b75867d85ab348dafb53
git describe: 4.4.162-rc1-hikey-20181018-306
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.162-rc1-hikey-20181018-306


No regressions (compared to build 4.4.161-rc1-hikey-20181011-301)


No fixes (compared to build 4.4.161-rc1-hikey-20181011-301)


Ran 2688 total tests in the following environments and test suites.

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

--=20
Linaro LKFT
https://lkft.linaro.org
