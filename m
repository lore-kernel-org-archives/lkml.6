Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2316C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E18222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025560;
	bh=3seTNSGhbmXA8FzndJ8C6urnmjrHlXL6anPUNcOv4sI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s0nzJrfgYNJaNehqI1ZhsL4y6hx0qiLPUVuMn0FTI9HEacx8hcbvb573pN2JSyVqe
	 Ay9168Z4EuoyXhCJS6LmJAKrl54ygiWMbxxT+jHGNUb0pqbY+lycBZ4ak067Sj5TtF
	 YHadSxhL/K8//uKlLhjPDmXVq+WVATy3nFiHImac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388657AbfBMCjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:39:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:42824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732877AbfBMCjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:39:16 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F17B02175B;
        Wed, 13 Feb 2019 02:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025555;
        bh=3seTNSGhbmXA8FzndJ8C6urnmjrHlXL6anPUNcOv4sI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M80kFxjzOqdt6aZkC0Dg/pSozGl6Nr/JYrjnHz+HMXWQRt19Pvok3g1ve4bZgw6FK
         2oy01qtyfuemXJPW2ahnhkrszZWmpCZAkLbeKALg4vKrcPGUBsiCOvUWSS+4+jS5P9
         MVQJZi87MPJ2uaM/HcRkI15Dm4RVzacWoVaDYXzw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Davide Caratti <dcaratti@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 65/83] selftests: tc-testing: fix tunnel_key failure if dst_port is unspecified
Date:   Tue, 12 Feb 2019 21:36:43 -0500
Message-Id: <20190213023701.20286-65-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023701.20286-1-sashal@kernel.org>
References: <20190213023701.20286-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davide Caratti <dcaratti@redhat.com>

[ Upstream commit 5216bd77798e2ed773ecd45f3f368dcaec63e5dd ]

After commit 1c25324caf82 ("net/sched: act_tunnel_key: Don't dump dst port
if it wasn't set"), act_tunnel_key doesn't dump anymore the destination
port, unless it was explicitly configured. This caused systematic failures
in the following TDC test case:

 7a88 - Add tunnel_key action with cookie parameter

Avoid matching zero values of TCA_TUNNEL_KEY_ENC_DST_PORT to let the test
pass again.

Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../selftests/tc-testing/tc-tests/actions/tunnel_key.json       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/actions/tunnel_key.json b/tools/testing/selftests/tc-testing/tc-tests/actions/tunnel_key.json
index af5e99d27229..e7e15a7336b6 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/actions/tunnel_key.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/actions/tunnel_key.json
@@ -605,7 +605,7 @@
         "cmdUnderTest": "$TC actions add action tunnel_key set src_ip 10.10.10.1 dst_ip 10.10.10.2 id 7 index 4 cookie aa11bb22cc33dd44ee55ff66aa11b1b2",
         "expExitCode": "0",
         "verifyCmd": "$TC actions get action tunnel_key index 4",
-        "matchPattern": "action order [0-9]+: tunnel_key.*set.*src_ip 10.10.10.1.*dst_ip 10.10.10.2.*key_id 7.*dst_port 0.*csum pipe.*index 4 ref.*cookie aa11bb22cc33dd44ee55ff66aa11b1b2",
+        "matchPattern": "action order [0-9]+: tunnel_key.*set.*src_ip 10.10.10.1.*dst_ip 10.10.10.2.*key_id 7.*csum pipe.*index 4 ref.*cookie aa11bb22cc33dd44ee55ff66aa11b1b2",
         "matchCount": "1",
         "teardown": [
             "$TC actions flush action tunnel_key"
-- 
2.19.1

