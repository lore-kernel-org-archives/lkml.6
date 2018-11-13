Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BA2C0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D61822520
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6Z8+qUk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D61822520
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732774AbeKMPso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:48:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:35344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732688AbeKMPsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:48:43 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20BF22251A;
        Tue, 13 Nov 2018 05:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542088335;
        bh=J9sP7obsTBXryISSF0+V0jPsXv4RJJIuTmsxrK9hz4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n6Z8+qUkoZ4hZgDFEw5SV0DqpiD7xGNMKt4fhDK3rN+rke1qEx8j5jGFtQa3DNm7I
         62/JLZjO7fFtdeSfVXfX5dVGgijOEsRwShn0J1IX+lxGBcdf2jO4d4kTSAIzgOVRBF
         QbXZsObKDjJh8W46AIfj/RWQKzZt5Sh8F+xAZSIw=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Feng Tang <feng.tang@intel.com>, Borislav Petkov <bp@suse.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Stuart R . Anderson" <stuart.r.anderson@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Rientjes <rientjes@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        H Peter Anvin <hpa@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, Jiri Kosina <jkosina@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thymo van Beers <thymovanbeers@gmail.com>,
        alan@linux.intel.com, linux-doc@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 20/26] x86/earlyprintk: Add a force option for pciserial device
Date:   Tue, 13 Nov 2018 00:51:44 -0500
Message-Id: <20181113055150.78773-20-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113055150.78773-1-sashal@kernel.org>
References: <20181113055150.78773-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Feng Tang <feng.tang@intel.com>

[ Upstream commit d2266bbfa9e3e32e3b642965088ca461bd24a94f ]

The "pciserial" earlyprintk variant helps much on many modern x86
platforms, but unfortunately there are still some platforms with PCI
UART devices which have the wrong PCI class code. In that case, the
current class code check does not allow for them to be used for logging.

Add a sub-option "force" which overrides the class code check and thus
the use of such device can be enforced.

 [ bp: massage formulations. ]

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Feng Tang <feng.tang@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Stuart R . Anderson" <stuart.r.anderson@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Feng Tang <feng.tang@intel.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: H Peter Anvin <hpa@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thymo van Beers <thymovanbeers@gmail.com>
Cc: alan@linux.intel.com
Cc: linux-doc@vger.kernel.org
Link: http://lkml.kernel.org/r/20181002164921.25833-1-feng.tang@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |  6 +++-
 arch/x86/kernel/early_printk.c                | 29 ++++++++++++-------
 2 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9841bad6f271..99a08722124d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1011,7 +1011,7 @@
 			earlyprintk=serial[,0x...[,baudrate]]
 			earlyprintk=ttySn[,baudrate]
 			earlyprintk=dbgp[debugController#]
-			earlyprintk=pciserial,bus:device.function[,baudrate]
+			earlyprintk=pciserial[,force],bus:device.function[,baudrate]
 			earlyprintk=xdbc[xhciController#]
 
 			earlyprintk is useful when the kernel crashes before
@@ -1043,6 +1043,10 @@
 
 			The sclp output can only be used on s390.
 
+			The optional "force" to "pciserial" enables use of a
+			PCI device even when its classcode is not of the
+			UART class.
+
 	edac_report=	[HW,EDAC] Control how to report EDAC event
 			Format: {"on" | "off" | "force"}
 			on: enable EDAC to report H/W event. May be overridden
diff --git a/arch/x86/kernel/early_printk.c b/arch/x86/kernel/early_printk.c
index 5e801c8c8ce7..374a52fa5296 100644
--- a/arch/x86/kernel/early_printk.c
+++ b/arch/x86/kernel/early_printk.c
@@ -213,8 +213,9 @@ static unsigned int mem32_serial_in(unsigned long addr, int offset)
  * early_pci_serial_init()
  *
  * This function is invoked when the early_printk param starts with "pciserial"
- * The rest of the param should be ",B:D.F,baud" where B, D & F describe the
- * location of a PCI device that must be a UART device.
+ * The rest of the param should be "[force],B:D.F,baud", where B, D & F describe
+ * the location of a PCI device that must be a UART device. "force" is optional
+ * and overrides the use of an UART device with a wrong PCI class code.
  */
 static __init void early_pci_serial_init(char *s)
 {
@@ -224,17 +225,23 @@ static __init void early_pci_serial_init(char *s)
 	u32 classcode, bar0;
 	u16 cmdreg;
 	char *e;
+	int force = 0;
 
-
-	/*
-	 * First, part the param to get the BDF values
-	 */
 	if (*s == ',')
 		++s;
 
 	if (*s == 0)
 		return;
 
+	/* Force the use of an UART device with wrong class code */
+	if (!strncmp(s, "force,", 6)) {
+		force = 1;
+		s += 6;
+	}
+
+	/*
+	 * Part the param to get the BDF values
+	 */
 	bus = (u8)simple_strtoul(s, &e, 16);
 	s = e;
 	if (*s != ':')
@@ -253,7 +260,7 @@ static __init void early_pci_serial_init(char *s)
 		s++;
 
 	/*
-	 * Second, find the device from the BDF
+	 * Find the device from the BDF
 	 */
 	cmdreg = read_pci_config(bus, slot, func, PCI_COMMAND);
 	classcode = read_pci_config(bus, slot, func, PCI_CLASS_REVISION);
@@ -264,8 +271,10 @@ static __init void early_pci_serial_init(char *s)
 	 */
 	if (((classcode >> 16 != PCI_CLASS_COMMUNICATION_MODEM) &&
 	     (classcode >> 16 != PCI_CLASS_COMMUNICATION_SERIAL)) ||
-	   (((classcode >> 8) & 0xff) != 0x02)) /* 16550 I/F at BAR0 */
-		return;
+	   (((classcode >> 8) & 0xff) != 0x02)) /* 16550 I/F at BAR0 */ {
+		if (!force)
+			return;
+	}
 
 	/*
 	 * Determine if it is IO or memory mapped
@@ -289,7 +298,7 @@ static __init void early_pci_serial_init(char *s)
 	}
 
 	/*
-	 * Lastly, initialize the hardware
+	 * Initialize the hardware
 	 */
 	if (*s) {
 		if (strcmp(s, "nocfg") == 0)
-- 
2.17.1

