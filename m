Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A473BC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 674702147A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 674702147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731766AbeHWMBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:01:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48222 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730989AbeHWMBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:01:23 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4C88DC74;
        Thu, 23 Aug 2018 08:32:49 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 189/217] octeon_mgmt: Fix MIX registers configuration on MTU setup
Date:   Thu, 23 Aug 2018 09:55:02 +0200
Message-Id: <20180823075514.142463547@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
References: <20180823075505.090246914@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Sverdlin <alexander.sverdlin@nsn.com>

[ Upstream commit 4aac0b43474d18f6160302a3caa147d77fa3baa1 ]

octeon_mgmt driver doesn't drop RX frames that are 1-4 bytes bigger than
MTU set for the corresponding interface. The problem is in the
AGL_GMX_RX0/1_FRM_MAX register setting, which should not account for VLAN
tagging.

According to Octeon HW manual:
"For tagged frames, MAX increases by four bytes for each VLAN found up to a
maximum of two VLANs, or MAX + 8 bytes."

OCTEON_FRAME_HEADER_LEN "define" is fine for ring buffer management, but
should not be used for AGL_GMX_RX0/1_FRM_MAX.

The problem could be easily reproduced using "ping" command. If affected
system has default MTU 1500, other host (having MTU >= 1504) can
successfully "ping" the affected system with payload size 1473-1476,
resulting in IP packets of size 1501-1504 accepted by the mgmt driver.
Fixed system still accepts IP packets of 1500 bytes even with VLAN tagging,
because the limits are lifted in HW as expected, for every VLAN tag.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/cavium/octeon/octeon_mgmt.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c
+++ b/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c
@@ -643,13 +643,21 @@ static int octeon_mgmt_set_mac_address(s
 static int octeon_mgmt_change_mtu(struct net_device *netdev, int new_mtu)
 {
 	struct octeon_mgmt *p = netdev_priv(netdev);
-	int size_without_fcs = new_mtu + OCTEON_MGMT_RX_HEADROOM;
+	int max_packet = new_mtu + ETH_HLEN + ETH_FCS_LEN;
 
 	netdev->mtu = new_mtu;
 
-	cvmx_write_csr(p->agl + AGL_GMX_RX_FRM_MAX, size_without_fcs);
+	/* HW lifts the limit if the frame is VLAN tagged
+	 * (+4 bytes per each tag, up to two tags)
+	 */
+	cvmx_write_csr(p->agl + AGL_GMX_RX_FRM_MAX, max_packet);
+	/* Set the hardware to truncate packets larger than the MTU. The jabber
+	 * register must be set to a multiple of 8 bytes, so round up. JABBER is
+	 * an unconditional limit, so we need to account for two possible VLAN
+	 * tags.
+	 */
 	cvmx_write_csr(p->agl + AGL_GMX_RX_JABBER,
-		       (size_without_fcs + 7) & 0xfff8);
+		       (max_packet + 7 + VLAN_HLEN * 2) & 0xfff8);
 
 	return 0;
 }


