Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F38C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 274042148E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789320;
	bh=vAT9P8f1lJLIGqJRkz22jgS/0yVXyaW0HzP+bc+B1Ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SEk/47oiJWkcjrdwNNB2XWXpSGhOcvRqCnPa5GbqK7fuiFOZn1gWp27S9rKXfHf7p
	 A//sQWKF8nXJRX/vlrP0I4G5/lEcs+19bQVggD6gG9tslnBFa0+chg3DwuEA7fC924
	 5IKLvSlhLRWmkwafLXb82HW/leVyqI6/FEkNnIpM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 274042148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731311AbeLNMIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:08:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:54082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731280AbeLNMIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:08:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 123F02148E;
        Fri, 14 Dec 2018 12:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789315;
        bh=vAT9P8f1lJLIGqJRkz22jgS/0yVXyaW0HzP+bc+B1Ac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VFhbbFY5f+Sl4e6IAHADQztfcy2FWMnuA69huGcB+U8Cfb1R0EEugqj0BJcH03NMb
         VoUki2sxRKMVq0iDnzyDsa8euscnWl5aipRyyLAxYF0tNj2bscNK9e+1Q5D++lPkVS
         I5nYopEBZ++WMzTOI89DMscDjchCAsAOUNlTmeGg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yusuke Goda <yusuke.goda.sx@renesas.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 17/89] ASoC: rsnd: fixup clock start checker
Date:   Fri, 14 Dec 2018 12:59:30 +0100
Message-Id: <20181214115730.525227630@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
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

[ Upstream commit 3ee9a76a8c5a10e1bfb04b81db767c6d562ddaf3 ]

commit 4d230d12710646 ("ASoC: rsnd: fixup not to call clk_get/set under
non-atomic") fixuped clock start timing. But it exchanged clock start
checker from ssi->usrcnt to ssi->rate.

Current rsnd_ssi_master_clk_start() is called from .prepare,
but some player (for example GStreamer) might calls it many times.
In such case, the checker might returns error even though it was not
error. It should check ssi->usrcnt instead of ssi->rate.
This patch fixup it. Without this patch, GStreamer can't switch
48kHz / 44.1kHz.

Reported-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 34223c8c28a8..0db2791f7035 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -280,7 +280,7 @@ static int rsnd_ssi_master_clk_start(struct rsnd_mod *mod,
 	if (rsnd_ssi_is_multi_slave(mod, io))
 		return 0;
 
-	if (ssi->rate) {
+	if (ssi->usrcnt > 1) {
 		if (ssi->rate != rate) {
 			dev_err(dev, "SSI parent/child should use same rate\n");
 			return -EINVAL;
-- 
2.19.1



