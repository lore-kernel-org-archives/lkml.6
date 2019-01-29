Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CD9C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE2820880
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548763126;
	bh=dmvJBLrEH6TZ3EU1RVd9ujE8virLArk+2yTGuUmeU/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ahIVOo8ewm7ggR9NxN4lK2fw6lZYxXZ8T7L+imDfK/ueg4Kgw83+GvQt/SlSvzW2d
	 rRBo5VqmfmU95miI0rvMlLR7C9FKOM07ju9I+jTXzh0/UvEKWmd2y8/xnpSB7f5lek
	 Nra8eiVK3UxEmTSIxTmJ8JVvJwYTJHXqFciIB+uw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731066AbfA2L6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:58:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:38586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730953AbfA2Lrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:47:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D56082086C;
        Tue, 29 Jan 2019 11:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762467;
        bh=dmvJBLrEH6TZ3EU1RVd9ujE8virLArk+2yTGuUmeU/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E3Hhw7NHv3kiOSVfKK9Jl8U2IXA8uEa7Lem2IySCTW77v2guGaUKyJdZrOHA8mWNj
         5Bwwd6NqSm5gImenZzcMvWTjr5ilSoehHfBQTQXGYx70slR3A+LO13RXvJ+/58We9y
         tuuDHLowk7A60+GGl3kK6df1bzHndLbC2j6uk/mE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.14 15/68] ASoC: atom: fix a missing check of snd_pcm_lib_malloc_pages
Date:   Tue, 29 Jan 2019 12:35:37 +0100
Message-Id: <20190129113132.793681839@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113131.751891514@linuxfoundation.org>
References: <20190129113131.751891514@linuxfoundation.org>
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
@@ -399,7 +399,13 @@ static int sst_media_hw_params(struct sn
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


