Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49DDC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD8E521545
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="i40AcBLu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD8E521545
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbeHOXhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:37:09 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:54800 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbeHOXhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:37:09 -0400
Received: by mail-it0-f67.google.com with SMTP id s7-v6so3459987itb.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 13:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fbeSdEaGMTUpWK7xEowtBfBnDuaaNT+/j3qKL+J+1kg=;
        b=i40AcBLuXWmJJDzOngcTgsz3XvvSsOzsE8WkGbEp+73W6N9/Vq0mTyX1G8ojyYrJKH
         9CjkBxUeWmeFXi+Si8PWnfL/491eYG4Zb86kKzUbMC/FQG2d8VBXDzuRzcSohMDgYNEl
         71Whm2O0G6tOKEUetmFGq7TdJzqLzSBD4wn/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=fbeSdEaGMTUpWK7xEowtBfBnDuaaNT+/j3qKL+J+1kg=;
        b=oBv4usnrd2at9CzFQ4Ciz00Nv2IyzMBpdm1gQ8CDJX61P7fodjjfZaJjxjLhoIRqo/
         6W8syJtmbRkQpuhv4wiwZLAShdefFmXRVM67qN3iuwE3Gjg82f4l/x97iHuGUYM9Ob0D
         Pyg5XIET/GlWk2II2tsXsjwybg4nBT8ZKdGsoHV00Og21SHZjVY7E56droQjCuQnjGlj
         VdXh0tnrVjU06MD8bmolY8dkp0zttZtDKkbPsXS3Z/FyQfgbGc751fRWlxBbIA8U8o1A
         JqvM5xFTQ1c1DO4AaXfswdlqo4/GTSwN70e9iyTwMxtD9YKOWV9W9Sao4ahgbv0Counr
         w+oQ==
X-Gm-Message-State: AOUpUlEdAOcgOxSOrVqt74X/2cbm6XXcx/y/22w76x+9uIs+H7etUIYp
        qPDVDKCTtITrjUnrl7sTy3UbN9fGVus=
X-Google-Smtp-Source: AA+uWPzW51oidPo+4LrnyyESSUBpb8Qqi4bPHfJ5OAjTsm29EnUWqp06wf5jWR6wQlEY9vXIc4roVQ==
X-Received: by 2002:a24:40d2:: with SMTP id n201-v6mr20305975ita.144.1534365803102;
        Wed, 15 Aug 2018 13:43:23 -0700 (PDT)
Received: from localhost (c-68-47-89-210.hsd1.mn.comcast.net. [68.47.89.210])
        by smtp.gmail.com with ESMTPSA id l10-v6sm1509459itb.27.2018.08.15.13.43.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 13:43:22 -0700 (PDT)
Date:   Wed, 15 Aug 2018 15:43:21 -0500
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 000/107] 4.9.120-stable review
Message-ID: <20180815204321.bq23qerkggg7q2kc@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20180814171520.883143803@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180814171520.883143803@linuxfoundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 07:16:23PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.120 release.
> There are 107 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Aug 16 17:14:53 UTC 2018.
> Anything received after that time might be too late.

Results from Linaro’s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.9.120-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.9.y
git commit: 1a93cfe683918b90ca033d21080a2990cc25b6df
git describe: v4.9.119-112-g1a93cfe68391
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/build/v4.9.119-112-g1a93cfe68391


No regressions (compared to build v4.9.119)


Ran 12080 total tests in the following environments and test suites.

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
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ltp-open-posix-tests

-- 
Linaro LKFT
https://lkft.linaro.org
