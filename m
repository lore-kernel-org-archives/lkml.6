Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45497C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 071842150B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:39:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 071842150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388943AbeHNU1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:27:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58528 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729689AbeHNU1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:27:52 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B9525CBA;
        Tue, 14 Aug 2018 17:39:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.9 008/107] ACPI / LPSS: Add missing prv_offset setting for byt/cht PWM devices
Date:   Tue, 14 Aug 2018 19:16:31 +0200
Message-Id: <20180814171521.323807077@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171520.883143803@linuxfoundation.org>
References: <20180814171520.883143803@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit fdcb613d49321b5bf5d5a1bd0fba8e7c241dcc70 upstream.

The LPSS PWM device on on Bay Trail and Cherry Trail devices has a set
of private registers at offset 0x800, the current lpss_device_desc for
them already sets the LPSS_SAVE_CTX flag to have these saved/restored
over device-suspend, but the current lpss_device_desc was not setting
the prv_offset field, leading to the regular device registers getting
saved/restored instead.

This is causing the PWM controller to no longer work, resulting in a black
screen,  after a suspend/resume on systems where the firmware clears the
APB clock and reset bits at offset 0x804.

This commit fixes this by properly setting prv_offset to 0x800 for
the PWM devices.

Cc: stable@vger.kernel.org
Fixes: e1c748179754 ("ACPI / LPSS: Add Intel BayTrail ACPI mode PWM")
Fixes: 1bfbd8eb8a7f ("ACPI / LPSS: Add ACPI IDs for Intel Braswell")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Rafael J . Wysocki <rjw@rjwysocki.net>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/acpi_lpss.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -187,10 +187,12 @@ static const struct lpss_device_desc lpt
 
 static const struct lpss_device_desc byt_pwm_dev_desc = {
 	.flags = LPSS_SAVE_CTX,
+	.prv_offset = 0x800,
 };
 
 static const struct lpss_device_desc bsw_pwm_dev_desc = {
 	.flags = LPSS_SAVE_CTX | LPSS_NO_D3_DELAY,
+	.prv_offset = 0x800,
 };
 
 static const struct lpss_device_desc byt_uart_dev_desc = {


