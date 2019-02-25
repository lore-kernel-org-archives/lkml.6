Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6434C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94909213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129834;
	bh=3va/XHtHhTxUBx3zJkwSlgw1mo1RVCmsXtLQ0QDxpJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2MZn/6p9ZnGYkjkQMrCa4mMJ6VEJdbskUPqWBjnhEFv+6bkp4ZSDx68WgwMtsdM8X
	 H6rUF1ZFjTaFaYueg1pY7h3Hffr9dDLkywAPBX8bBRz9+TqU1KZ9TDuGsEoyKd14gx
	 XvHiCV7Ek2U6+mGmnHk/PyMPdN6iY95AwX68jzdE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731157AbfBYVXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:23:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:58266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730689AbfBYVXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:23:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED81F21841;
        Mon, 25 Feb 2019 21:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129828;
        bh=3va/XHtHhTxUBx3zJkwSlgw1mo1RVCmsXtLQ0QDxpJA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hkT0YbtWgWgVDYT/Yo2kjUTHaL72yXIB+XexCC4aPGfspmorE7o6nAv1KJQw3j0Ej
         WkDOgYgPtT3b877jUpQAiSsgALCFAlXS1P0udogRG5y4dSC/uP+OScyWHEWWshll8Z
         Wdox3fGHgzI/pZYNxc4CCL7QQKbnZY0NCg09LYWo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 080/152] selftests: tc-testing: fix tunnel_key failure if dst_port is unspecified
Date:   Mon, 25 Feb 2019 22:11:12 +0100
Message-Id: <20190225195048.608103485@linuxfoundation.org>
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



