Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7791FC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1675820658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CqEijag1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1675820658
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbeH3QU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 12:20:59 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42942 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728120AbeH3QU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 12:20:58 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7UCIjkA007066;
        Thu, 30 Aug 2018 07:18:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535631526;
        bh=EAM3Bd2/5gveLhHgeRsf+3mZK5d36WW10G3Z0bjhRHE=;
        h=From:To:CC:Subject:Date;
        b=CqEijag1ScT4jXsVzERPqZVLGfACf2miWyFvABAtaYDMKeiRfpC9reu7CI1TwhW4z
         Zu4YRK0UJEFNpNPB8cOGh/q/f+nCFxUzd5nUJt7iDeU1Z2FvHQXwy9RAt+l13KLf1e
         +0zdsNrGc/Q2177kZD+Wy3g5+7MhySWHl+Bu5PLU=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7UCIj6D010076;
        Thu, 30 Aug 2018 07:18:45 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 30
 Aug 2018 07:18:45 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 30 Aug 2018 07:18:45 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7UCIhJx019829;
        Thu, 30 Aug 2018 07:18:43 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <dan.j.williams@intel.com>, <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>, <radheys@xilinx.com>
Subject: [PATCH v2 0/2] dmaengine: Add per descriptor metadata support
Date:   Thu, 30 Aug 2018 15:19:08 +0300
Message-ID: <20180830121910.16005-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

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
  dmaengine: Add metadata_ops for dma_async_tx_descriptor
  dmaengine: doc: Add sections for per descriptor metadata support

 Documentation/driver-api/dmaengine/client.rst |  70 ++++++++++++
 .../driver-api/dmaengine/provider.rst         |  46 ++++++++
 drivers/dma/dmaengine.c                       |  73 ++++++++++++
 include/linux/dmaengine.h                     | 108 ++++++++++++++++++
 4 files changed, 297 insertions(+)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

