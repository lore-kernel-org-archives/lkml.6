Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813DDC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 431DA20849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544676303;
	bh=zkAUfal45l9g3LqBJLr0ZfwiMqnzAmugf+weQIly7OE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mqm4fysKS5wIxGiq+FcH1UoqAnp6bsd2Sp+WFyN0cN4TdOlXgkn3BZrMnqzm48jMN
	 QCx33p6K+rGp2sUa/zj50s6PDjR3j870pwpvkq9XNq50hwvhM6aKP8Hn1r2tJHQhCP
	 XS3KKP4DqiC1+rIRzR1SeT85wZX3b8w9sUCqwwoQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 431DA20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbeLMEbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:31:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:43846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728577AbeLMEbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:31:02 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5C8D208E7;
        Thu, 13 Dec 2018 04:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675462;
        bh=zkAUfal45l9g3LqBJLr0ZfwiMqnzAmugf+weQIly7OE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v1RmEdgFQ+ElJ18UtqdCBIayw/wa7cgbYY2U5z3ifgpH57cyaEkXv5ihP5Oww45Rq
         Vhc7ZyGHgK0162/EhbAEjDVGgzJfFlJ/1dehPDNiiyDn06FA40zJXic90B2TiGQw7q
         ba3mhsMohl8yeQllTQurjhANyJrrWA6kjYC8Gptg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YiFei Zhu <zhuyifei1999@gmail.com>,
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
Subject: [PATCH AUTOSEL 4.14 05/41] x86/earlyprintk/efi: Fix infinite loop on some screen widths
Date:   Wed, 12 Dec 2018 23:30:18 -0500
Message-Id: <20181213043054.75891-5-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213043054.75891-1-sashal@kernel.org>
References: <20181213043054.75891-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YiFei Zhu <zhuyifei1999@gmail.com>

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

