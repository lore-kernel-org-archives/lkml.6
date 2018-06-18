Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7CEC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B154C20652
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B154C20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965084AbeFRJ5W (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:57:22 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:54357 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935593AbeFRJ5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 05:57:19 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.145]) with ESMTPA (Nemesis) id
 0LaaTv-1fvR4v1R1D-00mMr4; Mon, 18 Jun 2018 11:56:58 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: xmon: use ktime_get_coarse_boottime64
Date:   Mon, 18 Jun 2018 11:56:24 +0200
Message-Id: <20180618095653.1538471-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:K3qWwbYJPc/0FMoxy267GVAqqc3hnz7jWsMa1gYPT2HjARst7vv
 ZrsO2Jp0O68fl795Hx/f+3d+9f32OEqixHzP9p8D8qHYlD5kssl5LAWKLXqPFENwJNGiWdh
 uS5NvWHaBgCpjrg+eyMviHgm/X54FFl5VWAOJXFpURaooU396HYJuzul1jhiOy3c7z06YCD
 7jQdJmAt61FhzshCjm/jg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9o4fSSy/kCI=:ojttosg+6EHzDkKSG+U349
 oWAElekfUqsFTwFepEXEJj1pCBVn1dImnWc7RTmUugfpQXzKsianUHbH0cKK9W8zU5mhMhEfr
 lCfRANqMa0pW2E0DQsbmBRubz0z+3mHh33WHNy+9EGt2UsUe3WMpZg1pwAT9lNuXgmWeBHai4
 eKWj4GefsBYz2B6eYawZ69o/LTSYByf7iGRHEAS9CJm4dRbssUBaFF998xCrXBCJbF//zDXwn
 fJNpzFMfYNnK7NTUl8C4iEuYvFQFjp2yeRfYTIUwHq7k9GvI/VBKXyW18/vFSd4psS1KXXN0H
 ISXKWCksAGashXT4139b1DhsPrZw3Jz8XwlCtjZoouen6ePLmj66oaCqYKPQvpu9VYIpgcF+k
 LAaQSoMoFTXaJJjEhsnjIt9V/Pyf6lq0xeElAUilZq1oew2K/dQ8ISDDJ7zXhYhENZcfzsOHR
 mScouWPNKROQ1LS6HBxnBFqDFXbaR/E1Vzyjy3zw2ScXhxnRTaVxnpkRzkJ08+qjjc+sFrSDJ
 FBvcTEIPIS0/vb5a1UacPXEZ9LLAq/ZRwOwlaqFMPlfPDcpONQojJN5WqzSkYvbtVM3ZQh1E7
 x2tQEJS9DKqkEew6hORZRe5nJmwGPn/OY6iH6XFcJuMZqDXC8RbCctSccJbf9SqY/oDixsxuk
 iWOCm4givzIf/7ygwXKcwp9V7SkQdCM/BLZmdyAZsKZLJatjlcRvrm5RwqxMPM3b/DIQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_monotonic_boottime() is deprecated, and may not be safe to call in
every context, as it has to read a hardware clocksource.

This changes xmon to print the time using ktime_get_coarse_boottime64()
instead, which avoids the old timespec type and the HW access.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/xmon/xmon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 47166ad2a669..45e3d0ec1246 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -918,13 +918,13 @@ static void remove_cpu_bpts(void)
 static void
 show_uptime(void)
 {
-	struct timespec uptime;
+	struct timespec64 uptime;
 
 	if (setjmp(bus_error_jmp) == 0) {
 		catch_memory_errors = 1;
 		sync();
 
-		get_monotonic_boottime(&uptime);
+		ktime_get_coarse_boottime_ts64(&uptime);
 		printf("Uptime: %lu.%.2lu seconds\n", (unsigned long)uptime.tv_sec,
 			((unsigned long)uptime.tv_nsec / (NSEC_PER_SEC/100)));
 
-- 
2.9.0

