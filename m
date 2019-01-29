Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C2EC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D9CE20880
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548763319;
	bh=wOby97sO9Ix52Ye95VqDFizR/OBJJJ5ICEjzatY+BHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EiqG8nK+HHUHmm/0wX95fN6oaZ1opjv5jRnnmvT+Zq+Fy4xxx00ek4puMGTznvHQK
	 JsulWsnUJBiMuuy1kltbYxV/2aotDBgs2mSNmSBivVly35tPVXe3Ua3DFI777hrFnR
	 Fq829SCNvRaOIXVeQ6VFhlmQjz8aA2Y1OUY31E5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbfA2LpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:45:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:35638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728979AbfA2LpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:45:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5893820882;
        Tue, 29 Jan 2019 11:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762311;
        bh=wOby97sO9Ix52Ye95VqDFizR/OBJJJ5ICEjzatY+BHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RUSRKvM4ojH5V9kkTW7DfIcoslFa04J1U9WUSwTS7J8Xs2xcFg11kmz99BBVE5z9Z
         6uQAZ1s9NepNIrIXJF/naW2cenGXGJ2R68Aw2i+WYC4nbhgENjp/G5SPjXm2Molx0m
         Qq8+Z5YuLzdaG1jD5rQJ0uvcF1VjtdrLJepW+CGU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, b-ak <anur.bhargav@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.19 030/103] ASoC: tlv320aic32x4: Kernel OOPS while entering DAPM standby mode
Date:   Tue, 29 Jan 2019 12:35:07 +0100
Message-Id: <20190129113201.376872508@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
References: <20190129113159.567154026@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: b-ak <anur.bhargav@gmail.com>

commit 667e9334fa64da2273e36ce131b05ac9e47c5769 upstream.

During the bootup of the kernel, the DAPM bias level is in the OFF
state. As soon as the DAPM framework kicks in it pushes the codec
into STANDBY state.

The probe function doesn't prepare the clock, and STANDBY state
does a clk_disable_unprepare() without checking the previous state.
This leads to an OOPS.

Not transitioning from an OFF state to the STANDBY state fixes the
problem.

Signed-off-by: b-ak <anur.bhargav@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/codecs/tlv320aic32x4.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -822,6 +822,10 @@ static int aic32x4_set_bias_level(struct
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
+		/* Initial cold start */
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF)
+			break;
+
 		/* Switch off BCLK_N Divider */
 		snd_soc_component_update_bits(component, AIC32X4_BCLKN,
 				    AIC32X4_BCLKEN, 0);


