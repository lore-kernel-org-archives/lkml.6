Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63163C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CFE520843
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OeJizFMP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CFE520843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbeKCDsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:48:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728578AbeKCDsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:48:54 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09C1D2082E;
        Fri,  2 Nov 2018 18:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184042;
        bh=F/9RQ7uxniS0vABGBN2ScMoqRnBFFFmh455iSD7Rbdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OeJizFMPqvBOgHW1swdZekYfzZC0F5Pa8O5egYTAywk1ZVsj/68gtNsKhdKo1yMtj
         c+wNBc3unP90hjlYQW9Ush9kB3ewn2yxZoIvjNjzMHJmQULlwtg9tbVlxcKExRVBf0
         vtnTdcJSol8WPnhC1JRQoehN6PR0bQPBNYAkQvpM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Roy Pledge <roy.pledge@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Olof Johansson <olof@lixom.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 021/150] soc: fsl: qbman: qman: avoid allocating from non existing gen_pool
Date:   Fri,  2 Nov 2018 19:33:03 +0100
Message-Id: <20181102182904.502472305@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
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

[ Upstream commit 64e9e22e68512da8df3c9a7430f07621e48db3c2 ]

If the qman driver didn't probe, calling qman_alloc_fqid_range,
qman_alloc_pool_range or qman_alloc_cgrid_range (as done in dpaa_eth) will
pass a NULL pointer to gen_pool_alloc, leading to a NULL pointer
dereference.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Reviewed-by: Roy Pledge <roy.pledge@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
(cherry picked from commit f72487a2788aa70c3aee1d0ebd5470de9bac953a)
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/fsl/qbman/qman.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index ecb22749df0b..8cc015183043 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -2729,6 +2729,9 @@ static int qman_alloc_range(struct gen_pool *p, u32 *result, u32 cnt)
 {
 	unsigned long addr;
 
+	if (!p)
+		return -ENODEV;
+
 	addr = gen_pool_alloc(p, cnt);
 	if (!addr)
 		return -ENOMEM;
-- 
2.17.1



