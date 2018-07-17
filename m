Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2326ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACBF32146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACBF32146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731821AbeGQO0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 10:26:10 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:57787 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731655AbeGQO0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 10:26:10 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue007 [212.227.15.129]) with ESMTPA (Nemesis) id
 0LgSHJ-1gQFoB0Ybt-00nxB3; Tue, 17 Jul 2018 15:52:38 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        David Sterba <dsterba@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Qu Wenruo <wqu@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Su Yue <suy.fnst@cn.fujitsu.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: fix size_t format string
Date:   Tue, 17 Jul 2018 15:52:27 +0200
Message-Id: <20180717135236.3673195-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:JyOdYsiPIyHvDRUYcZbth9ln505lBrfeOoym1L7Eu6yYKCDUoM9
 n+Ggtg7fWOzfvQljM9aL+Ry+VV2RKws3qVqcGKI2931SPr+8yvX7UB2xb9xuClk3EDODPu0
 Z69tm4631fUDH3gX6PlUqQpDZAkliNmsoSzYBrKwJ7rBlSUzAbLJHIUSrCfQH7Rt6s5BBdl
 EE0igGuWxXJnZuuBzNsGA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ulCBUS9ZOzE=:UmmKXZ0exd1Yw64irmBxui
 FfCzA7KiUwT1LQRzAA1VJV7fUtHLWhfDaOOdH/EZ8xAqYTOOJD9Y/Ipw68m2kjsvgO7CF2VIN
 Dq3L+hACZ3XdnBKXt+GEQe+vZAVxri7iBV/yQjH5tib9HD20vidH/QoErd9bFlxVCFsA6YNRS
 zFtepNyplzn5ZEyNEfasmtZdcdHIvXY0ZLDUTcWgA4N3V4RH3LfMQpLW/zWxvlJLewhT5A1dD
 b6cQ/w5Xn/zSYeMNufp5tFoEAG7sxoIBulJ8VidH4Ud0GjmVR1UeUI8EOgKjl2/4G2mWX5yHk
 9V5QmEMQju0tGUVv0ddT/bOaTONG0ZSYyzzOgoVBmcxJD7A3VvwZIUHKoUluhuxhQ8My0/H5I
 NlkCSJnXGZ4EibQmERCshDWESKsKqKlgEVQtthkkBS+9zcK0kfgs5eygVsjur48Gd0T1hrObd
 Ng855zSxsyLDEBr96kuZBbFUbLqaFpybPnoSgvUMEcIZgZk16LW7kAYnx8TTLZ314zQoGvRrk
 j7u0xXyGa/GOp3YHrGsVpesVmLrHIg95Damc6FhsXWDYs0TRHzLyZU5plFrvWTMQnLK6MMXpZ
 OmF4nb9KJeMXYllmftVBF4gmScvcJjRVFUUB0BWfH0MiobCIDnMZEAN3IQmZCbZkUgSvhK+r0
 Cf6eZfHISE2bWoNVxoH3LihyJXHJz9JYOaOGqPgAjCoNlDEwxcCFVMA6/E3kuJydfY54=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly added check_block_group_item() function causes a build warning
on 32-bit architectures:

fs/btrfs/tree-checker.c: In function 'check_block_group_item':
fs/btrfs/tree-checker.c:404:41: error: format '%lu' expects argument of type 'long unsigned int', but argument 6 has type 'unsigned int' [-Werror=format=]

The type of a sizeof() expression is size_t, which is correctly printed
using the %zu format string.

Fixes: 9dc16aad5660 ("btrfs: tree-checker: Verify block_group_item")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/btrfs/tree-checker.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index e9414c3f375e..4c82a628df85 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -401,7 +401,7 @@ static int check_block_group_item(struct btrfs_fs_info *fs_info,
 
 	if (item_size != sizeof(bgi)) {
 		block_group_err(fs_info, leaf, slot,
-			"invalid item size, have %u expect %lu",
+			"invalid item size, have %u expect %zu",
 				item_size, sizeof(bgi));
 		return -EUCLEAN;
 	}
-- 
2.9.0

