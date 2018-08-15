Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809E7C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC4E21531
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OBXdCrj7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC4E21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbeHOXGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:06:03 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:55963 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbeHOXGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:06:03 -0400
Received: by mail-it0-f66.google.com with SMTP id d10-v6so3341517itj.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 13:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nfIdczo9TvuEPWdZ/9CUOvdkG+Hbgg/M4Ny5tc08SGE=;
        b=OBXdCrj7sNBkCKXJ6l7+qBRMk9Ku6aaEvE5HlJ6RaXW9t4i914SIk4Fj9GQZVJdIHh
         geP6W82vYaAjvGbMwO40oaH6c47B/hHxa4HxJxbsXkW4vJ11tuB8CX+Vph5YuyqFCMbQ
         xSmmVgWW/huShom3Y0omcOaPxbnfvLPRUpdME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=nfIdczo9TvuEPWdZ/9CUOvdkG+Hbgg/M4Ny5tc08SGE=;
        b=CAsYRtHJO8CFpdW4AiCaBE0VHAvLYKJHGP+WGkot5fyVjkJoTEQr1zmagtVGUqgXfn
         S6GV42dFJH7qjHnHc/iLSSmhatrng3YrOJUCFrWgAWAD813GgL0To1zWNSoj25Ia9bWF
         ADdos9TZPnPBwlknJXTYkxaE7wQxGux4tg2oo4kv+REbv3xOUwaEWVMxirjQ37AUe6ub
         VS47fjiaYewmQMzhBZBMgIhqf1KVuofWiaXeUUwB657xE8n4NQ3tlku4yhN1twmnxHd7
         1C/52HqBTqCfHx90PrURZrcKWJ67oNf8hwa53TkoXZQhyF4A2059xv3X7JhQNRJFfiDx
         zCgQ==
X-Gm-Message-State: AOUpUlH3r+Jh5+uzgiiPLhAz8koGE/cZckDzjKS8suoZGaAiOCOuVWST
        UqRQQ7R6XF3Syzwc7Alufbnt1Q==
X-Google-Smtp-Source: AA+uWPxG999PjIHNOMlZ2wOAD5IkMLCvXYS3eH7TBvNVnehLLcxtg+Ij9kQlkTwOBB+Omoqev6o9lQ==
X-Received: by 2002:a24:7f87:: with SMTP id r129-v6mr18893913itc.107.1534363944815;
        Wed, 15 Aug 2018 13:12:24 -0700 (PDT)
Received: from localhost (c-68-47-89-210.hsd1.mn.comcast.net. [68.47.89.210])
        by smtp.gmail.com with ESMTPSA id y9-v6sm5414309iop.7.2018.08.15.13.12.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 13:12:24 -0700 (PDT)
Date:   Wed, 15 Aug 2018 15:12:23 -0500
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.18 00/79] 4.18.1-stable review
Message-ID: <20180815201223.j6rhtk4asx7hfntp@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20180814171336.799314117@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180814171336.799314117@linuxfoundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 07:16:19PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.18.1 release.
> There are 79 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Aug 16 17:13:16 UTC 2018.
> Anything received after that time might be too late.

Our systems are swamped with these RCs and mainline today, but since I
see these are being tagged I wanted to get results out based on the data
that we do have. We manually screened the results and will follow up if
we notice anything subsequently. Caveat applies to all stable branches.

Results from Linaro’s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.18.1-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.18.y
git commit: 8105f76febd464c5c5cf4cd4647e42b724ed728c
git describe: v4.18-83-g8105f76febd4
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.18-oe/build/v4.18-83-g8105f76febd4


No regressions (compared to build v4.18)


Ran 15737 total tests in the following environments and test suites.

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

-- 
Linaro LKFT
https://lkft.linaro.org
