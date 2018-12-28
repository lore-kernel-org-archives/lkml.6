Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05527C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C11C02087F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999416;
	bh=4mPUExptAVIbqohtVs62eBlkcnGTlN9l0LVU2P+B0ms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zjju3QJ6IANcp9RLamha0/MCHEYZNX8pRkBxPmScpxtsjpVW+ZUD1qSXu0v1BL1Kx
	 zUN6VLsAtMgEpaaJ+iaSY62EzlePflTDhmqTkJzjOiG34aYU+r5YeG5KbAhZBOrZVm
	 lnJVVgOp/XZ9VByji4lwIclpB4zoT5pWzv/hzJsQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732809AbeL1MQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:16:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:35972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732788AbeL1MQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:16:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1679B2146F;
        Fri, 28 Dec 2018 12:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999412;
        bh=4mPUExptAVIbqohtVs62eBlkcnGTlN9l0LVU2P+B0ms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aWB0ut315BtMpg6DEnpufMVjNtI8KfqET/sk5+WAoSXKgDMhPNWRrVBpe1C2shyBX
         NY90oCosFsBXa8fw5ekyfFr17PeKWY688fDPwpeYCbyphvDBthdEs72I/9RkjpSdoI
         EGFr+nW4Eq0uth6yRHlZyO7CUI2RN7S1rec4mcl4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.14 17/36] mmc: core: Reset HPI enabled state during re-init and in case of errors
Date:   Fri, 28 Dec 2018 12:52:33 +0100
Message-Id: <20181228113127.758657235@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113126.526729877@linuxfoundation.org>
References: <20181228113126.526729877@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1755,9 +1755,11 @@ static int mmc_init_card(struct mmc_host
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


