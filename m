Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008DBC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B630320866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8CBqrQM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B630320866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbeJPMBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:01:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:48744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728320AbeJPMBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:01:34 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3082208E4;
        Tue, 16 Oct 2018 04:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663192;
        bh=d6H8XW0DjPIFbusLr1Bt4R4SGcWJbSds7c9ASEOEfIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q8CBqrQMqH69FRR7ab1FV5pHRpbPrBZ/qMM7gNA8+4YKbJ2DsSZWYkDQVcXpUEUVS
         lqM9D6+HxmtcUNhrr/2ViGkrViBEpxlnKmr736GM6p38u2+GAvE5es6jjW9QjKWeUF
         KdbrJtd7z22M2s6TUcyiaEpAQ8L63tR3ths8lQCc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Edgar Cherkasov <echerkasov@dev.rtsoft.ru>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 055/100] i2c: i2c-scmi: fix for i2c_smbus_write_block_data
Date:   Tue, 16 Oct 2018 00:11:36 -0400
Message-Id: <20181016041221.135528-55-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Edgar Cherkasov <echerkasov@dev.rtsoft.ru>

[ Upstream commit 08d9db00fe0e300d6df976e6c294f974988226dd ]

The i2c-scmi driver crashes when the SMBus Write Block transaction is
executed:

WARNING: CPU: 9 PID: 2194 at mm/page_alloc.c:3931 __alloc_pages_slowpath+0x9db/0xec0
 Call Trace:
  ? get_page_from_freelist+0x49d/0x11f0
  ? alloc_pages_current+0x6a/0xe0
  ? new_slab+0x499/0x690
  __alloc_pages_nodemask+0x265/0x280
  alloc_pages_current+0x6a/0xe0
  kmalloc_order+0x18/0x40
  kmalloc_order_trace+0x24/0xb0
  ? acpi_ut_allocate_object_desc_dbg+0x62/0x10c
  __kmalloc+0x203/0x220
  acpi_os_allocate_zeroed+0x34/0x36
  acpi_ut_copy_eobject_to_iobject+0x266/0x31e
  acpi_evaluate_object+0x166/0x3b2
  acpi_smbus_cmi_access+0x144/0x530 [i2c_scmi]
  i2c_smbus_xfer+0xda/0x370
  i2cdev_ioctl_smbus+0x1bd/0x270
  i2cdev_ioctl+0xaa/0x250
  do_vfs_ioctl+0xa4/0x600
  SyS_ioctl+0x79/0x90
  do_syscall_64+0x73/0x130
  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
ACPI Error: Evaluating _SBW: 4 (20170831/smbus_cmi-185)

This problem occurs because the length of ACPI Buffer object is not
defined/initialized in the code before a corresponding ACPI method is
called. The obvious patch below fixes this issue.

Signed-off-by: Edgar Cherkasov <echerkasov@dev.rtsoft.ru>
Acked-by: Viktor Krasnov <vkrasnov@dev.rtsoft.ru>
Acked-by: Michael Brunner <Michael.Brunner@kontron.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-scmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-scmi.c b/drivers/i2c/busses/i2c-scmi.c
index a01389b85f13..7e9a2bbf5ddc 100644
--- a/drivers/i2c/busses/i2c-scmi.c
+++ b/drivers/i2c/busses/i2c-scmi.c
@@ -152,6 +152,7 @@ acpi_smbus_cmi_access(struct i2c_adapter *adap, u16 addr, unsigned short flags,
 			mt_params[3].type = ACPI_TYPE_INTEGER;
 			mt_params[3].integer.value = len;
 			mt_params[4].type = ACPI_TYPE_BUFFER;
+			mt_params[4].buffer.length = len;
 			mt_params[4].buffer.pointer = data->block + 1;
 		}
 		break;
-- 
2.17.1

