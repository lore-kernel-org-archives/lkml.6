Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F46C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 16:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A863218EA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 16:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="CkOfY2zv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbeLZQpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 11:45:13 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46171 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbeLZQpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 11:45:13 -0500
Received: by mail-qt1-f196.google.com with SMTP id y20so17719822qtm.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 08:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GgtfxdhiLdvQCW7QGYVErnx606LplLlDcwec6P3WJq0=;
        b=CkOfY2zv/Z1q5cs672c00kKrdcb6NbKDvzkwnCCqm+j3yCQprxJC9get3MhYmhT6HW
         WT2Fm2Zcd9hu8IsYMrVfLek4ZNi9gDKzxJQrPZyQbDKziMXxMtVFhY7Fh6LoGHLeBdM9
         9/uBhvPBWzXxZDI+zua8lgN3BdlBlaj71dd8uuVo04q5ofFAWUHEIhKFUFm5/1U/bg6P
         piiwt2Xla3lT1iZOb/zBbhZh0IAMONGE8IPrtGxS5AL3cOOQ4iqAuxNUgo+2oDmInrRT
         AvFA/XWrzfZewqTxxu9W/L2V0ThNidVidy9ndxOQ9OFZknYaALgwpjA00/+dycf0/OMY
         hD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GgtfxdhiLdvQCW7QGYVErnx606LplLlDcwec6P3WJq0=;
        b=P6SE2WkMhwQd9KnMeV3nHa4hsKatJVjC4mxHMNTQAL1cxIvvHT776BP/13EGgYy/q/
         rOdZHZ3xqOwtvPdJAi7efsCMEwhUyWUpw8ENGAObPZerU8Q9Bg9hbdI0t8ZGDak2FidT
         ATOc/u/cnKBw6R3j/hNhK78u0x3I1bDKPEH7ZspSsCOaoHgw+UoVHZhfREyntavcecMI
         /D6WaMglZLfh50s6f+Cb0jzeMhHmYNmbKHf7cKAT/zRprX28rk3Ibe8pbvPx19qEV3vM
         rHTmN8mERFUeXNIXseQWoHSbrk26nUxjC8w3Lz388rt8BcTgZx/PgoJNFG/wy8thZ5sA
         mQ4Q==
X-Gm-Message-State: AA+aEWbuUYr+aetetE5tUC/igFmmvDzQqnKiwSr0Xf7SPDOV872qZeNh
        zC6T6qRj+jRpuUBwSVlsj1q9xw==
X-Google-Smtp-Source: ALg8bN7bG7R8aWj/3Z8/vN3VDVQ6HkXoBwOBo0vaBPWnVfhxTZqyOJOH4OSzdlwThfyjVARGZRGc7A==
X-Received: by 2002:aed:3968:: with SMTP id l95mr19363089qte.344.1545842711736;
        Wed, 26 Dec 2018 08:45:11 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id m41sm17874920qtc.58.2018.12.26.08.45.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Dec 2018 08:45:10 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     catalin.marinas@arm.com, will.deacon@arm.com,
        akpm@linux-foundation.org, rppt@linux.vnet.ibm.com,
        mhocko@suse.com, ard.biesheuvel@linaro.org, andrew.murray@arm.com,
        james.morse@arm.com, marc.zyngier@arm.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        pasha.tatashin@soleen.com
Subject: [PATCH v3 0/3] Early boot time stamps for arm64
Date:   Wed, 26 Dec 2018 11:45:06 -0500
Message-Id: <20181226164509.22916-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:
v2 - v3
	Addressed comments from Will Deacon: split into three
	patches, removed hardcoded assumption from vdso, don't
	assign arch_timer_read_counter during early boot.
v1 - v2
	Addressed comments from Marc Zyngier

I made early boot time stamps available for SPARC and X86.

x86:
https://lore.kernel.org/lkml/20180719205545.16512-1-pasha.tatashin@oracle.com

sparc:
https://www.spinics.net/lists/sparclinux/msg18063.html

As discussed at plumbers, I would like to add the same for arm64. The
implementation does not have to be perfect, and should work only when early
clock is easy to determine. arm64 defines a clock register, and thus makes
it easy, but on some platforms frequency register is broken, so if it is
not known, simply don't initialize clock early.

dmesg before:
https://paste.ubuntu.com/p/3pJ5kgJHyN

dmesg after:
https://paste.ubuntu.com/p/RHKGVd9nSM

As seen from the above with base smp_init is finished after 0.47s:
[    0.464585] SMP: Total of 8 processors activated.

But, in reality, 3.2s is missing which is a quiet long considering this is
only 60G domain.


Pavel Tatashin (3):
  arm_arch_timer: add macro for timer nbits
  arm64: vdso: Use ARCH_TIMER_NBITS to calculate mask
  arm64: Early boot time stamps

 arch/arm64/kernel/asm-offsets.c       |  1 +
 arch/arm64/kernel/setup.c             | 25 +++++++++++++++++++++++++
 arch/arm64/kernel/vdso/gettimeofday.S |  3 +--
 drivers/clocksource/arm_arch_timer.c  |  8 ++++----
 include/clocksource/arm_arch_timer.h  |  3 +++
 5 files changed, 34 insertions(+), 6 deletions(-)

-- 
2.20.1

