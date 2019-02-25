Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AEAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB8A021841
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129830;
	bh=GZaqxHFi+fpELkCwrANU3EJwlnpLRO3Ccmkj0jueqp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xqrusYkbGEdtPYur+la3vWWsLs0BiX5QpvYfzdomt4uRpLv5ZhoFsdNNux1JLsmQf
	 xFnHdQnhsn3lFhhKS7jQ7FoQmtT/SF1ip9nlRUu3OLIdkPAhSSMSNXzAnwh7MMoCcW
	 WKz/3TYJuKvN26bDJBGSp8ijmoLdhz/9JcB2QvuA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731148AbfBYVXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:23:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:58214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730712AbfBYVXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:23:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFF6921841;
        Mon, 25 Feb 2019 21:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129825;
        bh=GZaqxHFi+fpELkCwrANU3EJwlnpLRO3Ccmkj0jueqp8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bm5hoc+vOClmFSVjeMmBRX0QpRD0DeT6ZQ4tp6gQMDsmxIOADedKldlSK+pNzBMpu
         qfAemSg1gStswK2Ak4/zlnm0bpfh+FGGo1VfwZthPMCyvwnKyqYPkra0LwVYJMWCFz
         hVTNVsAkSmojgJli5MaONVyCRqBD8+y4/r4FACpY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 079/152] selftests: tc-testing: drop test on missing tunnel key id
Date:   Mon, 25 Feb 2019 22:11:11 +0100
Message-Id: <20190225195048.551240760@linuxfoundation.org>
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

[ Upstream commit e413615502a3324daba038f529932ba9a5248af0 ]

After merge of commit 80ef0f22ceda ("net/sched: act_tunnel_key: Allow
key-less tunnels"), act_tunnel_key does not reject anymore requests to
install 'set' rules where the key id is missing. Therefore, drop the
following TDC testcase:

 ba4e - Add tunnel_key set action with missing mandatory id parameter

because it's going to become a systematic fail as soon as userspace
iproute2 will start supporting key-less tunnels.

Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../tc-tests/actions/tunnel_key.json          | 29 -------------------
 1 file changed, 29 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/actions/tunnel_key.json b/tools/testing/selftests/tc-testing/tc-tests/actions/tunnel_key.json
index 10b2d894e4362..af5e99d272296 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/actions/tunnel_key.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/actions/tunnel_key.json
@@ -81,35 +81,6 @@
 	    ]
         ]
     },
-    {
-        "id": "ba4e",
-        "name": "Add tunnel_key set action with missing mandatory id parameter",
-        "category": [
-            "actions",
-            "tunnel_key"
-        ],
-        "setup": [
-            [
-                "$TC actions flush action tunnel_key",
-                0,
-                1,
-                255
-            ]
-        ],
-        "cmdUnderTest": "$TC actions add action tunnel_key set src_ip 10.10.10.1 dst_ip 20.20.20.2",
-        "expExitCode": "255",
-        "verifyCmd": "$TC actions list action tunnel_key",
-        "matchPattern": "action order [0-9]+: tunnel_key set.*src_ip 10.10.10.1.*dst_ip 20.20.20.2",
-        "matchCount": "0",
-        "teardown": [
-	    [
-		"$TC actions flush action tunnel_key",
-		0,
-		1,
-		255
-	    ]
-        ]
-    },
     {
         "id": "a5e0",
         "name": "Add tunnel_key set action with invalid src_ip parameter",
-- 
2.19.1



