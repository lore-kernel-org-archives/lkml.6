Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A062ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4639020848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKa9iXOT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4639020848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbeJYWsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:48:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:57708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728220AbeJYWsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:48:50 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39CB22086D;
        Thu, 25 Oct 2018 14:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476954;
        bh=6S//L59qjtXmZaiVK6R/vWn7u8Dl8a6SWTZ3z0sUvyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dKa9iXOTj8bNRAGXQapJ966iUeJ4Liza4SVBrSiJc9vrkxO8j8Hx4/o00hdYE8rv6
         sUrCMMSahw5UBPsKVnGNN0ht2cjct6zOjMJszdSNzkJduVJc5YDXqDXUR2c4+zGY9p
         8MEPCd1KChgAsM+9gElzkMP2FyF1PMBpGkeAVYbY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 61/98] ALSA: hda - No loopback on ALC299 codec
Date:   Thu, 25 Oct 2018 10:13:46 -0400
Message-Id: <20181025141423.213774-61-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit fa16b69f1299004b60b625f181143500a246e5cb ]

ALC299 has no loopback mixer, but the driver still tries to add a beep
control over the mixer NID which leads to the error at accessing it.
This patch fixes it by properly declaring mixer_nid=0 for this codec.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=195775
Fixes: 28f1f9b26cee ("ALSA: hda/realtek - Add new codec ID ALC299")
Cc: stable@vger.kernel.org
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index ca2945711dbe..0eee308365c4 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6392,8 +6392,11 @@ static int patch_alc269(struct hda_codec *codec)
 		break;
 	case 0x10ec0225:
 	case 0x10ec0295:
+		spec->codec_variant = ALC269_TYPE_ALC225;
+		break;
 	case 0x10ec0299:
 		spec->codec_variant = ALC269_TYPE_ALC225;
+		spec->gen.mixer_nid = 0; /* no loopback on ALC299 */
 		break;
 	case 0x10ec0234:
 	case 0x10ec0274:
-- 
2.17.1

