Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C65C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 567C120877
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:19:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 567C120877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751412AbeGJJTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 05:19:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:56626 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751213AbeGJJTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 05:19:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 555DEAD76;
        Tue, 10 Jul 2018 09:19:10 +0000 (UTC)
Date:   Tue, 10 Jul 2018 11:19:09 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vaneet Narang <v.narang@samsung.com>,
        PANKAJ MISHRA <pankaj.m@samsung.com>
Subject: Re: linux-next: build warning after merge of the printk tree
Message-ID: <20180710091909.rwgtahcew6grhd6n@pathway.suse.cz>
References: <20180710164514.22c552db@canb.auug.org.au>
 <CGME20180710064527epcas1p16fd9ad765711d69264b3251890bbcc2e@epcms5p5>
 <2014348883.271177.1531206974788.JavaMail.jboss@ep1ml503>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2014348883.271177.1531206974788.JavaMail.jboss@ep1ml503>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-07-10 12:46:14, Maninder Singh wrote:
> Hi Petr,
>  
> > Hi all,
>  
> > After merging the printk tree, today's linux-next build (x86_64
> > allnoconfig) produced this warning:
>  
> > kernel/printk/printk.c:2033:13: warning: 'suppress_message_printing' defined but not used [-Wunused-function]
> > static bool suppress_message_printing(int level) { return false; }
>              ^~~~~~~~~~~~~~~~~~~~~~~~~
>  
> seems there is no user for suppress_message_printing when CONFIG_PRINTK is disabled,
> because earlier it was getting used in console_unlock and now we shifted this into vprintk_emit
> which will be disabled on disabling CONFIG_PRINTk.
> 
> should we remove this defination when CONFIG_PRINTK is disabled ?
> 
> > Introduced by commit
> >  375899cddcbb ("printk: make sure to print log on console.")

Grr, I wonder how I missed it. I usually try build with CONFIG_PRINTK
disabled.

Anyway, I have just pushed the following patch into printk.git,
branch for-4.19:


From 7b83946e61a1e4a080d48c24396aeb18b6366203 Mon Sep 17 00:00:00 2001
From: Petr Mladek <pmladek@suse.com>
Date: Tue, 10 Jul 2018 10:44:53 +0200
Subject: [PATCH] printk: Fix warning about unused suppress_message_printing
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

suppress_message_printing() is not longer called in console_unlock().
Therefore it is not longer needed with disabled CONFIG_PRINTK.

This fixes the warning:

kernel/printk/printk.c:2033:13: warning: ‘suppress_message_printing’ defined but not used [-Wunused-function]
 static bool suppress_message_printing(int level) { return false; }

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Suggested-by: Maninder Singh <maninder1.s@samsung.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index fcc1992c040a..e2cb0fc18e2d 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2021,7 +2021,6 @@ static void call_console_drivers(const char *ext_text, size_t ext_len,
 				 const char *text, size_t len) {}
 static size_t msg_print_text(const struct printk_log *msg,
 			     bool syslog, char *buf, size_t size) { return 0; }
-static bool suppress_message_printing(int level) { return false; }
 
 #endif /* CONFIG_PRINTK */
 
-- 
2.13.7


