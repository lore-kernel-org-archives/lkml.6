Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5197FC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21F812229E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896893;
	bh=pviqqzT+PXc1/8/X2S/j2tiBUhF5KMqXM4C3K1Agb2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c5Q5YXqL93keozuPckpmeFfREGWSeFxc824qd9faFmRTGawzYh152b5Z+dBqoZr5t
	 fbl1JUC6mK9NZxwzvhd3sGwRbjRda31b96HHApLRHr6j69k7xkh0X9tr7Spbe4DzCN
	 2KDrlKwvjyNMAQEFSyT97JLxhCQ4MhwXhw4veAFU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388885AbfBKOyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:54:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:41542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388875AbfBKOyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:54:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BABAA222A8;
        Mon, 11 Feb 2019 14:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896883;
        bh=pviqqzT+PXc1/8/X2S/j2tiBUhF5KMqXM4C3K1Agb2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=niaGfrn9xmd6AdV+MZPYjgC4i1PBd64QXMmBx3J5k+Q+mTz5zt1GIoXskRIGZTtNf
         sZszMAsClGJ88T9KFUJQUSIKOnmdzSaz40HccQWbbtuqwxaJPEzpr46YBY+Muyh4ve
         aNnZhxBrn5naZdsauZow3+UUJLTuf2P5N1m+kqno=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 005/205] ASoC: Intel: mrfld: fix uninitialized variable access
Date:   Mon, 11 Feb 2019 15:16:43 +0100
Message-Id: <20190211141827.513129018@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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

[ Upstream commit 1539c7f23f256120f89f8b9ec53160790bce9ed2 ]

Randconfig testing revealed a very old bug, with gcc-8:

sound/soc/intel/atom/sst/sst_loader.c: In function 'sst_load_fw':
sound/soc/intel/atom/sst/sst_loader.c:357:5: error: 'fw' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  if (fw == NULL) {
     ^
sound/soc/intel/atom/sst/sst_loader.c:354:25: note: 'fw' was declared here
  const struct firmware *fw;

We must check the return code of request_firmware() before we look at the
pointer result that may be uninitialized when the function fails.

Fixes: 9012c9544eea ("ASoC: Intel: mrfld - Add DSP load and management")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/atom/sst/sst_loader.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_loader.c b/sound/soc/intel/atom/sst/sst_loader.c
index 33917146d9c4..054b1d514e8a 100644
--- a/sound/soc/intel/atom/sst/sst_loader.c
+++ b/sound/soc/intel/atom/sst/sst_loader.c
@@ -354,14 +354,14 @@ static int sst_request_fw(struct intel_sst_drv *sst)
 	const struct firmware *fw;
 
 	retval = request_firmware(&fw, sst->firmware_name, sst->dev);
-	if (fw == NULL) {
-		dev_err(sst->dev, "fw is returning as null\n");
-		return -EINVAL;
-	}
 	if (retval) {
 		dev_err(sst->dev, "request fw failed %d\n", retval);
 		return retval;
 	}
+	if (fw == NULL) {
+		dev_err(sst->dev, "fw is returning as null\n");
+		return -EINVAL;
+	}
 	mutex_lock(&sst->sst_lock);
 	retval = sst_cache_and_parse_fw(sst, fw);
 	mutex_unlock(&sst->sst_lock);
-- 
2.19.1



