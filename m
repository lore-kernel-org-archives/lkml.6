Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084B8C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE79720872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:28:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE79720872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754438AbeFTN2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 09:28:31 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:47647 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754406AbeFTN23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 09:28:29 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue007 [212.227.15.129]) with ESMTPA (Nemesis) id
 0LbCQQ-1ftSRh0qaY-00kxUU; Wed, 20 Jun 2018 15:28:23 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     David Howells <dhowells@redhat.com>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        linux-cachefs@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] cachefiles: avoid deprecated get_seconds()
Date:   Wed, 20 Jun 2018 15:28:03 +0200
Message-Id: <20180620132820.16467-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:P8aFXgh8yseBHyQq3UsF/rAh7KigW1hA1ZbgzZ8pqtZEkm38DjJ
 oltBN2qJq8PmUuYh3u99tAjCe2IndUKw9al0Fz4HGxaZJYppMeRQKqx2O77nGpJriyzq6Xa
 /daKgBL6ohb3t7PwQDbZ9Tz3rFfxnVcyk+dNMPGxj+q9x7n4YUv7uNriTXIl3u5ltFm9FZO
 ol3fa4zb7vEnLSRPfHsYQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:f/tYAiz6nD0=:4CxgXuX9G6ZjVRTGNtNgBT
 2/oX6zR5/7j+OAtS1cmkeyuCAUgy0aJy54nXRdZSYMOEkkX152zaaSxuvZQZuk7sb9X6vD5pm
 Irg0f2p3gwG0TNg2CHexZt/12lXC75mEHEDkC04UYTjY+MAa70H9n8hT1/zCgi6uQoGfSI1X6
 /UmNEiHxxdtYMp0oliGwQWko1T6dVnUNJiiJIYRRYuChfkf+kOo7Uzw8cbL6pDhXsyxeM6fHa
 So9s+pdK7N0/S4eNcf7vIlVo9U1k+4fT1pK8E/yYTTL0AS6Y1uii3SlGKdQ1I6qnW7euPhd0P
 SqGyTLCBCQMdF3WOQ59SmwG8rBxwjPDko06Vowd8CHP7UeqkPfsuGf1LowjX3ACnWmIUsYyzA
 AA7cKc3Z+xUkeLzHKzzfaMT0GKDt6oSuV+W72e4r+xryc8GTwlNhO1i5dQW+Wv2pOfRLGufDo
 KeclG9TEcDrV9mZW5x1yBUHLbUnjBJFskwhb5SjHDs5bRmstLKxZf+eLXTrQsLW11zIe95zZW
 60x0L0R1aZgb1CMdS1B448uECB2I5C5tAKixdW16kqjw3hZ0fKxM6koXgm6rb5iO/3y2FS8HB
 ISVcNYVLO1RfIwTOJIyRmjZxzEkdsMlaUHVsVsI0QOPSGSv/lYHjHAmWlVGa7fLBuN9zBt2WG
 4Ftp2r44H80s7nHOXeoLfvKi7N674pT1KG0N2753KvVjMosZqEvDigkm+aWWJbNj+fpA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_seconds() returns an unsigned long can overflow on some architectures
and is deprecated because of that. In cachefs, we cast that number to
a a 32-bit integer, which will overflow in year 2106 on all architectures.

As confirmed by David Howells, the overflow probably isn't harmful
in the end, since the timestamps are only used to make the file names
unique, but they don't strictly have to be in monotonically increasing
order since the files only exist in order to be deleted as quickly
as possible.

Moving to ktime_get_real_seconds() avoids the deprecated interface.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: only change to ktime_get_real_seconds() without printing the
    extra leading digits
---
 fs/cachefiles/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index ab0bbe93b398..0a38978b8cd3 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -337,7 +337,7 @@ static int cachefiles_bury_object(struct cachefiles_cache *cache,
 try_again:
 	/* first step is to make up a grave dentry in the graveyard */
 	sprintf(nbuffer, "%08x%08x",
-		(uint32_t) get_seconds(),
+		(uint32_t) ktime_get_real_seconds(),
 		(uint32_t) atomic_inc_return(&cache->gravecounter));
 
 	/* do the multiway lock magic */
-- 
2.9.0

