Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EDFC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 06:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A8D20833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 06:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yGG/13rm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48A8D20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbeILLsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 07:48:03 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44106 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbeILLsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 07:48:03 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8C6icmK006120;
        Wed, 12 Sep 2018 01:44:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536734678;
        bh=6q8iyqj5wxI0EcZ9ihQJcaWonAP+V1VV6WcxAI2Wx0s=;
        h=From:To:CC:Subject:Date;
        b=yGG/13rmJMv3nZWTkTmLQBtdsfsMFWYmRLk7QsxHfeAABlcRJgVq6vmLNSwwULbp4
         pmxvXHXYMiLQV4cI6T2Pq2m14BoGi5Wk07CF7BbrIqcNxJh51SlH+hDkojTH5DgB5o
         XrBdXG3DR6fwt11o4VXEWBQpu5X8bk7+za1teLh8=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8C6ic6U011845;
        Wed, 12 Sep 2018 01:44:38 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 12
 Sep 2018 01:44:38 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 12 Sep 2018 01:44:38 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8C6iZBR013004;
        Wed, 12 Sep 2018 01:44:36 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <dan.j.williams@intel.com>, <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>, <radheys@xilinx.com>
Subject: [PATCH v3 0/2] dmaengine: Add per descriptor metadata support
Date:   Wed, 12 Sep 2018 09:45:10 +0300
Message-ID: <20180912064512.27306-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes since v2:
- EXPORT_SYMBOL_GPL() for the metadata functions
- Added note to Documentation to not mix the two defined metadata modes
- Fixed the typos in Documentation

Changes since v1:
- Move code from header to dmaengine.c
- Fix spelling
- Use BIT() macro for bit definition
- Update both provider and client documentation

Changes since rfc:
- DESC_METADATA_EMBEDDED renamed to DESC_METADATA_ENGINE
- Use flow is added for both CLIENT and ENGINE metadata modes

Some data movement architecure (DMA controller and peripherals) uses metadata
associated with a transaction. The DMA controller role is to transfer the
payload and the metadata alongside.
The metadata itself is not used by the DMA engine itself, but it contains
parameters, keys, vectors, etc for peripheral or from the peripheral.

The DMAengine framework provides a generic ways to facilitate the metadata for
descriptors. Depending on the architecture the DMA driver can implment either
or both of the methods and it is up to the client driver to choose which one
to use.

If the DMA supports per descriptor metadata it can implement the attach,
get_ptr/set_len callbacks.

Client drivers must only use either attach or get_ptr/set_len to avoid
miss configuration.

Client driver can check if a given metadata mode is supported by the
channel during probe time with
dmaengine_is_metadata_mode_supported(chan, DESC_METADATA_CLIENT);
dmaengine_is_metadata_mode_supported(chan, DESC_METADATA_ENGINE);

and based on this information can use either mode.

Wrappers are also added for the metadata_ops.

To be used in DESC_METADATA_CLIENT mode:
dmaengine_desc_attach_metadata()

To be used in DESC_METADATA_ENGINE mode:
dmaengine_desc_get_metadata_ptr()
dmaengine_desc_set_metadata_len()

Regards,
Peter
---
Peter Ujfalusi (2):
  dmaengine: doc: Add sections for per descriptor metadata support
  dmaengine: Add metadata_ops for dma_async_tx_descriptor

 Documentation/driver-api/dmaengine/client.rst |  75 ++++++++++++
 .../driver-api/dmaengine/provider.rst         |  46 ++++++++
 drivers/dma/dmaengine.c                       |  73 ++++++++++++
 include/linux/dmaengine.h                     | 108 ++++++++++++++++++
 4 files changed, 302 insertions(+)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

