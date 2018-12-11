Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551C7C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC5C21104
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543836;
	bh=DYSE6VROtod+nkWJj6DwN2UgqXlcAj9jFPtgAzsv9vc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0iPDqDcFAT8DfbR031RdpJ0qCnsGNOqwhZ6fs69Ba0K7eQ2FkzS6OAgWoZYB+mY18
	 4ZkTloi8Vtqg7mnpDRWkvSExzxqRYcsr9Y3V7yjDV8EeTqvA+wpy7FKkml7JpOlDpX
	 pqCRdITEy7Bm3eBponhieNU87CzdrIrbVx16WUiA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC5C21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbeLKP5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:57:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:46148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730321AbeLKP5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:57:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7987B20855;
        Tue, 11 Dec 2018 15:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543832;
        bh=DYSE6VROtod+nkWJj6DwN2UgqXlcAj9jFPtgAzsv9vc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zAJ8R2t8JNIQx6xEtil9gtjjunax4QzBrhUNqcCXTx4Ub0ByI9rsYB7I7JXKxS/ML
         dCkN1eJwjNDcdn1Le6Lu+6r5K6Jq7xLsCkmwq7ksSUZWvwJ8A3tmOeRcHNjCVbopIF
         a9axTHGU0aumTdP7sMeA97SlgX0zjnqHnl48lOU4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stakanov Schufter <stakanov@eclipso.eu>,
        Takashi Iwai <tiwai@suse.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.19 074/118] media: dvb-pll: dont re-validate tuner frequencies
Date:   Tue, 11 Dec 2018 16:41:33 +0100
Message-Id: <20181211151647.241345556@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
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

From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

commit 3420f65cbbd0555049bd02394bed33a0ef74d860 upstream.

The dvb_frontend core already checks for the frequencies. No
need for any additional check inside the driver.

It is part of the fixes for the following bug:
  https://bugzilla.opensuse.org/show_bug.cgi?id=1116374

Fixes: a3f90c75b833 ("media: dvb: convert tuner_info frequencies to Hz")
Reported-by: Stakanov Schufter <stakanov@eclipso.eu>
Reported-by: Takashi Iwai <tiwai@suse.de>
Cc: stable@vger.kernel.org # For 4.19
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/dvb-frontends/dvb-pll.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/drivers/media/dvb-frontends/dvb-pll.c
+++ b/drivers/media/dvb-frontends/dvb-pll.c
@@ -610,9 +610,6 @@ static int dvb_pll_configure(struct dvb_
 	u32 div;
 	int i;
 
-	if (frequency && (frequency < desc->min || frequency > desc->max))
-		return -EINVAL;
-
 	for (i = 0; i < desc->count; i++) {
 		if (frequency > desc->entries[i].limit)
 			continue;


