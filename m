Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1D9C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49BCE2081F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49BCE2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbeLIWO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:14:58 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:38122 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727019AbeLIWO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:14:57 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73C-0002io-9q; Sun, 09 Dec 2018 21:55:46 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72d-0003PW-V5; Sun, 09 Dec 2018 21:55:11 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Andy Lutomirski" <luto@kernel.org>,
        "Vitaly Kuznetsov" <vkuznets@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        "Borislav Petkov" <bpetkov@suse.de>,
        "Dmitry Safonov" <dima@arista.com>,
        "Rian Hunter" <rian@alum.mit.edu>, "Joerg Roedel" <jroedel@suse.de>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.560950681@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 150/328] x86/process: Re-export start_thread()
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Rian Hunter <rian@alum.mit.edu>

commit dc76803e57cc86589c4efcb5362918f9b0c0436f upstream.

The consolidation of the start_thread() functions removed the export
unintentionally. This breaks binfmt handlers built as a module.

Add it back.

Fixes: e634d8fc792c ("x86-64: merge the standard and compat start_thread() functions")
Signed-off-by: Rian Hunter <rian@alum.mit.edu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bpetkov@suse.de>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Dmitry Safonov <dima@arista.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20180819230854.7275-1-rian@alum.mit.edu
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/process_64.c | 1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -254,6 +254,7 @@ start_thread(struct pt_regs *regs, unsig
 	start_thread_common(regs, new_ip, new_sp,
 			    __USER_CS, __USER_DS, 0);
 }
+EXPORT_SYMBOL_GPL(start_thread);
 
 #ifdef CONFIG_IA32_EMULATION
 void start_thread_ia32(struct pt_regs *regs, u32 new_ip, u32 new_sp)

