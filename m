Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EA2C282C6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CDE6218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548360124;
	bh=3SbchAvHrzX/fvVOm0fzQm3vR4nZiz/i0uWAyJQtBvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uM+yKPVWFKrdU2aV7RSHbSLqMIkb+NqxVLLXFUwUEucobunVExtxrfXO31Wn14CkL
	 p08GoSdbGxpIkBxJLCAOeyXiFLU9XtFQQEwvXI7vPMY8Y/KvlfTT/o5K67wvKmofsp
	 GcYDXr2WHJ06mHF41FykOqUd+MhA0ZnAgTQgnli0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732007AbfAXTdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:33:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:33136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731282AbfAXTdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:33:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63CAF218D4;
        Thu, 24 Jan 2019 19:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358399;
        bh=3SbchAvHrzX/fvVOm0fzQm3vR4nZiz/i0uWAyJQtBvI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PCmMgzFE/dqdVtCO/AcNR6PYkT6ji4o9U4g8B0kxRTEqz1KAKQAGv1EEZF/DSOfzO
         BUAm3Mo83entbWD/VlliIKDvU2BtUdHKvZXrXnJMWOrqLzpj7XLAVKX9CMhfO380RA
         q9ReGPxN3nTjjpileo3lN7rWDOKyKsAoGAIqfCxg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Chiu <chiu@endlessm.com>,
        Corey Minyard <cminyard@mvista.com>,
        Daniel Drake <drake@endlessm.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH 4.14 59/63] ipmi:pci: Blacklist a Realtek "IPMI" device
Date:   Thu, 24 Jan 2019 20:20:48 +0100
Message-Id: <20190124190202.219261697@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190155.176570028@linuxfoundation.org>
References: <20190124190155.176570028@linuxfoundation.org>
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

From: Corey Minyard <cminyard@mvista.com>

commit bc48fa1b9d3b04106055b27078da824cd209865a upstream.

Realtek has some sort of "Virtual" IPMI device on the PCI bus as a
KCS controller, but whatever it is, it's not one.  Ignore it if seen.

[ Commit 13d0b35c (ipmi_si: Move PCI setup to another file) from Linux
  4.15-rc1 has not been back ported, so the PCI code is still in
  `drivers/char/ipmi/ipmi_si_intf.c`, requiring to apply the commit
  manually.

  This fixes a 100 s boot delay on the HP EliteDesk 705 G4 MT with Linux
  4.14.94. ]

Reported-by: Chris Chiu <chiu@endlessm.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
Tested-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/ipmi/ipmi_si_intf.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -2447,6 +2447,15 @@ static int ipmi_pci_probe_regspacing(str
 	return DEFAULT_REGSPACING;
 }
 
+static struct pci_device_id ipmi_pci_blacklist[] = {
+	/*
+	 * This is a "Virtual IPMI device", whatever that is.  It appears
+	 * as a KCS device by the class, but it is not one.
+	 */
+	{ PCI_VDEVICE(REALTEK, 0x816c) },
+	{ 0, }
+};
+
 static int ipmi_pci_probe(struct pci_dev *pdev,
 				    const struct pci_device_id *ent)
 {
@@ -2454,6 +2463,9 @@ static int ipmi_pci_probe(struct pci_dev
 	int class_type = pdev->class & PCI_ERMC_CLASSCODE_TYPE_MASK;
 	struct smi_info *info;
 
+	if (pci_match_id(ipmi_pci_blacklist, pdev))
+		return -ENODEV;
+
 	info = smi_info_alloc();
 	if (!info)
 		return -ENOMEM;


