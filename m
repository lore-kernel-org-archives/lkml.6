Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1B9C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4AC20652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeElLowA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A4AC20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbeJEAvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 20:51:53 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39834 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbeJEAvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 20:51:42 -0400
Received: by mail-wm1-f66.google.com with SMTP id q8-v6so9897496wmq.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 10:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OGargqbFBzDzCxa21fThjzpDNtuSpPjabxp2Fwo/cC8=;
        b=FeElLowAexBye+Ynurn2gUIousCDO0fo2Ypu9T86fpFqbydXCElrYjPfiPeoVuvojt
         fa5GPUi3GgkkpAobPIaSd5bKxcW/pWNts7XslM8dP0Pj+Z9ZcwCM4OnOqhlE6CvHqEao
         AZ955rl/chlTg7tzBcDXkZp9U4dqn8O7O9sR3xmawcN2NBbTchFJLnLbriLMfzojYMXm
         aWeOjW8pGPg9StzxLtke9GDWFQ9XAKItYyYrYk7QmLV1A2IIG27T7txcfFUZ6ilVgCmU
         aRif0CB4ArQnAVgwG5q1Fzyd6Dk2p19MmZ3U+Wy5caQEUlUI/gq0orjw/YXo7SI5kkw3
         fEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OGargqbFBzDzCxa21fThjzpDNtuSpPjabxp2Fwo/cC8=;
        b=IK2gsD8I5DSxnz3sRlCfVacVsI+7HQf1klZ1MlN93cnh3xiEycPni/JuwH88dTsc33
         CKC2FjRFjjzGIG/HpE/Os34GOozMZGKAr2alGHEqlJcAOrbSYnE9A4D26WGPPAdVb6xe
         llik+R0NVK/a4OZQ4LsmiKPdgV0b5E+22AgEffvNer1edQ0svPGT2BStC9pAqdnp5vtS
         KnhTNjr/5SsiCmjr3j8xl+Lu22U/hEkglLxbF/d76vTEXOm8qMzX1a6eojEcmW8n7KA8
         qp4iguqanaD7WdD0kEuY3zZOb1i9huoYpuTKroro8IK2Rco6kqxcslbd5VVbdq9P1TEK
         3rRA==
X-Gm-Message-State: ABuFfohHF6MdIfCPH6oGisUpOZU4zM1KtaJeySXteYl2OIoL99IVz+Le
        WX9P3tCUDqwEqOOCYdIfXC4=
X-Google-Smtp-Source: ACcGV61/C4hmEJFPUF2Zh3xcTgJyV8DmyuwOofomKMlcOimvyk+MsrMJBXO21jZlSFN/civTPBpfaA==
X-Received: by 2002:a1c:1183:: with SMTP id 125-v6mr5670312wmr.103.1538675840309;
        Thu, 04 Oct 2018 10:57:20 -0700 (PDT)
Received: from localhost.localdomain (ip1f12fa7d.dynamic.kabel-deutschland.de. [31.18.250.125])
        by smtp.gmail.com with ESMTPSA id o63-v6sm3697353wmd.3.2018.10.04.10.57.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 10:57:19 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/4] staging: rtl8188eu: remove whitespace in rtw_mlme_ext.h
Date:   Thu,  4 Oct 2018 19:57:00 +0200
Message-Id: <20181004175700.1500-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181004175700.1500-1-straube.linux@gmail.com>
References: <20181004175700.1500-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove spaces and/or replace tabs with spaces in some declarations
in rtw_mlme_ext.h.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/include/rtw_mlme_ext.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
index 38911a7daa95..9526da3efcc4 100644
--- a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
@@ -231,22 +231,22 @@ enum SCAN_STATE {
 };
 
 struct mlme_handler {
-	unsigned int   num;
+	unsigned int num;
 	const char *str;
 	unsigned int (*func)(struct adapter *adapt, struct recv_frame *frame);
 };
 
 struct action_handler {
-	unsigned int   num;
+	unsigned int num;
 	const char *str;
 	unsigned int (*func)(struct adapter *adapt, struct recv_frame *frame);
 };
 
-struct	ss_res {
-	int	state;
-	int	bss_cnt;
-	int	channel_idx;
-	int	scan_mode;
+struct ss_res {
+	int state;
+	int bss_cnt;
+	int channel_idx;
+	int scan_mode;
 	u8 ssid_num;
 	u8 ch_num;
 	struct ndis_802_11_ssid ssid[RTW_SSID_SCAN_AMOUNT];
-- 
2.19.0

