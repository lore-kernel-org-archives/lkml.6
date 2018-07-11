Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B567EC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59CFB20878
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59CFB20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732566AbeGKJSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:18:18 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:36257 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732496AbeGKJSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:18:16 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MI6MY-1fep6K2TB0-003s6C; Wed, 11 Jul 2018 11:14:50 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     adilger.kernel@dilger.ca
Cc:     arnd@arndb.de, jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, sirmy15@gmail.com,
        stable@vger.kernel.org, tgnottingham@gmail.com, tytso@mit.edu,
        y2038@lists.linaro.org
Subject: [PATCH v2 5/6] jbd2: replace current_kernel_time64 with ktime equivalent
Date:   Wed, 11 Jul 2018 11:14:13 +0200
Message-Id: <20180711091414.1494843-5-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180711091414.1494843-1-arnd@arndb.de>
References: <20180711091414.1494843-1-arnd@arndb.de>
X-Provags-ID: V03:K1:cVp0WYR2ZFIdEgbp9PF+Qdqd0SUXDYog7yfsgNUFUmd9mj8u2Cs
 aGL4HqKtEcPQgTMkfDdVWDNaD4AN2C9Ymm4GdkWPO+05GTFnwidcyCfW3cL3vP8JMO9A4wC
 cZgpBTsvRsolEphYT0vewKYZMOCzAXOp+ymz019x+Eb5h8cNXy48NcABJtAgyOA2efmRYu4
 qmuQZU4q5Y/nqvJFhGaag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:d3MQqQdD6FA=:YokxPCv4m6sBog4Pxap2mi
 IcNPusw86p7AQW0af+5kMQeBMMbLFNvCWWbOjhoxWOQYcO0vl0I/UKc36+NeBvF7bQX75evS/
 iUfPkB9HzlKooY8Ln6mENqcLcIhmgPcaxbL2Muuj80Y/ap5EMrcbOZ1weRnPkIXp4MtbGmT98
 vBTlxgQlTfIZMbYM86s0YE92TTmrGANq/Ot7y3k0b8QmfGRzidu5wd2CcyL3WUU5sulqR0aaV
 tF5lyz4H30vRD5Ldf4+HAbZLPSlUAMchrda3kXsTgnhFND0W1KkhGcn0sMThZrDzRlyKQHLSo
 QO4tOqLq/SI1ENwwNbclLboGiJawK8ERW9uv7q3zo55d+ZFbR0S40aXspMV2nib3sryTxJivG
 NtLp97AyOLBgVbCSXe0kPuEMaRwGnQgs042wCAbCGls7JegV+M67hlPWEM5+Iz5BlW0NOAZBz
 WlOPH48mwCYBvaqfxOB0+XZKhfALtzAedh6RLzGY4AnBvav7bmi+Wt2SOMaqwg2gzf/EwoxZA
 GGbl63vopkyxCjXpFE+ttCp8yrx9Ee91lgWP0URGHRrPgWm1DrdG5lF66a28vU2K6p8ejz/p5
 WufSe6JlWsMb6tQb/JTdOk+NCEt04fCfRWHHFl4WnoYLAcku+GWo3/AWdGZp+t/THS4hxiKTt
 CQpQmvrzrAkw8U0wh3iJPZaMQUDtBw0hUcjLS4eOle+5r5zduu/ZQKIrf0Wj/jmTzTAc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

jbd2 is one of the few callers of current_kernel_time64(), which
is a wrapper around ktime_get_coarse_real_ts64(). This calls the
latter directly for consistency with the rest of the kernel that
is moving to the ktime_get_ family of time accessors.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/jbd2/commit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 8de0e7723316..150cc030b4d7 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -121,7 +121,7 @@ static int journal_submit_commit_record(journal_t *journal,
 	struct commit_header *tmp;
 	struct buffer_head *bh;
 	int ret;
-	struct timespec64 now = current_kernel_time64();
+	struct timespec64 now;
 
 	*cbh = NULL;
 
@@ -134,6 +134,7 @@ static int journal_submit_commit_record(journal_t *journal,
 		return 1;
 
 	tmp = (struct commit_header *)bh->b_data;
+	ktime_get_coarse_real_ts64(&now);
 	tmp->h_commit_sec = cpu_to_be64(now.tv_sec);
 	tmp->h_commit_nsec = cpu_to_be32(now.tv_nsec);
 
-- 
2.9.0

