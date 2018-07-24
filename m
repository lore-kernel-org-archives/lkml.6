Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EB2ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F49320856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F49320856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388445AbeGXOqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 10:46:40 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.35]:28846 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388428AbeGXOqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 10:46:40 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 8C78553EC
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 08:40:07 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id hxXrfryGfaSeyhxXrfSlgt; Tue, 24 Jul 2018 08:40:07 -0500
X-Authority-Reason: nr=8
Received: from [189.250.70.148] (port=46678 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fhxXq-001Ac5-T8; Tue, 24 Jul 2018 08:40:06 -0500
Date:   Tue, 24 Jul 2018 08:40:06 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Keith Busch <keith.busch@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] libnvdimm: fix NULL pointer dereference
Message-ID: <20180724134006.GA2775@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.70.148
X-Source-L: No
X-Exim-ID: 1fhxXq-001Ac5-T8
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.70.148]:46678
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 13
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ndd is being dereferenced before it is null checked, hence there is a
potential null pointer dereference.

Fix this by moving the pointer dereference after ndd has been properly
null checked at line 554: if (!ndd)

Addresses-Coverity-ID: 1472020 ("Dereference before null check")
Fixes: 42218e643bd2 ("libnvdimm: Use max contiguous area for namespace size")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/nvdimm/dimm_devs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index 9e977cb..1dc3125 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -546,7 +546,7 @@ resource_size_t nd_pmem_max_contiguous_dpa(struct nd_region *nd_region,
 					   struct nd_mapping *nd_mapping)
 {
 	struct nvdimm_drvdata *ndd = to_ndd(nd_mapping);
-	struct nvdimm_bus *nvdimm_bus = walk_to_nvdimm_bus(ndd->dev);
+	struct nvdimm_bus *nvdimm_bus;
 	resource_size_t max = 0;
 	struct resource *res;
 
@@ -554,6 +554,8 @@ resource_size_t nd_pmem_max_contiguous_dpa(struct nd_region *nd_region,
 	if (!ndd)
 		return 0;
 
+	nvdimm_bus = walk_to_nvdimm_bus(ndd->dev);
+
 	if (reserve_free_pmem(nvdimm_bus, nd_mapping))
 		return 0;
 	for_each_dpa_resource(ndd, res) {
-- 
2.7.4

