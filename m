Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C5EC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F99C23E87
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F99C23E87
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933299AbeGFMt0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 08:49:26 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:50703 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932569AbeGFMtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 08:49:22 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue104 [212.227.15.145]) with ESMTPA (Nemesis) id
 0M1XmT-1gPota1r45-00tPRZ; Fri, 06 Jul 2018 14:49:03 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jessica Yu <jeyu@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: module: fix modsign build error
Date:   Fri,  6 Jul 2018 14:48:47 +0200
Message-Id: <20180706124900.3294525-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:xOGyPsidIog15L88nfSJv2PQVsq3aWtSU/GyaHNoNTFoyuZxc+x
 E9SpBcFCYUr2qngnvoVPwlYhL8OqLdjzKNnBZvSeMIShFaBKHYaelUFBqapkaC0d0mmB5p+
 yzlQARcnBN4nPHK3BLSlkTiDJB0/7P/x1PqrItvxUfTCu8ZIN20fzvugm9RBYfCo4PZYLCd
 /EMzcm4lTIgPF4wdi6rKg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ac1ydgGFRw0=:lFr7Hfj7f+1mYNkJDUzpmE
 iW98jm3xCPVV4OnkWjsfZiGUgrHx3iEa2LwunmT47OLSMNZWnhTNH3ECxd/2PVL0ANw2cqidn
 1FY0M+OBM0FblMIw8vmVaFCVL85+Ws5tEnAcCgOwyQjPcgAZeCJzFgQ9HZxpMlIb4Upapz1Pz
 PsJV/5Jtlpsx/lZPaQr18FLGG1XFh/ky4dgbGnA/8Pc6zyaFAMZsSx9KDYxrxb0PPp9wAMbBs
 Hz84JKuO6CnO9YRixrUIR2tkuT/ewO8r8dDh7d5gRMD6Tp3Aw1vm5gp9qqrrgZMfv9gC8H+Zv
 XDNTyjy+ZyVYq5mGRSLNOaofUnFYU0sUzPQRZDFGwQsjywwToQucjebiU6xRCig8SLEZTNOXk
 mcFtouz2xa+hC9ifb4dRp4s0TefojBP9V4Ri5WrvFJEx+MsM39JYHeOU+wpBg+CZq0NfgiDsT
 sapKx7/KStMqowc8uEKnIkTBDSPE6If1U6xwOLigIWh5ThRmJ9iNeG4mpZQB3qBEd+KVENaUO
 4/gaDw7zcXT15DqNtiqONcn3PUGa90YLnsjSYVdFr7veZKXBbuJJRu32AqP3tiJDSWUQ+q57H
 vVCjU4hFS2kmxCNUzc+nsqqNCO3m12ZAL75b+8g9Wq8DQ3Rj7nPaNSBLmSf1kn5j1aPbDsHC+
 tcykvKFHXQSFjcBFPV/9SfsqDPzXXpBghgVs503LSiYw6RYlBdpe6RtNzgYwyQNIwYhY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The asm/module.h header file can not be included standalone, which
breaks the module signing code after a recent change:

In file included from kernel/module-internal.h:13,
                 from kernel/module_signing.c:17:
arch/arm/include/asm/module.h:37:27: error: 'struct module' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
 u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val);

This adds a forward declaration of struct module to make it all work.

Fixes: f314dfea16a0 ("modsign: log module name in the event of an error")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I guess it would be useful if Jessica can pick this change up
in her tree that introduced the warning.
---
 arch/arm/include/asm/module.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/include/asm/module.h b/arch/arm/include/asm/module.h
index 89ad0596033a..9e81b7c498d8 100644
--- a/arch/arm/include/asm/module.h
+++ b/arch/arm/include/asm/module.h
@@ -34,6 +34,7 @@ struct mod_arch_specific {
 #endif
 };
 
+struct module;
 u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val);
 
 /*
-- 
2.9.0

