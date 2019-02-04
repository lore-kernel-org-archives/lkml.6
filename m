Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3919C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74A0F207E0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549278591;
	bh=WPAjtMBOwJiUC/6ygohEWjhLigrVA1UDxv5vwDMefMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X7Jm2sSpAKLK0l0np29ZMNRsK3g/fZHCDfVm3W8pj4H3zgJfzBBlvghjn0Y5LRaxU
	 t7rhzPngZIZ9EgLOKjf3Lq8tHp7TwazwJ5xQu/mIj0CX+jwIQToPuSlQiN+bqAAnc+
	 AwJ8g+KapTM0z+7459uA5KuNlTGECdRfOpPpNEeo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbfBDKk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:40:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:38342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729991AbfBDKkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:40:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A8302070C;
        Mon,  4 Feb 2019 10:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549276820;
        bh=WPAjtMBOwJiUC/6ygohEWjhLigrVA1UDxv5vwDMefMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kda1a8xpB4cch8TeWSD5ccZuFxXnWPV0tRv0hhJlxKrcYCdwYwAOdHBM2zw1SRoyc
         hBfRNLevttlc6NKm2y5+67j+OmTGTs6esahlKnlF7dPoDupfow0WJUWCpIACV6Fvfo
         vfc+frpnGAcwveoK143pfkvXYGPZ3mnOd4iS4Wxs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.4 09/65] ASoC: atom: fix a missing check of snd_pcm_lib_malloc_pages
Date:   Mon,  4 Feb 2019 11:36:02 +0100
Message-Id: <20190204103612.186113805@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103610.583715954@linuxfoundation.org>
References: <20190204103610.583715954@linuxfoundation.org>
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

From: Kangjie Lu <kjlu@umn.edu>

commit 44fabd8cdaaa3acb80ad2bb3b5c61ae2136af661 upstream.

snd_pcm_lib_malloc_pages() may fail, so let's check its status and
return its error code upstream.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/intel/atom/sst-mfld-platform-pcm.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
@@ -398,7 +398,13 @@ static int sst_media_hw_params(struct sn
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai)
 {
-	snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(params));
+	int ret;
+
+	ret =
+		snd_pcm_lib_malloc_pages(substream,
+				params_buffer_bytes(params));
+	if (ret)
+		return ret;
 	memset(substream->runtime->dma_area, 0, params_buffer_bytes(params));
 	return 0;
 }


