Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862CAECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3886E20858
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qojrw479"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3886E20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387752AbeGVXJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 19:09:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34140 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730712AbeGVXJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 19:09:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id c13-v6so16040631wrt.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 15:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lXUEpg2C2uNk7eT3D8DaXYyUtWriLbNwKvR7YeMeTGw=;
        b=Qojrw479kEIlRoBdapZUD0VcPzktC7TN2yRPCSvrZrj27n93hls60+GuxvSLL3ky4d
         UESF13ebihhCKtDVbh75Ru+ShBR9s1t1vWFsjJUM2u11WYkFTpsXfwzrn//vt87irHLo
         jZBwS/jU6byktKlrX5L3LGOUsfZBskyiPLpS6bJe0UEzMppT578wFdfIlyTeZJ8P1hlp
         iyHgoM07AMoY/l+5zz80V5BVlf0ytnOqn0OAH59tGrXtO9Rf0zjSKOUAEukmqwJQz12T
         6keaixI6Aa8f2SvSBNTmMNPH8M0mNHNDBkTBznJrPapPMJvyh6L67GGnjPOq/gUOAxQR
         K5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lXUEpg2C2uNk7eT3D8DaXYyUtWriLbNwKvR7YeMeTGw=;
        b=qJTcQGeZiJFd2uhNB7p3ZanG1KlT2fPC2Uz1LFhD90bxovuhFseOEwqf55Z5U+WrMl
         AFVtFqenCbrPTyFAZq5lHvFdbmy9xb9lt5x623rmO5ZUwl4DLi071npefsBRi7Qs1df3
         d7FO4WjvNE5BMXuhV134ydQYE+9caxUMBViqJvlvFbtYyvpKnHwzvnGDm9U1C8f78uug
         /e0rDgMhYkoF638aDYk/QrgZ54qhSHNww2vGqUW9QSDXJRNV/z1KsXnHuu34aLWO8qXx
         2q2DI120y7pkOYsqO/gw7MZyRqOTYZm90DclDyCBdFEBf9lGcoqMkrK8QeE0wT5Oqw24
         HaLw==
X-Gm-Message-State: AOUpUlG5s52ooqELV0RdnFLn54vQWedXJjKJlZb2QNCS+zhWFO+wHdxj
        AyJ3Wj+fqioQOY859zBkydwW6ryb+qg=
X-Google-Smtp-Source: AAOMgpf2whuCuWiNP8wk/hK8oUQxtnTYAbH5LMNFi9ZOY+aHBg3PfWSPCKPQstCWxaYd1o33MDJFRQ==
X-Received: by 2002:adf:eb4c:: with SMTP id u12-v6mr7196398wrn.174.1532297453468;
        Sun, 22 Jul 2018 15:10:53 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id e12-v6sm5870824wrt.29.2018.07.22.15.10.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 15:10:52 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 04/20] staging:rtl8192u: Remove unused page a definitions - Style
Date:   Sun, 22 Jul 2018 23:10:19 +0100
Message-Id: <20180722221035.14453-5-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180722221035.14453-1-johnfwhitmore@gmail.com>
References: <20180722221035.14453-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused 'page a' definitions. These definitions fail the checkpatch
CamelCase naming test, rather then renaming these unused definitions they
have simply been removed. This is a coding style change only, and should
have no impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phyreg.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phyreg.h b/drivers/staging/rtl8192u/r819xU_phyreg.h
index e0c99a953afd..6be63aef33f7 100644
--- a/drivers/staging/rtl8192u/r819xU_phyreg.h
+++ b/drivers/staging/rtl8192u/r819xU_phyreg.h
@@ -46,19 +46,9 @@
 #define rCCK0_System				0xa00
 #define rCCK0_AFESetting			0xa04
 #define rCCK0_CCA					0xa08
-#define rCCK0_RxAGC1				0xa0c  /* AGC default value, saturation level */
-#define rCCK0_RxAGC2				0xa10  /* AGC & DAGC */
-#define rCCK0_RxHP				0xa14
-#define rCCK0_DSPParameter1		0xa18  /* Timing recovery & Channel estimation threshold */
-#define rCCK0_DSPParameter2		0xa1c  /* SQ threshold */
 #define rCCK0_TxFilter1				0xa20
 #define rCCK0_TxFilter2				0xa24
 #define rCCK0_DebugPort				0xa28  /* debug port and Tx filter3 */
-#define rCCK0_FalseAlarmReport		0xa2c  /* 0xa2d */
-#define rCCK0_TRSSIReport			0xa50
-#define rCCK0_RxReport				0xa54  /* 0xa57 */
-#define rCCK0_FACounterLower		0xa5c  /* 0xa5b */
-#define rCCK0_FACounterUpper		0xa58  /* 0xa5c */
 
 /* page c */
 #define rOFDM0_LSTF				0xc00
-- 
2.18.0

