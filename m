Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45ACECDE4C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A88CC2148E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgJ37fdw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A88CC2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbeKIHeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:34:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:50418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728103AbeKIHeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:34:01 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0707221104;
        Thu,  8 Nov 2018 21:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714194;
        bh=Xiir64usdaUv84kM1vP2AR6koDe2+w5g6wAyQtEzN64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FgJ37fdwqN/mkjW51fg70Y/YcQQDgpk0pHQQsTS3YzspRh5TnMqRypOc0jkrDf0Hb
         nJSKCz3HbbUUj918MQ9xp2dx7TmHqFGK3m4RKZu+72XVPL//SJcW4tMTL7czZgYAZA
         5HIXnuyhfK8tH8JtnLbaHnTYACs69+h3WTs7qFLA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Beulich <jbeulich@suse.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        David Vrabel <david.vrabel@citrix.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 115/144] x86/ldt: Fix small LDT allocation for Xen
Date:   Thu,  8 Nov 2018 13:51:26 -0800
Message-Id: <20181108215106.300920029@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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



