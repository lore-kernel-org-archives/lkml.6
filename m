Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752089AbeBZCuR (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 21:50:17 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:39109 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751958AbeBZCuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 21:50:16 -0500
X-Google-Smtp-Source: AH8x227R0xnLwRvoVj/9JZr0OMA0HupFaV/dzrac07QYySIFXhMFcjGrqenJXhE2zooaz/qn2O/XXQ==
From: minyard@acm.org
To: Chris Chiu <chiu@endlessm.com>
Cc: linux-kernel@vger.kernel.org,
        Linux Upstreaming Team <linux@endlessm.com>,
        openipmi-developer@lists.sourceforge.net,
        Corey Minyard <cminyard@mvista.com>
Subject: [PATCH] ipmi:pci: Blacklist a Realtek "IPMI" device
Date: Sun, 25 Feb 2018 20:50:06 -0600
Message-Id: <1519613406-32237-1-git-send-email-minyard@acm.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <CAB4CAwebQRJcjP8W0vyHgr-k=rqXpLo-PCxBKB3Zu4GSonmaJw@mail.gmail.com>
References: <CAB4CAwebQRJcjP8W0vyHgr-k=rqXpLo-PCxBKB3Zu4GSonmaJw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corey Minyard <cminyard@mvista.com>

Realtek has some sort of "Virtual" IPMI device on the PCI bus as a
KCS controller, but whatever it is, it's not one.  Ignore it if seen.

Reported-by: Chris Chiu <chiu@endlessm.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
---

I haven't heard anything from you on this.  Here is a patch that should
blacklist that device, though I don't have a way to easily test it.
If you would prefer this, could you test it?

 drivers/char/ipmi/ipmi_si_pci.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/char/ipmi/ipmi_si_pci.c b/drivers/char/ipmi/ipmi_si_pci.c
index 27dd11c..d24990b 100644
--- a/drivers/char/ipmi/ipmi_si_pci.c
+++ b/drivers/char/ipmi/ipmi_si_pci.c
@@ -65,6 +65,15 @@ static int ipmi_pci_probe_regspacing(struct si_sm_io *io)
 	return DEFAULT_REGSPACING;
 }
 
+static struct pci_device_id ipmi_pci_blacklist[] = {
+	/*
+	 * This is a "Virtual IPMI device", whatever that is.  It appears
+	 * as a KCS device by the class, but it is not one.
+	 */
+	{ PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0x816c) },
+	{ 0, }
+};
+
 static int ipmi_pci_probe(struct pci_dev *pdev,
 				    const struct pci_device_id *ent)
 {
@@ -72,6 +81,9 @@ static int ipmi_pci_probe(struct pci_dev *pdev,
 	int class_type = pdev->class & PCI_ERMC_CLASSCODE_TYPE_MASK;
 	struct si_sm_io io;
 
+	if (pci_match_id(ipmi_pci_blacklist, pdev))
+		return -ENODEV;
+
 	memset(&io, 0, sizeof(io));
 	io.addr_source = SI_PCI;
 	dev_info(&pdev->dev, "probing via PCI");
-- 
2.7.4
