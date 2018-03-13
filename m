Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752356AbeCMJIA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 05:08:00 -0400
Received: from mail1.bemta5.messagelabs.com ([195.245.231.145]:12716 "EHLO
        mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752261AbeCMJH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 05:07:58 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRWlGSWpSXmKPExsUSt3Opse7bKcu
  jDA6tkbW4cvEQk8XUh0/YLL5d6WCyuLxrDptF565+VosN39cyOrB5bPjcxOaxc9Zddo9NqzrZ
  PPa9XcbmsX7LVRaPz5vkAtiiWDPzkvIrElgzfn+dzlJwjqPi6/+jLA2MO9m7GLk4hATWM0r0N
  p5g62LkBHIqJG5efwxmswlYSEw+8QDMZhFQlXjV8pIdxBYW8JU4/XAOG0iziEAXo8TqV4/BEs
  wC5RJbPk1kBrF5BRwkej5MYIOwBSVOznzCAlEjIXHwxQtmiGUGEqcXNILFJQTsJaa/vwoU5wC
  y9SUaj8VChA0lvs/6BlViLrFjTy/TBEb+WUimzkIydQEj0ypGjeLUorLUIl1DQ72kosz0jJLc
  xMwcXUMDU73c1OLixPTUnMSkYr3k/NxNjMCAZgCCHYwr250PMUpyMCmJ8hqGLo8S4kvKT6nMS
  CzOiC8qzUktPsQow8GhJMF7bTJQTrAoNT21Ii0zBxhbMGkJDh4lEd6HIGne4oLE3OLMdIjUKU
  ZdjhsvXrcxC7Hk5eelSonzfgMpEgApyijNgxsBi/NLjLJSwryMQEcJ8RSkFuVmlqDKv2IU52B
  UEuY9CjKFJzOvBG7TK6AjmICOuHJiCcgRJYkIKakGRldu/o6VNZIX3iidijF5mLZ6x8rDTN/E
  r4bkb993cfuJjGUpPyPm6+e2WQcmPxN64BKplc+e9p/lPcfb6jX+S313fnCrTTb6stlP6GNRw
  Blu8a5pOhOf5iZZCcqeEj8vYLjEYbHiljMy5ftKj7v1skjnpJ8Kb1cJ3W7INvmSdJJuzeR1qb
  8uK7EUZyQaajEXFScCAPcgpDHuAgAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-11.tower-178.messagelabs.com!1520932075!98642228!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Tue, 13 Mar 2018 09:07:54 +0000
Subject: [PATCH] ASoC: da7219: clkdev_drop usage depends on CONFIG_COMMON_CLK
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: Support Opensource <support.opensource@diasemi.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Message-ID: <20180313090755.030AA3FBD3@swsrvapps-01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 13/03/2018 08:13:00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: ASoC: da7219: Add common clock usage for providing DAI clks

clkdev_drop usage in the codec remove function should be dependent
on if CONFIG_COMMON_CLK is defined for the platform, otherwise it
can cause build failures for platforms that do not support this.
The clkdev_* functions are still defined for those platforms, in
headers and source but the functions are not linked in.

This patch resolves this issue, so clkdev_drop is only used if
CONFIG_COMMON_CLK is defined.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 sound/soc/codecs/da7219.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 4412159..08f55d7 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1966,8 +1966,10 @@ static void da7219_remove(struct snd_soc_component *component)
 
 	da7219_aad_exit(component);
 
+#ifdef CONFIG_COMMON_CLK
 	if (da7219->dai_clks_lookup)
 		clkdev_drop(da7219->dai_clks_lookup);
+#endif
 
 	/* Supplies */
 	regulator_bulk_disable(DA7219_NUM_SUPPLIES, da7219->supplies);
-- 
1.9.1
