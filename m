Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73592ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 301422089A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YORiDHOk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 301422089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbeKIHei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:34:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:51190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726831AbeKIHei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:34:38 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 811DF2089A;
        Thu,  8 Nov 2018 21:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714230;
        bh=JaXnsPTVEVxvAVGVWT0Fnx5AtpjQwy4pizcIx8XKa50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YORiDHOk7hSbedUte5SEK0vyDhkg/r1kHJiUizWh3z5bBTlMyM2fLgSRj/l/vIkDG
         MsQkfOjdIb1vuexwmsUnqkBBl8xOxT6iOzckE1Mdmxp9ykgwY94iA3vqMyK4lRW/su
         o7FscOhf3+IvRnchHxv9qq/y4b2tF+rh7yRC8EsM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mateusz Sylwestrzak <matisec7@gmail.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 106/144] ALSA: hda - Add headset mic support for Acer Aspire V5-573G
Date:   Thu,  8 Nov 2018 13:51:17 -0800
Message-Id: <20181108215105.529366826@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 0420694dddeb9e269a1ab2129a0119a5cea294a4 ]

Acer Aspire V5 with the ALC282 codec is given the wrong value for the
0x19 PIN by the laptop's BIOS. Overriding it with the correct value
adds support for the headset microphone which would not otherwise be
visible in the system.

The fix is based on commit 7819717b1134 with a similar quirk for Acer
Aspire with the ALC269 codec.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=96201
Cc: <stable@vger.kernel.org>
Signed-off-by: Mateusz Sylwestrzak <matisec7@gmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index fd3bbcf317ee..c32d51d51b3e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5185,7 +5185,7 @@ static const struct hda_fixup alc269_fixups[] = {
 			{ 0x14, 0x90170110 },
 			{ 0x17, 0x40000008 },
 			{ 0x18, 0x411111f0 },
-			{ 0x19, 0x411111f0 },
+			{ 0x19, 0x01a1913c },
 			{ 0x1a, 0x411111f0 },
 			{ 0x1b, 0x411111f0 },
 			{ 0x1d, 0x40f89b2d },
-- 
2.17.1



