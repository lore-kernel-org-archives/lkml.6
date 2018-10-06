Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AC6C67871
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 18:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F75821473
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 18:46:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F75821473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbeJGBu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 21:50:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41877 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbeJGBu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 21:50:29 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w96Ijsgn3646355
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 6 Oct 2018 11:45:54 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w96IjsVu3646352;
        Sat, 6 Oct 2018 11:45:54 -0700
Date:   Sat, 6 Oct 2018 11:45:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-fa112cf1e8bc693d5a666b1c479a2859c8b6e0f1@git.kernel.org>
Cc:     mingo@kernel.org, bp@suse.de, linux-kernel@vger.kernel.org,
        hpa@zytor.com, tglx@linutronix.de, lkundrak@v3.sk
Reply-To: lkundrak@v3.sk, tglx@linutronix.de, mingo@kernel.org, bp@suse.de,
          linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <20181005131750.GA5366@zn.tnic>
References: <20181005131750.GA5366@zn.tnic>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/platform] x86/olpc: Fix build error with
 CONFIG_MFD_CS5535=m
Git-Commit-ID: fa112cf1e8bc693d5a666b1c479a2859c8b6e0f1
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

Commit-ID:  fa112cf1e8bc693d5a666b1c479a2859c8b6e0f1
Gitweb:     https://git.kernel.org/tip/fa112cf1e8bc693d5a666b1c479a2859c8b6e0f1
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Fri, 5 Oct 2018 15:13:07 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Sat, 6 Oct 2018 20:40:43 +0200

x86/olpc: Fix build error with CONFIG_MFD_CS5535=m

When building a 32-bit config which has the above MFD item as module
but OLPC_XO1_PM is enabled =y - which is bool, btw - the kernel fails
building with:

  ld: arch/x86/platform/olpc/olpc-xo1-pm.o: in function `xo1_pm_remove':
  /home/boris/kernel/linux/arch/x86/platform/olpc/olpc-xo1-pm.c:159: undefined reference to `mfd_cell_disable'
  ld: arch/x86/platform/olpc/olpc-xo1-pm.o: in function `xo1_pm_probe':
  /home/boris/kernel/linux/arch/x86/platform/olpc/olpc-xo1-pm.c:133: undefined reference to `mfd_cell_enable'
  make: *** [Makefile:1030: vmlinux] Error 1

Force MFD_CS5535 to y if OLPC_XO1_PM is enabled.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Lubomir Rintel <lkundrak@v3.sk>
Cc: x86@kernel.org
Link: http://lkml.kernel.org/r/20181005131750.GA5366@zn.tnic
---
 arch/x86/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1a0be022f91d..285b5d6a5ea5 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2742,8 +2742,7 @@ config OLPC
 
 config OLPC_XO1_PM
 	bool "OLPC XO-1 Power Management"
-	depends on OLPC && MFD_CS5535 && PM_SLEEP
-	select MFD_CORE
+	depends on OLPC && MFD_CS5535=y && PM_SLEEP
 	---help---
 	  Add support for poweroff and suspend of the OLPC XO-1 laptop.
 
