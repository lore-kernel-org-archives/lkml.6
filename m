Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CABC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1552F20645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1552F20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbeIHCBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:01:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45084 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728049AbeIHCBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:01:51 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C4A5EDC4;
        Fri,  7 Sep 2018 21:19:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 4.18 107/145] iommu/ipmmu-vmsa: Dont register as BUS IOMMU if machine doesnt have IPMMU-VMSA
Date:   Fri,  7 Sep 2018 23:09:33 +0200
Message-Id: <20180907210912.505428169@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Osipenko <digetx@gmail.com>

commit 5c5c87411488af3cd082221e567498d813d0fe83 upstream.

This fixes kernel crashing on NVIDIA Tegra if kernel is compiled in
a multiplatform configuration and IPMMU-VMSA driver is enabled.

Cc: <stable@vger.kernel.org> # v3.20+
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iommu/ipmmu-vmsa.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -1081,12 +1081,19 @@ static struct platform_driver ipmmu_driv
 
 static int __init ipmmu_init(void)
 {
+	struct device_node *np;
 	static bool setup_done;
 	int ret;
 
 	if (setup_done)
 		return 0;
 
+	np = of_find_matching_node(NULL, ipmmu_of_ids);
+	if (!np)
+		return 0;
+
+	of_node_put(np);
+
 	ret = platform_driver_register(&ipmmu_driver);
 	if (ret < 0)
 		return ret;


