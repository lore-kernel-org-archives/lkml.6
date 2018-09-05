Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB729C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B05520869
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="b+zf3lA3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B05520869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbeIES4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 14:56:18 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:36160 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbeIES4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 14:56:17 -0400
Received: by mail-it0-f65.google.com with SMTP id u13-v6so9691749iti.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 07:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cMz6hZdMxiSyMbH46DXEcenBezX/+y3K7GpDK4l1RO0=;
        b=b+zf3lA3QPsuIxHox4oeYWimKOS6XHbyD1y1pK3+yRPurKjEnaSs7mLvUQfB4eLeFQ
         aEuyesbKRKAbJwzFjzJbknbt1gJ9xbFNp4aEemoTPiveJEOMl+M4Uh4IEVjZIAcdj1aZ
         25NBasKDFvtnKBrlX5SRLQUouyp8CJ9P7I7x8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=cMz6hZdMxiSyMbH46DXEcenBezX/+y3K7GpDK4l1RO0=;
        b=SuhF7NyyESjKDV8lDrv/QfJ/pA6p7KEDQqD92NQJd+QZzIeeqK5n9WDW4rxivs+Wqj
         kC0hFCUEKtqkoQfzS7LWrxX7J/2DQHKdofgjSWr/QrQnRDrKlUmiTncxB+3cw7xNYGKG
         36vlR0b/q7EM0iQUxyVZElpFCUk8QdgTCejU1e/awZDS1VNx0Bbascm+Pgjj4ydt6B/U
         +DppeiVd+HNSkHRrgTEryL95AaW+5DLUJp3p7JYHpXyB8IfUlOREFMCwY6TbRpyxuKwH
         6fi0dL+WHSscnES76ziq+5C31I9uyV5JJGTH/HHBEcBAQ+LScZRmvqUJyRwOMNFZVNFe
         X63A==
X-Gm-Message-State: APzg51AOHHmLEpLvv4jIWXd/yhr5bOgesRic6VBWvQI/HmZIHJsnWbOh
        Ka50gQAdBSMsyT+s1GAiHzObEQ==
X-Google-Smtp-Source: ANB0VdYUwRuxu8Yf+HuvblW79HRr18y4k4b96cuIgosAtt5JZfU8BE68x1Iqv1qsSDkLX/eVTeBXuQ==
X-Received: by 2002:a02:12d6:: with SMTP id 83-v6mr26334787jap.37.1536157551166;
        Wed, 05 Sep 2018 07:25:51 -0700 (PDT)
Received: from localhost (c-107-2-67-121.hsd1.mn.comcast.net. [107.2.67.121])
        by smtp.gmail.com with ESMTPSA id c3-v6sm1165402itd.8.2018.09.05.07.25.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 07:25:50 -0700 (PDT)
Date:   Wed, 5 Sep 2018 09:25:49 -0500
From:   Dan Rue <dan.rue@linaro.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Subject: Re: [PATCH 4.18 000/123] 4.18.6-stable review
Message-ID: <20180905142549.mymrqt5oey554kkt@xps.therub.org>
Mail-Followup-To: Naresh Kamboju <naresh.kamboju@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>, Shuah Khan <shuah@kernel.org>,
        patches@kernelci.org, Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
References: <20180903165719.499675257@linuxfoundation.org>
 <20180904193202.GB17786@kroah.com>
 <CA+G9fYun7J_BCZ390oa5tY6jp6faaknczzDBuc7w5v6o8+WWVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYun7J_BCZ390oa5tY6jp6faaknczzDBuc7w5v6o8+WWVg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 04:08:35PM +0530, Naresh Kamboju wrote:
> On 5 September 2018 at 01:02, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Mon, Sep 03, 2018 at 06:55:44PM +0200, Greg Kroah-Hartman wrote:
> >> This is the start of the stable review cycle for the 4.18.6 release.
> >> There are 123 patches in this series, all will be posted as a response
> >> to this one.  If anyone has any issues with these being applied, please
> >> let me know.
> >>
> >> Responses should be made by Wed Sep  5 16:56:53 UTC 2018.
> >> Anything received after that time might be too late.
> >>
> >> The whole patch series can be found in one patch at:
> >>       https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.18.6-rc1.gz
> >> or in the git tree and branch at:
> >>       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.18.y
> >> and the diffstat can be found below.
> >
> > I have released -rc2 to fix a reported problem:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.18.6-rc2.gz
> 
> I get to see  4.18.6-rc1 not rc2.
> With the current results on given commit id are looking good.
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm and x86_64.

You may have noticed i386 listed below under Environments. This was
added last week, and runs functional testing on an i386 kernel under
QEMU emulation, as well as on x86_64 server hardware. This also accounts
for our total test count (unique tests * test environments) surpassing
20,000.

We'll therefore be updating the email header to read:

No regressions on arm64, arm, x86_64, and i386.

Thanks,
Dan

> 
> Summary
> ------------------------------------------------------------------------
> 
> kernel: 4.18.6-rc1
> git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> git branch: linux-4.18.y
> git commit: a6a229cf7e7f147eb6d118815a01758749fa6e8d
> git describe: v4.18.5-124-ga6a229cf7e7f
> Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.18-oe/build/v4.18.5-124-ga6a229cf7e7f
> 
> 
> No regressions (compared to build v4.18.5)
> 
> 
> Ran 21181 total tests in the following environments and test suites.
> 
> Environments
> --------------
> - dragonboard-410c - arm64
> - hi6220-hikey - arm64
> - i386
> - juno-r2 - arm64
> - qemu_arm
> - qemu_arm64
> - qemu_i386
> - qemu_x86_64
> - x15 - arm
> - x86_64
> 
> Test Suites
> -----------
> * boot
> * kselftest
> * libhugetlbfs
> * ltp-cap_bounds-tests
> * ltp-containers-tests
> * ltp-cve-tests
> * ltp-fcntl-locktests-tests
> * ltp-filecaps-tests
> * ltp-fs-tests > * ltp-fs_bind-tests > * ltp-fs_perms_simple-tests
> * ltp-fsx-tests
> * ltp-hugetlb-tests
> * ltp-io-tests
> * ltp-ipc-tests
> * ltp-math-tests
> * ltp-nptl-tests
> * ltp-pty-tests
> * ltp-sched-tests
> * ltp-securebits-tests
> * ltp-syscalls-tests
> * ltp-timers-tests
> * prep-inline
> * ltp-open-posix-tests
> * kselftest-vsyscall-mode-native
> * kselftest-vsyscall-mode-none
> 
> -- 
> Linaro LKFT
> https://lkft.linaro.org
> 
> >
