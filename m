Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC882C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F55208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70F55208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932602AbeFTIcy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:32:54 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:40021 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbeFTIcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:32:51 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MYvrP-1fiaQx0I4p-00VjOU; Wed, 20 Jun 2018 09:50:44 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, linux-nilfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nilfs2: use 64-bit superblock timstamps
Date:   Wed, 20 Jun 2018 09:50:26 +0200
Message-Id: <20180620075041.4154396-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:sn75UZGuQLxG66saQVUywZfkfjsQ1TY90Nz0T0U06RJkHTK+BPK
 +EIRBVfxkGAdh34E+yEy/Od8B8Z6tv25ik3J0z6TMQgWhuWX4zaqx2dLkXEUJgjulhBCg+e
 Ne53+TPwemJVIIIBefTg9NvqGbzRt9sMGC0Wcv+vpek/JbQf2yh2thExKv5E/qVhuLnPOuv
 6ZVEn0lYV8HzEZxms0kdA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kSvg6QS/uS4=:MreyxY57RyNtcY2c+Sm8fj
 2mB3FObbWXTdqIvjWjJbKTUu8KyWps/dhTG+OWwCpURPDokbnPTB+iZW3tQH4kGpcO43BeLz3
 SMXsRBcO2AyX6ngfTLuMaxD/ym0Fv+MjTpRuskl0L0Kh22S8cmJ/DjzxVcxgHe/9I9HKn1Srg
 A1o4DHbiPk6bbYIkLOgeSgLJ/4RiVXreS3RiHfBuVtYDNy+oHk7/YFBQ3m5dBNbLKjUSbnrWy
 APchkXCGrWiKWrlJCm6p7xxA23cIH5nEyvPC0uNOUiJoB4cnLc0aKBQPXKik8iGL2/YuWBo3Z
 GGW2yap0nqTcYZf6QA8bkW3e3Ci2vl9GcWNR1ayBzEcJRuRs4mjgs1YCeDkibsqyCNHTd0jeU
 A6pF3BX4GOAUhF8rYLtbrbPGeZ6kdl58EUgrI22VUTa+KQ0Wai7zu/PC0Is7knBqsLT5wihFj
 GIKeLsBoosNBuUmzZ6MYr5w2gr2/cjv1a8TSm/IdLb3ar4ZIvy1j8rtgkekwlzURNr2fCrlfI
 Ea0Es/MVbLOVlSbQU5f5ZLYp63BJdNp9qSzIAmy/5yX/iE2IWqt8zRWL52gs9HprlkqgN8pgZ
 HcUSpmp6bu4PTxRvbBCeuVxm7EPMk0zGmexd3JBPMKJvDszPkrUuhZu4tmQTXfuDnZgUJNLId
 s5zRStiQnGDu1zNWpl9k8FAJpSapus/iadm2iu0EkZQHmB3DOql9NZoBA2rqmSud57YA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mount time field in the superblock uses a 64-bit timestamp, but
calling get_seconds() may truncate the current time to 32 bits.

This changes it to ktime_get_real_seconds() to avoid the potential
overflow.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/nilfs2/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
index 6ffeca84d7c3..1b9067cf4511 100644
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -834,7 +834,7 @@ static int nilfs_setup_super(struct super_block *sb, int is_mount)
 		sbp[0]->s_max_mnt_count = cpu_to_le16(NILFS_DFL_MAX_MNT_COUNT);
 
 	sbp[0]->s_mnt_count = cpu_to_le16(mnt_count + 1);
-	sbp[0]->s_mtime = cpu_to_le64(get_seconds());
+	sbp[0]->s_mtime = cpu_to_le64(ktime_get_real_seconds());
 
 skip_mount_setup:
 	sbp[0]->s_state =
-- 
2.9.0

