Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BBBC43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A9BE20818
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHc2561d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A9BE20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731103AbeKIH6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:58:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:35862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731831AbeKIHn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:43:29 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26F0B20892;
        Thu,  8 Nov 2018 22:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714759;
        bh=v4ng/d6YUq+vsszXlsCzvaswR1FBcFixk+KwMTGIUpw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dHc2561daJc2ZyNchf01xTjlqdtOwXBdTpLR0E0WdTvw5z9Vdv/gyLTMEwHrmeO1z
         QA0CvgEH/I4qBi7LbQYgy5Ih4RnQGBCGtc9vCpvdM+LDxOslqNzZrU+z3BSTV5FaUc
         MInJn8aL/Ae5qsfbMGPfabpreIoAiv4xawqwrdxg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 112/171] ALSA: hda - Fix incorrect usage of IS_REACHABLE()
Date:   Thu,  8 Nov 2018 13:51:22 -0800
Message-Id: <20181108215135.427685916@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 6a30abaa40b62aed46ef12ea4c16c48565bdb376 ]

The commit c469652bb5e8 ("ALSA: hda - Use IS_REACHABLE() for
dependency on input") simplified the dependencies with IS_REACHABLE()
macro, but it broke due to its incorrect usage: it should have been
IS_REACHABLE(CONFIG_INPUT) instead of IS_REACHABLE(INPUT).

Fixes: c469652bb5e8 ("ALSA: hda - Use IS_REACHABLE() for dependency on input")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 0eee308365c4..cc48800f95e0 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3499,7 +3499,7 @@ static void alc280_fixup_hp_gpio4(struct hda_codec *codec,
 	}
 }
 
-#if IS_REACHABLE(INPUT)
+#if IS_REACHABLE(CONFIG_INPUT)
 static void gpio2_mic_hotkey_event(struct hda_codec *codec,
 				   struct hda_jack_callback *event)
 {
-- 
2.17.1



