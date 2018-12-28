Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66901C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C19A2148E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999444;
	bh=FRClkQMXU/kP6lJjyoPFEDeS4FkBdOfj5TsfOd7H9M0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wuvugaM+Mq+ja14luGp9gfQZPxFapJ/nVZEVXBCyuLGZu+1q2pbuVZEgqLZEHi0qi
	 F6ciOUN0s3mmSsE74DSLw3rFUmGLw1gm0mV9M2gUPxGxogrUBY7pHZIQyjGIVxoUX5
	 PhFdOGnVYCz89KD/N4x0GP0ZZLCQ3M9x9RxPxZ8I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732917AbeL1MRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:17:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:36390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732889AbeL1MRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:17:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F05B120675;
        Fri, 28 Dec 2018 12:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999437;
        bh=FRClkQMXU/kP6lJjyoPFEDeS4FkBdOfj5TsfOd7H9M0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XGFG26sx5I3PBG2/nB9Ht57Rx1MIicfFK5P7t9m8F1pCbHyDW7ECrerxAGiUqj1Br
         6SmZ7AZVZ7eEp4YZqf4Ud60UBeP9wC0cvkYljEBkC4bfNus7q6hWMd1M4dLJWNNgZt
         tvOd1gCJHaoDD3553sTYFUrC+Gujivh9k3DKyATs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.9 11/22] mmc: core: Reset HPI enabled state during re-init and in case of errors
Date:   Fri, 28 Dec 2018 12:52:48 +0100
Message-Id: <20181228113126.916957499@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113126.144310132@linuxfoundation.org>
References: <20181228113126.144310132@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1719,9 +1719,11 @@ static int mmc_init_card(struct mmc_host
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


