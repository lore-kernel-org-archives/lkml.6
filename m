Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5646C0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814762243E
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="utTwX1J5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 814762243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732373AbeKLISD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:18:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:34210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732353AbeKLISC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:02 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 317B9223DD;
        Sun, 11 Nov 2018 22:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975287;
        bh=asuu4RVyajOtDsMtgsA+5dzdXpFMx0bxnOXmczRBWSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=utTwX1J574n7vRAc+sC7LaJotEO2CLOyODgxt04LcLz3FjqPA564tZXEddm88giRv
         jgl0OsNUK+6JRLsUzcAJ/mcG2Jba0PRVLQwI86wHRYgRxEfsE9fgTfE3aBY2u4xRqe
         G0EOHWZFuBpaNUVvPDf+ROC2nmOAI+5z8iHbk3jc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.19 221/361] ASoC: sta32x: set ->component pointer in private struct
Date:   Sun, 11 Nov 2018 14:19:28 -0800
Message-Id: <20181111221650.742823324@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Mack <daniel@zonque.org>

commit 747df19747bc9752cd40b9cce761e17a033aa5c2 upstream.

The ESD watchdog code in sta32x_watchdog() dereferences the pointer
which is never assigned.

This is a regression from a1be4cead9b950 ("ASoC: sta32x: Convert to direct
regmap API usage.") which went unnoticed since nobody seems to use that ESD
workaround.

Fixes: a1be4cead9b950 ("ASoC: sta32x: Convert to direct regmap API usage.")
Signed-off-by: Daniel Mack <daniel@zonque.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/codecs/sta32x.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/sound/soc/codecs/sta32x.c
+++ b/sound/soc/codecs/sta32x.c
@@ -879,6 +879,9 @@ static int sta32x_probe(struct snd_soc_c
 	struct sta32x_priv *sta32x = snd_soc_component_get_drvdata(component);
 	struct sta32x_platform_data *pdata = sta32x->pdata;
 	int i, ret = 0, thermal = 0;
+
+	sta32x->component = component;
+
 	ret = regulator_bulk_enable(ARRAY_SIZE(sta32x->supplies),
 				    sta32x->supplies);
 	if (ret != 0) {


