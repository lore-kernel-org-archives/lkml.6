Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2764CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6132208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBsFi6Pa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6132208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbeK2RDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:03:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:37114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728093AbeK2RDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:03:07 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA9C021019;
        Thu, 29 Nov 2018 05:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471136;
        bh=Ap2anoJiNcpI+hFZ1Qs2mDg+L74svbJ+T8lVX8KJ0GA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OBsFi6PaQVB+HqcWdZkCkWxw+MTPpH3jX0apahwX62CKIL5EPeZWMRmvMAKburmkM
         RXJe5s1eHcAWdN/Nb7ILOt5T7lun3k836h1hSf1tS/VAAhscvwp7Jwy5mHzywBtcvq
         iJJ55j3ByoP1+4rNJB8i0FesoKsZf+9OQwMrFuJ4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lucas Bates <lucasb@mojatatu.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 35/68] tc-testing: tdc.py: ignore errors when decoding stdout/stderr
Date:   Thu, 29 Nov 2018 00:55:26 -0500
Message-Id: <20181129055559.159228-35-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129055559.159228-1-sashal@kernel.org>
References: <20181129055559.159228-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Bates <lucasb@mojatatu.com>

[ Upstream commit 5aaf6428526bcad98d6f51f2f679c919bb75d7e9 ]

Prevent exceptions from being raised while decoding output
from an executed command. There is no impact on tdc's
execution and the verify command phase would fail the pattern
match.

Signed-off-by: Lucas Bates <lucasb@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/tc-testing/tdc.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/tdc.py b/tools/testing/selftests/tc-testing/tdc.py
index 87a04a8a5945..9b3f414ff1e9 100755
--- a/tools/testing/selftests/tc-testing/tdc.py
+++ b/tools/testing/selftests/tc-testing/tdc.py
@@ -134,9 +134,9 @@ def exec_cmd(args, pm, stage, command):
     (rawout, serr) = proc.communicate()
 
     if proc.returncode != 0 and len(serr) > 0:
-        foutput = serr.decode("utf-8")
+        foutput = serr.decode("utf-8", errors="ignore")
     else:
-        foutput = rawout.decode("utf-8")
+        foutput = rawout.decode("utf-8", errors="ignore")
 
     proc.stdout.close()
     proc.stderr.close()
-- 
2.17.1

