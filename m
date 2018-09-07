Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7D1C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 620372075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 620372075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbeIGP3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 11:29:50 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41740 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728308AbeIGP3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 11:29:49 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NnKQYubhVAmn; Fri,  7 Sep 2018 12:49:25 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCC4300329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcc:4300:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6593F1EC0322;
        Fri,  7 Sep 2018 12:49:25 +0200 (CEST)
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Juergen Gross <jgross@suse.com>, x86@kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH] x86/paravirt: Get rid of patch_site label
Date:   Fri,  7 Sep 2018 12:49:17 +0200
Message-Id: <20180907104917.12502-1-bp@alien8.de>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

When CONFIG_PARAVIRT_SPINLOCKS=n, it fires

  arch/x86/kernel/paravirt_patch_64.c: In function ‘native_patch’:
  arch/x86/kernel/paravirt_patch_64.c:89:1: warning: label ‘patch_site’ defined but not used [-Wunused-label]
   patch_site:

but that label can simply be removed by directly calling
paravirt_patch_insns() there.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Juergen Gross <jgross@suse.com>
Cc: x86@kernel.org
Cc: virtualization@lists.linux-foundation.org
---
 arch/x86/kernel/paravirt_patch_64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/paravirt_patch_64.c b/arch/x86/kernel/paravirt_patch_64.c
index 5ad5bcda9dc6..f09d264cbd2d 100644
--- a/arch/x86/kernel/paravirt_patch_64.c
+++ b/arch/x86/kernel/paravirt_patch_64.c
@@ -76,7 +76,8 @@ unsigned native_patch(u8 type, void *ibuf, unsigned long addr, unsigned len)
 			if (pv_is_native_vcpu_is_preempted()) {
 				start = start_lock_vcpu_is_preempted;
 				end   = end_lock_vcpu_is_preempted;
-				goto patch_site;
+
+				return paravirt_patch_insns(ibuf, len, start, end);
 			}
 			goto patch_default;
 #endif
@@ -86,7 +87,6 @@ patch_default: __maybe_unused
 		ret = paravirt_patch_default(type, ibuf, addr, len);
 		break;
 
-patch_site:
 		ret = paravirt_patch_insns(ibuf, len, start, end);
 		break;
 	}
-- 
2.17.0.582.gccdcbd54c

