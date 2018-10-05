Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B7BC65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F7E121473
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbZEFu+9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F7E121473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbeJEXN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:13:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:50896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727958AbeJEXN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:13:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD0C42148D;
        Fri,  5 Oct 2018 16:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538756074;
        bh=2CHOi86Myddl7TisdRqK1y06+D1TqKxm2Ker6sGEr1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CbZEFu+9WyuNaUGi8rkWRN7YwJCprspdIAGjYPjEEG8SGGsEXYZObf3dkhmGzkJpa
         LOaV5DMKH0/75PdnB0HrJ54p0e5TFeAdn8LRl7z0Jcr6zvnFMKQZjZSbauHLIrG6zR
         tPkp7wOXHyAbQojs2oU1Q4JKkqTeFt2ZX4aDCyO8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 09/48] ASoC: q6routing: initialize data correctly
Date:   Fri,  5 Oct 2018 12:13:45 -0400
Message-Id: <20181005161424.20521-9-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005161424.20521-1-sashal@kernel.org>
References: <20181005161424.20521-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

[ Upstream commit 7aa09ff24301535491cd4de1b93107ee91449a12 ]

Some of the router data fields are left as default zeros which are
valid dai ids, so initialize these to invalid value of -1.

Without intializing these correctly get_session_from_id() can return
incorrect session resulting in not closing the opened copp and messing
up with the copp ref count.

Fixes: e3a33673e845 ("ASoC: qdsp6: q6routing: Add q6routing driver")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/soc/qcom/qdsp6/q6routing.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index 593f66b8622f..33bb97c0b6b6 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -933,8 +933,10 @@ static int msm_routing_probe(struct snd_soc_component *c)
 {
 	int i;
 
-	for (i = 0; i < MAX_SESSIONS; i++)
+	for (i = 0; i < MAX_SESSIONS; i++) {
 		routing_data->sessions[i].port_id = -1;
+		routing_data->sessions[i].fedai_id = -1;
+	}
 
 	return 0;
 }
-- 
2.17.1

