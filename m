Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83596C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4993E214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548761987;
	bh=AOX218mD5zuacfE7z1JHzYpajg+H+rpf3mWu+rXkRT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EGxpC9Vuh3n50TjYqhnJ+WwcZmGay+PP1rklH2QVPNebhWhJq56WUNfHYXBCul9PG
	 z2rsSIYVOK0MUEmBBosZ2N8eyJWGw0cnkCsylx6tPMzk0Zqf1EzUgmrRjsbP0xxJ7E
	 vanvBnYxZvhgpoL6QeG4K9+eY8xW+3Z+BZ6r1GCY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbfA2Ljp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:39:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:56466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729488AbfA2Ljn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:39:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D272D214DA;
        Tue, 29 Jan 2019 11:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548761982;
        bh=AOX218mD5zuacfE7z1JHzYpajg+H+rpf3mWu+rXkRT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vqqNTMKUI9n8Zyfc1Arldc9+X2PwYDKJ+PjVjmG5X4DIEO/XgtFmyJLc5Q9eJCvIY
         XmcAr4NdIcu2aviDRjKkQTzuhsqUh2bDfpw3O82iw3r0fvAAMlcwH7dLZgJMkO4rLh
         y7emZ6JZPxxGdM9GCEZ6Lwqg1Hwg4W+fBTFo8vSk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, b-ak <anur.bhargav@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.20 034/117] ASoC: tlv320aic32x4: Kernel OOPS while entering DAPM standby mode
Date:   Tue, 29 Jan 2019 12:34:45 +0100
Message-Id: <20190129113209.320190307@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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


