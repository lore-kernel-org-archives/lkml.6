Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753301AbeFDHCj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:02:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:54960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752720AbeFDHCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:02:35 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stanislaw Gruszka <sgruszka@redhat.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.14 44/52] Revert "rt2800: use TXOP_BACKOFF for probe frames"
Date: Mon,  4 Jun 2018 08:58:39 +0200
Message-Id: <20180604065608.360936425@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180604065606.532044490@linuxfoundation.org>
References: <20180604065606.532044490@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stanislaw Gruszka <sgruszka@redhat.com>

commit 52a192362932f333a7ebafd581c4d9b81da2fec8 upstream.

This reverts commit fb47ada8dc3c30c8e7b415da155742b49536c61e.

In some situations when we set TXOP_BACKOFF, the probe frame is
not sent at all. What it worse then sending probe frame as part
of AMPDU and can degrade 11n performance to 11g rates.

Cc: stable@vger.kernel.org
Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/ralink/rt2x00/rt2x00queue.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/net/wireless/ralink/rt2x00/rt2x00queue.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00queue.c
@@ -372,16 +372,15 @@ static void rt2x00queue_create_tx_descri
 
 	/*
 	 * Determine IFS values
-	 * - Use TXOP_BACKOFF for probe and management frames except beacons
+	 * - Use TXOP_BACKOFF for management frames except beacons
 	 * - Use TXOP_SIFS for fragment bursts
 	 * - Use TXOP_HTTXOP for everything else
 	 *
 	 * Note: rt2800 devices won't use CTS protection (if used)
 	 * for frames not transmitted with TXOP_HTTXOP
 	 */
-	if ((ieee80211_is_mgmt(hdr->frame_control) &&
-	     !ieee80211_is_beacon(hdr->frame_control)) ||
-	    (tx_info->flags & IEEE80211_TX_CTL_RATE_CTRL_PROBE))
+	if (ieee80211_is_mgmt(hdr->frame_control) &&
+	    !ieee80211_is_beacon(hdr->frame_control))
 		txdesc->u.ht.txop = TXOP_BACKOFF;
 	else if (!(tx_info->flags & IEEE80211_TX_CTL_FIRST_FRAGMENT))
 		txdesc->u.ht.txop = TXOP_SIFS;
