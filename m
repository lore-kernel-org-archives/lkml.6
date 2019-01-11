Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3BCC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A099D21783
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfAKUkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 15:40:04 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37913 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfAKUkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 15:40:02 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0BKds2Z805158
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 11 Jan 2019 12:39:54 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0BKdsBv805155;
        Fri, 11 Jan 2019 12:39:54 -0800
Date:   Fri, 11 Jan 2019 12:39:54 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Daniel Drake <tipbot@zytor.com>
Message-ID: <tip-7e6fc2f50a3197d0e82d1c0e86282976c9e6c8a4@git.kernel.org>
Cc:     drake@endlessm.com, hpa@zytor.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          mingo@kernel.org, hpa@zytor.com, drake@endlessm.com
In-Reply-To: <20190107034024.15005-1-drake@endlessm.com>
References: <20190107034024.15005-1-drake@endlessm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/kaslr: Fix incorrect i8254 outb() parameters
Git-Commit-ID: 7e6fc2f50a3197d0e82d1c0e86282976c9e6c8a4
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  7e6fc2f50a3197d0e82d1c0e86282976c9e6c8a4
Gitweb:     https://git.kernel.org/tip/7e6fc2f50a3197d0e82d1c0e86282976c9e6c8a4
Author:     Daniel Drake <drake@endlessm.com>
AuthorDate: Mon, 7 Jan 2019 11:40:24 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 11 Jan 2019 21:35:47 +0100

x86/kaslr: Fix incorrect i8254 outb() parameters

The outb() function takes parameters value and port, in that order.  Fix
the parameters used in the kalsr i8254 fallback code.

Fixes: 5bfce5ef55cb ("x86, kaslr: Provide randomness functions")
Signed-off-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: bp@alien8.de
Cc: hpa@zytor.com
Cc: linux@endlessm.com
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20190107034024.15005-1-drake@endlessm.com

---
 arch/x86/lib/kaslr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/lib/kaslr.c b/arch/x86/lib/kaslr.c
index 79778ab200e4..a53665116458 100644
--- a/arch/x86/lib/kaslr.c
+++ b/arch/x86/lib/kaslr.c
@@ -36,8 +36,8 @@ static inline u16 i8254(void)
 	u16 status, timer;
 
 	do {
-		outb(I8254_PORT_CONTROL,
-		     I8254_CMD_READBACK | I8254_SELECT_COUNTER0);
+		outb(I8254_CMD_READBACK | I8254_SELECT_COUNTER0,
+		     I8254_PORT_CONTROL);
 		status = inb(I8254_PORT_COUNTER0);
 		timer  = inb(I8254_PORT_COUNTER0);
 		timer |= inb(I8254_PORT_COUNTER0) << 8;
