Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5FAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F5172229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y1iEwJhy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407264AbfBNOte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:49:34 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33031 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390743AbfBNOte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:49:34 -0500
Received: by mail-qt1-f193.google.com with SMTP id z39so7146323qtz.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=4OMBVou4qebwFqB5VwBh3FlAvgT21K5AaH/tbF5iY1Y=;
        b=Y1iEwJhyidP/O2f5pszWUmSXx0GZ2nZ9z4jJB1hIXquDGcvmpyuuzISOxVK4cf+j05
         0zr1eAv/Pl6+cFlW0CgKImM47UjXPAd5nWrxkk01JfC1JIWxwzVGBheMaHkBkbLt3eoW
         n/PRV3I1H5rmPNpre0hdblJ+8nl/JBGg7grabgllOSuIkSo66A4tsfHpZR5Fhlee88JQ
         T1ZhGlth3sNpjuKBfMLqJf6Dr1PIqK/xurdTC1On0P5Wcak0EJlsvUSxr96Ld5ITJ+tt
         4Zh7I20OzvMQCY1eMJz+6gbv58RrAQoUL4bZVL5LdrioHe7hNxqpZcEDfFPs/ftE+v4O
         eUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4OMBVou4qebwFqB5VwBh3FlAvgT21K5AaH/tbF5iY1Y=;
        b=oVRe02tpHXapOCV2JXFEsI3QsZcJl4fRGWHJ/lxmEhRbuSZg+qIpRHAl7kjYE07iLH
         Gw6zgO/n9QXLiZ0pImPOo1U+1MhYiR82/drp1Z/tyk2RTTRpc9N0wJvrjiyuC4ldgdvF
         lZxHWDsshLb6Etx5mLH3fHEQ/XUwhD/RIpVPLB2OK/C6hjrhFyk0+LchpnVx/iPg6SZH
         gEIKO78ATrrwDJTRpKGpkYknrz4pPI3J5LcbZh25rpbyHXFvP6tyVkVlhncbk3Txr/C4
         UZuR4b/PpwxJnp1zvAsRTAEIHhJG/HzI46j82wSAyO7BrahlRzzFDxgwnn/stYYe6FNZ
         Kwxw==
X-Gm-Message-State: AHQUAuZAfwTcSIOjYRbf0n6nA5YUHEFNXfGHboM8hR5gnWeUBiiey8TU
        rmBsdfqnWqmJhariOELcQwWDBw==
X-Google-Smtp-Source: AHgI3IbQ7KUrWBYl394zB9/w7jbXgXWb2dLvxyHf3BYgHGWVJLfdBhK7TPIkp1JTT4sBv1+YRZgtKQ==
X-Received: by 2002:ac8:1e84:: with SMTP id c4mr3304948qtm.181.1550155772912;
        Thu, 14 Feb 2019 06:49:32 -0800 (PST)
Received: from localhost.localdomain (pool-72-71-243-63.cncdnh.fast00.myfairpoint.net. [72.71.243.63])
        by smtp.googlemail.com with ESMTPSA id k66sm1498919qkc.25.2019.02.14.06.49.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:49:32 -0800 (PST)
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
Subject: [PATCH 4.9 00/16] V4.9 backport of more 32-bit arm spectre patches
Date:   Thu, 14 Feb 2019 09:49:14 -0500
Message-Id: <20190214144930.27539-1-dave.long@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "David A. Long" <dave.long@linaro.org>

V4.9 backport of spectre patches from Russell M. King's spectre branch.
Patches have been kvm-unit-test'ed on an arndale, run through kernelci, and
handed off to ARM for functional testing.

Julien Thierry (9):
  ARM: 8789/1: signal: copy registers using __copy_to_user()
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

 arch/arm/include/asm/assembler.h   | 11 +++++
 arch/arm/include/asm/cputype.h     |  1 +
 arch/arm/include/asm/proc-fns.h    | 61 +++++++++++++++++++++-----
 arch/arm/include/asm/thread_info.h |  4 +-
 arch/arm/include/asm/uaccess.h     | 49 ++++++++++++++++++---
 arch/arm/kernel/bugs.c             |  4 +-
 arch/arm/kernel/head-common.S      |  6 +--
 arch/arm/kernel/setup.c            | 40 ++++++++++-------
 arch/arm/kernel/signal.c           | 70 ++++++++++++++++--------------
 arch/arm/kernel/smp.c              | 32 ++++++++++++++
 arch/arm/kernel/sys_oabi-compat.c  |  8 +++-
 arch/arm/lib/copy_from_user.S      |  6 +--
 arch/arm/lib/copy_to_user.S        |  6 ++-
 arch/arm/lib/uaccess_with_memcpy.c |  3 +-
 arch/arm/mm/proc-macros.S          | 10 +++++
 arch/arm/mm/proc-v7-bugs.c         | 17 +-------
 arch/arm/vfp/vfpmodule.c           | 20 ++++-----
 17 files changed, 240 insertions(+), 108 deletions(-)

-- 
2.17.1

