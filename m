Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE15CECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F612081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+eWDEX4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3F612081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbeKIHbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:31:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:45462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbeKIHbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:31:01 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E87A020844;
        Thu,  8 Nov 2018 21:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714015;
        bh=LThJV54ncOWaGyEgyXRWKV1uCb6j2Mx8Ix29I0gtsGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W+eWDEX4VM2pNTv+nn8ekOqyOQbhJHBR1IzTpMCEGIU0Qnyx62aXX8SsOvGU4s/OU
         VgnXKnmEr1ysl7ipa7CIkvT5oy5/Mz/utFOpqkTJffIPyw7/G8VsRhC31WjqdqIPPR
         1ByBckcy9R3ZuYOB7yTEiHSMvNs+RxDgKt5Vpwrs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Edgar Cherkasov <echerkasov@dev.rtsoft.ru>,
        Viktor Krasnov <vkrasnov@dev.rtsoft.ru>,
        Michael Brunner <Michael.Brunner@kontron.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 3.18 005/144] i2c: i2c-scmi: fix for i2c_smbus_write_block_data
Date:   Thu,  8 Nov 2018 13:49:36 -0800
Message-Id: <20181108215055.184950244@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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


