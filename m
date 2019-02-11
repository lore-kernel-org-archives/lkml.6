Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E87C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC6F20700
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896952;
	bh=8Iki6BDd+uME8ppEftSLuKhGZtMXkag4HPqqlmFY+9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iM92YRyQ9cg4skUnS1Lx/NOkrrPEMvROGuZC7H+SeoaVZHxbKy58tFLzu88knxd4C
	 sNxzaFBeiNmEPjXWThq4ImYKuhT2VJg8HBaV1DbbJVmr298ftRXZXf5AYvwriSMy3y
	 eMDBzAa+kKkD4Zy/6renuNyLNyfBQUMvDU5RO0nE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389061AbfBKOzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:55:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:42874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389038AbfBKOzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:55:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D636520700;
        Mon, 11 Feb 2019 14:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896947;
        bh=8Iki6BDd+uME8ppEftSLuKhGZtMXkag4HPqqlmFY+9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wMGVk6M6xi6lu5gmU8Rk66HF6DtVenD+Vs2LFD9uMw9bFZvX8lcEG+HjQtg63f+Gi
         h7nOfLoYioZPiqxbEQ2SU4kgcqD6/s3zaAsqtIoSkSHyl4+0q6zGse85xdZdw1/vCh
         VFsZaS3+5zxHh14R3bEHBiE6D3+5MmDfl6jujkKY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Prarit Bhargava <prarit@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 040/205] ACPI: SPCR: Consider baud rate 0 as preconfigured state
Date:   Mon, 11 Feb 2019 15:17:18 +0100
Message-Id: <20190211141830.647894436@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index 324b35bfe781..f567fa5f0148 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -148,6 +148,13 @@ int __init parse_spcr(bool earlycon)
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
@@ -196,6 +203,10 @@ int __init parse_spcr(bool earlycon)
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



