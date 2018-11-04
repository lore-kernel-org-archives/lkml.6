Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8463CECDE46
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A132085A
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YI7YAN3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43A132085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730257AbeKDXLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:11:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:49374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731735AbeKDXJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:09:32 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5912A20868;
        Sun,  4 Nov 2018 13:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339668;
        bh=cuJp/kSefluQLDZhUcBqmLRdgEEsqjUNREywZCU3qog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YI7YAN3wSv2NxHzR1IVR2aMWaQRT+tY7xXzBsWC6UKewyIVQ/djVfwkjWq+LRm7+S
         SSC/7JtV55xTWoDl11U/FtP0Iz3kFSVyUAFEWrnSU4BmDVkgZgWfn6VlP8uVggLgA7
         v+ucX7Yh7LqPBvECjS2Pmq5LCUcGh+ojmvXh+O9I=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 09/15] media: pci: cx23885: handle adding to list failure
Date:   Sun,  4 Nov 2018 08:54:11 -0500
Message-Id: <20181104135417.88671-9-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135417.88671-1-sashal@kernel.org>
References: <20181104135417.88671-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Mc Guire <hofrat@osadl.org>

[ Upstream commit c5d59528e24ad22500347b199d52b9368e686a42 ]

altera_hw_filt_init() which calls append_internal() assumes
that the node was successfully linked in while in fact it can
silently fail. So the call-site needs to set return to -ENOMEM
on append_internal() returning NULL and exit through the err path.

Fixes: 349bcf02e361 ("[media] Altera FPGA based CI driver module")

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/cx23885/altera-ci.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/media/pci/cx23885/altera-ci.c b/drivers/media/pci/cx23885/altera-ci.c
index aaf4e46ff3e9..a0c1ff97f905 100644
--- a/drivers/media/pci/cx23885/altera-ci.c
+++ b/drivers/media/pci/cx23885/altera-ci.c
@@ -660,6 +660,10 @@ static int altera_hw_filt_init(struct altera_ci_config *config, int hw_filt_nr)
 		}
 
 		temp_int = append_internal(inter);
+		if (!temp_int) {
+			ret = -ENOMEM;
+			goto err;
+		}
 		inter->filts_used = 1;
 		inter->dev = config->dev;
 		inter->fpga_rw = config->fpga_rw;
@@ -694,6 +698,7 @@ static int altera_hw_filt_init(struct altera_ci_config *config, int hw_filt_nr)
 		     __func__, ret);
 
 	kfree(pid_filt);
+	kfree(inter);
 
 	return ret;
 }
@@ -728,6 +733,10 @@ int altera_ci_init(struct altera_ci_config *config, int ci_nr)
 		}
 
 		temp_int = append_internal(inter);
+		if (!temp_int) {
+			ret = -ENOMEM;
+			goto err;
+		}
 		inter->cis_used = 1;
 		inter->dev = config->dev;
 		inter->fpga_rw = config->fpga_rw;
@@ -796,6 +805,7 @@ int altera_ci_init(struct altera_ci_config *config, int ci_nr)
 	ci_dbg_print("%s: Cannot initialize CI: Error %d.\n", __func__, ret);
 
 	kfree(state);
+	kfree(inter);
 
 	return ret;
 }
-- 
2.17.1

