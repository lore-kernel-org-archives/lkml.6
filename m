Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F26C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 03:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 076F1214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 03:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eR3qLhkj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 076F1214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeJQLuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 07:50:24 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36143 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbeJQLuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 07:50:24 -0400
Received: by mail-io1-f68.google.com with SMTP id p4-v6so17977316iom.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 20:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=37qfKIQn2F/zuG3mSaFIQxcnlRXFrQCwgR47g9iRnds=;
        b=eR3qLhkj/cnfYG5BLIB37/9jHtum4kuIzgrrJ/0XfrR9eSxXIDs4qzt9/VWJldGxRj
         1lkTX6DdTdFiWK6VkqBUNC82D4gsFfL+VsFn9xlaTkzRTnLZwNHcwFqRf9ai30xTW3Pf
         /cD4k52NKBF7AcD/T+9etQcIWXdgWggNUVDcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=37qfKIQn2F/zuG3mSaFIQxcnlRXFrQCwgR47g9iRnds=;
        b=nsSAYbTCATQYe0uqUNt6ONzoRv6IC2mXYd3AT8+PdORaOBOlJh2ba0F7LHxQHFF8OQ
         aFsRK09P5PBI+NMrYctjzQq1LG+onsJBxITYz2Py20aYO68cIoxCxUyCosB5xUUvyzZD
         f9dwsLYe+i3LtI9IdMDRoZp+XjydTQ640tQLJAEG4lAcwDRjg0xWRmzua2x8c3rYlDtF
         Ohg9m/Uptt0UUJROm7UMC7WRTxsikHRqQU3oBch3KA6WHF2AtbAVhm1KVBbkyviiyKUi
         7y+eGtN/DGzCNKa0MixLEZTPCLWJAakH6jHAjfjXeFvDj6WXXiZed4pUZxkvnFbdwIwZ
         PLSw==
X-Gm-Message-State: ABuFfoh3B/JotuQZLPE+m7/JqgrO8s1UGGcL6ZthR5/soZZJC0guwLy9
        RL5CMnOJyJvvIGTrj/efDzIPzw==
X-Google-Smtp-Source: ACcGV6045Cu3NOwe0rUGTmvOePnUviGdgWIKo3LGp6OM1wbAtCFAvUQy5joGJhJz27f5dE6CQjTWuw==
X-Received: by 2002:a6b:2c08:: with SMTP id s8-v6mr16725223ios.217.1539748604595;
        Tue, 16 Oct 2018 20:56:44 -0700 (PDT)
Received: from localhost (c-107-2-67-121.hsd1.mn.comcast.net. [107.2.67.121])
        by smtp.gmail.com with ESMTPSA id b130-v6sm376261itb.28.2018.10.16.20.56.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 20:56:43 -0700 (PDT)
Date:   Tue, 16 Oct 2018 22:56:42 -0500
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/109] 4.14.77-stable review
Message-ID: <20181017035642.33i6jcg2bsr7lhq2@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20181016170524.530541524@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181016170524.530541524@linuxfoundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 07:04:28PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.77 release.
> There are 109 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Oct 18 17:04:58 UTC 2018.
> Anything received after that time might be too late.

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.14.77-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.14.y
git commit: 3dbba66c8671a97270f35e072c54f74ddca6954e
git describe: v4.14.76-110-g3dbba66c8671
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/build/v4.14.76-110-g3dbba66c8671


No regressions (compared to build v4.14.76)


No fixes (compared to build v4.14.76)


Ran 21021 total tests in the following environments and test suites.

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
* libhugetlbfs
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
* ltp-cap_bounds-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

-- 
Linaro LKFT
https://lkft.linaro.org
