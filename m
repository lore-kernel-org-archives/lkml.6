Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2D1C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ACB620883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730441AbfAIKv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 05:51:59 -0500
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:15733 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729798AbfAIKvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 05:51:45 -0500
Received: from g4t3428.houston.hpe.com (g4t3428.houston.hpe.com [15.241.140.76])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g2t1383g.austin.hpe.com (Postfix) with ESMTPS id 96EA5E5F;
        Wed,  9 Jan 2019 10:45:47 +0000 (UTC)
Received: from sarge.linuxathome.me (unknown [16.214.81.200])
        by g4t3428.houston.hpe.com (Postfix) with ESMTP id 991E853;
        Wed,  9 Jan 2019 10:45:48 +0000 (UTC)
From:   Hedi Berriche <hedi.berriche@hpe.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hedi Berriche <hedi.berriche@hpe.com>
Subject: [PATCH 0/3] Protect against concurrent calls into UV BIOS
Date:   Wed,  9 Jan 2019 10:45:38 +0000
Message-Id: <20190109104541.25733-1-hedi.berriche@hpe.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calls into UV BIOS were not being serialised which is wrong as it violates
EFI runtime rules, and bad as it does result in all sorts of potentially
hard to track down hangs and panics when efi_scratch gets clobbered.

Patch #1 makes the efi_runtime_lock semaphore visible to EFI runtime
callers defined outside drivers/firmware/efi/runtime-wrappers.c in
preparation for using it to serialise calls into UV BIOS.

Patch #2 removes uv_bios_call_reentrant() because it's dead code.

Patch #3 makes uv_bios_call() variants use efi_runtime_sem to protect
against concurrency.

Hedi Berriche (3):
  efi/x86: turn EFI runtime semaphore into a global lock
  x86/platform/UV: kill uv_bios_call_reentrant() as it has no callers
  x86/platform/UV: use efi_runtime_sem to serialise BIOS calls

 arch/x86/include/asm/uv/bios.h          |    4 +-
 arch/x86/platform/uv/bios_uv.c          |   37 +++++++++++--------
 drivers/firmware/efi/runtime-wrappers.c |   60 ++++++++++++++++----------------
 include/linux/efi.h                     |    3 +
 4 files changed, 57 insertions(+), 47 deletions(-)

-- 
2.20.0

