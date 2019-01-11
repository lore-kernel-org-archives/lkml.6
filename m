Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2DCC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFFA621783
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216242;
	bh=hjQaQ+0ih18jOZ/vjbNK77DlyCttwvC+YaUHC81tpKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wpnkURNFLEIykCcfwBfAmu2+qLxHke/RxQF291jrvFhsMZf+xynp3V5xw/xuHdtzj
	 97/q641v12KMtwqN1A94ggiA64IZChZyiIkZevR4WoiCakULfpND9nMU7LgxjIROGQ
	 rgK2HMXD9RA64PO+O8XN1P1sf+U57YaP16dE57X8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbfAKORV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:17:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:33696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387844AbfAKORS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:17:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D67002177B;
        Fri, 11 Jan 2019 14:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216238;
        bh=hjQaQ+0ih18jOZ/vjbNK77DlyCttwvC+YaUHC81tpKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LlFzOAMS3cmL1cY0I0ZpkvPBR5Ae1KfW5Hye7k7CSoBJ7vmX1gxP+oN9RhGBykvIc
         32WaKcuOltcKlwlrQ5RXSBfXL2RF8+E0Nl8lAh/77z1P25Oi3mz4AX1WF4OYHKnMWI
         dPz3Dajcf/beCZyzEQ7vUUASMAbIiE/bW4arvs/k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.4 08/88] mmc: core: Reset HPI enabled state during re-init and in case of errors
Date:   Fri, 11 Jan 2019 15:07:37 +0100
Message-Id: <20190111131047.531010258@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131045.137499039@linuxfoundation.org>
References: <20190111131045.137499039@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ulf Hansson <ulf.hansson@linaro.org>

commit a0741ba40a009f97c019ae7541dc61c1fdf41efb upstream.

During a re-initialization of the eMMC card, we may fail to re-enable HPI.
In these cases, that isn't properly reflected in the card->ext_csd.hpi_en
bit, as it keeps being set. This may cause following attempts to use HPI,
even if's not enabled. Let's fix this!

Fixes: eb0d8f135b67 ("mmc: core: support HPI send command")
Cc: <stable@vger.kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/core/mmc.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1608,9 +1608,11 @@ static int mmc_init_card(struct mmc_host
 		if (err) {
 			pr_warn("%s: Enabling HPI failed\n",
 				mmc_hostname(card->host));
+			card->ext_csd.hpi_en = 0;
 			err = 0;
-		} else
+		} else {
 			card->ext_csd.hpi_en = 1;
+		}
 	}
 
 	/*


