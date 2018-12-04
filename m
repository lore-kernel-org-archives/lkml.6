Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD36C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47925214D9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrs7i8rf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47925214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbeLDLBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:01:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:46590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbeLDLBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:01:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89D04214D9;
        Tue,  4 Dec 2018 11:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921270;
        bh=isGmbfiBcZVxb35/TUu9J4tfEPq3ZlpdjMo1fF4fX9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nrs7i8rfzZm6+KEY/LMAxy9IBvoc4oL/zucP5uXrkNHxmWA7Esaz6um6QeoelbAvk
         J0AoigsqroIt8QyJRbQBk3KQZdaMi6Tudr6/fOe0G0KQHoeuOJ/DmRxVh4P+dKp6yU
         FYcOUuHClTmRO32o3AB7oraVV+tqCZhG3hnw/KTU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        Andreas Dannenberg <dannenberg@ti.com>,
        "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.19 120/139] ASoC: pcm186x: Fix device reset-registers trigger value
Date:   Tue,  4 Dec 2018 11:50:01 +0100
Message-Id: <20181204103655.603936088@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
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

From: Andreas Dannenberg <dannenberg@ti.com>

commit 5277715639ff6f75c729e657690751a831112c4b upstream.

According to the current device datasheet (TI Lit # SLAS831D, revised
March 2018) the value written to the device's PAGE register to trigger
a complete register reset should be 0xfe, not 0xff. So go ahead and
update to the correct value.

Reported-by: Stephane Le Provost <stephane.leprovost@mediatek.com>
Tested-by: Stephane Le Provost <stephane.leprovost@mediatek.com>
Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
Acked-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/codecs/pcm186x.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/soc/codecs/pcm186x.h
+++ b/sound/soc/codecs/pcm186x.h
@@ -139,7 +139,7 @@ enum pcm186x_type {
 #define PCM186X_MAX_REGISTER		PCM186X_CURR_TRIM_CTRL
 
 /* PCM186X_PAGE */
-#define PCM186X_RESET			0xff
+#define PCM186X_RESET			0xfe
 
 /* PCM186X_ADCX_INPUT_SEL_X */
 #define PCM186X_ADC_INPUT_SEL_POL	BIT(7)


