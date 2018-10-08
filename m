Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7E3C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 368C1214C5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9XVF7/k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 368C1214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731577AbeJICBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:01:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728239AbeJICBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:01:08 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC2F32087D;
        Mon,  8 Oct 2018 18:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024481;
        bh=NjViDnZ83mNSQbBovvNDHu7AAJLQjAAXfsWASIwVf4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H9XVF7/kcktL2QtF/KcNuRheucibCta1yLoqthuTlKWT0/iuMEwmuZRZRA7aeSP6M
         cZuTz1Nfu6Wd0Fu8b+vVWju1g/Z8VVDEAWRemQHTpGn5XpQtVlZZBSIiBBpjwKXXIp
         3b4bUX8YNtLlEkfrsCDQrlqm7vW+0KxjVTLHGV1k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 036/168] tc-testing: add test-cases for numeric and invalid control action
Date:   Mon,  8 Oct 2018 20:30:16 +0200
Message-Id: <20181008175621.421719073@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 25a8238f4cc8425d4aade4f9041be468d0e8aa2e ]

Only the police action allows us to specify an arbitrary numeric value
for the control action. This change introduces an explicit test case
for the above feature and then leverage it for testing the kernel behavior
for invalid control actions (reject).

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/tc-testing/tc-tests/actions/police.json |   48 ++++++++++
 1 file changed, 48 insertions(+)

--- a/tools/testing/selftests/tc-testing/tc-tests/actions/police.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/actions/police.json
@@ -313,6 +313,54 @@
         ]
     },
     {
+        "id": "6aaf",
+        "name": "Add police actions with conform-exceed control pass/pipe [with numeric values]",
+        "category": [
+            "actions",
+            "police"
+        ],
+        "setup": [
+            [
+                "$TC actions flush action police",
+                0,
+                1,
+                255
+            ]
+        ],
+        "cmdUnderTest": "$TC actions add action police rate 3mbit burst 250k conform-exceed 0/3 index 1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC actions get action police index 1",
+        "matchPattern": "action order [0-9]*:  police 0x1 rate 3Mbit burst 250Kb mtu 2Kb action pass/pipe",
+        "matchCount": "1",
+        "teardown": [
+            "$TC actions flush action police"
+        ]
+    },
+    {
+        "id": "29b1",
+        "name": "Add police actions with conform-exceed control <invalid>/drop",
+        "category": [
+            "actions",
+            "police"
+        ],
+        "setup": [
+            [
+                "$TC actions flush action police",
+                0,
+                1,
+                255
+            ]
+        ],
+        "cmdUnderTest": "$TC actions add action police rate 3mbit burst 250k conform-exceed 10/drop index 1",
+        "expExitCode": "255",
+        "verifyCmd": "$TC actions ls action police",
+        "matchPattern": "action order [0-9]*:  police 0x1 rate 3Mbit burst 250Kb mtu 2Kb action ",
+        "matchCount": "0",
+        "teardown": [
+            "$TC actions flush action police"
+        ]
+    },
+    {
         "id": "c26f",
         "name": "Add police action with invalid peakrate value",
         "category": [


