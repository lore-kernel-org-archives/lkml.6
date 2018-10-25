Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C29EC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A8B20883
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5CXe9iv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A8B20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731395AbeJYWyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:54:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731324AbeJYWyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:54:08 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61FAE214ED;
        Thu, 25 Oct 2018 14:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477270;
        bh=ShUGdPE98f4v+zYVXpVXH5PMveT2TiNhHAcylM4Z3w0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M5CXe9ivBgEo8tTHbriHXtjJKmtfuftRQ7n7PNoRnbFbgl4Ynha2SC6mRrmSk1Bjl
         H/l2WAp1AVATYJH6OqWh6ZDdhHqyiVDX4PvFaSL6SUPmxq9G8xAOFvQ2MqA3vMHgkq
         qORweJdPdIWeWA/fkRhGns9oGnD5+dx/fNhitRhE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jan Beulich <JBeulich@suse.com>, Jan Beulich <jbeulich@suse.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        David Vrabel <david.vrabel@citrix.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 87/98] x86/ldt: Fix small LDT allocation for Xen
Date:   Thu, 25 Oct 2018 10:18:42 -0400
Message-Id: <20181025141853.214051-87-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Beulich <JBeulich@suse.com>

[ Upstream commit f454b478861325f067fd58ba7ee9f1b5c4a9d6a0 ]

While the following commit:

  37868fe113 ("x86/ldt: Make modify_ldt synchronous")

added a nice comment explaining that Xen needs page-aligned
whole page chunks for guest descriptor tables, it then
nevertheless used kzalloc() on the small size path.

As I'm unaware of guarantees for kmalloc(PAGE_SIZE, ) to return
page-aligned memory blocks, I believe this needs to be switched
back to __get_free_page() (or better get_zeroed_page()).

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: David Vrabel <david.vrabel@citrix.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/55E735D6020000780009F1E6@prv-mh.provo.novell.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/ldt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index 2bcc0525f1c1..6acc9dd91f36 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -58,7 +58,7 @@ static struct ldt_struct *alloc_ldt_struct(int size)
 	if (alloc_size > PAGE_SIZE)
 		new_ldt->entries = vzalloc(alloc_size);
 	else
-		new_ldt->entries = kzalloc(PAGE_SIZE, GFP_KERNEL);
+		new_ldt->entries = (void *)get_zeroed_page(GFP_KERNEL);
 
 	if (!new_ldt->entries) {
 		kfree(new_ldt);
@@ -95,7 +95,7 @@ static void free_ldt_struct(struct ldt_struct *ldt)
 	if (ldt->size * LDT_ENTRY_SIZE > PAGE_SIZE)
 		vfree(ldt->entries);
 	else
-		kfree(ldt->entries);
+		free_page((unsigned long)ldt->entries);
 	kfree(ldt);
 }
 
-- 
2.17.1

