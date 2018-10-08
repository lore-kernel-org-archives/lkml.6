Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79545C677E4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DF6F214DC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2y/GpgE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DF6F214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbeJHWiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:38:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727370AbeJHWiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:38:08 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEC88214FF;
        Mon,  8 Oct 2018 15:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012353;
        bh=BKW7hA2GzJvXMjtfwNO/aBqgB34CU8Cvx7gas2jcDAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p2y/GpgElw9RezX+/FznuDCbkzhzM5LJys8kTi3vHQBPPhMn8QPNgOTb7RgRaAgsT
         wuyb2hxkPs9RulHBO/zYBxMVrDChlD+LFh0F2G7Lm9eDP0QDMhgcvKLv8bT9/HJDny
         tQ7reW1hz/zqIro7/8gNTn0CYyq78Rw7hBtdEjOw=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sabrina Dubroca <sd@queasysnail.net>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 27/58] selftests: pmtu: properly redirect stderr to /dev/null
Date:   Mon,  8 Oct 2018 11:24:52 -0400
Message-Id: <20181008152523.70705-27-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152523.70705-1-sashal@kernel.org>
References: <20181008152523.70705-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit 0a286afee5a1e8dca86d824209dbd3200294f86f ]

The cleanup function uses "$CMD 2 > /dev/null", which doesn't actually
send stderr to /dev/null, so when the netns doesn't exist, the error
message is shown. Use "2> /dev/null" instead, so that those messages
disappear, as was intended.

Fixes: d1f1b9cbf34c ("selftests: net: Introduce first PMTU test")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Acked-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/testing/selftests/net/pmtu.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index f8cc38afffa2..03e0566740de 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -175,8 +175,8 @@ setup() {
 
 cleanup() {
 	[ ${cleanup_done} -eq 1 ] && return
-	ip netns del ${NS_A} 2 > /dev/null
-	ip netns del ${NS_B} 2 > /dev/null
+	ip netns del ${NS_A} 2> /dev/null
+	ip netns del ${NS_B} 2> /dev/null
 	cleanup_done=1
 }
 
-- 
2.17.1

