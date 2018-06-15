Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9D02AC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 07:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5214A208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 07:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Drlj4S+Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5214A208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755962AbeFOH4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 03:56:14 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:37470 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755675AbeFOH4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 03:56:13 -0400
Received: by mail-pg0-f68.google.com with SMTP id r21-v6so4088677pgv.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 00:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=WzVN66zjSPbJR5IzIGU4tb/JlqZjf7YjlSjrWHq8CXQ=;
        b=Drlj4S+QDKphAp2YDTD7rASiINKArchwnUCyhuKs/dWzpq64kg5kA4e1HJ7mGdTumS
         P2p6bHf45sS4R87E2SVhUrrZrg6dZdLEO5UyCND9CvZUJ8UzVLVcaKXzaKkDQE445W+0
         Q4x/ihI9CbjDwsJbm5OlQbfqzXBISP6d6iRMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WzVN66zjSPbJR5IzIGU4tb/JlqZjf7YjlSjrWHq8CXQ=;
        b=NYBKV0kK3ZdYgRHKJExUu9gkDk7hDYC8TXVRg7uedJG/B1mLAhJPvpVWEvjVmXpruU
         Ya43UKsSIGoTwd/qmiDE3BZV2kjyA10L7b3W2meY1Q0waRxIhkMu+WFca9nQoRs9TIsg
         l9ejm3d64ICdRUbFS23YPhIJhpFxJZcANNCzdV54WnD9nI17XVGg9e392yuzToUP5d/h
         7WxMpGJZf+/l2qC9YeKM0HIe4FRJEfLVgM3Uu+CzwqXEWJo39HiCUVxD+gFju+T0uL9g
         cPKTYJh3jfXX1sxQFH+SbptQs6z14n7gmkbPiPmbrdgHFu/JMfpOLZHLawzLfpgcPmWq
         G7+w==
X-Gm-Message-State: APt69E2ywcI+PQ/bOuwyb/EwH0wEPEbJDFCv9XHf7XFhBItdSrUd2qaj
        VstUD1wIXPU9wfYBRTwI7OVM2Q==
X-Google-Smtp-Source: ADUXVKIjAJ8j/goIWjX12W/1enGemdYageTZzAxRp/UCoUfHpsdV/biz8f6m5VmlSLdI+PJFE3NyLw==
X-Received: by 2002:a65:6319:: with SMTP id g25-v6mr572843pgv.437.1529049372781;
        Fri, 15 Jun 2018 00:56:12 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id l11-v6sm8970654pgp.56.2018.06.15.00.56.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 00:56:12 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com,
        akpm@linux-foundation.org, ard.biesheuvel@linaro.org
Cc:     tbaicar@codeaurora.org, bhsharma@redhat.com, dyoung@redhat.com,
        james.morse@arm.com, mark.rutland@arm.com, al.stone@linaro.org,
        graeme.gregory@linaro.org, hanjun.guo@linaro.org,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH 0/3] arm64: kexec,kdump: fix boot failures on acpi-only system
Date:   Fri, 15 Jun 2018 16:56:20 +0900
Message-Id: <20180615075623.13454-1-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

# apologies for a bit late updates

This patch series is a set of bug fixes to address kexec/kdump
failures which are sometimes observed on ACPI-only system and reported
in LAK-ML before.

In short, the phenomena are:
1. kexec'ed kernel can fail to boot because some ACPI table is corrupted
   by a new kernel (or other data) being loaded into System RAM. Currently
   kexec may possibly allocate space ignoring such "reserved" regions.
   We will see no messages after "Bye!"

2. crash dump (kdump) kernel can fail to boot and get into panic due to
   an alignment fault when accessing ACPI tables. This can happen because
   those tables are not always properly aligned while they are mapped
   non-cacheable (ioremap'ed) as they are not recognized as part of System
   RAM under the current implementation.

After discussing several possibilities to address those issues,
the agreed approach, in my understanding, is
* to add resource entries for every "reserved", i.e. memblock_reserve(),
  regions to /proc/iomem.
  (NOMAP regions, also marked as "reserved," remains at top-level for
  backward compatibility.)
* For case (1), user space (kexec-tools) should rule out such regions
  in searching for free space for loaded data.
* For case (2), the kernel should access ACPI tables by mapping
  them with appropriate memory attributes described in UEFI memory map.
  (This means that it doesn't require any changes in /proc/iomem, and
  hence user space.)

Please find past discussions about /proc/iomem in [1].

Patch#1 addresses kexec case, for which you are also required to update
user space. See necessary patches in [2]. If you want to review Patch#1,
please also take a look at and review [2].

Patch#2 and #3 addresses kdump case. This is a revised version after
Ard's comments.[3]

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-March/565980.html
[2] https://git.linaro.org/people/takahiro.akashi/kexec-tools.git arm64/resv_mem
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-April/573655.html

AKASHI Takahiro (2):
  arm64: acpi,efi: fix alignment fault in accessing ACPI tables at kdump
  init: map UEFI memory map early if on arm or arm64

James Morse (1):
  arm64: export memblock_reserve()d regions via /proc/iomem

 arch/arm64/include/asm/acpi.h      | 23 ++++++++++++------
 arch/arm64/kernel/acpi.c           | 11 +++------
 arch/arm64/kernel/setup.c          | 38 ++++++++++++++++++++++++++++++
 drivers/firmware/efi/arm-runtime.c | 27 ++++++++++-----------
 init/main.c                        |  3 +++
 5 files changed, 72 insertions(+), 30 deletions(-)

-- 
2.17.0

