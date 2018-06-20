Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4687C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4863208B1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:29:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4863208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754089AbeFTO3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 10:29:06 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:54233 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752856AbeFTO3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 10:29:04 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0LkhLo-1g64mk1qBI-00aSCY; Wed, 20 Jun 2018 16:28:58 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Abhi Das <adas@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] gfs2: call ktime_get_coarse_real_ts64() directly
Date:   Wed, 20 Jun 2018 16:28:47 +0200
Message-Id: <20180620142857.33297-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:l3p5GxGN7knTndQjforCziNa6/BXQmpytg19Pzs0nO4oha8/vCr
 Kqz9XTW/E8zaWJy23JVOTL/+e9ahbYrxOO72pkBKub4yDgCFz/3+KFHIJhk6iPS0HArMoMh
 p9B23vG6wTrk5p71hK48SnCiIswVHOOVMDhS2ix30n8/70B4qv/r4oV7aIDl1VKmA6LMtxt
 JQdweWOVDKjVrpzKbizAg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:D7UryJOhb1g=:B4y5b3TPYgWyN0eMv45AR/
 IeoxFLCdBi+q2oyjHbUyzEBheYF+MPIWcwR0JQWEmjma9MVX7MsLDu8rNWuhdocpx7Z1lnGBR
 MKVwnFVXuxtH79SJfWQPsB4kOoSyUWjYVfCOhqc7RySxQX8wTohJ0d8Nk2W8OJ+OJ07ZBGZ09
 0ihR47tzeFVwoPN4F+W0i2sPHn4XnrPtSPZ1rdvIvwaEQSJbsXHobpX3a193J3WXVVMEe8TJ7
 1Cv9NQI4IzyW6/woQ5YCfj0ECaBwhewzA/lJ6d3CVXlvFtA1In32q9fcNi9QBWSMyFxJxFNGE
 H1B9X+o4zDm1W1t+L0WiTIYaT+jWvTjjzua5wgRaWBLcfkRz7ZrHMpcpZVso4IJEbnJnfkWzG
 qJ92biMNgOd5ZxHIIamBTbjUpsF2R6UFKu+3gsm/qSHoeaiY8OXr9apNDKi8CZ2gtUuLiaFII
 MaqzZ6/9e/8mTlaYeL2E0xvdbS+mF01wED78FAdrP/ESCtNlpX0Sxc9WJ2wofMWOLqkeMKv87
 cPLojF8lWna16mncKCUyGQPiYiaYBEmiEA60EifSaYEOqV/J5VyaFsRK8QfL1mXWOWOQcskBZ
 H/VI7ncnNXTh49AhqujN8fY+g4Q1iZTLEvTqtxPV3przpRjYy08VZ1leghdYsWicwji7PnRSJ
 8neSTJUeu3o6xv6mrajibnofGZRYS3hpFax5IgtELR6W+gU4+Pvq5Fhu5IBc00QdBy1M=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

current_kernel_time64() is now just a deprecated wrapper around
ktime_get_coarse_real_ts64(), so let's just call that directly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/gfs2/log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 0248835625f1..c7b1c0f75a55 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -689,7 +689,7 @@ void gfs2_write_log_header(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd,
 	hash = ~crc32(~0, lh, LH_V1_SIZE);
 	lh->lh_hash = cpu_to_be32(hash);
 
-	tv = current_kernel_time64();
+	ktime_get_coarse_real_ts64(&tv);
 	lh->lh_nsec = cpu_to_be32(tv.tv_nsec);
 	lh->lh_sec = cpu_to_be64(tv.tv_sec);
 	addr = gfs2_log_bmap(sdp);
-- 
2.9.0

