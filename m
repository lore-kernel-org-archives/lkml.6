Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D65DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D547120652
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131053;
	bh=jXdIEs+ZJFjeyLWtDN1uCeiofJa8s86WPAIBclKo57o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=USPuivxENcv+Q62GFkIYVtZHD8g4JnQAsLf2xPACn/8Ws7NJmv7vj+UclSk4C5OC8
	 zjd6WvV51DEPyQgt18HtqgaOifZlwMJfzIbZ9xX6euIckEEpJnT1ZS983F+dIJZfyN
	 iG7VJCzRsN6ZxmxMPBiUhbaF1ZGWHaIFw8+PNncU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730677AbfBYVoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:44:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:36210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727640AbfBYVae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:30:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 137DD21841;
        Mon, 25 Feb 2019 21:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130233;
        bh=jXdIEs+ZJFjeyLWtDN1uCeiofJa8s86WPAIBclKo57o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OlXbm5rbY7Etoq6VQWIezrHUp9EyzwiOKYDSbhBQq+gHZNESmusbMnKdfmaKlhXtI
         +r5CT4U3YeQzR1tVYoqY3XB0/P5mR6alTnZbWxOYIL0Byiu3SbbuxWy3X4fg/1akUn
         Ag+8Wu4M6spWkI5+aVP1UsdEih1GCN8LB2DIZZuM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 055/183] selftests: forwarding: Add a test for VLAN deletion
Date:   Mon, 25 Feb 2019 22:10:28 +0100
Message-Id: <20190225195103.789781642@linuxfoundation.org>
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

[ Upstream commit 4fabf3bf93a194c7fa5288da3e0af37e4b943cf3 ]

Add a VLAN on a bridge port, delete it and make sure the PVID VLAN is
not affected.

Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../selftests/net/forwarding/bridge_vlan_aware.sh | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_vlan_aware.sh b/tools/testing/selftests/net/forwarding/bridge_vlan_aware.sh
index d8313d0438b74..04c6431b2bd8c 100755
--- a/tools/testing/selftests/net/forwarding/bridge_vlan_aware.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_vlan_aware.sh
@@ -1,7 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-ALL_TESTS="ping_ipv4 ping_ipv6 learning flooding"
+ALL_TESTS="ping_ipv4 ping_ipv6 learning flooding vlan_deletion"
 NUM_NETIFS=4
 CHECK_TC="yes"
 source lib.sh
@@ -96,6 +96,19 @@ flooding()
 	flood_test $swp2 $h1 $h2
 }
 
+vlan_deletion()
+{
+	# Test that the deletion of a VLAN on a bridge port does not affect
+	# the PVID VLAN
+	log_info "Add and delete a VLAN on bridge port $swp1"
+
+	bridge vlan add vid 10 dev $swp1
+	bridge vlan del vid 10 dev $swp1
+
+	ping_ipv4
+	ping_ipv6
+}
+
 trap cleanup EXIT
 
 setup_prepare
-- 
2.19.1



