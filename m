Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CF2C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E59432133F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5XY0H2S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E59432133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731540AbeK3B0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:26:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:50704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728678AbeK3B0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:26:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 768CF205C9;
        Thu, 29 Nov 2018 14:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501264;
        bh=6EDwcV46ipJJ8g6A9BMpEP8xolB5EmFhPyAAVsQKDIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U5XY0H2Scpq/8wLpgHzAAxZ81340YIdlfqBC3qcSDPlrU/+k2nXBlerydoBxBhQHQ
         8lP29FiwO97Lg+JlwekTKJ0POzNinm5LhwUOBvgkxFMFBwI4W2uoofdGgqVs5XyVQI
         97/qPZywmSNUWdDr2nEWqVuJoJRmbIH8T0kuP0NA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.9 02/92] usb: dwc3: core: Clean up ULPI device
Date:   Thu, 29 Nov 2018 15:11:31 +0100
Message-Id: <20181129140106.689987193@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140106.520639693@linuxfoundation.org>
References: <20181129140106.520639693@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

commit 08fd9a82fda86529bb2f2af3c2f7cb657b4d3066 upstream.

If dwc3_core_init_mode() fails with deferred probe,
next probe fails on sysfs with

sysfs: cannot create duplicate filename '/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/dwc3.0.auto.ulpi'

To avoid this failure, clean up ULPI device.

Cc: <stable@vger.kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc3/core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1145,6 +1145,7 @@ static int dwc3_probe(struct platform_de
 
 err5:
 	dwc3_event_buffers_cleanup(dwc);
+	dwc3_ulpi_exit(dwc);
 
 err4:
 	dwc3_free_scratch_buffers(dwc);


