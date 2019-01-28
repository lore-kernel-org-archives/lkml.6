Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E32C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 131E72175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691239;
	bh=VfMUqBrIhtUz7f5JkorF4EfrldSBVxG6udWYl4O43no=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d1m/xrtspcqU4WVNcye8oEdmIWDAli5s86HdUuLj/c9WOgnecF5mLx3Q1Bj3ph3kD
	 S/KVP3XvcSPeN7r384S840dobskI7Xtr28g9GfCrzeSuH3zlgcYMJtGwBXb4LcVvy4
	 26lrq+AznOIA3HfNaPEcDXitbNeCz6cwmDTNqBkE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730819AbfA1QAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:00:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:45870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730274AbfA1QAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:00:33 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 343982082E;
        Mon, 28 Jan 2019 16:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691232;
        bh=VfMUqBrIhtUz7f5JkorF4EfrldSBVxG6udWYl4O43no=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SB1o8OBjXphrw41EIXBlXbMsXZArLQSWGgbfw5C1G2jsxmOXhGvAKyt0QFcKQqkhi
         iFZaf1219AJUmM9BJ7KznBE2G5xtanTP/uTt10VLjJQr8wGz9fF6VbzBeYCo30yB+G
         1Lt8d5PKvObXQ7iMA0d49irwEpv6H31qubsEseWk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Frank Rowand <frank.rowand@sony.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 025/258] of: overlay: do not duplicate properties from overlay for new nodes
Date:   Mon, 28 Jan 2019 10:55:31 -0500
Message-Id: <20190128155924.51521-25-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

[ Upstream commit 8814dc46bd9e347d4de55ec5bf8f16ea54470499 ]

When allocating a new node, add_changeset_node() was duplicating the
properties from the respective node in the overlay instead of
allocating a node with no properties.

When this patch is applied the errors reported by the devictree
unittest from patch "of: overlay: add tests to validate kfrees from
overlay removal" will no longer occur.  These error messages are of
the form:

   "OF: ERROR: ..."

and the unittest results will change from:

   ### dt-test ### end of unittest - 203 passed, 7 failed

to

   ### dt-test ### end of unittest - 210 passed, 0 failed

Tested-by: Alan Tull <atull@kernel.org>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/of/overlay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index baa9cee6fa2c..4b834518596f 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -368,7 +368,7 @@ static int add_changeset_node(struct overlay_changeset *ovcs,
 			break;
 
 	if (!tchild) {
-		tchild = __of_node_dup(node, node_kbasename);
+		tchild = __of_node_dup(NULL, node_kbasename);
 		if (!tchild)
 			return -ENOMEM;
 
-- 
2.19.1

