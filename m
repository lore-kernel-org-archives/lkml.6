Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AB4C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A3024C34
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="PgVBbVrx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40A3024C34
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752550AbeGCLwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 07:52:35 -0400
Received: from 8bytes.org ([81.169.241.247]:45326 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752414AbeGCLwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 07:52:32 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 770F42F5; Tue,  3 Jul 2018 13:52:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1530618750; bh=i2GtK09yCudgz5FuFkHkfA7sjW59F7I4P1WlnuW6lwE=;
        h=From:To:Cc:Subject:Date:From;
        b=PgVBbVrx4PDc7zONB81VDZjdFu3LtM4Y+MyB8qGX0rb5i3NW80JhnJpSC9MhS8X+d
         aG0ZgLcigX49ZogXCAqv3OjTGHFgKCjTxigEyU6OAJerEE3BcyniGfohOc08wW4qZ6
         4QeOhVW+/rK4p06CuvOMrPu2dZacdp9gXKbXod5FG7DJjCcjD56vlO1cfOZwkCUZ0a
         YRbIKSvkSZ2sW9sAjuCT5jW2aep9TkdNxhSaI8NRsRAwJVOJOA77ICJTx/pbLrmBR6
         0MmctGs09aSvae3tMea0lPFYZtV+AmmFjEJoU0/hvcbcX+9S0M+bacJdk1RNobOeiQ
         lpZSwlfq43yvQ==
From:   Joerg Roedel <joro@8bytes.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Cc:     hpa@zytor.com, Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 0/3] x86/pti: Call pti_init() after mark_readonly()
Date:   Tue,  3 Jul 2018 13:52:23 +0200
Message-Id: <1530618746-23116-1-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here is a small patch-set to move the call to pti_init()
after mark_readonly() has run. The purpose of pti_inti() is to
initialize the kernel-mappings in the user-space page-table
by mapping kernel-text, entry-text, espfix and vsyscall
mappings into the user-space page-table.

These mappings only make sense when they have exactly the
same permissions as in the kernel page-table wrt.
read/write/execute with the global bit set (which we set in
shared mappings for performance reasons).

Since the mappings are copied only once and are not updated
later, we need to copy them when they are finished, which is
not before mark_readonly() has run.

Calling pti_init() earlier worked for now on x86-64 because
the sections that are cloned are at least 2M aligned and not
changed by later code. But that is still fragile because
pti_init() always needs special care when kernel mappings or
the elf-layout is changed or extended. Further it doesn't
work on x86-32 because the elf sections are not 2M aligned
there.

So move the call to pti_init() after all the kernel-mappings
have been finished.

Any useful feedback appreciated.


Thanks,

	Joerg

Joerg Roedel (3):
  x86/pti: Move pti_init() code out of __init
  x86/mm/pti: Call pti_init() after mark_readonly()
  x86/pti: Call pti_clone_kernel_text() from pti_init()

 arch/x86/entry/vsyscall/vsyscall_64.c |  2 +-
 arch/x86/include/asm/pti.h            |  2 --
 arch/x86/mm/init_64.c                 |  6 ------
 arch/x86/mm/pti.c                     | 19 ++++++++++---------
 init/main.c                           |  8 ++++++--
 5 files changed, 17 insertions(+), 20 deletions(-)

-- 
2.7.4

