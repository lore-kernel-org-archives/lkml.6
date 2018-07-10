Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92449C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F6B2089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59F6B2089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934059AbeGJPWi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:22:38 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:52231 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933359AbeGJPWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:22:36 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue104 [212.227.15.145]) with ESMTPA (Nemesis) id
 0M2dAz-1ftTNn3IEn-00sKDg; Tue, 10 Jul 2018 17:22:18 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dave Young <dyoung@redhat.com>,
        Namit Gupta <gupta.namit@samsung.com>,
        Nikitas Angelinas <nikitas.angelinas@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] printk: remove unused suppress_message_printing()
Date:   Tue, 10 Jul 2018 17:22:10 +0200
Message-Id: <20180710152216.2393454-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:mC9H8IdobZU41vI5YvPRMBV3xaOW2ZprvcdNkbTq0MmqyTKqUEY
 uF1JgcNBc3pwacuwyglvEHimngSmVD2Aqnvbm51R/RP5SlCHT3DSp3xthQo8MqJfGElZEXn
 GXW2TFsrQK5RfiKKCud+8L5cRbTTRxcwiaUEQXk45Q9GoLV0ZLtW8kO3gOPvLBBy088Sg2W
 Ifa6PKruQHs6bmUELL4Vw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6htTifwGRLM=:7s0q7wBCMeEAdSERy834/7
 WtJhq7c7wYXI0XL+6640GwgNlbmEUJwOQPHoJ4J1Pl61fjuIkJQLC9XHCw9GVcSULRfssVZlu
 VCyW4RGTokGa+y2lbHdeci4AcgtsaqiIkhHCEdy8bh69mBzf87DaT59su2/ZHbGnfFNov7NQu
 6D/koqKhD3sFb1btOhSFk+KdnYoki/Fj15rSLdZ6E9P8DtIoKCkL6GDY7b5p+nvPLfppb3DUC
 q9mwOi/8xqRY2mhuJipJQkyDkoPwDlu9cklPxRNDaVgNIAU+spyylRRKlY2Akbp+YL2IL/3FD
 F3jcmke2x06A78aeCcsr+Z1C4tGu7TPReh1ljIUfzXFeZuUQDUguDTTdyMbYyumHnXdID3tdP
 BDbw0Bx6qlCr5SO4fcm0NiqQOZHLPzIarIyL1XpKrxUgbOaKV3F2PhfNr+5zj2vNc6b1AqufZ
 C/SPyDIz8mdkxwXyP4wihxvS//4Nh3ZIRok6ntJCWtBqHadEiqjnjtp0bvbK6+Zfss29AmsPX
 mwJ2xm+99AR7L53wOuyB1jqlwuSlXFfYDWb5QHozTThjNa2vXvmYjTm6ooV/YbENRDi9SR6MX
 4FSKjevsEtT6B+BaWxbAV8McHnFgCzFKOOt5Vi/wP5YdLAvXyZfybmDrl1Uda1xXzO2hSC5gC
 qAm6chXK0BbduOhjadtQ1/lPgYFHZ3R6A/FYqdr/iIrz1pEPMtO+Xx37PnjdArf1WzhQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving the call to suppress_message_printing() into the '#ifdef CONFIG_PRINTK'
section means that the alternative definition is now unused when PRINTK is
disabled:

kernel/printk/printk.c:2033:13: error: 'suppress_message_printing' defined but not used [-Werror=unused-function]

This removes the stub function.

Fixes: 375899cddcbb ("printk: make sure to print log on console.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/printk/printk.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 4ca0f9bca82c..e015ac4ee367 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2030,8 +2030,6 @@ static void call_console_drivers(const char *ext_text, size_t ext_len,
 				 const char *text, size_t len) {}
 static size_t msg_print_text(const struct printk_log *msg,
 			     bool syslog, char *buf, size_t size) { return 0; }
-static bool suppress_message_printing(int level) { return false; }
-
 #endif /* CONFIG_PRINTK */
 
 #ifdef CONFIG_EARLY_PRINTK
-- 
2.9.0

