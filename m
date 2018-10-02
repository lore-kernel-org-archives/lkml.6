Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508FDC004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DBEF208AE
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DBEF208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbeJBUK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:10:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60390 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbeJBUK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:10:57 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8923DBF0;
        Tue,  2 Oct 2018 13:27:35 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Petr Machata <petrm@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 066/228] selftests: forwarding: Tweak tc filters for mirror-to-gretap tests
Date:   Tue,  2 Oct 2018 06:22:43 -0700
Message-Id: <20181002132503.761221651@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Petr Machata <petrm@mellanox.com>

[ Upstream commit ec9fdc99f5a6a2cfe4061e807fcb0cc1129f0a2d ]

When running mirror_gre_bridge_1d_vlan tests on veth, several issues
cause spurious failures:

- vlan_ethtype should be ip, not ipv6 even in mirror-to-ip6gretap case,
  because the overlay packet is still IPv4.
- Similarly ip_proto matches the innermost IP protocol, so can't be used
  to filter out GRE packet. Drop the corresponding condition.
- Because the above fixes the filters to match in slow path as well,
  they need to be made skip_hw so as not to double-count packets.

Signed-off-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/forwarding/mirror_gre_bridge_1d_vlan.sh |    6 ++++--
 tools/testing/selftests/net/forwarding/mirror_gre_lib.sh            |    2 +-
 tools/testing/selftests/net/forwarding/mirror_gre_vlan_bridge_1q.sh |    6 ++++--
 3 files changed, 9 insertions(+), 5 deletions(-)

--- a/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1d_vlan.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1d_vlan.sh
@@ -74,12 +74,14 @@ test_vlan_match()
 
 test_gretap()
 {
-	test_vlan_match gt4 'vlan_id 555 vlan_ethtype ip' "mirror to gretap"
+	test_vlan_match gt4 'skip_hw vlan_id 555 vlan_ethtype ip' \
+			"mirror to gretap"
 }
 
 test_ip6gretap()
 {
-	test_vlan_match gt6 'vlan_id 555 vlan_ethtype ipv6' "mirror to ip6gretap"
+	test_vlan_match gt6 'skip_hw vlan_id 555 vlan_ethtype ip' \
+			"mirror to ip6gretap"
 }
 
 test_gretap_stp()
--- a/tools/testing/selftests/net/forwarding/mirror_gre_lib.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_lib.sh
@@ -62,7 +62,7 @@ full_test_span_gre_dir_vlan_ips()
 			  "$backward_type" "$ip1" "$ip2"
 
 	tc filter add dev $h3 ingress pref 77 prot 802.1q \
-		flower $vlan_match ip_proto 0x2f \
+		flower $vlan_match \
 		action pass
 	mirror_test v$h1 $ip1 $ip2 $h3 77 10
 	tc filter del dev $h3 ingress pref 77
--- a/tools/testing/selftests/net/forwarding/mirror_gre_vlan_bridge_1q.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_vlan_bridge_1q.sh
@@ -79,12 +79,14 @@ test_vlan_match()
 
 test_gretap()
 {
-	test_vlan_match gt4 'vlan_id 555 vlan_ethtype ip' "mirror to gretap"
+	test_vlan_match gt4 'skip_hw vlan_id 555 vlan_ethtype ip' \
+			"mirror to gretap"
 }
 
 test_ip6gretap()
 {
-	test_vlan_match gt6 'vlan_id 555 vlan_ethtype ipv6' "mirror to ip6gretap"
+	test_vlan_match gt6 'skip_hw vlan_id 555 vlan_ethtype ip' \
+			"mirror to ip6gretap"
 }
 
 test_span_gre_forbidden_cpu()


