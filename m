Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C20C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A8A2098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="y/31dg5x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72A8A2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730769AbeJQBMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:12:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729296AbeJQBMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:12:23 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4717A21476;
        Tue, 16 Oct 2018 17:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710458;
        bh=/M53Kq7OJLLG1idCZ3p5bMbj+JsmCBo4ptLDcGk4bMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y/31dg5x4806WhtkddqKfz5GMILV66yUmELvAAFtQI1LCC5BlJBC3TaJJuOpIwlkD
         /HuAa16TyLa0/ODPwq3UgHNJuj/KH2n4i2kY0ZbIJOMVGslEdEhQ2Rk+MdCVIXDQx4
         hGMQL03IlZKhoT5F/Bu7puacDARvpklnAbl/aw3Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Edgar Cherkasov <echerkasov@dev.rtsoft.ru>,
        Viktor Krasnov <vkrasnov@dev.rtsoft.ru>,
        Michael Brunner <Michael.Brunner@kontron.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 4.14 078/109] i2c: i2c-scmi: fix for i2c_smbus_write_block_data
Date:   Tue, 16 Oct 2018 19:05:46 +0200
Message-Id: <20181016170529.149259351@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170524.530541524@linuxfoundation.org>
References: <20181016170524.530541524@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Edgar Cherkasov <echerkasov@dev.rtsoft.ru>

commit 08d9db00fe0e300d6df976e6c294f974988226dd upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/busses/i2c-scmi.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/i2c/busses/i2c-scmi.c
+++ b/drivers/i2c/busses/i2c-scmi.c
@@ -152,6 +152,7 @@ acpi_smbus_cmi_access(struct i2c_adapter
 			mt_params[3].type = ACPI_TYPE_INTEGER;
 			mt_params[3].integer.value = len;
 			mt_params[4].type = ACPI_TYPE_BUFFER;
+			mt_params[4].buffer.length = len;
 			mt_params[4].buffer.pointer = data->block + 1;
 		}
 		break;


