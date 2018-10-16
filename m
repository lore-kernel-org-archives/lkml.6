Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E001AC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA5462147E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YaCMOAyh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA5462147E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730734AbeJQBMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:12:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729296AbeJQBMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:12:15 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0564B2098A;
        Tue, 16 Oct 2018 17:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710450;
        bh=XOHEfNleFC+6Y6TxFaAktDUPEZc/Jn8IwnqlVgNumfs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YaCMOAyhC9Isfb8ecER4wGGejrVSZ3dN39OPLnGIdTm/ymn+7Es33KKag9yUeLTLW
         z9huxapXn1YWpjcOJFSMvagL0s/nyJIZfCg5QYA+gWeFDW46TfIepq+BnxhMUqhWvq
         gbk/TQi2om0b1fQrnvFmdXz3xaJiott0fBdk4mXU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 045/109] ASoC: rsnd: dont fallback to PIO mode when -EPROBE_DEFER
Date:   Tue, 16 Oct 2018 19:05:13 +0200
Message-Id: <20181016170527.428381156@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170524.530541524@linuxfoundation.org>
References: <20181016170524.530541524@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit 6c92d5a2744e27619a8fcc9d74b91ee9f1cdebd1 ]

Current rsnd driver will fallback to PIO mode if it can't get DMA
handler. But, DMA might return -EPROBE_DEFER when probe timing.
This driver always fallback to PIO mode especially from
commit ac6bbf0cdf4206c ("iommu: Remove IOMMU_OF_DECLARE") because
of this reason.

The DMA driver will be probed later, but sound driver might be
probed as PIO mode in such case. This patch fixup this issue.
Then, -EPROBE_DEFER is not error. Thus, let's don't indicate error
message in such case.
And it needs to call rsnd_adg_remove() individually if probe failed,
because it registers clk which should be unregister.

Maybe PIO fallback feature itself is not needed,
but let's keep it so far.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/sh/rcar/core.c |   10 +++++++++-
 sound/soc/sh/rcar/dma.c  |    4 ++++
 2 files changed, 13 insertions(+), 1 deletion(-)

--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -486,7 +486,7 @@ static int rsnd_status_update(u32 *statu
 			(func_call && (mod)->ops->fn) ? #fn : "");	\
 		if (func_call && (mod)->ops->fn)			\
 			tmp = (mod)->ops->fn(mod, io, param);		\
-		if (tmp)						\
+		if (tmp && (tmp != -EPROBE_DEFER))			\
 			dev_err(dev, "%s[%d] : %s error %d\n",		\
 				rsnd_mod_name(mod), rsnd_mod_id(mod),	\
 						     #fn, tmp);		\
@@ -1469,6 +1469,14 @@ exit_snd_probe:
 		rsnd_dai_call(remove, &rdai->capture, priv);
 	}
 
+	/*
+	 * adg is very special mod which can't use rsnd_dai_call(remove),
+	 * and it registers ADG clock on probe.
+	 * It should be unregister if probe failed.
+	 * Mainly it is assuming -EPROBE_DEFER case
+	 */
+	rsnd_adg_remove(priv);
+
 	return ret;
 }
 
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -330,6 +330,10 @@ static int rsnd_dmaen_attach(struct rsnd
 	/* try to get DMAEngine channel */
 	chan = rsnd_dmaen_request_channel(io, mod_from, mod_to);
 	if (IS_ERR_OR_NULL(chan)) {
+		/* Let's follow when -EPROBE_DEFER case */
+		if (PTR_ERR(chan) == -EPROBE_DEFER)
+			return PTR_ERR(chan);
+
 		/*
 		 * DMA failed. try to PIO mode
 		 * see


