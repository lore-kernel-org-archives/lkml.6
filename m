Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC80C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4471A20855
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550955975;
	bh=xWhci2uiZVKn8+F0XxbRqRgkhpvH1cIACyISIkzvWqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LbynhReW6bqjTJ0RnH22owQxbnf1Uz72aBMxccParO0U1ugrGAWANtBzRZSUpvyM/
	 +TMwSthEvIAmt5YFwxn/sBiqg0iIpmQ8vpUbWMOMQcSq3t4nwGFlzNgArPcPQKdG8T
	 NJdU3/NOHS7twiqog1QchVaQckk2PbeIkpPX3tb0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbfBWVGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:06:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:41268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728640AbfBWVGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:06:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC92D20861;
        Sat, 23 Feb 2019 21:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550955968;
        bh=xWhci2uiZVKn8+F0XxbRqRgkhpvH1cIACyISIkzvWqo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zSsXCBjK8+vHdNNf1FGMP51m1M5LtEnLUcqqq0Op4+rr+pF+E4pZGVcq4pJqsjNsM
         uwUaAyZ03m5Q9+bte+tYSJotl3nxVJNsXuoDMTNf6We9NPuu0dvyTbJjM6CKx3I3X3
         su6jXpWP/XJWxW+AKU3B4xKZjttLXLHs2vthxtjs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     John Johansen <john.johansen@canonical.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 62/72] apparmor: Fix aa_label_build() error handling for failed merges
Date:   Sat, 23 Feb 2019 16:04:12 -0500
Message-Id: <20190223210422.199966-62-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210422.199966-1-sashal@kernel.org>
References: <20190223210422.199966-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Johansen <john.johansen@canonical.com>

[ Upstream commit d6d478aee003e19ef90321176552a8ad2929a47f ]

aa_label_merge() can return NULL for memory allocations failures
make sure to handle and set the correct error in this case.

Reported-by: Peng Hao <peng.hao2@zte.com.cn>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/domain.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index 08c88de0ffdad..11975ec8d5665 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -1444,7 +1444,10 @@ int aa_change_profile(const char *fqname, int flags)
 			new = aa_label_merge(label, target, GFP_KERNEL);
 		if (IS_ERR_OR_NULL(new)) {
 			info = "failed to build target label";
-			error = PTR_ERR(new);
+			if (!new)
+				error = -ENOMEM;
+			else
+				error = PTR_ERR(new);
 			new = NULL;
 			perms.allow = 0;
 			goto audit;
-- 
2.19.1

