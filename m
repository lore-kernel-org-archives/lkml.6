Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31321C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE4220658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECE4220658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731878AbeICV77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:59:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49020 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbeICV77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:59:59 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DFB2CA95;
        Mon,  3 Sep 2018 17:38:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.18 072/123] ASoC: dpcm: dont merge format from invalid codec dai
Date:   Mon,  3 Sep 2018 18:56:56 +0200
Message-Id: <20180903165722.595772653@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165719.499675257@linuxfoundation.org>
References: <20180903165719.499675257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jerome Brunet <jbrunet@baylibre.com>

commit 4febced15ac8ddb9cf3e603edb111842e4863d9a upstream.

When merging codec formats, dpcm_runtime_base_format() should skip
the codecs which are not supporting the current stream direction.

At the moment, if a BE link has more than one codec, and only one
of these codecs has no capture DAI, it becomes impossible to start
a capture stream because the merged format would be 0.

Skipping invalid codec DAI solves the problem.

Fixes: b073ed4e2126 ("ASoC: soc-pcm: DPCM cares BE format")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/soc-pcm.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1694,6 +1694,14 @@ static u64 dpcm_runtime_base_format(stru
 		int i;
 
 		for (i = 0; i < be->num_codecs; i++) {
+			/*
+			 * Skip CODECs which don't support the current stream
+			 * type. See soc_pcm_init_runtime_hw() for more details
+			 */
+			if (!snd_soc_dai_stream_valid(be->codec_dais[i],
+						      stream))
+				continue;
+
 			codec_dai_drv = be->codec_dais[i]->driver;
 			if (stream == SNDRV_PCM_STREAM_PLAYBACK)
 				codec_stream = &codec_dai_drv->playback;


