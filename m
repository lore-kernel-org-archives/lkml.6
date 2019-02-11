Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F1AC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F16B20844
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895307;
	bh=BChTxnJKbpaGDSxm3qWTT/lfgwai3R5tyWZncbdPCKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UG0XZxaTdVctv2/f9rFxYN6bcU71v26wHQJu9+gJmWx3ZtCAFg3EOwLt+3niU98VG
	 ULAaDcM2L02p7/A7qrdz6d6+0omQYsZ3vLWzBeD30JTv6CuA34SbaR9SJivUEKlCpf
	 Sj/+m7YXXZVhkv3sbTW38FzqzSuqRXd8bPcM8z3o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729868AbfBKO20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:28:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:34276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728991AbfBKO2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:28:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 388E720821;
        Mon, 11 Feb 2019 14:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895299;
        bh=BChTxnJKbpaGDSxm3qWTT/lfgwai3R5tyWZncbdPCKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oNogGCA4YwQoCsEZJ1KK5ZfirYNSGlIfCA3daEqT0FteqTtZd0XyN9G1uzzweYNOz
         eOvuG38um1wU5gyz0AZrkal1iviO32p2MwaamN/M5t6SBI/bLeYLwWzaefVpJIVPdR
         nHYqTGG7d3vBzZBpqoDixtZIA+kb+dYP3/6XfSpU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joey Zhang <joey.zhang@microchip.com>,
        Wesley Sheng <wesley.sheng@microchip.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 160/352] switchtec: Fix SWITCHTEC_IOCTL_EVENT_IDX_ALL flags overwrite
Date:   Mon, 11 Feb 2019 15:16:27 +0100
Message-Id: <20190211141857.063936593@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit e4a7dca5de625018b29417ecc39dc5037d9a5a36 ]

In the ioctl_event_ctl() SWITCHTEC_IOCTL_EVENT_IDX_ALL case, we call
event_ctl() several times with the same "ctl" struct.  Each call clobbers
ctl.flags, which leads to the problem that we may not actually enable or
disable all events as the user requested.

Preserve the event flag value with a temporary variable.

Fixes: 52eabba5bcdb ("switchtec: Add IOCTLs to the Switchtec driver")
Signed-off-by: Joey Zhang <joey.zhang@microchip.com>
Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
[bhelgaas: changelog]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/switch/switchtec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 54a8b30dda38..37d0c15c9eeb 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -800,6 +800,7 @@ static int ioctl_event_ctl(struct switchtec_dev *stdev,
 {
 	int ret;
 	int nr_idxs;
+	unsigned int event_flags;
 	struct switchtec_ioctl_event_ctl ctl;
 
 	if (copy_from_user(&ctl, uctl, sizeof(ctl)))
@@ -821,7 +822,9 @@ static int ioctl_event_ctl(struct switchtec_dev *stdev,
 		else
 			return -EINVAL;
 
+		event_flags = ctl.flags;
 		for (ctl.index = 0; ctl.index < nr_idxs; ctl.index++) {
+			ctl.flags = event_flags;
 			ret = event_ctl(stdev, &ctl);
 			if (ret < 0)
 				return ret;
-- 
2.19.1



