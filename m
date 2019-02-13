Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16767C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9066222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025413;
	bh=m6jhPpqtd/2FceZOibbof9G/YWsm+uUUjAU0JWnwGb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0H6rjEqf8i+cPvanL7FFJ0HYFQngRdw3J3qtQ7gy1rA9Ubyc1nWObJsdolLiEX4uJ
	 5ubeTbJAOgUoeDRrkpoVVLqOXlmKRq7Hof83OsddXXgU6oQIh0hw4+orXhxBWpsx7y
	 W6RTRsM5Mvqs3cMdCcAXpiLv0Ecm1Akcor9p9pDc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388188AbfBMCgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:36:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:40412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730755AbfBMCgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:36:48 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC0C6206B6;
        Wed, 13 Feb 2019 02:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025407;
        bh=m6jhPpqtd/2FceZOibbof9G/YWsm+uUUjAU0JWnwGb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EO2ylSY0serV+rDAnr1EifuPhOXT4PM74RqUJB3xiykD4kKlCNuBS7vkTQnO8u+wA
         zJATNxXEzbpHqG2Ucw+NSuDOqsUw9al2UW1MBnqWmaPkt/FsIroGHP2Od5J4xuAZWZ
         pzmFYd++IaB0TOHgeK3yPHUw+/lh839wA0KOu9SM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ido Schimmel <idosch@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 101/105] selftests: forwarding: Add a test case for externally learned FDB entries
Date:   Tue, 12 Feb 2019 21:33:32 -0500
Message-Id: <20190213023336.19019-101-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ido Schimmel <idosch@mellanox.com>

[ Upstream commit 479a2b761d61c04e2ae97325aa391a8a8c99c23e ]

Test that externally learned FDB entries can roam, but not age out.

Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reviewed-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/forwarding/bridge_vlan_aware.sh       | 34 ++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_vlan_aware.sh b/tools/testing/selftests/net/forwarding/bridge_vlan_aware.sh
index 04c6431b2bd8..b90dff8d3a94 100755
--- a/tools/testing/selftests/net/forwarding/bridge_vlan_aware.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_vlan_aware.sh
@@ -1,7 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-ALL_TESTS="ping_ipv4 ping_ipv6 learning flooding vlan_deletion"
+ALL_TESTS="ping_ipv4 ping_ipv6 learning flooding vlan_deletion extern_learn"
 NUM_NETIFS=4
 CHECK_TC="yes"
 source lib.sh
@@ -109,6 +109,38 @@ vlan_deletion()
 	ping_ipv6
 }
 
+extern_learn()
+{
+	local mac=de:ad:be:ef:13:37
+	local ageing_time
+
+	# Test that externally learned FDB entries can roam, but not age out
+	RET=0
+
+	bridge fdb add de:ad:be:ef:13:37 dev $swp1 master extern_learn vlan 1
+
+	bridge fdb show brport $swp1 | grep -q de:ad:be:ef:13:37
+	check_err $? "Did not find FDB entry when should"
+
+	# Wait for 10 seconds after the ageing time to make sure the FDB entry
+	# was not aged out
+	ageing_time=$(bridge_ageing_time_get br0)
+	sleep $((ageing_time + 10))
+
+	bridge fdb show brport $swp1 | grep -q de:ad:be:ef:13:37
+	check_err $? "FDB entry was aged out when should not"
+
+	$MZ $h2 -c 1 -p 64 -a $mac -t ip -q
+
+	bridge fdb show brport $swp2 | grep -q de:ad:be:ef:13:37
+	check_err $? "FDB entry did not roam when should"
+
+	log_test "Externally learned FDB entry - ageing & roaming"
+
+	bridge fdb del de:ad:be:ef:13:37 dev $swp2 master vlan 1 &> /dev/null
+	bridge fdb del de:ad:be:ef:13:37 dev $swp1 master vlan 1 &> /dev/null
+}
+
 trap cleanup EXIT
 
 setup_prepare
-- 
2.19.1

