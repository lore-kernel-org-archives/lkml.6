Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F4DC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 19:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159F821855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 19:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sgEmVafd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfAWTls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 14:41:48 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34985 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfAWTls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 14:41:48 -0500
Received: by mail-wm1-f67.google.com with SMTP id t200so631977wmt.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 11:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MkIKp+vIvpi+A6uy1TcoMWGCqTQeQ+FBrAVybh8CU3s=;
        b=sgEmVafdnVYI+2g1mKgcSzvA/3sswPQV/WZ0uo44WnM1UszgWDjunmMT2VUV7CAYAw
         KQ/3lfe9JSQyzlhBI78AyAjJ6t+zEdSoFeWnM0M0fijqNW/CCk2U4MlwjThJPWYXqja/
         TgfgFIyJJrRKTCNMvvc2NYG09QonqTti+26hgzAVeIXdCW0FO84/Z4/yD4mskADWgsyn
         MsAdyR+lSsPudVb6fE0f5c7p5uCgTqzXWC60qb+vpyeYf8OnKnmEMESUBLuqwYIYv/VI
         qGexhbicH/ZuJsAd8pzMzPk1w6Z13uH/ZI31bXrmr2wMXnbinO+knUqyFxEtomqSn6DS
         S9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=MkIKp+vIvpi+A6uy1TcoMWGCqTQeQ+FBrAVybh8CU3s=;
        b=q2B4BkrHoIYUBOnptd2bP5Yy10jVrqKsnL2V5tk6pkRyCRkkrlPh2AXm6UGohKaHJO
         PfcHBCEIwvyoTCDjM/c0ff0DR0XyEU5OZ2rjEesRc5ohH15vihJpXp34RnnMwEClW01M
         qxUtH73B9R+GrriO7Y/j4cZA93teZmAJalQ30A30ImxSH4/ySIQiEizSA0Kmt9kP/P37
         FTGwR+aSS+6HrLbHddK22UJSueJE+s9WiEKqnVgD7hnpt0MDDYJ0NezibrFA0twcTQe0
         RAMuZD5SPUonmEiG1QRDZnGl7CLcSf3osh68a5LhBLcroed8DTV6pH8+giCdPtX1eJWY
         sdZg==
X-Gm-Message-State: AJcUukdZBa2NUnvHs0Lw0Bf5MCHHAOxL/jbE4yB9ngbM1nPBAImOtmmw
        XizHnUytxw0S5vQjZEJOOOY=
X-Google-Smtp-Source: ALg8bN76SiWek2X7eJAmg21sU+ASZpYWma5MLGBiKZtIF+NEXHe5Eytqt/f5lxCKrNxuvNp9VpSrVQ==
X-Received: by 2002:a1c:400b:: with SMTP id n11mr4063653wma.85.1548272505857;
        Wed, 23 Jan 2019 11:41:45 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id 124sm60192786wmh.22.2019.01.23.11.41.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 11:41:44 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 3DBF1114246D; Wed, 23 Jan 2019 20:41:43 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Liam Girdwood <lgirdwood@gmail.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: Use __printf markup to silence compiler
Date:   Wed, 23 Jan 2019 20:41:30 +0100
Message-Id: <20190123194131.19406-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Silence warnings (triggered at W=1) by adding relevant __printf
attributes.

  sound/soc/soc-dapm.c:149:2: warning: function 'pop_dbg' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 sound/soc/soc-dapm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index a5178845065b..92a2e7dab5fe 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -133,6 +133,7 @@ static void pop_wait(u32 pop_time)
 		schedule_timeout_uninterruptible(msecs_to_jiffies(pop_time));
 }
 
+__printf(3, 4)
 static void pop_dbg(struct device *dev, u32 pop_time, const char *fmt, ...)
 {
 	va_list args;
-- 
2.19.2

