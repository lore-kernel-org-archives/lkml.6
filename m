Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4CFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4AD20578
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130433;
	bh=TOwUUMeduYDKYOumDyfEWUpqtpWeT8IV3/5dt+BxEoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YwXNGT/2SAfdsDHToWVBHUKJnBWEik9Sx0RhKPGcZV6x0xGbTBs86qAtwtjq04etB
	 pVxfNcG8saN9YQsikpX2QaUrLJ81ISg/5eImDkLXKgNjojJRs/2seMKcKvBnYqVc0Z
	 SB8OMEiG4nfNCJndWY2LuFbnt204TOFhT+YlZtGc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732733AbfBYVdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:33:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:40058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732722AbfBYVdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:33:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35039217F5;
        Mon, 25 Feb 2019 21:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130428;
        bh=TOwUUMeduYDKYOumDyfEWUpqtpWeT8IV3/5dt+BxEoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rrMZvA01jK0WsEIaPF4zLqTX0wWENGLMHzDmfs46sGJgwfeNh24m/JPE9cPDwjJce
         xS4w18mBCfuU0OVVbdk1Z/000l/aXKr1m/JFApTqmbf12RU6amuk0gN+Db6z+MMK93
         0j28jvvgR3CKU2fuIwbPit9LAvf/6cb7RNEIXXtY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ido Schimmel <idosch@mellanox.com>,
        Petr Machata <petrm@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 118/183] selftests: forwarding: Add a test case for externally learned FDB entries
Date:   Mon, 25 Feb 2019 22:11:31 +0100
Message-Id: <20190225195114.495130898@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 04c6431b2bd8c..b90dff8d3a94b 100755
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



