Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C50C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE55D213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzBfItSe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE55D213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388503AbeK3BfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:35:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:36880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732084AbeK3BfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:35:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91F2F213A2;
        Thu, 29 Nov 2018 14:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501777;
        bh=q3XLv2w1ES3hVzre+rFcuRaF6yMk4yT3Mk/rb3Sly10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IzBfItSeNH5Fy1SzfwJKUZEwD7hKnPUDXGCXRPxxU/AvXcwwfJPQmWwTq+/PvIpWc
         ZilOxkFYbiVtRkFDVlYxWFbjeil1uEoK4jaTrUs9DiwOxkfBiykcMocpXNMB4kIZ32
         tsF46Bi0vSezwL2Y2nXjRUe5/jidBXTt2YjPiI1k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rajat Jain <rajatja@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.19 019/110] mmc: sdhci-pci: Try "cd" for card-detect lookup before using NULL
Date:   Thu, 29 Nov 2018 15:11:50 +0100
Message-Id: <20181129135922.029116103@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129135921.231283053@linuxfoundation.org>
References: <20181129135921.231283053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rajat Jain <rajatja@google.com>

commit cdcefe6bd9df754f528ffc339d3cc143cea4ddf6 upstream.

Problem:

The card detect IRQ does not work with modern BIOS (that want
to use _DSD to provide the card detect GPIO to the driver).

Details:

The mmc core provides the mmc_gpiod_request_cd() API to let host drivers
request the gpio descriptor for the "card detect" pin.
This pin is specified in the ACPI for the SDHC device:

 * Either as a resource using _CRS. This is a method used by legacy BIOS.
   (The driver needs to tell which resource index).

 * Or as a named property ("cd-gpios"/"cd-gpio") in _DSD (which internally
   points to an entry in _CRS). This way, the driver can lookup using a
   string. This is what modern BIOS prefer to use.

This API finally results in a call to the following code:

struct gpio_desc *acpi_find_gpio(..., const char *con_id,...)
{
...
   /* Lookup gpio (using "<con_id>-gpio") in the _DSD */
...
   if (!acpi_can_fallback_to_crs(adev, con_id))
          return ERR_PTR(-ENOENT);
...
   /* Falling back to _CRS is allowed, Lookup gpio in the _CRS */
...
}

Note that this means that if the ACPI has _DSD properties, the kernel
will never use _CRS for the lookup (Because acpi_can_fallback_to_crs()
will always be false for any device hat has _DSD entries).

The SDHCI driver is thus currently broken on a modern BIOS, even if
BIOS provides both _CRS (for index based lookup) and _DSD entries (for
string based lookup). Ironically, none of these will be used for the
lookup currently because:

* Since the con_id is NULL, acpi_find_gpio() does not find a matching
  entry in DSDT. (The _DSDT entry has the property name = "cd-gpios")

* Because ACPI contains DSDT entries, thus acpi_can_fallback_to_crs()
  returns false (because device properties have been populated from
  _DSD), thus the _CRS is never used for the lookup.

Fix:

Try "cd" for lookup in the _DSD before falling back to using NULL so
as to try looking up in the _CRS.

I've tested this patch successfully with both Legacy BIOS (that
provide only _CRS method) as well as modern BIOS (that provide both
_CRS and _DSD). Also the use of "cd" appears to be fairly consistent
across other users of this API (other MMC host controller drivers).

Link: https://lkml.org/lkml/2018/9/25/1113
Signed-off-by: Rajat Jain <rajatja@google.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Fixes: f10e4bf6632b ("gpio: acpi: Even more tighten up ACPI GPIO lookups")
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/sdhci-pci-core.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1762,8 +1762,13 @@ static struct sdhci_pci_slot *sdhci_pci_
 		device_init_wakeup(&pdev->dev, true);
 
 	if (slot->cd_idx >= 0) {
-		ret = mmc_gpiod_request_cd(host->mmc, NULL, slot->cd_idx,
+		ret = mmc_gpiod_request_cd(host->mmc, "cd", slot->cd_idx,
 					   slot->cd_override_level, 0, NULL);
+		if (ret && ret != -EPROBE_DEFER)
+			ret = mmc_gpiod_request_cd(host->mmc, NULL,
+						   slot->cd_idx,
+						   slot->cd_override_level,
+						   0, NULL);
 		if (ret == -EPROBE_DEFER)
 			goto remove;
 


