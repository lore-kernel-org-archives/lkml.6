Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180E4C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF6F5214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895082;
	bh=w5WSb/uEfpoz2iAjZ2JSfX3Bn7DGypH0y3LbchJEjzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lE8aW6ADOj7obHiQ12A5G+LkVfFX96pouvb5mqh9XVtMmxXk0jUc6/0gAi70iqMQL
	 9f+z0PRwr68Eoe2a6STxgGKQE1bqeFF9egynQksVoXTbY1fwBwufwjTGv1p9vfdoyU
	 4oPPiyaejCvqSfDZ49jAFGPUgo6ijWPk2DdNpzbc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbfBKOYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:24:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:57908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729242AbfBKOYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:24:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E70642075C;
        Mon, 11 Feb 2019 14:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895078;
        bh=w5WSb/uEfpoz2iAjZ2JSfX3Bn7DGypH0y3LbchJEjzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wyP3QgtFBNYwhf+3oqn8OWBSnF9czKrgB3Qna6mozrwatCmhG5KDUoc+OJbDk6lxT
         9NzkkEKx/zpSp4iBP5me+9/G/GMYruXDNCLO+KGTH0Hoaeo/D5310Dq1HPInK8qATb
         k+XG/gZAgVqdPqKLbKqmnEYUJJPmzSqUJfJFJ41Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Prarit Bhargava <prarit@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 077/352] ACPI: SPCR: Consider baud rate 0 as preconfigured state
Date:   Mon, 11 Feb 2019 15:15:04 +0100
Message-Id: <20190211141850.947607772@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit b413b1abeb21b4a152c0bf8d1379efa30759b6e3 ]

Since SPCR 1.04 [1] the baud rate of 0 means a preconfigured state of UART.
Assume firmware or bootloader configures console correctly.

[1]: https://docs.microsoft.com/en-us/windows-hardware/drivers/serports/serial-port-console-redirection-table

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Prarit Bhargava <prarit@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/spcr.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index 9d52743080a4..c336784d0bcb 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -148,6 +148,13 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
 	}
 
 	switch (table->baud_rate) {
+	case 0:
+		/*
+		 * SPCR 1.04 defines 0 as a preconfigured state of UART.
+		 * Assume firmware or bootloader configures console correctly.
+		 */
+		baud_rate = 0;
+		break;
 	case 3:
 		baud_rate = 9600;
 		break;
@@ -196,6 +203,10 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
 		 * UART so don't attempt to change to the baud rate state
 		 * in the table because driver cannot calculate the dividers
 		 */
+		baud_rate = 0;
+	}
+
+	if (!baud_rate) {
 		snprintf(opts, sizeof(opts), "%s,%s,0x%llx", uart, iotype,
 			 table->serial_port.address);
 	} else {
-- 
2.19.1



