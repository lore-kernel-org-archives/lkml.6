Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94470C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E4E120866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n0OTbyfU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E4E120866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbeIKXSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 19:18:46 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40995 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbeIKXSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 19:18:46 -0400
Received: by mail-pl1-f195.google.com with SMTP id b12-v6so11700266plr.8;
        Tue, 11 Sep 2018 11:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=xMTYmbu9TF8vr5DZNqn01viqMITsSTa74IIa+8P0Es4=;
        b=n0OTbyfUASsNyDohCmbBmd/7mPNiUXOAUW8SovDOeuCK3uQzaZkBpf7SwrKTdOD7lx
         SF7sTOWQaEunI74heGEeAJYVVZTLS5EERP/+79cA8QReFtpmXhlADdcvbrXS90zU1s6u
         sZG+YFC6AFZ7CtFE3tI9eTKtCX+aOxGwJAF0W4PZiPgGulmDtwZRUfYZ824RGhIebIwF
         gVHdsBgvi3pU5dV+UnlXs9bXPkfHjyY2S3RYq/1H7txK4UJCLMSL3ZNWL8ZHc3X1PhO8
         MGeZBLeSdRBO2LJVeoNesIyFUlEb8RtmqddyTuFNDMlOICJyJGuqjyuzRMdmrcl81ZIV
         6zHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=xMTYmbu9TF8vr5DZNqn01viqMITsSTa74IIa+8P0Es4=;
        b=tEAR0ffd5LvAKBXBhDypYvQDpKrG2Bi0qJ3YLDkpyuRoUQgCskNOflYuQCSkn+6JSN
         3t5f8R32ltLQYQwNNbGuqAXmjT9W8S7Jgnx+G3Ln6Ppf6IFmI4q9jEuydrSMmSwOUERY
         6pWU6XTWvSUPV3xvkd+z5rpUYn5jXhytdSQfhmQiMnxv+8vyEOkVM0CKUPIF2zZs4h1A
         S9sK5ghEwAsuKVNJCa8cStA7wcZzqzwmasM9xZHWrKZCMX7CVPNcB2eyHv8V+g4/9XGd
         S3qvOkd2Xe1bmsiRjQriExfaz/JAYuPDVUP00lBnKyJqn8W1Dw///kENuQWFGB+KqHKl
         fOlg==
X-Gm-Message-State: APzg51AJrD6rSL5wPlpmEQzlohJ2pERMv47krjm0sRV1d2QiEBtEfdm/
        ld6BPHSjbFDs8b8kmVXPaSkI17S+
X-Google-Smtp-Source: ANB0VdYPxB20cLtl1PtUWsEGbXmPxbfyd6+bVQveTcaQ1kaUv7qb5XWdz6PaLvAPnws/6Njzm4LpPw==
X-Received: by 2002:a17:902:5501:: with SMTP id f1-v6mr28293331pli.219.1536689895852;
        Tue, 11 Sep 2018 11:18:15 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id e26-v6sm24232765pfi.70.2018.09.11.11.18.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 11:18:14 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] x86/efi: Load fixmap GDT in efi_call_phys_epilog() before setting %cr3
Date:   Tue, 11 Sep 2018 11:18:12 -0700
Message-Id: <1536689892-21538-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit eeb89e2bb1ac ("x86/efi: Load fixmap GDT in efi_call_phys_epilog()")
moved loading the fixmap in efi_call_phys_epilog() after load_cr3()
since it was assumed to be more logical.

Turns out this is incorrect: In efi_call_phys_prolog(), we load the gdt
with its physical address, and when we reload the %cr3 in _epilog from
initial_page_table to swapper_pg_dir again the gdt is no longer mapped.
This results in a triple fault if an interrupt occurs after load_cr3()
and before load_fixmap_gdt(0). Calling load_fixmap_gdt(0) first restores
the execution order prior to commit eeb89e2bb1ac and fixes the problem.

Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Joerg Roedel <jroedel@suse.de>
Fixes: eeb89e2bb1ac ("x86/efi: Load fixmap GDT in efi_call_phys_epilog()")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/x86/platform/efi/efi_32.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/platform/efi/efi_32.c b/arch/x86/platform/efi/efi_32.c
index 05ca14222463..9959657127f4 100644
--- a/arch/x86/platform/efi/efi_32.c
+++ b/arch/x86/platform/efi/efi_32.c
@@ -85,10 +85,9 @@ pgd_t * __init efi_call_phys_prolog(void)
 
 void __init efi_call_phys_epilog(pgd_t *save_pgd)
 {
+	load_fixmap_gdt(0);
 	load_cr3(save_pgd);
 	__flush_tlb_all();
-
-	load_fixmap_gdt(0);
 }
 
 void __init efi_runtime_update_mappings(void)
-- 
2.7.4

