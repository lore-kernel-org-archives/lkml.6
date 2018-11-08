Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18B7ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5968A20840
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPZPe61D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5968A20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732826AbeKIHrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:47:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:40808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728473AbeKIHrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:47:00 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78C3721019;
        Thu,  8 Nov 2018 22:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714968;
        bh=IxY2jZuxZipU8cED7qMqxRmbzNRSxd7xf9QvwD6eSqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UPZPe61DczrLEIQVY8GLlUnQGcuEwWC3Om8TeopL9kUq1KhGkOPljEnbRi97BkVNT
         n/roDCJyqG3BC8c6tJP4GPDNdRHZ00FvmPCpbWjy+jk1uad56tlkznQCRYMtTJt6Je
         GvRagvtOdTHYLJAT3NJByvMZ5m5pjtEe+iTmmKfQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tobias Herzog <t-herzog@gmx.de>,
        Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 4.18 15/34] cdc-acm: do not reset notification buffer index upon urb unlinking
Date:   Thu,  8 Nov 2018 13:52:44 -0800
Message-Id: <20181108215139.854853344@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215138.892971755@linuxfoundation.org>
References: <20181108215138.892971755@linuxfoundation.org>
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

From: Tobias Herzog <t-herzog@gmx.de>

commit dae3ddba36f8c337fb59cef07d564da6fc9b7551 upstream.

Resetting the write index of the notification buffer on urb unlink (e.g.
closing a cdc-acm device from userspace) may lead to wrong interpretation
of further received notifications, in case the index is not 0 when urb
unlink happens (i.e. when parts of a notification already have been
transferred). On the device side there is no "reset" of the notification
transimission and thus we would get out of sync with the device.

Signed-off-by: Tobias Herzog <t-herzog@gmx.de>
Acked-by: Oliver Neukum <oneukum@suse.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/class/cdc-acm.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -354,7 +354,6 @@ static void acm_ctrl_irq(struct urb *urb
 	case -ENOENT:
 	case -ESHUTDOWN:
 		/* this urb is terminated, clean up */
-		acm->nb_index = 0;
 		dev_dbg(&acm->control->dev,
 			"%s - urb shutting down with status: %d\n",
 			__func__, status);


