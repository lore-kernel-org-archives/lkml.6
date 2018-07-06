Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839F6C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F7B520877
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:50:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F7B520877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933788AbeGFFuC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:50:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60438 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933733AbeGFFuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:50:00 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 19A9886A;
        Fri,  6 Jul 2018 05:49:59 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 4.14 06/61] usb: typec: ucsi: acpi: Workaround for cache mode issue
Date:   Fri,  6 Jul 2018 07:46:30 +0200
Message-Id: <20180706054712.576584253@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706054712.332416244@linuxfoundation.org>
References: <20180706054712.332416244@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

commit 1f9f9d168ce619608572b01771c47a41b15429e6 upstream.

This fixes an issue where the driver fails with an error:

	ioremap error for 0x3f799000-0x3f79a000, requested 0x2, got 0x0

On some platforms the UCSI ACPI mailbox SystemMemory
Operation Region may be setup before the driver has been
loaded. That will lead into the driver failing to map the
mailbox region, as it has been already marked as write-back
memory. acpi_os_ioremap() for x86 uses ioremap_cache()
unconditionally.

When the issue happens, the embedded controller has a
pending query event for the UCSI notification right after
boot-up which causes the operation region to be setup before
UCSI driver has been loaded.

The fix is to notify acpi core that the driver is about to
access memory region which potentially overlaps with an
operation region right before mapping it.
acpi_release_memory() will check if the memory has already
been setup (mapped) by acpi core, and deactivate it (unmap)
if it has. The driver is then able to map the memory with
ioremap_nocache() and set the memtype to uncached for the
region.

Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Fixes: 8243edf44152 ("usb: typec: ucsi: Add ACPI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/typec/ucsi/ucsi_acpi.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -82,6 +82,11 @@ static int ucsi_acpi_probe(struct platfo
 		return -ENODEV;
 	}
 
+	/* This will make sure we can use ioremap_nocache() */
+	status = acpi_release_memory(ACPI_HANDLE(&pdev->dev), res, 1);
+	if (ACPI_FAILURE(status))
+		return -ENOMEM;
+
 	/*
 	 * NOTE: The memory region for the data structures is used also in an
 	 * operation region, which means ACPI has already reserved it. Therefore


