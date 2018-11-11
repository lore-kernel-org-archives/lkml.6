Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68063C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6C120866
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IH7Zsgjy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D6C120866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732364AbeKLJzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:55:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:34210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732020AbeKLIRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:46 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 400E02154B;
        Sun, 11 Nov 2018 22:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975271;
        bh=8DveBt9ltGW1Eua9YGpjUiOOXJHA80J49rsh/mtW5dQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IH7ZsgjyxFmROifbz2X+drYKY7uZG66MSXNNXDzP+UTrp5cWWj3EZP9fqkfNRq3Fo
         uGjBEI3AyZDpwWDXhguPM28Bgp2WmMUVadVyt/Zc6zQ5wNg7edz9m6+bPHfcM9Aeyq
         8K7/XdZMt6XwCIJ5JlhES7anT6TZc6DqshNd6eNA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 170/361] coresight: etb10: Fix handling of perf mode
Date:   Sun, 11 Nov 2018 14:18:37 -0800
Message-Id: <20181111221644.176289613@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -147,6 +147,10 @@ static int etb_enable(struct coresight_d
 	if (val == CS_MODE_PERF)
 		return -EBUSY;
 
+	/* Don't let perf disturb sysFS sessions */
+	if (val == CS_MODE_SYSFS && mode == CS_MODE_PERF)
+		return -EBUSY;
+
 	/* Nothing to do, the tracer is already enabled. */
 	if (val == CS_MODE_SYSFS)
 		goto out;


