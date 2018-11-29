Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF08FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7658A2081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:07:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7658A2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbeK2NKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 08:10:45 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:38160 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726929AbeK2NKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 08:10:44 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 07FC0E36B03EF3042048;
        Thu, 29 Nov 2018 10:07:01 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wAT26sBe006277;
        Thu, 29 Nov 2018 10:06:54 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from LIN-A6CB96A0603.zte.intra ([10.90.106.118])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018112910072153-13604195 ;
          Thu, 29 Nov 2018 10:07:21 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     olivier.moysan@st.com, arnaud.pouliquen@st.com, broonie@kernel.org,
        tiwai@suse.com, mcoquelin.stm32@gmail.com
Cc:     linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        Wen Yang <wen.yang99@zte.com.cn>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Wen Yang <yellowriver2010@hotmail.com>,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] ASoC: stm32: sai: Fix unsigned comparison with less than zero
Date:   Thu, 29 Nov 2018 10:06:11 +0800
Message-Id: <20181129020611.8436-1-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-11-29 10:07:21,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-11-29 10:06:42
Content-Transfer-Encoding: quoted-printable
X-MAIL: mse01.zte.com.cn wAT26sBe006277
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return from the call to stm32=5Fsai=5Fget=5Fclk=5Fdiv can be a negative=
 error
code however this is being assigned to an unsigned variable 'div'
hence the check is always false. Fix this by making 'div' an
int.

Detected by Coccinelle ("Unsigned expression compared with zero:stages
< 0")

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
CC: Mark Brown <broonie@kernel.org>
CC: Olivier Moysan <olivier.moysan@st.com>
CC: Arnaud Pouliquen <arnaud.pouliquen@st.com>
CC: Liam Girdwood <lgirdwood@gmail.com>
CC: Jaroslav Kysela <perex@perex.cz>
CC: Takashi Iwai <tiwai@suse.com>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC: Alexandre Torgue <alexandre.torgue@st.com>
CC: Julia Lawall <julia.lawall@lip6.fr>
CC: Wen Yang <yellowriver2010@hotmail.com>
CC: linux-stm32@st-md-mailman.stormreply.com
CC: linux-kernel@vger.kernel.org
---
 sound/soc/stm/stm32=5Fsai=5Fsub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32=5Fsai=5Fsub.c b/sound/soc/stm/stm32=5Fsai=
=5Fsub.c
index 211589b0b2ef..6e9fff0f9ed7 100644
--- a/sound/soc/stm/stm32=5Fsai=5Fsub.c
+++ b/sound/soc/stm/stm32=5Fsai=5Fsub.c
@@ -336,7 +336,7 @@ static int stm32=5Fsai=5Fmclk=5Fset=5Frate(struct clk=
=5Fhw *hw, unsigned long rate,
 {
 	struct stm32=5Fsai=5Fmclk=5Fdata *mclk =3D to=5Fmclk=5Fdata(hw);
 	struct stm32=5Fsai=5Fsub=5Fdata *sai =3D mclk->sai=5Fdata;
-	unsigned int div;
+	int div;
 	int ret;
=20
 	div =3D stm32=5Fsai=5Fget=5Fclk=5Fdiv(sai, parent=5Frate, rate);
--=20
2.19.1

