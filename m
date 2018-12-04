Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DA1C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 868B520851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9FMSr94"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 868B520851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbeLDK7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:59:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:44924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbeLDK7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:59:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA9032087F;
        Tue,  4 Dec 2018 10:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921192;
        bh=M8ml5plknAYioYz8msCT+UHTjsHKjb63T+K/NfJ9mwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i9FMSr94MsWjevQ0GJR7gmy+wtqPtfPvS9Wc9oGy8CISl2ZEj6ItcwqnmZCo/3pIG
         qNptSbzbdPt0GqFvXX3v3C/lFKxLZayXwhP/dIb8wuZmqQbaN195yaYdw8ZbfXeBtG
         AGwZWJoYszSX3akby34XlhlwWgFJWVFujmSMmQQI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.19 081/139] PCI: Fix incorrect value returned from pcie_get_speed_cap()
Date:   Tue,  4 Dec 2018 11:49:22 +0100
Message-Id: <20181204103653.510773818@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit f1f90e254e46e0a14220e4090041f68256fbe297 upstream.

The macros PCI_EXP_LNKCAP_SLS_*GB are values, not bit masks.  We must mask
the register and compare it against them.

This fixes errors like this:

  amdgpu: [powerplay] failed to send message 261 ret is 0

when a PCIe-v3 card is plugged into a PCIe-v1 slot, because the slot is
being incorrectly reported as PCIe-v3 capable.

6cf57be0f78e, which appeared in v4.17, added pcie_get_speed_cap() with the
incorrect test of PCI_EXP_LNKCAP_SLS as a bitmask.  5d9a63304032, which
appeared in v4.19, changed amdgpu to use pcie_get_speed_cap(), so the
amdgpu bug reports below are regressions in v4.19.

Fixes: 6cf57be0f78e ("PCI: Add pcie_get_speed_cap() to find max supported link speed")
Fixes: 5d9a63304032 ("drm/amdgpu: use pcie functions for link width and speed")
Link: https://bugs.freedesktop.org/show_bug.cgi?id=108704
Link: https://bugs.freedesktop.org/show_bug.cgi?id=108778
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
[bhelgaas: update comment, remove use of PCI_EXP_LNKCAP_SLS_8_0GB and
PCI_EXP_LNKCAP_SLS_16_0GB since those should be covered by PCI_EXP_LNKCAP2,
remove test of PCI_EXP_LNKCAP for zero, since that register is required]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org	# v4.17+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/pci.c |   24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5473,9 +5473,13 @@ enum pci_bus_speed pcie_get_speed_cap(st
 	u32 lnkcap2, lnkcap;
 
 	/*
-	 * PCIe r4.0 sec 7.5.3.18 recommends using the Supported Link
-	 * Speeds Vector in Link Capabilities 2 when supported, falling
-	 * back to Max Link Speed in Link Capabilities otherwise.
+	 * Link Capabilities 2 was added in PCIe r3.0, sec 7.8.18.  The
+	 * implementation note there recommends using the Supported Link
+	 * Speeds Vector in Link Capabilities 2 when supported.
+	 *
+	 * Without Link Capabilities 2, i.e., prior to PCIe r3.0, software
+	 * should use the Supported Link Speeds field in Link Capabilities,
+	 * where only 2.5 GT/s and 5.0 GT/s speeds were defined.
 	 */
 	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP2, &lnkcap2);
 	if (lnkcap2) { /* PCIe r3.0-compliant */
@@ -5491,16 +5495,10 @@ enum pci_bus_speed pcie_get_speed_cap(st
 	}
 
 	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
-	if (lnkcap) {
-		if (lnkcap & PCI_EXP_LNKCAP_SLS_16_0GB)
-			return PCIE_SPEED_16_0GT;
-		else if (lnkcap & PCI_EXP_LNKCAP_SLS_8_0GB)
-			return PCIE_SPEED_8_0GT;
-		else if (lnkcap & PCI_EXP_LNKCAP_SLS_5_0GB)
-			return PCIE_SPEED_5_0GT;
-		else if (lnkcap & PCI_EXP_LNKCAP_SLS_2_5GB)
-			return PCIE_SPEED_2_5GT;
-	}
+	if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_5_0GB)
+		return PCIE_SPEED_5_0GT;
+	else if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_2_5GB)
+		return PCIE_SPEED_2_5GT;
 
 	return PCI_SPEED_UNKNOWN;
 }


