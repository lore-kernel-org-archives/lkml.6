Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C7BC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6307922540
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oy+JJc6t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6307922540
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934251AbeGFSJg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 14:09:36 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:45772 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934048AbeGFSJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 14:09:33 -0400
Received: by mail-ua0-f193.google.com with SMTP id z4-v6so8068641uao.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 11:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bKwvSl9ehnxk0KqFOhCn4Tk1xz0Smfo2MrIH1uzBrUo=;
        b=Oy+JJc6tD391eZMR5yg59PFcjkR8TLR22SjQ+fh9vakuoos1PADXb1xS5P5k3yPg04
         /wb5sZYj9xiBoUN18WSZmFPn1uWlVrshmtVM1GErtM/Bdwtg+f4jwwU4lLqIqhc2neSY
         F8Z++AUkBlVtJRBb2kEJegvwcHLkDHBRI5mgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=bKwvSl9ehnxk0KqFOhCn4Tk1xz0Smfo2MrIH1uzBrUo=;
        b=mxyXU5Xk+I88+lmvIAtiS2loZAcik5Ig9A5WOGyvVDcaGHYHOl4irMYZJlS40mbRk7
         lGEIIsXwc8vMRaD5T/VuTSRTA4VM3eSQUIC3eS2gkJBysf9nzIHJcP1zb5oF1sDR4bjO
         Nocgn80YHPzfEX/jSdgniAOM6BgY26L2vwVNDFlIm6BC0DqBwf40Zuht3Q+9ZJyM+Eds
         ZeLnYssoIDRE265gGG3Ym6DS/7TfOaxs6icMlZzsDNjmriar2FScLBzmn+k+U0snE5gq
         0zi0J9NhxyHD9feJLuYsoR54BhFqtkTm4P3Pr7Xlt9lgu1L59CiOzAHjb/2KkCb6EGuR
         Tbbg==
X-Gm-Message-State: APt69E1xAk4h5to0dTVwxYuCrXBts4T515GFIM0rc3Mkc643giJqRm6F
        UoZPZ4jmu512oOmtVxFJE4bUyL9gdl4=
X-Google-Smtp-Source: AAOMgpeSQHWrght8gaDherWPl37vfX+yJz4RB+KcOEv78ST0r8QyVmBxFZH9Y+koK6o0mlg9ZvpsqA==
X-Received: by 2002:ab0:60c6:: with SMTP id g6-v6mr6868162uam.41.1530900572820;
        Fri, 06 Jul 2018 11:09:32 -0700 (PDT)
Received: from localhost ([201.205.46.105])
        by smtp.gmail.com with ESMTPSA id r128-v6sm1921492vkb.18.2018.07.06.11.09.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 11:09:32 -0700 (PDT)
Date:   Fri, 6 Jul 2018 12:09:28 -0600
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.17 00/46] 4.17.5-stable review
Message-ID: <20180706180928.7noxnd7kty26vi5j@xps>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20180706054524.595521988@linuxfoundation.org>
 <20180706175124.4l7zf5wxzwnwxcsy@xps>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180706175124.4l7zf5wxzwnwxcsy@xps>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 11:51:24AM -0600, Dan Rue wrote:
> On Fri, Jul 06, 2018 at 07:46:21AM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.17.5 release.
> > There are 46 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm and x86_64.
> 
> Summary
> ------------------------------------------------------------------------
> 
> kernel: 4.17.5-rc1
> git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> git branch: linux-4.17.y
> git commit: 211fe6663749212887c5d36f2e483acfb831377b
> git describe: v4.17.4-47-g211fe6663749
> Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.17-oe/build/v4.17.4-47-g211fe6663749
> 
> No regressions (compared to build v4.17.4-47-gd0d428d64248)
> 
> Ran 16369 total tests in the following environments and test suites.

Forgot to mention - you may (or may not) notice the test count is about
5000 higher. LTP Open Posix test suite was added this week, which adds
about 1700 tests per environment. We are running it on one environment
per architecture (arm32, arm64, x86_64), because its runtime is a little
long on some boards.

> 
> Environments
> --------------
> - dragonboard-410c - arm64
> - hi6220-hikey - arm64
> - juno-r2 - arm64
> - qemu_arm
> - qemu_arm64
> - qemu_x86_64
> - x15 - arm
> - x86_64
> 
> Test Suites
> -----------
> * boot
> * libhugetlbfs
> * ltp-cap_bounds-tests
> * ltp-containers-tests
> * ltp-cve-tests
> * ltp-fcntl-locktests-tests
> * ltp-filecaps-tests
> * ltp-fs-tests
> * ltp-fs_bind-tests
> * ltp-fs_perms_simple-tests
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
> * kselftest
> * ltp-open-posix-tests
> * kselftest-vsyscall-mode-native
> * kselftest-vsyscall-mode-none
> 
> -- 
> Linaro LKFT
> https://lkft.linaro.org
