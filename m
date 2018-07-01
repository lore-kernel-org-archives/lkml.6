Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC9BC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FDBA257E4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:57:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FDBA257E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753797AbeGAR5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:57:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34902 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030244AbeGAQbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:31:02 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A8D89AEF;
        Sun,  1 Jul 2018 16:31:01 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vaibhav Jain <vaibhav@linux.ibm.com>,
        Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 044/157] cxl: Disable prefault_mode in Radix mode
Date:   Sun,  1 Jul 2018 18:21:56 +0200
Message-Id: <20180701160854.882526102@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160852.287307684@linuxfoundation.org>
References: <20180701160852.287307684@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vaibhav Jain <vaibhav@linux.ibm.com>

commit b6c84ba22ff3a198eb8d5552cf9b8fda1d792e54 upstream.

Currently we see a kernel-oops reported on Power-9 while attaching a
context to an AFU, with radix-mode and sysfs attr 'prefault_mode' set
to anything other than 'none'. The backtrace of the oops is of this
form:

  Unable to handle kernel paging request for data at address 0x00000080
  Faulting instruction address: 0xc00800000bcf3b20
  cpu 0x1: Vector: 300 (Data Access) at [c00000037f003800]
      pc: c00800000bcf3b20: cxl_load_segment+0x178/0x290 [cxl]
      lr: c00800000bcf39f0: cxl_load_segment+0x48/0x290 [cxl]
      sp: c00000037f003a80
     msr: 9000000000009033
     dar: 80
   dsisr: 40000000
    current = 0xc00000037f280000
    paca    = 0xc0000003ffffe600   softe: 3        irq_happened: 0x01
      pid   = 3529, comm = afp_no_int
  <snip>
  cxl_prefault+0xfc/0x248 [cxl]
  process_element_entry_psl9+0xd8/0x1a0 [cxl]
  cxl_attach_dedicated_process_psl9+0x44/0x130 [cxl]
  native_attach_process+0xc0/0x130 [cxl]
  afu_ioctl+0x3f4/0x5e0 [cxl]
  do_vfs_ioctl+0xdc/0x890
  ksys_ioctl+0x68/0xf0
  sys_ioctl+0x40/0xa0
  system_call+0x58/0x6c

The issue is caused as on Power-8 the AFU attr 'prefault_mode' was
used to improve initial storage fault performance by prefaulting
process segments. However on Power-9 with radix mode we don't have
Storage-Segments that we can prefault. Also prefaulting process Pages
will be too costly and fine-grained.

Hence, since the prefaulting mechanism doesn't makes sense of
radix-mode, this patch updates prefault_mode_store() to not allow any
other value apart from CXL_PREFAULT_NONE when radix mode is enabled.

Fixes: f24be42aab37 ("cxl: Add psl9 specific code")
Cc: stable@vger.kernel.org # v4.12+
Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/ABI/testing/sysfs-class-cxl |    4 +++-
 drivers/misc/cxl/sysfs.c                  |   16 ++++++++++++----
 2 files changed, 15 insertions(+), 5 deletions(-)

--- a/Documentation/ABI/testing/sysfs-class-cxl
+++ b/Documentation/ABI/testing/sysfs-class-cxl
@@ -69,7 +69,9 @@ Date:           September 2014
 Contact:        linuxppc-dev@lists.ozlabs.org
 Description:    read/write
                 Set the mode for prefaulting in segments into the segment table
-                when performing the START_WORK ioctl. Possible values:
+                when performing the START_WORK ioctl. Only applicable when
+                running under hashed page table mmu.
+                Possible values:
                         none: No prefaulting (default)
                         work_element_descriptor: Treat the work element
                                  descriptor as an effective address and
--- a/drivers/misc/cxl/sysfs.c
+++ b/drivers/misc/cxl/sysfs.c
@@ -331,12 +331,20 @@ static ssize_t prefault_mode_store(struc
 	struct cxl_afu *afu = to_cxl_afu(device);
 	enum prefault_modes mode = -1;
 
-	if (!strncmp(buf, "work_element_descriptor", 23))
-		mode = CXL_PREFAULT_WED;
-	if (!strncmp(buf, "all", 3))
-		mode = CXL_PREFAULT_ALL;
 	if (!strncmp(buf, "none", 4))
 		mode = CXL_PREFAULT_NONE;
+	else {
+		if (!radix_enabled()) {
+
+			/* only allowed when not in radix mode */
+			if (!strncmp(buf, "work_element_descriptor", 23))
+				mode = CXL_PREFAULT_WED;
+			if (!strncmp(buf, "all", 3))
+				mode = CXL_PREFAULT_ALL;
+		} else {
+			dev_err(device, "Cannot prefault with radix enabled\n");
+		}
+	}
 
 	if (mode == -1)
 		return -EINVAL;


