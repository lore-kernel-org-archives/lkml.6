Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48929C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4AE20843
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GiMEaw/r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC4AE20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731434AbeKAIV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:21:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:34500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731461AbeKAILM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:11:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF54A2145D;
        Wed, 31 Oct 2018 23:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027460;
        bh=XJqvd9/r/qBSEuDd6g7CmlhV8xiSX3AzdYvwq/6xwcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GiMEaw/rSn4qwBzFWquc+0ahExEnpabD7s/w44w2wp7lx+vVaM36oWcVGduVP+f6G
         3yqlDpg1geFx8BM5ShgJf0fKoJQwYgNVewCyXZzj3R8xDnjyR0akBhA6/byLDlcaW3
         I+mUUaF0z0lvO0hBOHQIyYkaZd6DDkW64hKNxU0A=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Janosch Frank <frankja@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 06/48] s390/sthyi: Fix machine name validity indication
Date:   Wed, 31 Oct 2018 19:10:12 -0400
Message-Id: <20181031231054.29333-6-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031231054.29333-1-sashal@kernel.org>
References: <20181031231054.29333-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Janosch Frank <frankja@linux.ibm.com>

[ Upstream commit b5130dc2224d1881f24224c0590c6d97f2168d6a ]

When running as a level 3 guest with no host provided sthyi support
sclp_ocf_cpc_name_copy() will only return zeroes. Zeroes are not a
valid group name, so let's not indicate that the group name field is
valid.

Also the group name is not dependent on stsi, let's not return based
on stsi before setting it.

Fixes: 95ca2cb57985 ("KVM: s390: Add sthyi emulation")
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kvm/sthyi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/sthyi.c b/arch/s390/kvm/sthyi.c
index 2f04ad1ea01c..029fd5e707b4 100644
--- a/arch/s390/kvm/sthyi.c
+++ b/arch/s390/kvm/sthyi.c
@@ -174,17 +174,19 @@ static void fill_hdr(struct sthyi_sctns *sctns)
 static void fill_stsi_mac(struct sthyi_sctns *sctns,
 			  struct sysinfo_1_1_1 *sysinfo)
 {
+	sclp_ocf_cpc_name_copy(sctns->mac.infmname);
+	if (*(u64 *)sctns->mac.infmname != 0)
+		sctns->mac.infmval1 |= MAC_NAME_VLD;
+
 	if (stsi(sysinfo, 1, 1, 1))
 		return;
 
-	sclp_ocf_cpc_name_copy(sctns->mac.infmname);
-
 	memcpy(sctns->mac.infmtype, sysinfo->type, sizeof(sctns->mac.infmtype));
 	memcpy(sctns->mac.infmmanu, sysinfo->manufacturer, sizeof(sctns->mac.infmmanu));
 	memcpy(sctns->mac.infmpman, sysinfo->plant, sizeof(sctns->mac.infmpman));
 	memcpy(sctns->mac.infmseq, sysinfo->sequence, sizeof(sctns->mac.infmseq));
 
-	sctns->mac.infmval1 |= MAC_ID_VLD | MAC_NAME_VLD;
+	sctns->mac.infmval1 |= MAC_ID_VLD;
 }
 
 static void fill_stsi_par(struct sthyi_sctns *sctns,
-- 
2.17.1

