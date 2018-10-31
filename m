Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403B3C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F38FB2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bje362Qw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F38FB2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731335AbeKAIK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:10:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:33826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729310AbeKAIKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:10:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAA8A20840;
        Wed, 31 Oct 2018 23:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027442;
        bh=P4dBa6QwIFTIxdJYFjirUd2f1MoTVTDRr6xjgwk52Dg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bje362QwogG5w+zyIbdQrEMrtZvZyESoV4EtDTHlHVRoyplK26vLZAD5Vt/qxawD1
         CHYAe/LBTmqx54xN3UowlBIqai1jvLu1sl9PfnVbH/Sp1vdqfELEN3inHGIxT704CI
         YnfuF16lcK0+brFtvhow7oZalJJ/AALsjEG4lTjA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 60/73] coresight: etb10: Fix handling of perf mode
Date:   Wed, 31 Oct 2018 19:09:35 -0400
Message-Id: <20181031230948.29203-60-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230948.29203-1-sashal@kernel.org>
References: <20181031230948.29203-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

[ Upstream commit 987d1e8dcd370d96029a3d76a0031b043c4a69ae ]

If the ETB is already enabled in sysfs mode, the ETB reports
success even if a perf mode is requested. Fix this by checking
the requested mode.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 56ecd7aff5eb..d14a9cb7959a 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -155,6 +155,10 @@ static int etb_enable(struct coresight_device *csdev, u32 mode)
 	if (val == CS_MODE_PERF)
 		return -EBUSY;
 
+	/* Don't let perf disturb sysFS sessions */
+	if (val == CS_MODE_SYSFS && mode == CS_MODE_PERF)
+		return -EBUSY;
+
 	/* Nothing to do, the tracer is already enabled. */
 	if (val == CS_MODE_SYSFS)
 		goto out;
-- 
2.17.1

