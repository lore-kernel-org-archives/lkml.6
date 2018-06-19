Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076C9C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B516020661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:44:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B516020661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966784AbeFSPok (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:44:40 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:35599 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964999AbeFSPoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:44:38 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue006 [212.227.15.129]) with ESMTPA (Nemesis) id
 0LfcCc-1fya533Zww-00pMdY; Tue, 19 Jun 2018 17:44:36 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     y2038@lists.linaro.org, Jan Kara <jack@suse.cz>,
        Arnd Bergmann <arnd@arndb.de>, reiserfs-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] reiserfs: use 64-bit values in print_time
Date:   Tue, 19 Jun 2018 17:43:15 +0200
Message-Id: <20180619154343.3640484-3-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180619154343.3640484-1-arnd@arndb.de>
References: <20180619154343.3640484-1-arnd@arndb.de>
X-Provags-ID: V03:K1:52k9zeNWrwsdYEhT04fve0Mkyatoe2paE7NXA9DXR/xTGb+bCSi
 74f2ak6fl7sNyt2UYeSlbTtWDhq6IdxOunhsbQ7PUPkTaO4A8qIetj8W9Qq1C/t5v+1A9mW
 wfaQfH3RVZRLveDO/7B6E8HI16NPKh/tr35uw35pgomT19FancGashdlC7ljOvdeakojhsH
 0ia9Ou6Sf1xJyMs2OyPTQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Aacv8960YZY=:GvqKP78lPufsLVgzPi1PEt
 p35ys5uba0cpcKTZ6Lq/kgtpNrCWAJzxsalEbAF7b91ZklbOjaLnCz6kODU8/5f8tKoiiRINj
 sI82PNwsA65oBgBqrC5P2gfZslC1h/ZOBAhuqSa9jn95PhZq+fwqHfX0Kpn+48CHLbzaeE4u1
 CBFj2/pdJfyqfAi3R/5pMRjs8aeaCxvhMSg1n31tk0hLV8yP3OSrHvX79QqLmsM83D2hgfNq+
 Hg2T6uY8bmE3LgTLwNWcaIk2E+qwmHrDqlWGDbchSwOh14JxbODUUbG5FRYrmd9LvscIRdWfX
 T0+BvrcdC4sy1Kh3GQ3vZd92AOtraO5toYk63VGdUih9leeFSBMKRwOhH3wmGK4AfucTKfJ/m
 K7I1TsB2dLSJYqV4fTL+FEmPjoomKcEqDa73A79do82EJPmS4uQMp4QHj01OBQUGQxFEXC+Kg
 iPXYVsEJ2Bm1SkgFgcMBverftGIr3jR7aRB1vMhib0o/+CGpjGCSdCY4AU/av+hPUBfe6iPbx
 Niew5gZEyCt9Ldo5uzfwyrm3Jpv8p9m/oKPO2N7ajDysU27opmr2ygmSJWd6Dh1L/7WP+yS8i
 wUfe1Qb4Y0ZsNIZdUwT7I4UVZ7j+S4Ywa3RW1Cs/lYXAZBOmNnzZNmQtFfFeewIqAWi2FOGcL
 plbKs5Qh2TgGjzTF0MryIF2hrQ5ObJY52p1TbXFD0SZj3GTJ0vHcfVYXWYaG7ct5g4NA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inode timestamps are now 64-bit wide even on 32-bit machines, and reiserfs
interprets the 32-bit on-disk timestamps as unsigned when returning them
to user space with statx(), so for consistency we should print them
the same way in the emergency console logs.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/reiserfs/item_ops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/reiserfs/item_ops.c b/fs/reiserfs/item_ops.c
index e3c558d1b78c..d0ab3a763962 100644
--- a/fs/reiserfs/item_ops.c
+++ b/fs/reiserfs/item_ops.c
@@ -33,11 +33,11 @@ static int sd_is_left_mergeable(struct reiserfs_key *key, unsigned long bsize)
 	return 0;
 }
 
-static char *print_time(time_t t)
+static char *print_time(time64_t t)
 {
 	static char timebuf[256];
 
-	sprintf(timebuf, "%ld", t);
+	sprintf(timebuf, "%lld", t);
 	return timebuf;
 }
 
-- 
2.9.0

