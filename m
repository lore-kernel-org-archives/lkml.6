Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6655EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32FBC217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298020;
	bh=Ruo0XwTyg3PADOlTU1Z9wP0mQuz30Wb2HFovacYqTgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ORLptL8Jdz3GhU4Z9yCqDDskXZHJVrFhpKtYLv0oD92DbAt7UD99uEf/g0yLaaOJN
	 OL43jF+dca+v13+L5Z9rbM0qSoquC/chqOjBU0wERuFDWka9OG8NzAqydJ0WqBB7Vm
	 u+QwXIS4uYChsP/gSyV7FDA+98znIzkgizfDsEX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbeLTJ07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:26:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:59654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732190AbeLTJ04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:26:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70549218AE;
        Thu, 20 Dec 2018 09:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298014;
        bh=Ruo0XwTyg3PADOlTU1Z9wP0mQuz30Wb2HFovacYqTgU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1J3OYy+TmYksDPUCQacwTR6SSzp51KnyC521lqQG3zUj/H8LGJvDPxh0W+K/ynbsl
         S7FWqR0wtw/z5b4/rda8tOECw4hpjiOuCp+3e4R3RHNOXfrgHpckz9e1m12YpTfpJO
         Z3PNOv/GG4KPEpbZfYig4GNeojPfnOMWiKELRaJE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YiFei Zhu <zhuyifei1999@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Joe Perches <joe@perches.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 40/72] x86/earlyprintk/efi: Fix infinite loop on some screen widths
Date:   Thu, 20 Dec 2018 10:18:39 +0100
Message-Id: <20181220085923.925075636@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085922.332225035@linuxfoundation.org>
References: <20181220085922.332225035@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 79c2206d369b87b19ac29cb47601059b6bf5c291 ]

An affected screen resolution is 1366 x 768, which width is not
divisible by 8, the default font width. On such screens, when longer
lines are earlyprintk'ed, overflow-to-next-line can never trigger,
due to the left-most x-coordinate of the next character always less
than the screen width. Earlyprintk will infinite loop in trying to
print the rest of the string but unable to, due to the line being
full.

This patch makes the trigger consider the right-most x-coordinate,
instead of left-most, as the value to compare against the screen
width threshold.

Signed-off-by: YiFei Zhu <zhuyifei1999@gmail.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Joe Perches <joe@perches.com>
Cc: Jon Hunter <jonathanh@nvidia.com>
Cc: Julien Thierry <julien.thierry@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20181129171230.18699-12-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/platform/efi/early_printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/efi/early_printk.c b/arch/x86/platform/efi/early_printk.c
index 5fdacb322ceb..c3e6be110b7d 100644
--- a/arch/x86/platform/efi/early_printk.c
+++ b/arch/x86/platform/efi/early_printk.c
@@ -179,7 +179,7 @@ early_efi_write(struct console *con, const char *str, unsigned int num)
 			num--;
 		}
 
-		if (efi_x >= si->lfb_width) {
+		if (efi_x + font->width > si->lfb_width) {
 			efi_x = 0;
 			efi_y += font->height;
 		}
-- 
2.19.1



