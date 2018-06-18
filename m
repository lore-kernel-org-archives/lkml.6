Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9197DC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 542EE20850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:08:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 542EE20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964833AbeFRKI5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:08:57 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:57907 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934816AbeFRKIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 06:08:54 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.145]) with ESMTPA (Nemesis) id
 0Meu09-1fssHc1lNJ-00OUWW; Mon, 18 Jun 2018 12:08:05 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86: mce: always use 64-bit timestamps
Date:   Mon, 18 Jun 2018 12:06:46 +0200
Message-Id: <20180618100759.1921750-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:/gD/4FHZoPykeF9LtSxeOZYaiu25VmXC2YABBWG6FNwVJHtwEO3
 IG7lij89dOLso+z/KMNmrtQvTxWgoaCeu0hzOBngCObf9T23xqx+6C8abiTUICAlZdaX1HU
 4LgQKuxKRjEsfpTbRc6Bbxx4azethfLbPLm4yCVlhgGoogkAh4xSFCNjE4DwVlxB3Wtcm+h
 GnQd87PlKbgNPLvliaqHw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Pri8vuxQUpU=:c5MhX04gQ7ucHsrJwhJy46
 lMtpABvm2cI23XnijTzt2vhLbjC0eGUIn+rz0uYeFrPYVpiRrI+3FKf7UbDC01sFEGinidnSy
 D2KlMg0DATpXv4dN+TyEL7tVTGt4PRNprgzudrk0MPZiPi80Qb9nBWNyPKWTWg67v+87CWGMj
 F92YeEKLj6x9AQ2gkxJtuTz6NVAHvp0///j2EClpNN2Apm9ztnhsutrqeNFeOCIvzOzuj0jX1
 dN6i/qDRM7RprhfRQ+U0LYb5nbn93ujl2IfUw0EEXPZxg6F/PwuasuYVxmthCudy9EEIjc/fn
 IZmzZTqbynRZElyjF8gKWWqJmsL0AHD+Sg1uqqLYqbbw+avmZ3JDHMr9UMJTteGOCDYJswurT
 njlpRBlaup2ukbY9YNgw7HHC236v2Jw7yaZfnKi/lbNPBKtyAe3tgVdApVOJEH2YOfxNjW1Jh
 n8QtYjAFxJ2ah3fvufp1p3v6GTf+v9GCa75FczbcZyjSCic7CB1HEZ2v8JBsVxIdlfgu2q5uU
 udMB85DEJPGq4x+Dc6EXo0C9d0kn7DXCPXjodLhaUT/HgIMAJ+476wE0vwSWnNmY0ODu9KFDT
 DxY+1/IPpPSEvSztdbtYlNZrLK7SxwwfZiBdM0W7QANbB+XP8xoaMz7hTv3W8Udf4PGXYgsgk
 D6bMc2iymmsI+fAeIQ+zk1XUTAthsZMK6bP0V1zAGlN+ZuYOp2B1wac3l6qbnd7R/TVA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The machine check timestamp uses get_seconds(), which returns an 'unsigned long'
number that might overflow on 32-bit architectures (in the distant future)
and is therefore deprecated.

The normal replacement would be ktime_get_real_seconds(), but that needs to
use a sequence lock that might cause a deadlock if the mce happens at just
the wrong moment. The __ktime_get_real_seconds() skips that lock and is
safer here, but has a miniscule risk of returning the wrong time when we read
it on a 32-bit architecture at the same time as updating the epoch, i.e.
from before y2106 overflow time to after, or vice versa.

This seems to be an acceptable risk in this particular case, and is the
same thing we do in kdb.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/kernel/cpu/mcheck/mce.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index e4cf6ff1c2e1..b887415652ed 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -123,8 +123,8 @@ void mce_setup(struct mce *m)
 {
 	memset(m, 0, sizeof(struct mce));
 	m->cpu = m->extcpu = smp_processor_id();
-	/* We hope get_seconds stays lockless */
-	m->time = get_seconds();
+	/* need the internal __ version to avoid deadlocks */
+	m->time = __ktime_get_real_seconds();
 	m->cpuvendor = boot_cpu_data.x86_vendor;
 	m->cpuid = cpuid_eax(1);
 	m->socketid = cpu_data(m->extcpu).phys_proc_id;
-- 
2.9.0

