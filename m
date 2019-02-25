Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8473C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1DE21848
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129727;
	bh=j1AwC6L3fbW0YAQI/PbLYOnd0cCKdEw9XUjLrA9vOT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=plBmCu7Idyacf/ftoygU5beoYk9jbxa7+a2fFOT3W2+Z5ye9iL/17vJSjTfka5JRq
	 iUWDt/i3MZsKS+U+RjF5ZLUFAampAWkcXLm/2QSKamk5VMcDHUvWLkgmnGjPaTU/Nt
	 HAVqAyEurzdzfQwKiwDY/rMTKzmKJynchYLYFuus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730796AbfBYVWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:22:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:56014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730779AbfBYVWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:22:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF5D821852;
        Mon, 25 Feb 2019 21:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129721;
        bh=j1AwC6L3fbW0YAQI/PbLYOnd0cCKdEw9XUjLrA9vOT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WLo75vpZtxDpNGtJ68ecPCGP6JdPI9WhBAE7XVWa4RU98OFvv9LnOSixZDO9poI+2
         JGsfv3T1N/vULoNwOb0jZ183y5KPArWanZuA/XVtzrgABUcbw5y1Gx/Q6eRvrjXaaU
         YvpQSfPhK+mh9ZlUBOTvV/GtFQnjSXmne7laImZg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 046/152] selftests: forwarding: Add a test for VLAN deletion
Date:   Mon, 25 Feb 2019 22:10:38 +0100
Message-Id: <20190225195046.890490985@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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



