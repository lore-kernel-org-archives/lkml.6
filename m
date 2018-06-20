Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED3BC1B0F6
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ADE020836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ADE020836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754358AbeFTPeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 11:34:44 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:44891 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754297AbeFTPem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 11:34:42 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.129]) with ESMTPA (Nemesis) id
 0LfbNC-1fxnnW2sKQ-00pOJ3; Wed, 20 Jun 2018 17:33:52 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>
Cc:     y2038@lists.linaro.org, linux-ext4@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Jan Kara <jack@suse.cz>,
        Tahsin Erdogan <tahsin@google.com>,
        Miao Xie <miaoxie@huawei.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] ext4: use ktime_get_real_seconds for i_dtime
Date:   Wed, 20 Jun 2018 17:33:00 +0200
Message-Id: <20180620153322.54221-3-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180620153322.54221-1-arnd@arndb.de>
References: <20180620153322.54221-1-arnd@arndb.de>
X-Provags-ID: V03:K1:77Ay0kvre9eEXCP+7Do73N197ZmQxp5tyy1w2ShvryDjGW1P4ch
 qaJlRiiAdnYXZlKeR1LgS8cGfEM1E9RM2fDvIq0xasKmeimbIB9rzstYuoTOLeHj++Uw+7T
 3hFwXrhTVF35vaTkO38GzWnKZstwH2ukIIlWG9zcZbYHAye1xEPwYx7AYP6QkuACwsnR15m
 +BCN6jFfXo3hlxvvLU5ZA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:btxtYbaX/6A=:bCChF3C9ZVKhZE2XXftEkB
 Fi4hlG8aVieyETiVBXUvLVkL5iyp78KSXQyaWbwuQVtzXrHlWrCRrlm2YJAInyZ/6wKLWZQsk
 ws6hdaF9R3wa17wN+bMqSQ+rh66cXh4VklJbXqcK8Z/qC+rQcwW2SC1oSlkFxWoO719EGO1PI
 P8F0sINc7MQXPpDgJn7MH0Nif8TE2DK3tm8H2Xl10QULk0hlwpf24bigw9WS8MLLU5BnJuldf
 5LGT48+8N3priqHIQHwmtVcrhfJa560jFNBpzW2FrN5gNx4pd0yRQppZkOTf1glmMCLGVyB6n
 V1dkTMS2x95hrdUPHq55hGCwuG5LvfH5l034wgFdM6DcMHEGvYZEsDFznQuKEp3Dn6a/fRpDY
 8qSsVsAAEVesTCD/fTaDMKZ827xKHfE6QFfsnUKtkEbx4WNE5gxRNQ3lIQ3u6JmNYMBMvYSTU
 TCdNhP6cAyOx4qSpTaNt9LW9WjoDR9dScm7Nx2IMbfqDCGDfDvQcICu5cfb5aHlh+/mLC0A/g
 TLugKh0z11nqubHdF8+UvUzkektyO0xfQuX0H6zH0Bm1xMao9NcZ0Jwq6yHjfNyYLq3guPob/
 meRjplQwRUloTBzmvEEXfmwpVOPM4KDC1zdwYEpXFMPJoXwmnCJuCmNSBnZrmO7hmsv3QzyZO
 4oJdxRH/Jma2tNBCNTW2Y9D8TKsLlLbzgcLLJjFhWOFEKgzmbRtEnwLg6tuVf/gapM6g=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We only care about the low 32-bit for i_dtime as explained in commit
b5f515735bea ("ext4: avoid Y2038 overflow in recently_deleted()"), so
the use of get_seconds() is correct here, but that function is getting
removed in the process of the y2038 fixes, so let's use the modern
ktime_get_real_seconds() here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/ext4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 2ea07efbe016..600e2063d1df 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -317,7 +317,7 @@ void ext4_evict_inode(struct inode *inode)
 	 * (Well, we could do this if we need to, but heck - it works)
 	 */
 	ext4_orphan_del(handle, inode);
-	EXT4_I(inode)->i_dtime	= get_seconds();
+	EXT4_I(inode)->i_dtime	= ktime_get_real_seconds();
 
 	/*
 	 * One subtle ordering requirement: if anything has gone wrong
-- 
2.9.0

