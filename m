Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13142C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCBC3208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:03:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCBC3208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964853AbeFRPDu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:03:50 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:45703 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934773AbeFRPDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:03:47 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MXHhV-1fgjvF43y1-00WHyw; Mon, 18 Jun 2018 17:03:33 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Dave Young <dyoung@redhat.com>,
        Xunlei Pang <xlpang@redhat.com>, Baoquan He <bhe@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] crash: print timestamp using time64_t
Date:   Mon, 18 Jun 2018 17:03:01 +0200
Message-Id: <20180618150329.941903-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:w03wT6vJO/pi4aWPc0WXIP4TcjBByuzb00xVaaJuA3rn4MLdVf/
 xaVCZTxH57oPx2vGkE6ky/iSuy+KMp+pKnd+0JoImIuMvdlD/Aecqls5hWjXaOHQDS0JVFH
 h7Oprz57Nq0gchzfFLTPYUeNrzlcy0HOcczoNw+4jWXMVMV+Ss+yJXks3QckjlxW6a+Y2+p
 rlZ7PfRir27H6aU0Mfhuw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XABJns4SUFo=:lFQpteQCeIeYoNgzxey6KU
 qTPcUC/AlL4eqae9kekqJTG8JGDMmA4aWu3NviJVtnPfH7B0y4KxIrwOnpsmw3cB+hGl2LFwG
 gVWanrfaNmV6pyDUNyNx3I4I1nWD0JTvMBvbjXeVHEqBghhwHFGXmxE1H1vmdVVapbNjRAbyn
 gvsbtC8CuNaxNhdZ6ug+VfFbFel7Lni24SSOSdiE18OysBkLctlqzlFVAakKGaTXgbDmXnOjB
 nnymZDLlKI7pYl5SIwWwofgxB4bMAW896Kp2qmoUvR0uPznYV0S19PyudUcCKdK7OR/sEBNB6
 vajjuyXZE07KtxotOjhO71J0/LxSEVVJ5BaLy23V9oBWbWPga7xTKvKZWrFsP4DFP1a/eS2QN
 bIuL16ZhECUSv4O4Qqel1axi3O/ogk7eTZukpKSA+EBhczqgHqAmpdqM/kspqxmm2Ys8N8Qpe
 JhUJxbVLrXoWOhXwBWH9VXHfkIS72hGZBp+HQIxsmcgJfZg5xagDbqRXxxq/S505AQFG9VWjt
 IDxwI4mXH0QOArHkIJT6UHnxl+CRQ+rltkCRT/fKT6/cIgIWu4DrM2+daIYyCeYhK/9VEGpLH
 KnqWOICZSNfmS5nqKsqTicFc5wBxQ2wvmqEC+uIWnj9wTJ1htJRg0TqP3rCehHPCIkQujhkMk
 ZXuW2FMHyEB00uCZIvu323mJEuDV4CJiBOfhab/5lPViBtdmNR/wx3COzYICQLL8W6nQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The get_seconds() call returns a 32-bit timestamp on some architectures,
and will overflow in the future. The newer ktime_get_real_seconds()
always returns a 64-bit timestamp that does not suffer from this problem.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/crash_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index b66aced5e8c2..9612b2571bd6 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -344,7 +344,7 @@ void crash_save_vmcoreinfo(void)
 	if (vmcoreinfo_data_safecopy)
 		vmcoreinfo_data = vmcoreinfo_data_safecopy;
 
-	vmcoreinfo_append_str("CRASHTIME=%ld\n", get_seconds());
+	vmcoreinfo_append_str("CRASHTIME=%lld\n", ktime_get_real_seconds());
 	update_vmcoreinfo_note();
 }
 
-- 
2.9.0

