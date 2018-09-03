Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFA0C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764EE20862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="pjOly+9b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 764EE20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbeICSHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 14:07:36 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57778 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbeICSHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 14:07:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=rtAAKhLu6abHSfqMKvIteHXlq5ii/lQqjoB4yH4S9Xc=; b=pjOly+9boC0C
        rTCoUvl1TXAagwflQGiqaLoseeRfnTznQdl7wzcShqHM5oHEvMbD5NCNV0URQypq49k6VuW1cdijF
        XfVeHagHuSpps3uMGr5pH5fVd9e1lx7c8JeHJl6i8oomwn+o1ZUvungLlwsEFdFFbh2wJr4AkfmAn
        vMTLQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fwpCH-0000Ik-0l; Mon, 03 Sep 2018 13:47:17 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id BC3FF11227AE; Mon,  3 Sep 2018 14:47:16 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
        rohitkr@codeaurora.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: q6routing: initialize data correctly" to the asoc tree
In-Reply-To:  <20180903110747.10745-1-srinivas.kandagatla@linaro.org>
Message-Id: <20180903134716.BC3FF11227AE@debutante.sirena.org.uk>
Date:   Mon,  3 Sep 2018 14:47:16 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: q6routing: initialize data correctly

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 7aa09ff24301535491cd4de1b93107ee91449a12 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Mon, 3 Sep 2018 12:07:47 +0100
Subject: [PATCH] ASoC: q6routing: initialize data correctly

Some of the router data fields are left as default zeros which are
valid dai ids, so initialize these to invalid value of -1.

Without intializing these correctly get_session_from_id() can return
incorrect session resulting in not closing the opened copp and messing
up with the copp ref count.

Fixes: e3a33673e845 ("ASoC: qdsp6: q6routing: Add q6routing driver")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6routing.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index dc94c5c53788..c6b51571be94 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -960,8 +960,10 @@ static int msm_routing_probe(struct snd_soc_component *c)
 {
 	int i;
 
-	for (i = 0; i < MAX_SESSIONS; i++)
+	for (i = 0; i < MAX_SESSIONS; i++) {
 		routing_data->sessions[i].port_id = -1;
+		routing_data->sessions[i].fedai_id = -1;
+	}
 
 	return 0;
 }
-- 
2.19.0.rc1

