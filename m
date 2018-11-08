Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EA9ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 322E92089F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a849wG+C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 322E92089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731618AbeKIHtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:49:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:41338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730588AbeKIHrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:47:37 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6224208A3;
        Thu,  8 Nov 2018 22:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541715005;
        bh=SLLrevI/7BdUx9MQNc+pOxSkoKtNXqUem+N4FoN/vro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a849wG+CKZCM1H+mQ9u6XYrARRVOR9BwehPPjSFd+eXfP8mSRaKv2PrINoo+fCUL2
         yMghjwhIIp4bCax+9Yr+Kf6+UCn+tOpLGNsdIL0EGxtxV5SluU7Arfv/3yQ47YYtEw
         Esi5PiLEzwt+5OPf3Oj6qV/fZLESGySmkeA993SU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 4.18 05/34] clk: sunxi-ng: sun4i: Set VCO and PLL bias current to lowest setting
Date:   Thu,  8 Nov 2018 13:52:34 -0800
Message-Id: <20181108215139.240865556@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215138.892971755@linuxfoundation.org>
References: <20181108215138.892971755@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen-Yu Tsai <wens@csie.org>

commit 80a6ec7d5e1653208eb53f6738620dab98f6f50e upstream.

The default mid-level PLL bias current setting interferes with sigma
delta modulation. This manifests as decreased audio quality at lower
sampling rates, which sounds like radio broadcast quality, and
distortion noises at sampling rates at 48 kHz or above.

Changing the bias current settings to the lowest gets rid of the
noise.

Fixes: de3448519194 ("clk: sunxi-ng: sun4i: Use sigma-delta modulation
		      for audio PLL")
Cc: <stable@vger.kernel.org> # 4.15.x
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/sunxi-ng/ccu-sun4i-a10.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
+++ b/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
@@ -1434,8 +1434,16 @@ static void __init sun4i_ccu_init(struct
 		return;
 	}
 
-	/* Force the PLL-Audio-1x divider to 1 */
 	val = readl(reg + SUN4I_PLL_AUDIO_REG);
+
+	/*
+	 * Force VCO and PLL bias current to lowest setting. Higher
+	 * settings interfere with sigma-delta modulation and result
+	 * in audible noise and distortions when using SPDIF or I2S.
+	 */
+	val &= ~GENMASK(25, 16);
+
+	/* Force the PLL-Audio-1x divider to 1 */
 	val &= ~GENMASK(29, 26);
 	writel(val | (1 << 26), reg + SUN4I_PLL_AUDIO_REG);
 


