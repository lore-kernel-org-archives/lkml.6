Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225B6C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 19:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB3F21735
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 19:32:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEB3F21735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbeHTWsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 18:48:52 -0400
Received: from g9t5008.houston.hpe.com ([15.241.48.72]:59682 "EHLO
        g9t5008.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbeHTWsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 18:48:52 -0400
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id 562FB57;
        Mon, 20 Aug 2018 19:31:59 +0000 (UTC)
Received: from anatevka.ftc.rdlabs.hpecorp.net (anatevka.americas.hpqcorp.net [10.34.81.6])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 6AC114A;
        Mon, 20 Aug 2018 19:31:58 +0000 (UTC)
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        rwright@hpe.com, Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH] watchdog: hpwdt: Update Driver Documentation.
Date:   Mon, 20 Aug 2018 13:31:23 -0600
Message-Id: <20180820193123.23976-1-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove references to deprecated features like NMI sourcing
and obsoleted module parameters.

Add details concerning new module parameter pretimeout and tips
to programming it.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 Documentation/watchdog/hpwdt.txt | 93 ++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 62 deletions(-)

diff --git a/Documentation/watchdog/hpwdt.txt b/Documentation/watchdog/hpwdt.txt
index 6d866c537127..55df692c5595 100644
--- a/Documentation/watchdog/hpwdt.txt
+++ b/Documentation/watchdog/hpwdt.txt
@@ -1,15 +1,12 @@
-Last reviewed: 05/20/2016
+Last reviewed: 08/20/2018
 
                      HPE iLO NMI Watchdog Driver
-              NMI sourcing for iLO based ProLiant Servers
-                     Documentation and Driver by
-                         Thomas Mingarelli
+                   for iLO based ProLiant Servers
 
  The HPE iLO NMI Watchdog driver is a kernel module that provides basic
- watchdog functionality and the added benefit of NMI sourcing. Both the
- watchdog functionality and the NMI sourcing capability need to be enabled
- by the user. Remember that the two modes are not dependent on one another.
- A user can have the NMI sourcing without the watchdog timer and vice-versa.
+ watchdog functionality and handler for the iLO "Generate NMI to System"
+ virtual button.
+
  All references to iLO in this document imply it also works on iLO2 and all
  subsequent generations.
 
@@ -21,12 +18,16 @@ Last reviewed: 05/20/2016
  not be updated in a timely fashion and a hardware system reset (also known as
  an Automatic Server Recovery (ASR)) event will occur.
 
- The hpwdt driver also has three (3) module parameters. They are the following:
+ The hpwdt driver also has the following module parameters:
 
  soft_margin - allows the user to set the watchdog timer value.
                Default value is 30 seconds.
- allow_kdump - allows the user to save off a kernel dump image after an NMI.
-               Default value is 1/ON
+ timeout     - an alias of soft_margin.
+ pretimeout  - allows the user to set the watchdog pretimeout value.
+               This is the number of seconds before timeout when an
+               NMI is delivered to the system. Setting the value to
+               zero disables the pretimeout NMI.
+               Default value is 9 seconds.
  nowayout    - basic watchdog parameter that does not allow the timer to
                be restarted or an impending ASR to be escaped.
                Default value is set when compiling the kernel. If it is set
@@ -37,61 +38,29 @@ Last reviewed: 05/20/2016
        interface to /dev/watchdog can be found in
        Documentation/watchdog/watchdog-api.txt and Documentation/IPMI.txt.
 
- The NMI sourcing capability is disabled by default due to the inability to
- distinguish between "NMI Watchdog Ticks" and "HW generated NMI events" in the
- Linux kernel. What this means is that the hpwdt nmi handler code is called
- each time the NMI signal fires off. This could amount to several thousands of
- NMIs in a matter of seconds. If a user sees the Linux kernel's "dazed and
- confused" message in the logs or if the system gets into a hung state, then
- the hpwdt driver can be reloaded.
-
- 1. If the kernel has not been booted with nmi_watchdog turned off then
-    edit and place the nmi_watchdog=0 at the end of the currently booting
-    kernel line. Depending on your Linux distribution and platform setup:
-    For non-UEFI systems
-       /boot/grub/grub.conf   or
-       /boot/grub/menu.lst
-    For UEFI systems
-      /boot/efi/EFI/distroname/grub.conf   or
-      /boot/efi/efi/distroname/elilo.conf
- 2. reboot the sever
- 3. Once the system comes up perform a modprobe -r hpwdt
- 4. modprobe /lib/modules/`uname -r`/kernel/drivers/watchdog/hpwdt.ko
-
- Now, the hpwdt can successfully receive and source the NMI and provide a log
- message that details the reason for the NMI (as determined by the HPE BIOS).
-
- Below is a list of NMIs the HPE BIOS understands along with the associated
- code (reason):
-
-	No source found                00h
-
-	Uncorrectable Memory Error     01h
-
-	ASR NMI                        1Bh
-
-	PCI Parity Error               20h
-
-	NMI Button Press               27h
-
-	SB_BUS_NMI                     28h
-
-	ILO Doorbell NMI               29h
-
-	ILO IOP NMI                    2Ah
-
-	ILO Watchdog NMI               2Bh
-
-	Proc Throt NMI                 2Ch
+ Due to limitations in the iLO hardware, the NMI pretimeout if enabled,
+ can only be set to 9 seconds.  Attempts to set pretimeout to other
+ non-zero values will be rounded, possibly to zero.  Users should verify
+ the pretimeout value after attempting to set pretimeout or timeout.
 
-	Front Side Bus NMI             2Dh
+ Upon receipt of an NMI from the iLO, the hpwdt driver will initiate a
+ panic. This is to allow for a crash dump to be collected.  It is incumbent
+ upon the user to have properly configured the system for kdump.
 
-	PCI Express Error              2Fh
+ The default Linux kernel behavior upon panic is to print a kernel tombstone
+ and loop forever.  This is generally not what a watchdog user wants.
 
-	DMA controller NMI             30h
+ For those wishing to learn more please see:
+	Documentation/kdump/kdump.txt
+	Documentation/admin-guide/kernel-parameters.txt (panic=)
+	Your Linux Distribution specific documentation.
 
-	Hypertransport/CSI Error       31h
+ If the hpwdt does not receive the NMI associated with an expiring timer,
+ the iLO will proceed to reset the system at timeout if the timer hasn't
+ been updated.
 
+--
 
+ The HPE iLO NMI Watchdog Driver and documentation were originally developed
+ by Tom Mingarelli.
 
- -- Tom Mingarelli
-- 
2.13.6

