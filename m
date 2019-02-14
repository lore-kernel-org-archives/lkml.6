Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7944BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43840222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oY7D8sXi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393889AbfBNCK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 21:10:29 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38353 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbfBNCKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 21:10:25 -0500
Received: by mail-qt1-f196.google.com with SMTP id 2so5198658qtb.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 18:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=UZUWVxCWrQrbsOUy2e1U0Sl4o1q/8Eqt6om0AFG+LA0=;
        b=oY7D8sXiNd5usUh9oroDx1SLTuG6WMdZ8aRWzq/0gECW9XLkvCKByQOspC1a4dhBio
         zXxoHyo5Y93itmx5JRrkv+K+jTGCo34/z8S7fIGws0tJMCTDzeVqMfAbVslVldkhjoDs
         wnbwrdGqGrPnUvsyYjPHt3Os1AFX3MiMio5VySr71ltsfl26ddIJpnTIJSfQuw5gFwZa
         p9FB0xliv7RzuJ1ZS6OsbXYGlVMPb3jAKb8k4vEd2mT1nKfmLEWENxSysIzFIVpUrAAi
         eKK5AJYzDxfq6+rdtdc/sxqsotL7Uu/FRdEuHtjtlGCAsw2+9+DR+VGZ4zF15kVxK9Yk
         lYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UZUWVxCWrQrbsOUy2e1U0Sl4o1q/8Eqt6om0AFG+LA0=;
        b=HDucWxvYzeAKUcVBS4SK16DWrgZgZENfzlhAh5Aedt4t3qbTqbAoWyId8vnuU0oLoc
         xLUk3ODKM/JNO9PLNnc3uHxT8/wZexA9wMya16Om9n/KS+XuEQJOgqGaYAxMPb/Gngq/
         MVLmpJHzFwdIhdEdJgh/eShU/iXAIdcz5cWZ3zzbuyPZ15URQWkAq3Yxi9cA+HONed1n
         mQ1pab6F/urHAjx7IT3xVC3go0US6fLrU0e1nlXMxqT6uy6jLXyQHD+hdlQFtbng+9I7
         Z5vnaZSjxjZjioFeFIapuwk3FmdpeUOBmBheNV2Q34jhduUNgjRjf/LUTV6AF6vVN7yy
         wrug==
X-Gm-Message-State: AHQUAuY6DhqGqQb28DeRZoP5Z1NkhT5nLAo+4Z6Iqm7FsNr+exf8oI2A
        muwBmQcJ0CmG/2jQPokz/21uqw==
X-Google-Smtp-Source: AHgI3IaLt92oYaVZkuv6T4gCnR1ZEbRr+1YgRVeeMfAfms8j9SwmuqJbT+MIWEqDE5tO80szMUZKGw==
X-Received: by 2002:ac8:34ed:: with SMTP id x42mr1062166qtb.173.1550110224757;
        Wed, 13 Feb 2019 18:10:24 -0800 (PST)
Received: from localhost.localdomain (pool-72-71-243-63.cncdnh.fast00.myfairpoint.net. [72.71.243.63])
        by smtp.googlemail.com with ESMTPSA id d63sm1091575qka.22.2019.02.13.18.10.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 18:10:24 -0800 (PST)
From:   David Long <dave.long@linaro.org>
To:     stable@vger.kernel.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4.14 V2 00/17] V4.14 backport of more 32-bit arm spectre patches
Date:   Wed, 13 Feb 2019 21:10:05 -0500
Message-Id: <20190214021022.5313-1-dave.long@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "David A. Long" <dave.long@linaro.org>

V4.14 backport of spectre patches from Russell M. King's spectre branch.
Patches have been kvm-unit-test'ed on an arndale, run through kernelci, and
handed off to ARM for functional testing.

Julien Thierry (10):
  ARM: 8789/1: signal: copy registers using __copy_to_user()
  ARM: 8790/1: signal: always use __copy_to_user to save iwmmxt context
  ARM: 8791/1: vfp: use __copy_to_user() when saving VFP state
  ARM: 8792/1: oabi-compat: copy oabi events using __copy_to_user()
  ARM: 8793/1: signal: replace __put_user_error with __put_user
  ARM: 8794/1: uaccess: Prevent speculative use of the current
    addr_limit
  ARM: 8795/1: spectre-v1.1: use put_user() for __put_user()
  ARM: 8796/1: spectre-v1,v1.1: provide helpers for address sanitization
  ARM: 8797/1: spectre-v1.1: harden __copy_to_user
  ARM: 8810/1: vfp: Fix wrong assignement to ufp_exc

Russell King (7):
  ARM: make lookup_processor_type() non-__init
  ARM: split out processor lookup
  ARM: clean up per-processor check_bugs method call
  ARM: add PROC_VTABLE and PROC_TABLE macros
  ARM: spectre-v2: per-CPU vtables to work around big.Little systems
  ARM: ensure that processor vtables is not lost after boot
  ARM: fix the cockup in the previous patch

 arch/arm/include/asm/assembler.h   | 11 ++++
 arch/arm/include/asm/cputype.h     |  1 +
 arch/arm/include/asm/proc-fns.h    | 61 ++++++++++++++++++-----
 arch/arm/include/asm/thread_info.h |  4 +-
 arch/arm/include/asm/uaccess.h     | 49 +++++++++++++++---
 arch/arm/kernel/bugs.c             |  4 +-
 arch/arm/kernel/head-common.S      |  6 +--
 arch/arm/kernel/setup.c            | 40 +++++++++------
 arch/arm/kernel/signal.c           | 80 ++++++++++++++++--------------
 arch/arm/kernel/smp.c              | 31 ++++++++++++
 arch/arm/kernel/sys_oabi-compat.c  |  8 ++-
 arch/arm/lib/copy_from_user.S      |  6 +--
 arch/arm/lib/copy_to_user.S        |  6 ++-
 arch/arm/lib/uaccess_with_memcpy.c |  3 +-
 arch/arm/mm/proc-macros.S          | 10 ++++
 arch/arm/mm/proc-v7-bugs.c         | 17 +------
 arch/arm/vfp/vfpmodule.c           | 20 +++-----
 17 files changed, 245 insertions(+), 112 deletions(-)

-- 
2.17.1

