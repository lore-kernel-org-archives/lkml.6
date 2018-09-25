Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEC0C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A41121480
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OhCXNS8I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A41121480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeIYXdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:33:40 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:51540 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbeIYXdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 19:33:40 -0400
Received: by mail-it1-f196.google.com with SMTP id e14-v6so16497913itf.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 10:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pSBR8dpoZU+jI4evIy7YNljbptBnifzxzx12VcIpxKw=;
        b=OhCXNS8IpbGiU3riip0Npj0XoWATu1ocOajrx8uJEIa/1C5uEuHfJ4GHFCkeAz70zz
         zQNXFsho7P7Uq/gXeSpnHMSCiM4h61o1sSNSyzTkvEWs5d4IYs8OM3iN7nzl57GDPzBi
         ROg+WFR5skaqOKdO0eY9ceSVo6FuOop/sNYB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=pSBR8dpoZU+jI4evIy7YNljbptBnifzxzx12VcIpxKw=;
        b=WxFY3oxuv5IXxD3txsBUVCB+X2wTomRSyqbDY6i3cc9CqCxDXdUzXmolb6wdkFYzwb
         AeqqPRYLvZP96UnQQb0HQXZ9Spog6HQnTw9I0h9cgBzb1+TD6wAoTDHK47mWx8KcJol5
         iHGzV26/XfBToIKcsPOzN63HoChMCWutsRuHeXG9mDF6lGx17/4dFdjtjEEfR22fXAw+
         FDQAA6VSBr6IoOA4KX0sGQaYNIQ/07gaM5teifjEmM4nn6gXxDtBlzkGVM9RQKS9A6We
         I3QgKJOmifnMTw4ipNaGUvtQaY6oUXkrgF5uRiBrTJOKg01+eRv/Vi0jalkFYTCqA/vw
         xXRQ==
X-Gm-Message-State: ABuFfoiDtgOUBYcqRVExIWmjy4CYbBfckQNQvui57FvymKzu1OrjnwOg
        tLsEnbJlaWguHHSpBzY822Jqaw==
X-Google-Smtp-Source: ACcGV63asHAoTSFBUxNfA3BjXd572zSbAEwxm6DxbMSUom7c0j1aBa81R8GyEZYvTirv+YJ84ZuklA==
X-Received: by 2002:a24:5d0:: with SMTP id 199-v6mr1670042itl.88.1537896309899;
        Tue, 25 Sep 2018 10:25:09 -0700 (PDT)
Received: from localhost (c-107-2-67-121.hsd1.mn.comcast.net. [107.2.67.121])
        by smtp.gmail.com with ESMTPSA id h2-v6sm986628iok.29.2018.09.25.10.25.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 10:25:08 -0700 (PDT)
Date:   Tue, 25 Sep 2018 12:25:07 -0500
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.18 000/235] 4.18.10-stable review
Message-ID: <20180925172507.nkjow2cgzjbdoaip@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20180924113103.999624566@linuxfoundation.org>
 <20180925090710.GA21224@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180925090710.GA21224@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 11:07:11AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Sep 24, 2018 at 01:49:46PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.18.10 release.
> > There are 235 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Sep 26 11:30:01 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.18.10-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.18.y
> > and the diffstat can be found below.
> 
> -rc2 is out to resolve some reported problems:
>  	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.18.10-rc2.gz

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.18.10-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.18.y
git commit: a728cc9e2683aba1752aa9a0aacae4bbfc1066d2
git describe: v4.18.9-232-ga728cc9e2683
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.18-oe/build/v4.18.9-232-ga728cc9e2683

No regressions (compared to build v4.18.9)
------------------------------------------------------------------------

Ran 16243 total tests in the following environments and test suites.

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
* ltp-timers-tests
* ltp-syscalls-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

-- 
Linaro LKFT
https://lkft.linaro.org
