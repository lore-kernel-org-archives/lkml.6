Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E3DC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F269B21773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Srkq0XQg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfBLHKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:10:13 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40915 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfBLHKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:10:13 -0500
Received: by mail-pl1-f194.google.com with SMTP id bj4so855032plb.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 23:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8pLjLesSuhLAfDTWo9wzo0tP7B1KRUiRqW/Fsiv6QzE=;
        b=Srkq0XQgomiaSMWAcvhv+jEohHEg5wCq0NPhyPe9hJpYCvequGD74s5ZbZPg2ho1DP
         Z7veh55aiIY7eVkJF0FTjNdzi3odNJE9zeQCfiTXCCVTIg0eDl2CUpca5VMjrQrLKt3M
         HSISYKGx9/rvJrj2VZNjX/DthTKcSiuroRcR/pUfMW8WXTKhJ57gBitKKbt0gl6CtcP2
         gyZzkbnsHKDuhSOOkXzhzOFxoKFbi6caGcGOPhnaN9bvWPwBvR+geSiJPFUkgUpgwoRp
         YARlAiSpDAwhCEtnlig3yE5E8WcscHB1Lw4z5DIfK54rfffmOV4AW9d+INA7iHlGngyR
         xlgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8pLjLesSuhLAfDTWo9wzo0tP7B1KRUiRqW/Fsiv6QzE=;
        b=m6LTqifm2Q8ITesgUMNBSeuc1rZJ2y80TLV7R1IUBM/oCvmBMXFgy36D5uA6UjYj5r
         RJMHUXFbcxzIUz0sHL0GJJ6zquPwmCX2bbSYRkSc4jVHmF8+wt38ErkqaUefgHQkig/Q
         X0ZNhdeI9PNUuSZqRDz7cQv0YkyLIMazasSKBMGaDGOih0l9jvOUVl9e9NHuUVFEyKVr
         248KxADQ4N1EHFRgUOWJUzjQ3qYqRZtEBgO2mVSEyeDCQo6sEVHwgZAdx8lqZ/+0q/Ar
         u2PkYAgueTbOBmwaafTZ8divaCijjaoNWJJcXca7tcae1tuH9FV6SRWJZzmnVbQw+xCU
         jwfQ==
X-Gm-Message-State: AHQUAuZ+TVc/2KDciciSh5hxyGfqXTi+PsyzxtCvDSHMh+hfLnLMWU6T
        OfQB9/gr3CTWSFhgU3TLgsE=
X-Google-Smtp-Source: AHgI3IZ2O6B597s7/LojJ7S0vhhu9wPMFlwm2YxMjgFpO/pDNLeXJrpzcXRcBjM2pimzCH5j1gYBvw==
X-Received: by 2002:a17:902:346:: with SMTP id 64mr2556030pld.337.1549955412543;
        Mon, 11 Feb 2019 23:10:12 -0800 (PST)
Received: from localhost ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id g2sm15079293pfi.95.2019.02.11.23.10.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 11 Feb 2019 23:10:12 -0800 (PST)
From:   Jing Xia <jing.xia.mail@gmail.com>
X-Google-Original-From: Jing Xia <jing.xia@unisoc.com>
To:     labbott@redhat.com, sumit.semwal@linaro.org,
        gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, christian@brauner.io,
        puck.chen@hisilicon.com
Cc:     devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        jing.xia.mail@gmail.com, yuming.han@unisoc.com,
        zhaoyang.huang@unisoc.com, orson.zhai@unisoc.com,
        wenan.hu@unisoc.com
Subject: [PATCH] staging: android: ion: Use low_order_gfp_flags for smaller allocations
Date:   Tue, 12 Feb 2019 15:09:26 +0800
Message-Id: <1549955366-19930-1-git-send-email-jing.xia@unisoc.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gfp_flags is always set high_order_gfp_flags even if allocations of
order 0 are made.But for smaller allocations, the system should be able
to reclaim some memory.

Signed-off-by: Jing Xia <jing.xia@unisoc.com>
Reviewed-by: Yuming Han <yuming.han@unisoc.com>
Reviewed-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
Reviewed-by: Orson Zhai <orson.zhai@unisoc.com>
---
 drivers/staging/android/ion/ion_system_heap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/android/ion/ion_system_heap.c b/drivers/staging/android/ion/ion_system_heap.c
index 0383f75..20f2103 100644
--- a/drivers/staging/android/ion/ion_system_heap.c
+++ b/drivers/staging/android/ion/ion_system_heap.c
@@ -223,10 +223,10 @@ static void ion_system_heap_destroy_pools(struct ion_page_pool **pools)
 static int ion_system_heap_create_pools(struct ion_page_pool **pools)
 {
 	int i;
-	gfp_t gfp_flags = low_order_gfp_flags;
 
 	for (i = 0; i < NUM_ORDERS; i++) {
 		struct ion_page_pool *pool;
+		gfp_t gfp_flags = low_order_gfp_flags;
 
 		if (orders[i] > 4)
 			gfp_flags = high_order_gfp_flags;
-- 
1.9.1

