Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E70C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 03:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41CAD2064D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 03:00:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41CAD2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=innovation.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbeJAJgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 05:36:03 -0400
Received: from chill.innovation.ch ([216.218.245.220]:60692 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbeJAJgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 05:36:03 -0400
X-Greylist: delayed 460 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Oct 2018 05:36:03 EDT
Date:   Sun, 30 Sep 2018 19:52:51 -0700
From:   Ronald =?iso-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI/sbs: Fix GPE storm on recent MacBookPro's.
Message-ID: <20181001025251.GA9069@innovation.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Apple machines, plugging-in or unplugging the power triggers a GPE
for the EC. Since these machines expose an SBS device, this GPE ends
up triggering the acpi_sbs_callback(). This in turn tries to get the
status of the SBS charger. However, on MBP13,* and MBP14,* machines,
performing the smbus-read operation to get the charger's status triggers
the EC's GPE again. The result is an endless re-triggering and handling
of that GPE, consuming significant CPU resources (> 50% in irq).

In the end this is quite similar to commit 3031cddea633 (ACPI / SBS:
Don't assume the existence of an SBS charger), except that on the above
machines a status of all 1's is returned. And like there, we just want
ignore the charger here.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=198169
CC: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
---
 drivers/acpi/sbs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index 295b59271189..96c5e27967f4 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -441,9 +441,13 @@ static int acpi_ac_get_present(struct acpi_sbs *sbs)
 
 	/*
 	 * The spec requires that bit 4 always be 1. If it's not set, assume
-	 * that the implementation doesn't support an SBS charger
+	 * that the implementation doesn't support an SBS charger.
+	 *
+	 * And on some MacBooks a status of 0xffff is always returned, no
+	 * matter whether the charger is plugged in or not, which is also
+	 * wrong, so ignore the SBS charger for those too.
 	 */
-	if (!((status >> 4) & 0x1))
+	if (!((status >> 4) & 0x1) || status == 0xffff)
 		return -ENODEV;
 
 	sbs->charger_present = (status >> 15) & 0x1;
-- 
2.17.1

