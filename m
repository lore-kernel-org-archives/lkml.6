Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76592C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C3F214C4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UA9oyTFc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C3F214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbeJIBrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:47:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726568AbeJIBrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:47:18 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED48D2145D;
        Mon,  8 Oct 2018 18:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539023656;
        bh=W/EkkQP6R1bPhNZp8/OQuONeeKpVPbRwezXlNVL0tOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UA9oyTFcewkShQa/YqaCSdyGVTXpyClukdwWgQ8HYZKD5YMNYHk8RWoCLxQhMk4G/
         QbK5XKO2sWgslwY4jlM/HuBntZWa/UAROxC8RT/qJpcGIK2Vjxhq6UvwJIWPfrobVw
         KCzcYCxgiELaj3YkaOQXBj45Mrhz3dw6myRaY/i4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 039/113] ASoC: dapm: Fix potential DAI widget pointer deref when linking DAIs
Date:   Mon,  8 Oct 2018 20:30:40 +0200
Message-Id: <20181008175532.747740020@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175530.864641368@linuxfoundation.org>
References: <20181008175530.864641368@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liam Girdwood <liam.r.girdwood@linux.intel.com>

[ Upstream commit e01b4f624278d5efe5fb5da585ca371947b16680 ]

Sometime a component or topology may configure a DAI widget with no
private data leading to a dev_dbg() dereferencne of this data.

Fix this to check for non NULL private data and let users know if widget
is missing DAI.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/soc-dapm.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3864,6 +3864,13 @@ int snd_soc_dapm_link_dai_widgets(struct
 			continue;
 		}
 
+		/* let users know there is no DAI to link */
+		if (!dai_w->priv) {
+			dev_dbg(card->dev, "dai widget %s has no DAI\n",
+				dai_w->name);
+			continue;
+		}
+
 		dai = dai_w->priv;
 
 		/* ...find all widgets with the same stream and link them */


