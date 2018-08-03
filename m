Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB74C43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 564E4214AB
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UteM/CVQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 564E4214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732079AbeHCB4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 21:56:18 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42718 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729790AbeHCB4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 21:56:17 -0400
Received: by mail-ed1-f67.google.com with SMTP id r4-v6so1553356edp.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 17:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=scEuEAYEvexUAVvb2WFzVZUqmOQ+6YCiFo8tGrrFykc=;
        b=UteM/CVQdJuu73bGr6iy7GOIEqBIQDen1l0J+5rk3OuQrw3L+ByTJFotWCH5zShctf
         zx7nnI+seWSVlgJt0mzakikrWIYoqbQ0KuN0wzyo1OrbM4aN9fh/caVPEBOOR91ZXLaD
         x799i5o1/4Z86hC3cYUHwegaPxtbZp41LcbH5X/ZOMJPkmZu/9QDimlufiDBAxj/uIe3
         SLWlNvHoYYdVZRiFpRV6xwpaWgO/aPPuUakPV90blTmia13Qo0CBdVJEd769t5/EFY4t
         EpaCXAlBZN/0mLNPHYFOHDAsb84NXRQtY7+un5JKuKIHcFwmttfYKVk2gvsMGhoy9Rdi
         p3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=scEuEAYEvexUAVvb2WFzVZUqmOQ+6YCiFo8tGrrFykc=;
        b=KXh9TIgjf8eQxVkcsw9c7bPD8mNo1moxnL/iAippL8gHqkwvMUJ+T4xfZywbQqGjZS
         dRVrAbL4/qEz4BlKMjAtDxZxwPiN4RHTtVEoqwZdggFS78sz3Os8EjYHqfjoPxBsdVJp
         e2N+y11hkJ0iW70RQb14V6chMCRewH1RS5mDmielkA67uBRxFEE/Jz1VNZ7zKqlEa0J/
         ntIe2j2m8q6K9e8A3vXdmuRRgamhUrB2ZXhA2u02hj4eZxN4Fo4dbaPFQADHi8r2ju0x
         JaPKAFFXeWrWW7KSHRlav1U8xPstAcKZBuruJf3qkU7liluuTmuCRca3Dl9KZeLGvh0H
         CjJw==
X-Gm-Message-State: AOUpUlH96WFx+sQNHx9QQy4LcuUpwN1CoCZYbYE7ldyZUtkxCi+5S4zC
        65k1D8CMEHgG3ydadrZsPpYRIzFe
X-Google-Smtp-Source: AAOMgpfsDr49YBPz4oKybeA0r7aGw3pxIU3scJqIZ0IBRP+a1RaAs4Udu34EowqXilOepGChVvBLqA==
X-Received: by 2002:a50:b8c5:: with SMTP id l63-v6mr5174027ede.80.1533254564695;
        Thu, 02 Aug 2018 17:02:44 -0700 (PDT)
Received: from localhost.localdomain ([109.78.209.16])
        by smtp.gmail.com with ESMTPSA id d11-v6sm1310843edo.39.2018.08.02.17.02.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 17:02:43 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 02/18] staging:rtl8192u: Remove member variable rx_gain_range_max - Style
Date:   Fri,  3 Aug 2018 01:01:55 +0100
Message-Id: <20180803000211.10589-3-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180803000211.10589-1-johnfwhitmore@gmail.com>
References: <20180803000211.10589-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The structure 'dig' defines a member variable, (rx_gain_range_max)
which is initialised to the value 'DM_DIG_MAX', (a defined constant).
The variable is then used to test and set another variable. Since
the member rx_gain_range_max is never assigned any other value then
the constant 'DM_DIG_MAX' the code might as well simply use that
constant, rather the a member variable set to that constant.

The member variable has been removed and the constant used directly
in the code. This is a coding style change which should not impact
runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_dm.c | 5 ++---
 drivers/staging/rtl8192u/r8192U_dm.h | 1 -
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl8192u/r8192U_dm.c
index 3336798310ac..8b9d011e9eec 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.c
+++ b/drivers/staging/rtl8192u/r8192U_dm.c
@@ -1650,7 +1650,6 @@ static void dm_dig_init(struct net_device *dev)
 
 	dm_digtable.rssi_val = 50;	/* for new dig debug rssi value */
 	dm_digtable.backoff_val = DM_DIG_BACKOFF;
-	dm_digtable.rx_gain_range_max = DM_DIG_MAX;
 	if (priv->CustomerID == RT_CID_819x_Netcore)
 		dm_digtable.rx_gain_range_min = DM_DIG_MIN_Netcore;
 	else
@@ -1968,8 +1967,8 @@ static void dm_initial_gain(
 
 	if (dm_digtable.pre_connect_state == dm_digtable.cur_connect_state) {
 		if (dm_digtable.cur_connect_state == DIG_CONNECT) {
-			if ((dm_digtable.rssi_val+10-dm_digtable.backoff_val) > dm_digtable.rx_gain_range_max)
-				dm_digtable.cur_ig_value = dm_digtable.rx_gain_range_max;
+			if ((dm_digtable.rssi_val + 10 - dm_digtable.backoff_val) > DM_DIG_MAX)
+				dm_digtable.cur_ig_value = DM_DIG_MAX;
 			else if ((dm_digtable.rssi_val+10-dm_digtable.backoff_val) < dm_digtable.rx_gain_range_min)
 				dm_digtable.cur_ig_value = dm_digtable.rx_gain_range_min;
 			else
diff --git a/drivers/staging/rtl8192u/r8192U_dm.h b/drivers/staging/rtl8192u/r8192U_dm.h
index bc736f2f5a5c..f3e3db18fdd0 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.h
+++ b/drivers/staging/rtl8192u/r8192U_dm.h
@@ -118,7 +118,6 @@ struct dig {
 	u32		cur_ig_value;
 
 	u8		backoff_val;
-	u8		rx_gain_range_max;
 	u8		rx_gain_range_min;
 	bool		initialgain_lowerbound_state;
 
-- 
2.18.0

