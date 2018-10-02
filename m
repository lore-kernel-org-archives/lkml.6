Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F82C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AAC42083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AAC42083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbeJBUK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:10:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60402 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbeJBUK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:10:57 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AC6AAC2B;
        Tue,  2 Oct 2018 13:27:36 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Van Assche <bart.vanassche@wdc.com>,
        Venkata Sandeep Dhanalakota <venkata.s.dhanalakota@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 040/228] include/rdma/opa_addr.h: Fix an endianness issue
Date:   Tue,  2 Oct 2018 06:22:17 -0700
Message-Id: <20181002132501.801360645@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
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

From: Bart Van Assche <bart.vanassche@wdc.com>

[ Upstream commit 4eefd62c17a9a5e7576207e84f3d2b4f73aba750 ]

IB_MULTICAST_LID_BASE is defined as follows:

  #define IB_MULTICAST_LID_BASE   cpu_to_be16(0xC000)

Hence use be16_to_cpu() to convert it to CPU endianness. Compile-tested
only.

Fixes: af808ece5ce9 ("IB/SA: Check dlid before SA agent queries for ClassPortInfo")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Venkata Sandeep Dhanalakota <venkata.s.dhanalakota@intel.com>
Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/rdma/opa_addr.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/rdma/opa_addr.h
+++ b/include/rdma/opa_addr.h
@@ -120,7 +120,7 @@ static inline bool rdma_is_valid_unicast
 	if (attr->type == RDMA_AH_ATTR_TYPE_IB) {
 		if (!rdma_ah_get_dlid(attr) ||
 		    rdma_ah_get_dlid(attr) >=
-		    be32_to_cpu(IB_MULTICAST_LID_BASE))
+		    be16_to_cpu(IB_MULTICAST_LID_BASE))
 			return false;
 	} else if (attr->type == RDMA_AH_ATTR_TYPE_OPA) {
 		if (!rdma_ah_get_dlid(attr) ||


