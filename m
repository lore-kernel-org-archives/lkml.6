Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 9uy4GTmVGlvJAgAAmS7hNA
	; Fri, 08 Jun 2018 14:40:18 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id CCFAE607A4; Fri,  8 Jun 2018 14:40:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3F99F60275;
	Fri,  8 Jun 2018 14:40:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3F99F60275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752754AbeFHOkQ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 10:40:16 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:46917 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751486AbeFHOkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 10:40:15 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MQcnt-1fqyhT1USr-00Tz5O; Fri, 08 Jun 2018 16:39:38 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fat: fix sector print
Date: Fri,  8 Jun 2018 16:38:52 +0200
Message-Id: <20180608143907.2620349-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:B2oRvm8W6ZPIfosZtGxjoVOgksHu8ReMJnJQmkkzYnWiovoSBp3
 NVbrDkJ1jalYwx1E4/PJC3iV/62juSkV2CCP5NXecE3H/aZGvRDCnldggZ19tGFVIejMaMK
 L3l8/d/YEepMugA2jT7Jy2uSTzDRjCR5/rh0D2BudL97OiR1NSKBgRSuyr76fhOoQYIM9EA
 tsnRNtWpOMgkxSyIz8MVA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EOfzXs3uVt0=:yPfaz7q6gWbkhSWxgqVa2P
 Y3RK84+MGHdiQDYejbYSEl0J9eXEQTopvfb/9G0CBXJZ0TtCtXWm3Dh1VRBE/eHYrzKudebSt
 RuUqL2JrmkA/vfsI/Ce3EEQGxLMWIugGOxvmbTOHrEgoBu+kpTC98LOo8sr2bxLceG9UV2CS5
 1Z8HYxADM16K0qKu1tKUhHfDM/S8qBvk4Kn45SMfspKjhbAC/xATUmlDGc5BzoJFzdWL+VY57
 mFxjJgemO6AgzyfHmFt8qYyY1BJ4v1Ku960bj4+hQZO+U/br9Ami/to2WX7HQ0R3A1pw98GlX
 hKZoCWe/h/jKAtxpq71tzpvfg2UvmKHYAaz+zmiYzjk0hcRAkd5mUmbyszM3mGXfB9f5N7Dib
 hrVcspzF/rY4O1LR4W0tgPV3cAtSdCaY614xPHMN/SsjEhknj480KLSL7o2NoW6hgMm5/y8nR
 DAjTrZHt0Z+rcozojwy/qOaLYxBoO2FRjOtaAkC6lhbc1VxDvIWe15EdQuC0jirMSsRVIsTDa
 tnl5SsplwFhPiNVcqihKmaXjuHJw8/0CWoVgwkp8cnkV9sgqVW7JivNaUaZvJM1U8OAFROZ1j
 IBEV5hK0ZQmBOxXyu61tlHItO0RXOepCR6E2DvrcqJKmZVykbEOdWhWDcqNIUVE4CMNaRv9Zq
 oIqS37uuHFKSl/CA+jX/ZKZxbIy0XbxaqhIBCO4mZNca7CkksaWwA/LlI5RxDaNVHhEo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Printing a sector_t using %ld fails when that is a 64-bit type on
32-bit architectures:

fs/fat/inode.c: In function '__fat_get_block':
fs/fat/inode.c:163:9: error: format '%ld' expects argument of type 'long int', but argument 5 has type 'sector_t' {aka 'long long unsigned int'} [-Werror=format=]
         "invalid FAT chain (i_pos %lld, last_block %ld)",

The common workaround is to cast the number to a 64-bit type and print that
as %lld, that works in all configurations.

Fixes: mmotm ("fat: use fat_fs_error() instead of BUG_ON() in __fat_get_block()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/fat/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index d380d0f844bb..d168df5a4a73 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -160,8 +160,8 @@ static inline int __fat_get_block(struct inode *inode, sector_t iblock,
 		return err;
 	if (!phys) {
 		fat_fs_error(sb,
-			     "invalid FAT chain (i_pos %lld, last_block %ld)",
-			     MSDOS_I(inode)->i_pos, last_block);
+			     "invalid FAT chain (i_pos %lld, last_block %llu)",
+			     MSDOS_I(inode)->i_pos, (u64)last_block);
 		return -EIO;
 	}
 
-- 
2.9.0
