Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210FDC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E46CE20645
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:00:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E46CE20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbeLIVze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 16:55:34 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34870 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726437AbeLIVzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:15 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72e-0002iY-Kk; Sun, 09 Dec 2018 21:55:12 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72b-0003KJ-EE; Sun, 09 Dec 2018 21:55:09 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Sven Eckelmann" <sven.eckelmann@openmesh.com>,
        "Kalle Valo" <kvalo@codeaurora.org>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.758661454@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 089/328] ath10k: prevent active scans on potential
 unusable channels
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Eckelmann <sven.eckelmann@openmesh.com>

commit 3f259111583801013cb605bb4414aa529adccf1c upstream.

The QCA4019 hw1.0 firmware 10.4-3.2.1-00050 and 10.4-3.5.3-00053 (and most
likely all other) seem to ignore the WMI_CHAN_FLAG_DFS flag during the
scan. This results in transmission (probe requests) on channels which are
not "available" for transmissions.

Since the firmware is closed source and nothing can be done from our side
to fix the problem in it, the driver has to work around this problem. The
WMI_CHAN_FLAG_PASSIVE seems to be interpreted by the firmware to not
scan actively on a channel unless an AP was detected on it. Simple probe
requests will then be transmitted by the STA on the channel.

ath10k must therefore also use this flag when it queues a radar channel for
scanning. This should reduce the chance of an active scan when the channel
might be "unusable" for transmissions.

Fixes: e8a50f8ba44b ("ath10k: introduce DFS implementation")
Signed-off-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/wireless/ath/ath10k/mac.c | 7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -1724,6 +1724,13 @@ static int ath10k_update_channel_list(st
 			passive = channel->flags & IEEE80211_CHAN_NO_IR;
 			ch->passive = passive;
 
+			/* the firmware is ignoring the "radar" flag of the
+			 * channel and is scanning actively using Probe Requests
+			 * on "Radar detection"/DFS channels which are not
+			 * marked as "available"
+			 */
+			ch->passive |= ch->chan_radar;
+
 			ch->freq = channel->center_freq;
 			ch->min_power = 0;
 			ch->max_power = channel->max_power * 2;

