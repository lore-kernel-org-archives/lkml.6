Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B62C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2EC420989
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4tNNWWK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2EC420989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731310AbeKTC6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:58:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:57206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729995AbeKTC6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:58:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11004208E4;
        Mon, 19 Nov 2018 16:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645244;
        bh=7dsM07+k+/O+QvQ51YMplyUuRu7GVbPkob81n9LlwG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W4tNNWWKvB+9tpiTrlYKr8wAk3o1MkxEmwCoFSUd59CskSCO6K9gwCcRvkS2O8R2I
         7fE5r+MUERjQw0+0x2ddrCpb0ywia/QqEoKDRammaY9cubumJU3w+HN6osncpWjgAW
         LXUbrA74wE/hlD7Qxasf9yYvdsPAMRXLuDBDsR0w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robert Elliott <elliott@hpe.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Borislav Petkov <bp@suse.de>, Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-edac <linux-edac@vger.kernel.org>,
        linux-nvdimm@lists.01.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ross Zwisler <zwisler@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, x86-ml <x86@kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 4.19 091/205] acpi/nfit, x86/mce: Validate a MCEs address before using it
Date:   Mon, 19 Nov 2018 17:26:38 +0100
Message-Id: <20181119162632.213681486@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
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

From: Vishal Verma <vishal.l.verma@intel.com>

commit e8a308e5f47e545e0d41d0686c00f5f5217c5f61 upstream.

The NFIT machine check handler uses the physical address from the mce
structure, and compares it against information in the ACPI NFIT table
to determine whether that location lies on an NVDIMM. The mce->addr
field however may not always be valid, and this is indicated by the
MCI_STATUS_ADDRV bit in the status field.

Export mce_usable_address() which already performs validation for the
address, and use it in the NFIT handler.

Fixes: 6839a6d96f4e ("nfit: do an ARS scrub on hitting a latent media error")
Reported-by: Robert Elliott <elliott@hpe.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
CC: Arnd Bergmann <arnd@arndb.de>
Cc: Dan Williams <dan.j.williams@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>
CC: elliott@hpe.com
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: Len Brown <lenb@kernel.org>
CC: linux-acpi@vger.kernel.org
CC: linux-edac <linux-edac@vger.kernel.org>
CC: linux-nvdimm@lists.01.org
CC: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Ross Zwisler <zwisler@kernel.org>
CC: stable <stable@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Tony Luck <tony.luck@intel.com>
CC: x86-ml <x86@kernel.org>
CC: Yazen Ghannam <yazen.ghannam@amd.com>
Link: http://lkml.kernel.org/r/20181026003729.8420-2-vishal.l.verma@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/mce.h       |    1 +
 arch/x86/kernel/cpu/mcheck/mce.c |    3 ++-
 drivers/acpi/nfit/mce.c          |    4 ++++
 3 files changed, 7 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -217,6 +217,7 @@ static inline int umc_normaddr_to_sysadd
 int mce_available(struct cpuinfo_x86 *c);
 bool mce_is_memory_error(struct mce *m);
 bool mce_is_correctable(struct mce *m);
+int mce_usable_address(struct mce *m);
 
 DECLARE_PER_CPU(unsigned, mce_exception_count);
 DECLARE_PER_CPU(unsigned, mce_poll_count);
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -485,7 +485,7 @@ static void mce_report_event(struct pt_r
  * be somewhat complicated (e.g. segment offset would require an instruction
  * parser). So only support physical addresses up to page granuality for now.
  */
-static int mce_usable_address(struct mce *m)
+int mce_usable_address(struct mce *m)
 {
 	if (!(m->status & MCI_STATUS_ADDRV))
 		return 0;
@@ -505,6 +505,7 @@ static int mce_usable_address(struct mce
 
 	return 1;
 }
+EXPORT_SYMBOL_GPL(mce_usable_address);
 
 bool mce_is_memory_error(struct mce *m)
 {
--- a/drivers/acpi/nfit/mce.c
+++ b/drivers/acpi/nfit/mce.c
@@ -29,6 +29,10 @@ static int nfit_handle_mce(struct notifi
 	if (!mce_is_memory_error(mce) || mce_is_correctable(mce))
 		return NOTIFY_DONE;
 
+	/* Verify the address reported in the MCE is valid. */
+	if (!mce_usable_address(mce))
+		return NOTIFY_DONE;
+
 	/*
 	 * mce->addr contains the physical addr accessed that caused the
 	 * machine check. We need to walk through the list of NFITs, and see


