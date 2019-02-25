Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F02FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFFC621848
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130431;
	bh=rO8xS7Ito2a2Y9kjwbcavNGPkUSEsUmnt6y5odpuyo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m+DIGBHlimUZKaF0CM5DIX78+qpOfb9pQ/rhq018OKbPyUqLzMda0i8WTZlY+0sRe
	 MEbJFKieKw+rxtYWubcRDxLw1GrJAT2gvbmK0zQN/SoJ7T84cm6i4uMzhfqfBvvli0
	 GnKJYK8qh2K68HIcgUwUMBW2EQw/849OfsHS80L4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732724AbfBYVdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:33:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:40014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732714AbfBYVdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:33:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7ED16217F5;
        Mon, 25 Feb 2019 21:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130426;
        bh=rO8xS7Ito2a2Y9kjwbcavNGPkUSEsUmnt6y5odpuyo4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dwuC43EshIo6LitDx5KxDjDsruhncnV66MXZ9WWtOZ/M95IsY2J3vl2JX5bsiTyDv
         eAj6LmqQv4LqmhPBVeVy1V4w8D/il++E3jfcfil3G2WgaSjZLJfdcgJnNS5HxmUrl2
         lP3KTtsLxtOxQmO9JLKEbXVI9Mz42A2V0w3lQWjU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 100/183] selftests: tc-testing: fix tunnel_key failure if dst_port is unspecified
Date:   Mon, 25 Feb 2019 22:11:13 +0100
Message-Id: <20190225195111.525415106@linuxfoundation.org>
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
index af5e99d272296..e7e15a7336b6d 100644
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



