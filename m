Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21D5C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E89C208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:41:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E89C208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934644AbeFRPl1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:41:27 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:49475 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932442AbeFRPl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:41:26 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPA (Nemesis) id
 0M6alo-1gOoeA1RYq-00wRqM; Mon, 18 Jun 2018 17:41:10 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ALSA: use ktime_get_raw_ts64() instead of getrawmonotonic64()
Date:   Mon, 18 Jun 2018 17:41:00 +0200
Message-Id: <20180618154108.2227779-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:F1gy04h0YwpOlNbuVolHXeDBHhhrwHBpsfcMkHvkMZYYiRGqJ8P
 ddoltF4AH/6rhaFdtJ5IQn6jf2F/zY8LFeWxJKbcBauMyw3m8ISjfPA1kj9bKyqLEJVOuXV
 XM0mV0QrDHFP3qIR/Q6GB960XEIbFbyX6s5Q2Hg8InV6vYDqvINUr1VPR5I7jqk9yGrj+0D
 N8GNhsheyia/wOt91oC5Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:n/9KxaoTUpI=:f9jEhRDCMp21Ci/4/cvtHc
 W3sVvDO/u0oMRL9T+vzwDm59T5jQczCGqiJXgb/tikq5W4JhemWjmMz0nBfAJswteKczxGeSU
 gAX5PvM29GEP90eKrQG/jC/ZybCjplBTDH4P/ZBI2YTbS0VKPv9Ir+ZdkmjLAXM2cAQVl7fbw
 77An8oz8poE05rpvZxCy/jf3q4Os7zmt2ZrxreR5YfxNNKuNXkSi+krdUc4OnxDK4g8KWZ0OF
 W0sfxgVybnHz5PSOlvgNKLpGEAhNpWzcTeSt+Olu18KBbg1aotDrd1VglLs1PKt1FVtW9Fv6S
 6/Z5K/VpTb0WVRah87pHXYND8x+kjO1msCAgzYdwYIC6q4xJKx1mUWymXy/PyV1to6t5nGYGP
 SWMnnmieEjQnYzpAMyPpCfaqAfEPVLJAK/mAnNgaP0XzzEPCfd2o6Oix5ATgYA6Wnfq/OVVuh
 r7+bW+YzrHO7vynmh28r7rhWEbyslHKit1O3HB0Cupod0/Y82iqHvK729Z7VKkv9qat0UHWQJ
 01sdH8AQw0POAsrZIN1vem3/jmo6l23mlpu5eb7cJUEiQhfSeajAjrnZAyO4rWxMiTtSwv/T8
 nu+jCaiPJwqc0+tWQDDF403jrkoLW77nGSOs2MckptKdXu3T+6n7CbN1pzVpNQfvoqbGHPOy+
 vpekulMg96vGqrkLvgJ8KgZsP4T/JyOqyMi+QKI3wc3XXCSMUrc+0TkQPbo58KUrURoQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The API got renamed for consistency and the old name will
be removed once the last users are gone.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/sound/pcm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 5d5daa190b08..f566611f0fef 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -1187,7 +1187,7 @@ static inline void snd_pcm_gettime(struct snd_pcm_runtime *runtime,
 		ktime_get_ts64(tv);
 		break;
 	case SNDRV_PCM_TSTAMP_TYPE_MONOTONIC_RAW:
-		getrawmonotonic64(tv);
+		ktime_get_raw_ts64(tv);
 		break;
 	default:
 #ifdef CONFIG_SND_TSTAMP_REALTIME
-- 
2.9.0

