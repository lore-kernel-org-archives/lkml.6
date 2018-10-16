Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6FDC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 157DF2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhzK7o+h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 157DF2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbeJQBEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:04:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727734AbeJQBEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:04:14 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDD3C20866;
        Tue, 16 Oct 2018 17:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539709971;
        bh=5Vabquq2TbjKYVF8K3irGQbxt82XtFltD9AhwC+QYbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HhzK7o+hyfrfwgNkHDqzar0RtrnzNk0kivpjTBfoPaIcbuY6yMJY5Dfm8vuibrFyi
         P8dxjw/WGqYI5ZjGrhXLbPn23gczxA2xiP+kWEwM49xt2WRX95TT1+a2AHIOR0UJ+z
         zFLqqwawT6Yo6lVr6/J7Ee7U2jpwd7aL/Mdb8n1s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>,
        Michal Kalderon <Michal.Kalderon@cavium.com>
Subject: [PATCH 4.18 059/135] qed: Fix shmem structure inconsistency between driver and the mfw.
Date:   Tue, 16 Oct 2018 19:04:49 +0200
Message-Id: <20181016170518.617034126@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
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

From: Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>

[ Upstream commit 5f672090e44f4951084c5e1d6b0668a5fc422af8 ]

The structure shared between driver and the management FW (mfw) differ in
sizes. This would lead to issues when driver try to access the structure
members which are not-aligned with the mfw copy e.g., data_ptr usage in the
case of mfw_tlv request.
Align the driver structure with mfw copy, add reserved field(s) to driver
structure for the members not used by the driver.

Fixes: dd006921d67f ("qed: Add MFW interfaces for TLV request support.)
Signed-off-by: Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>
Signed-off-by: Michal Kalderon <Michal.Kalderon@cavium.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qed/qed_hsi.h |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/qlogic/qed/qed_hsi.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_hsi.h
@@ -11987,6 +11987,7 @@ struct public_global {
 	u32 running_bundle_id;
 	s32 external_temperature;
 	u32 mdump_reason;
+	u64 reserved;
 	u32 data_ptr;
 	u32 data_size;
 };


