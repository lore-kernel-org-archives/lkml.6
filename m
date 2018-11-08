Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E81C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C588206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wXosLdak"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C588206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731542AbeKIIA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:00:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:35184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727454AbeKIHnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:43:02 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 383D4208A3;
        Thu,  8 Nov 2018 22:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714732;
        bh=08jRPimp1upugyT2mOw9O7aYRVe8Wz5WqEe6BLN00CE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wXosLdakIP1pANnB6/DJCsoGnP1LSTKJsFgtwtsNE3iglXB2m9gypFHm5nSkL9KjF
         RIqm/csVAK5vzoGZJOdAghznDr32y4y8vPDbWuGHVUoHAJGSpn/+kWt7I/1rNps6In
         E+C1AtKQy/1WYi9wXJLsgY3LDRouOXAP/ztTwZ/o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 091/171] ALSA: hda - No loopback on ALC299 codec
Date:   Thu,  8 Nov 2018 13:51:01 -0800
Message-Id: <20181108215133.984638774@linuxfoundation.org>
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



