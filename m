Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51E8C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781E52148E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999420;
	bh=xJ8vNbLpBGNA6C8+wgo+NPRZRdCAaSy1Bk8kG5tx25A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DiZgS5OC2W2B2aoGCkmZZatIpmcWadYX7Br6GjfRHCu76aRaXeG/WyURDvRVj4cqS
	 VglhaQsCQIIrHFqfoOxYXpMJWdJl08jXHxf3l9Mv5RNw6o32GNaJYgRzh37Z3+FtMu
	 F54yE19h5xV36DB7b/+VT5QZ6RM+ht+Gt7+8HWEw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732824AbeL1MQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:16:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:36022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732804AbeL1MQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:16:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA7A12087F;
        Fri, 28 Dec 2018 12:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999415;
        bh=xJ8vNbLpBGNA6C8+wgo+NPRZRdCAaSy1Bk8kG5tx25A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=opZBuqwniIKNnQcfV1hcWsMsVvVu8O4ynuKnWUugpGz25weEYjK1re3+wj5ld0Y7q
         1DUJClDf1ciAyCpkO0bTKSbjSc2C/1KMHvQhJEKJg9ZvM1NEiSBZxFVh4vz0AT1w3X
         OhEvDJiW0YQo9P1gwKePck8g/DncasQj/rgY3nsE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pratibhasagar V <pratibha@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.14 18/36] mmc: core: Allow BKOPS and CACHE ctrl even if no HPI support
Date:   Fri, 28 Dec 2018 12:52:34 +0100
Message-Id: <20181228113127.835947388@linuxfoundation.org>
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

commit ba9f39a785a9977e72233000711ef1eb48203551 upstream.

In commit 5320226a0512 ("mmc: core: Disable HPI for certain Hynix eMMC
cards"), then intent was to prevent HPI from being used for some eMMC
cards, which didn't properly support it. However, that went too far, as
even BKOPS and CACHE ctrl became prevented. Let's restore those parts and
allow BKOPS and CACHE ctrl even if HPI isn't supported.

Fixes: 5320226a0512 ("mmc: core: Disable HPI for certain Hynix eMMC cards")
Cc: Pratibhasagar V <pratibha@codeaurora.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/core/mmc.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -526,8 +526,7 @@ static int mmc_decode_ext_csd(struct mmc
 			card->cid.year += 16;
 
 		/* check whether the eMMC card supports BKOPS */
-		if (!mmc_card_broken_hpi(card) &&
-		    ext_csd[EXT_CSD_BKOPS_SUPPORT] & 0x1) {
+		if (ext_csd[EXT_CSD_BKOPS_SUPPORT] & 0x1) {
 			card->ext_csd.bkops = 1;
 			card->ext_csd.man_bkops_en =
 					(ext_csd[EXT_CSD_BKOPS_EN] &
@@ -1766,8 +1765,7 @@ static int mmc_init_card(struct mmc_host
 	 * If cache size is higher than 0, this indicates
 	 * the existence of cache and it can be turned on.
 	 */
-	if (!mmc_card_broken_hpi(card) &&
-	    card->ext_csd.cache_size > 0) {
+	if (card->ext_csd.cache_size > 0) {
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 				EXT_CSD_CACHE_CTRL, 1,
 				card->ext_csd.generic_cmd6_time);


