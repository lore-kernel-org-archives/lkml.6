Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB197C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E7D3214F1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqwQlMO5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E7D3214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbeLEJwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:52:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:59274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729847AbeLEJwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:52:42 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C3A9213A2;
        Wed,  5 Dec 2018 09:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544003561;
        bh=J3rUV7snoSU1IzTsUjT6UyH4RNOtl08Ib8hrxIZg8iM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EqwQlMO5e30RVSANI7XQBci2mINw5oA6kpDmOYP3oLI97+oLe1EG6v4Mg2sirQRrV
         y337q9XJ3yivAbo+j+qXLzIjkkLAaBLPGWMR12NH26+7uTnHSrI1ZdbRZ3GVBEE1Ut
         tdedOQ2RD7ZoYgPBdLi006+8MqRvlUJFxPC9yhPo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tzung-Bi Shih <tzungbi@google.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 06/33] ASoC: dapm: Recalculate audio map forcely when card instantiated
Date:   Wed,  5 Dec 2018 04:51:04 -0500
Message-Id: <20181205095131.7685-6-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205095131.7685-1-sashal@kernel.org>
References: <20181205095131.7685-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tzung-Bi Shih <tzungbi@google.com>

[ Upstream commit 882eab6c28d23a970ae73b7eb831b169a672d456 ]

Audio map are possible in wrong state before card->instantiated has
been set to true.  Imaging the following examples:

time 1: at the beginning

  in:-1    in:-1    in:-1    in:-1
 out:-1   out:-1   out:-1   out:-1
 SIGGEN        A        B      Spk

time 2: after someone called snd_soc_dapm_new_widgets()
(e.g. create_fill_widget_route_map() in sound/soc/codecs/hdac_hdmi.c)

   in:1     in:0     in:0     in:0
  out:0    out:0    out:0    out:1
 SIGGEN        A        B      Spk

time 3: routes added

   in:1     in:0     in:0     in:0
  out:0    out:0    out:0    out:1
 SIGGEN -----> A -----> B ---> Spk

In the end, the path should be powered on but it did not.  At time 3,
"in" of SIGGEN and "out" of Spk did not propagate to their neighbors
because snd_soc_dapm_add_path() will not invalidate the paths if
the card has not instantiated (i.e. card->instantiated is false).
To correct the state of audio map, recalculate the whole map forcely.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index fa6b74a304a7..b927f9c81d92 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1711,6 +1711,7 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 	}
 
 	card->instantiated = 1;
+	dapm_mark_endpoints_dirty(card);
 	snd_soc_dapm_sync(&card->dapm);
 	mutex_unlock(&card->mutex);
 	mutex_unlock(&client_mutex);
-- 
2.17.1

