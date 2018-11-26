Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08915C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB0BB2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zQ9Xiz2E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB0BB2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbeKZV4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:56:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:39188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729135AbeKZV4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:56:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C63F21479;
        Mon, 26 Nov 2018 11:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230147;
        bh=pLabZEc3qzUP5IReUum+GbQN3DgS09nLClXiwJF0erA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zQ9Xiz2EI287KT2Gw1g+P2M9bGGqhaOAkO1CdFbPLpSO1f8Vhf+ygW7Adt5k5BOaI
         f5qgHpMpmz/EYbgGUA5mNQ2lPiJ4GLuVjrImTi08e7oIErq+KKdimmy+vwGXWzmLsb
         3ra979D4TirYyrwCBidVr9SlLA5lGFLakfeg1Xok=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Feng Tang <feng.tang@intel.com>, Borislav Petkov <bp@suse.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Stuart R . Anderson" <stuart.r.anderson@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Rientjes <rientjes@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
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
Subject: [PATCH 4.19 025/118] x86/earlyprintk: Add a force option for pciserial device
Date:   Mon, 26 Nov 2018 11:50:19 +0100
Message-Id: <20181126105100.829963680@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
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
index 92eb1f42240d..34e6800dea0e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1063,7 +1063,7 @@
 			earlyprintk=serial[,0x...[,baudrate]]
 			earlyprintk=ttySn[,baudrate]
 			earlyprintk=dbgp[debugController#]
-			earlyprintk=pciserial,bus:device.function[,baudrate]
+			earlyprintk=pciserial[,force],bus:device.function[,baudrate]
 			earlyprintk=xdbc[xhciController#]
 
 			earlyprintk is useful when the kernel crashes before
@@ -1095,6 +1095,10 @@
 
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



